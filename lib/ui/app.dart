import 'package:flutter/material.dart';
import 'package:yangpt/ui/chat.dart';

class MyTabbedPage extends StatefulWidget {
  const MyTabbedPage({Key? key}) : super(key: key);

  @override
  _MyTabbedPageState createState() => _MyTabbedPageState();
}

class _MyTabbedPageState extends State<MyTabbedPage> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    ChatBotWidget(),
    Text('Images'),
    Text('Chat'),
    Text('Tab 4'),
  ];

  static const List<IconData> _iconOptions = <IconData>[
    Icons.chat_outlined,
    Icons.code,
    Icons.favorite,
    Icons.person,
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return const ChatBotWidget();
  }
}
