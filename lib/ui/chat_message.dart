import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:yangpt/utils/utils.dart';

class ChatMessage extends StatelessWidget {
  final String text;
  final bool isUser;
  final controller = WebViewController();
  ChatMessage({super.key, required this.text, required this.isUser});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: isUser ? 80 : 8,
        right: 8,
        top: 4,
        bottom: 4,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          isUser
              ? Expanded(child: Container())
              : Padding(
            padding: const EdgeInsets.only(right: 8),
            child: isUser? const Icon(Icons.person):Image.asset('images/chat_gpt.png',width: 24,),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: isUser ? Colors.blue[100] : Colors.grey[300],
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(isUser ? 16 : 2),
                  topRight: Radius.circular(isUser ? 2 : 16),
                  bottomLeft: const Radius.circular(16),
                  bottomRight: const Radius.circular(16),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: isUser? Text(
                  text,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ):buildWebView(text, controller),
              ),
            ),
          ),
          isUser
              ? const Padding(
            padding: EdgeInsets.only(left: 8),
            child: Icon(Icons.person),
          )
              : Container(),
        ],
      ),
    );
  }

}
