// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:chat_app/core/models/user_model.dart';
import 'package:chat_app/core/services/auth_services.dart';
import 'package:chat_app/core/view_models/theme_mode/theme_mode_cubit.dart';
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
  final FocusNode focusNode = FocusNode();
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    focusNode.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void scrollDown() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

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

          // Scroll after messages are updated
          WidgetsBinding.instance.addPostFrameCallback((_) => scrollDown());

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  controller: _scrollController,
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final msg = messages[index];
                    final isMe = msg.senderID == currentUserID;
                    final isDark = context.read<ThemeModeCubit>().isDark;

                    return Align(
                      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: isMe
                              ? Colors.green[400]
                              : (isDark ? Colors.grey.shade800 : Colors.white),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          msg.message,
                          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: isMe ? Colors.white : (isDark ? Colors.white : Colors.black),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              _MessageInputField(
                otherUserID: otherUserID,
                focusNode: focusNode,
                onSend: scrollDown, // scroll after sending a message
              ),
            ],
          );
        },
      ),
    );
  }
}

class _MessageInputField extends StatefulWidget {
  final String otherUserID;
  final FocusNode focusNode;
  final VoidCallback onSend;
  const _MessageInputField({
    required this.otherUserID,
    required this.focusNode,
    required this.onSend,
  });

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
                focusNode: widget.focusNode,
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
                final text = _controller.text.trim();
                if (text.isNotEmpty) {
                  chatCubit.sendMessage(widget.otherUserID, text);
                  _controller.clear();
                  widget.onSend(); // force scroll down
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
