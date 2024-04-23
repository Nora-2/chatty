import 'package:flutter/material.dart';
import 'package:scholar_chat/core/constants/colorconstant.dart';
import '../../../../core/models/message_model.dart';

class Chat_bubble extends StatelessWidget {
  final MessageModel message;
  const Chat_bubble({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
  return  Align(
      alignment: Alignment.centerLeft,
      child: message.imageUrl != null || message.body == null
          ? SizedBox(
              width: 200,
              height: 200,
              child: Image.network(
                message.imageUrl!,
                width: 200, // Adjust width as needed
                height: 200, // Adjust height as needed
                fit: BoxFit.cover,
              ),
            )
          : Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: const BoxDecoration(
                  color: seccolor,
                  borderRadius: BorderRadius.only(
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

class Chat_bubble_tofriend extends StatelessWidget {
  final MessageModel message;
  const Chat_bubble_tofriend({Key? key, required this.message})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: message.imageUrl != null || message.body == null
          ? Container(
              width: 200,
              height: 200,
              child: Image.network(
                message.imageUrl!,
                width: 200, // Adjust width as needed
                height: 200, // Adjust height as needed
                fit: BoxFit.cover,
              ),
            )
          : Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: const BoxDecoration(
                  color: icolor,
                  borderRadius: BorderRadius.only(
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
