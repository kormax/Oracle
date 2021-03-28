import 'package:data/environment/environment.model.dart';

// 192.168.0.132 - change to your local ip address
String serverUrl = '93.188.34.235';
final environment = EnvironmentModel(
    authUrl: '$serverUrl:8001',
    metricsUrl: '$serverUrl:8002',
    taskUrl: '$serverUrl:8003',

);