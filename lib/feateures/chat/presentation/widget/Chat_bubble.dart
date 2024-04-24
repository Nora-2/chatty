// ignore_for_file: file_names

import 'package:flutter/material.dart';
import '../../../../core/models/message_model.dart';


class ChatBubble extends StatelessWidget {
  final MessageModel message;
  final AlignmentGeometry alignment;
 final Color color;
  const ChatBubble({Key? key, required this.message, required this.alignment,required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: message.imageUrl != null || message.body == null
          ? SizedBox(
              width: 200,
              height: 200,
              child: Image.network(
                message.imageUrl!,
                width: 200,
                height: 200,
                fit: BoxFit.cover,
              ),
            )
          : Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration:  BoxDecoration(
                  color: color,
                  borderRadius:const BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15))),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text(
                  message.body!,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
    );
  }
}
