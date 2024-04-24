 // ignore_for_file: non_constant_identifier_names

 import 'package:flutter/material.dart';

Widget BuilStory(username, photo) => SizedBox(
        width: 70,
        child: Column(
          children: [
            const SizedBox(
              height: 15,
            ),
            Stack(
              alignment: AlignmentDirectional.bottomEnd,
              children: [
                CircleAvatar(
                  radius: 35,
                  backgroundImage: NetworkImage(photo),
                ),
                const Padding(
                  padding: EdgeInsetsDirectional.only(
                    bottom: 5,
                    end: 5,
                  ),
                  child: CircleAvatar(
                    radius: 7,
                    backgroundColor: Colors.green,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              username,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );

