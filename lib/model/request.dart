import 'duo.dart';

class Request {
  String requestTime;
  Duo duo;

  Request({
    required this.duo,
    required this.requestTime
  });
}
