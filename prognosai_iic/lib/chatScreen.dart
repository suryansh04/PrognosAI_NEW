import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:uuid/Uuid.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({this.name, Key? key}) : super(key: key);
  final name;
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List<types.Message> _messages = [];
  final _client = GenerativeModel(
      model: 'gemini-1.5-flash-latest',
      apiKey: 'AIzaSyBblqf3-2jNFmhz1C1dAjxntL6fNVjYIbk');

  final _user = const types.User(
    id: '1',
    firstName: 'User',
  );

  final _bot = const types.User(
    id: '2',
    firstName: 'Health Assistant',
  );

  @override
  void initState() {
    super.initState();

    _addBotMessage(
      "Hello ${widget.name} 👋! I'm your health assistant. Please describe your symptoms, and I'll provide some general guidance. "
      "Remember, this is not a replacement for professional medical advice.",
    );
  }

  void _addBotMessage(String text) {
    final message = types.TextMessage(
      author: _bot,
      id: const Uuid().v4(),
      text: text,
      createdAt: DateTime.now().millisecondsSinceEpoch,
    );

    setState(() {
      _messages.insert(0, message);
    });
  }

  void _handleSendPressed(types.PartialText message) async {
    final userMessage = types.TextMessage(
      author: _user,
      id: const Uuid().v4(),
      text: message.text,
      createdAt: DateTime.now().millisecondsSinceEpoch,
    );

    setState(() {
      _messages.insert(0, userMessage);
    });

    _addBotMessage("Thinking...");

    try {
      final response = await _getGenerativeAiResponse(message.text);

      setState(() {
        _messages.removeAt(0);
      });

      _addBotMessage(response);
    } catch (e) {
      setState(() {
        print("Error: $e"); // Log the error message

        _messages.removeAt(0);
      });

      _addBotMessage('Sorry, I encountered an error. Please try again.');
    }
  }

  Future<String> _getGenerativeAiResponse(String userMessage) async {
    try {
      final prompt =
          "You are a helpful health assistant. Provide potential conditions, home remedies, and guidance on seeking professional care based on symptoms in short and concise bullet points."
          "Remind users this is not a diagnosis - they should consult a doctor."
          "User's input: $userMessage";
      final content = [Content.text(prompt)];
      final response = await _client.generateContent(content);

      return response.text ?? 'No response generated.';
    } catch (e) {
      throw Exception('Error communicating with Generative AI API: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Chat(
        messages: _messages,
        onSendPressed: _handleSendPressed,
        user: _user,
        theme: DefaultChatTheme(
          backgroundColor: Colors.white,
          messageBorderRadius: 20,
          primaryColor: Color(0xffDCF4B8),
          secondaryColor: Color(0xff85CC16),
          userAvatarNameColors: [Colors.blue],
          inputBackgroundColor: Colors.grey.shade100,
          inputTextColor: Colors.black,
          sentMessageBodyTextStyle: const TextStyle(
            color: Colors.black,
            fontSize: 16,
          ),
          receivedMessageBodyTextStyle: const TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
