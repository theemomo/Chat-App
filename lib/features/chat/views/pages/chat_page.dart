// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:chat_app/core/models/user_model.dart';
import 'package:chat_app/core/services/auth_services.dart';
import 'package:chat_app/features/chat/chat_cubit/chat_cubit.dart';
import 'package:chat_app/features/models/message_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatPage extends StatefulWidget {
  final UserModel user;
  const ChatPage({super.key, required this.user});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    final currentUserID = AuthServices().getCurrentUser()!.uid;
    final otherUserID = widget.user.id!;
    return Scaffold(
      appBar: AppBar(title: Text(widget.user.email!)),
      body: StreamBuilder<List<MessageModel>>(
        stream: BlocProvider.of<ChatCubit>(context).getMessages(currentUserID, otherUserID),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final List<MessageModel> messages = snapshot.data!;
          return ListView.builder(
            itemCount: messages.length,
            itemBuilder: (context, index) {
              final msg = messages[index];
              final isMe = msg.senderID == currentUserID;

              return Align(
                alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: isMe ? Colors.green[400] : Colors.grey[500],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    msg.message,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.white),
                  ),
                ),
              );
            },
          );
        },
      ),
      bottomNavigationBar: _MessageInputField(otherUserID: otherUserID),
    );
  }
}

class _MessageInputField extends StatefulWidget {
  final String otherUserID;
  const _MessageInputField({required this.otherUserID});

  @override
  State<_MessageInputField> createState() => _MessageInputFieldState();
}

class _MessageInputFieldState extends State<_MessageInputField> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final chatCubit = context.read<ChatCubit>();

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _controller,
                decoration: const InputDecoration(
                  hintText: "Type a message...",
                  border: InputBorder.none,
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.send),
              onPressed: () {
                if (_controller.text.trim().isNotEmpty) {
                  chatCubit.sendMessage(widget.otherUserID, _controller.text.trim());
                  _controller.clear();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
