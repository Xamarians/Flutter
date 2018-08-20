import 'package:flutter/material.dart';
import 'package:sample_list/Fragments/chatMessage.dart';
import 'package:sample_list/Fragments/reverseChatMessage.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => new _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin {
  TextEditingController _controllerChat = new TextEditingController();
  List<StatelessWidget> _messages = <StatelessWidget>[];
  bool _isComposing = false;
  bool _sender = true;

 //handle sending of message
  void _handleSendSubmitted(String text) {
    setState(() {
      _isComposing = false;
    });
    _controllerChat.clear();

    if (_sender) {
      ChatMessage message = new ChatMessage(
        text: text,
        animationController: new AnimationController(
          duration: new Duration(milliseconds: 350),
          vsync: this,
        ),
      );
      setState(() {
        _messages.insert(0, message);
      });
      message.animationController.forward();
    } else {
      ReverseChatMessage message = new ReverseChatMessage(
          text: text,
          animationController: new AnimationController(
            duration: new Duration(milliseconds: 350),
            vsync: this,
          ));
      setState(() {
        _messages.insert(0, message);
      });
      message.animationController.forward();
    }

    _sender = !_sender;
  }

  @override
  void dispose() {
    for (ChatMessage message in _messages)
      message.animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Column(
        children: <Widget>[
          new Flexible(
            child: new ListView.builder(
              padding: new EdgeInsets.all(8.0),
              reverse: true,
              itemBuilder: (_, int index) => _messages[index],
              itemCount: _messages.length,
            ),
          ),
          new Divider(height: 1.0),
          new Container(
            padding: EdgeInsets.all(1.0),
          ),
          new Divider(height: 1.0),
          new Container(
            decoration: new BoxDecoration(color: Theme.of(context).cardColor),
            child: _buildTextComposer(),
          ),
        ],
      ),
    );
  }

  //Building the text composer
  Widget _buildTextComposer() {
    return new IconTheme(
      data: new IconThemeData(color: Theme.of(context).accentColor),
      child: new Container(
        margin: const EdgeInsets.only(left: 8.0),
        child: new Row(
          children: <Widget>[
            new Flexible(
              child: new TextField(
                controller: _controllerChat,
                onChanged: (String text) {
                  setState(() {
                    _isComposing = text.length > 0;
                  });
                },
                onSubmitted: _isComposing ? _handleSendSubmitted : null,
                decoration:
                    new InputDecoration.collapsed(hintText: "Send a message"),
              ),
            ),
            new Container(
              height: 30.0,
              width: 1.0,
              color: Colors.grey[350],
              margin: const EdgeInsets.only(left: 10.0, right: 0.0),
            ),
            new Container(
              child: new IconButton(
                  icon: new Icon(Icons.send),
                  onPressed: _isComposing
                      ? () => _handleSendSubmitted(_controllerChat.text)
                      : null),
            ),
          ],
        ),
      ),
    );
  }
}
