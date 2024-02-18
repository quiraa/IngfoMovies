import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

enum ConnectionStatus { CONNECTED, DISCONNECTED }

class InternetStatusProvider extends ChangeNotifier {
  late Connectivity _connectivity;
  late ConnectionStatus _status;

  InternetStatusProvider() {
    _connectivity = Connectivity();
    _status = ConnectionStatus.CONNECTED;
    _connectivity.onConnectivityChanged.listen((result) {
      _status = result == ConnectivityResult.none
          ? ConnectionStatus.DISCONNECTED
          : ConnectionStatus.CONNECTED;
    });
  }

  ConnectionStatus get status => _status;
}
