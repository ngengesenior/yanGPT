import 'package:flutter/material.dart';
import 'package:yangpt/contollers/networking.dart';
import 'package:yangpt/injection_container.dart';

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:yangpt/models/Message.dart';
import 'package:yangpt/models/chat_completion.dart';
import 'package:yangpt/ui/chat_message.dart';

class ChatBotWidget extends StatefulWidget {
  const ChatBotWidget({Key? key}) : super(key: key);

  @override
  _ChatBotWidgetState createState() => _ChatBotWidgetState();
}

class _ChatBotWidgetState extends State<ChatBotWidget> {
  final List<Message> _messages = [];
  final Networking _networking = getIt.get<Networking>();
  final TextEditingController _textEditingController = TextEditingController();
  bool _isSending = false;

  Future<void> _sendMessage(String message) async {
    if (message.isEmpty) {
      return;
    }

    setState(() {
      _isSending = true;
      _messages.add(Message(role: 'user', content: message));
    });
    final response = await _networking.getChatCompletion(message);
    if(response.isOk()) {
      final responseData = jsonDecode(response.body);
      final ChatCompletion completion = ChatCompletion.fromJson(responseData);
      final choice = completion.choices[0];
      _messages.add(Message(role:choice['role'], content: choice['content']));
    }

    setState(() {
          /*{
        'role': 'assistant',
        'content': completion.choices[0]['message']['content'],
      });*/
      _isSending = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('yanGPT')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (BuildContext context, int index) {
                final Map<String,dynamic> message = _messages[index];
                return ChatMessage(text: message['content'], isUser: message['role'] == 'assistant'? false:true);
              },
            ),
          ),
          const Divider(height: 1.0),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 4.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _textEditingController,
                    decoration: const InputDecoration.collapsed(
                      hintText: 'Talk to me...',
                    ),
                  ),
                ),
                if (_isSending)
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: SizedBox(
                      height: 24.0,
                      width: 24.0,
                      child: CircularProgressIndicator(
                        strokeWidth: 3.0,
                      ),
                    ),
                  )
                else
                  IconButton(
                    icon: const Icon(Icons.send),
                    onPressed: () {
                      final message = _textEditingController.text.trim();
                      _sendMessage(message);
                      _textEditingController.clear();
                    },
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


/**
 * import 'dart:convert';
    import 'package:flutter/material.dart';
    import 'package:http/http.dart' as http;

    class ChatBotWidget extends StatefulWidget {
    const ChatBotWidget({Key? key}) : super(key: key);

    @override
    _ChatBotWidgetState createState() => _ChatBotWidgetState();
    }

    class _ChatBotWidgetState extends State<ChatBotWidget> {
    final List<Map<String, String>> _messages = [];

    final TextEditingController _textEditingController = TextEditingController();

    Future<void> _sendMessage(String message) async {
    final url = Uri.parse('https://api.openai.com/v1/chat/completions');
    final headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $OPENAI_API_KEY',
    };
    final data = jsonEncode({
    'model': 'gpt-3.5-turbo',
    'messages': _messages.isEmpty
    ? [{'role': 'user', 'content': message}]
    : _messages + [{'role': 'user', 'content': message}],
    });
    final response = await http.post(url, headers: headers, body: data);

    final responseData = jsonDecode(response.body);
    setState(() {
    _messages.addAll(responseData['choices'].map<Map<String, String>>((choice) {
    return {
    'role': 'assistant',
    'content': choice['text'],
    };
    }));
    });
    }

    @override
    Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(title: const Text('Chat Bot')),
    body: Column(
    children: [
    Expanded(
    child: ListView.builder(
    itemCount: _messages.length,
    itemBuilder: (BuildContext context, int index) {
    final message = _messages[index];
    return ListTile(
    title: Text(message['content']!),
    subtitle: Text(message['role']!),
    trailing: const Icon(Icons.android),
    );
    },
    ),
    ),
    const Divider(height: 1.0),
    Container(
    margin: const EdgeInsets.symmetric(horizontal: 4.0),
    child: Row(
    children: [
    Expanded(
    child: TextField(
    controller: _textEditingController,
    decoration: const InputDecoration.collapsed(
    hintText: 'Type your message...',
    ),
    ),
    ),
    IconButton(
    icon: const Icon(Icons.send),
    onPressed: () {
    final message = _textEditingController.text.trim();
    if (message.isNotEmpty) {
    _sendMessage(message);
    _textEditingController.clear();
    }
    },
    ),
    ],
    ),
    ),
    ],
    ),
    );
    }
    }

 */
