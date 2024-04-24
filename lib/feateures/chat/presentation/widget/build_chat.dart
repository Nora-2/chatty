
// ignore_for_file: non_constant_identifier_names

  import 'package:flutter/material.dart';

Widget BuilChat(String username, photo) => Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(photo),
            radius: 30,
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  username,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w400),
                ),
                Row(
                  children: [
                    const Expanded(
                        child: Text(
                      'Tap to see the messages',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    )),
                    const SizedBox(
                      width: 3,
                    ),
                    Container(
                      height: 6,
                      width: 6,
                      decoration: const BoxDecoration(
                        color: Colors.black,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      );

