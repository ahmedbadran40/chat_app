// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:chat_app/constant.dart';

class MessagesModel {
  final String id;
  final String message;

  MessagesModel({required this.id, required this.message});
  factory MessagesModel.fromJson(jsonData) {
    return MessagesModel(message: jsonData[kMessage], id: jsonData[kId]);
  }
}
