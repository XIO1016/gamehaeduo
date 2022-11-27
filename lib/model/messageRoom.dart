import 'duo.dart';

class MessageRoom {
  int roomId;
  String currentMessage;
  String currentMessageTime;

  Duo duo;
  MessageRoom({
    required this.duo,
    required this.roomId,
    required this.currentMessage,
    required this.currentMessageTime,
  });
}
