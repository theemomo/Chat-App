// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  final String email;
  const ChatPage({
    super.key,
    required this.email,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text(email)));
  }
}
