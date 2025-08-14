import 'package:chat_app/models/messages_model.dart';

sealed class ChatscreenState {}

final class ChatscreenInitial extends ChatscreenState {}

final class ChatSuccess extends ChatscreenState {
  List<MessagesModel> messagesList;
  ChatSuccess({required this.messagesList});
}
