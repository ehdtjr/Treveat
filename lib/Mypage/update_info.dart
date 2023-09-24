import 'package:flutter/material.dart';

class MyDialog extends StatelessWidget {
  final Function(String) onSubmitted;

  MyDialog({required this.onSubmitted});

  @override
  Widget build(BuildContext context) {
    String userInput = "";
    String img, nickname, infotext = "";

    return AlertDialog(
      content: TextFormField(
        onChanged: (value) {
          userInput = value;
        },
        decoration: InputDecoration(
          labelText: '변경 내용을 입력하세요',
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('취소'),
        ),
        TextButton(
          onPressed: () {
            onSubmitted(userInput); // 입력된 데이터를 콜백으로 전달
            Navigator.of(context).pop();
          },
          child: Text('확인'),
        ),
      ],
    );
  }
}
