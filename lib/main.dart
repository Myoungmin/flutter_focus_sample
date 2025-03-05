import 'dart:developer';

import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: const FocusPage()));
}

class FocusPage extends StatefulWidget {
  const FocusPage({super.key});

  @override
  State<FocusPage> createState() => _FocusPageState();
}

class _FocusPageState extends State<FocusPage> {
  final FocusNode _focusNode = FocusNode();
  final TextEditingController _textController = TextEditingController();
  String notifyText = "";

  void _handleFocusChange() {
    if (_focusNode.hasFocus) {
      log('##### focus ON #####');
    } else {
      log('##### focus OFF #####');
    }
  }

  @override
  Widget build(BuildContext context) {
    _focusNode.addListener(_handleFocusChange);

    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextField(
                focusNode: _focusNode,
                controller: _textController,
                decoration: const InputDecoration(labelText: '내용 입력'),
              ),
              Text(notifyText, style: const TextStyle(color: Colors.red)),
              ElevatedButton(
                onPressed: () {
                  if (_textController.text == "") {
                    _focusNode.requestFocus();
                    setState(() => notifyText = "내용을 입력해주세요.");
                  } else {
                    setState(() => notifyText = _textController.text);
                  }
                },
                child: const Text("확인"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _focusNode.removeListener(_handleFocusChange);
    _focusNode.dispose();
    _textController.dispose();

    super.dispose();
  }
}
