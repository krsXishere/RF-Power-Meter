import 'dart:async';
import 'dart:developer';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:rf_power_meter/models/sensor_data_model.dart';
import 'dart:math' as math;

class SensorDataService {
  late MqttServerClient client;

  final _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  final math.Random _rnd = math.Random();

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

  Future<void> connect() async {
    // Konfigurasi client MQTT
    client = MqttServerClient("167.86.84.22", getRandomString(6));
    String username = "1260hu2445";
    String password = "670ehijopy";
    String topic = "1260hu2445/telepati";
    client.logging(on: false); // Aktifkan logging
    client.keepAlivePeriod = 20; // Keep-alive setiap 20 detik
    client.onConnected = onConnected;
    client.onDisconnected = onDisconnected;
    client.onSubscribed = onSubscribed;

    // Konfigurasi otentikasi
    client.connectionMessage = MqttConnectMessage()
        .authenticateAs(username, password)
        .withClientIdentifier(client.clientIdentifier)
        .startClean() // Clean session
        .withWillQos(MqttQos.atLeastOnce); // QoS untuk Last Will

    try {
      log('Connecting to MQTT broker...');
      await client.connect();

      // Periksa status koneksi
      if (client.connectionStatus!.state == MqttConnectionState.connected) {
        log('Connected to broker');
        subscribeToTopic(topic); // Langsung subscribe setelah koneksi berhasil
      } else {
        log('Failed to connect. Status: ${client.connectionStatus!.state}');
        handleConnectionError(client.connectionStatus!.returnCode!);
      }
    } on Exception catch (e) {
      log('Connection error: $e');
      client.disconnect(); // Putuskan koneksi jika gagal
    }
  }

  void subscribeToTopic(String topic) {
    if (client.connectionStatus!.state == MqttConnectionState.connected) {
      client.subscribe(topic, MqttQos.atLeastOnce);
      log('Subscribed to topic: $topic');
      listenToMessages();
    } else {
      log('Cannot subscribe, client is not connected');
    }
  }

  void onConnected() {
    log('Connected callback triggered');
  }

  void onDisconnected() {
    log('Disconnected callback triggered');
  }

  void onSubscribed(String topic) {
    log('Subscribed to topic: $topic');
  }

  void handleConnectionError(MqttConnectReturnCode returnCode) {
    switch (returnCode) {
      case MqttConnectReturnCode.badUsernameOrPassword:
        log('Invalid username or password');
        break;
      case MqttConnectReturnCode.brokerUnavailable:
        log('Broker unavailable');
        break;
      case MqttConnectReturnCode.identifierRejected:
        log('Client identifier rejected');
        break;
      default:
        log('Connection failed: $returnCode');
    }
  }

  Future<SensorDataModel> listenToMessages() async {
    final completer = Completer<SensorDataModel>();

    client.updates!.listen((List<MqttReceivedMessage<MqttMessage>> events) {
      final MqttReceivedMessage<MqttMessage> event = events.first;
      final MqttPublishMessage payload = event.payload as MqttPublishMessage;

      // Konversi payload ke String
      final String message =
          MqttPublishPayload.bytesToStringAsString(payload.payload.message);

      log('Message received on topic ${event.topic}: $message');

      try {
        // Parsing pesan menjadi SensorDataModel
        final sensorData = SensorDataModel.fromString(message);

        if (!completer.isCompleted) {
          completer.complete(sensorData);
        }
      } catch (e) {
        log('Failed to parse message: $e');
        if (!completer.isCompleted) {
          completer.completeError(e);
        }
      }
    });

    return completer.future;
  }
}
