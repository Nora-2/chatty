// ignore_for_file: unused_local_variable, unnecessary_null_comparison, camel_case_types, avoid_print

import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:scholar_chat/core/constants/colorconstant.dart';
import 'package:scholar_chat/feateures/chat/cubit/chat_cubit.dart';
import 'package:scholar_chat/feateures/chat/presentation/widget/Chat_bubble.dart';
import 'package:scholar_chat/feateures/register/presentation/view/Register_Screen.dart';

class Chat_Screen extends StatefulWidget {
  static String id = 'chatpage';

  const Chat_Screen({Key? key}) : super(key: key);

  @override
  State<Chat_Screen> createState() => _Chat_ScreenState();
}

class _Chat_ScreenState extends State<Chat_Screen> {
  String? data;
  Uint8List? imageBytes = Uint8List(0);
  final chatcontroler = ScrollController();

  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var email = FirebaseAuth.instance.currentUser;
    var sender = email!.uid;
    var reciver = ModalRoute.of(context)!.settings.arguments as String;
    final messages = FirebaseFirestore.instance
        .collection('users')
        .doc(sender)
        .collection('chats')
        .doc(reciver)
        .collection('messages');
    final sendmessages = FirebaseFirestore.instance.collection('users');
    return ModalProgressHUD(
      progressIndicator:const CircularProgressIndicator(backgroundColor: Colors.white,color: icolor,)
        ,color: icolor,
      inAsyncCall: false,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: icolor,
          automaticallyImplyLeading: true,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/freepik-export-202404221730096pgB.png',
                height: 60,
                width: 60,
              ),
              const Text('Chat'),
            ],
          ),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, RegisterScreen.id);
                },
                icon: const Icon(Icons.login_sharp))
          ],
        ),
        body: Column(children: [
          Expanded(child: BlocBuilder<ChatCubit, ChatState>(
            builder: (context, state) {
              var messageList = BlocProvider.of<ChatCubit>(context).messageList;
              return ListView.builder(
                  reverse: true,
                  controller: chatcontroler,
                  itemCount: messageList.length,
                  itemBuilder: (context, index) {
                    return messageList[index].sender == sender
                        ? ChatBubble(
                            message: messageList[index],alignment: Alignment.centerLeft,color: seccolor,borderRadius: const BorderRadius.only(
                      bottomRight: Radius.circular(15),
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15)),
                          )
                        : ChatBubble(message: messageList[index],alignment: Alignment.centerRight,color: icolor,borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15)),);
                  });
            },
          )),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    onChanged: (value) {
                      data = value;
                    },
                    controller: controller,
                    decoration: InputDecoration(
                        hintText: 'Send Message',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: const BorderSide(color: icolor))),
                  ),
                ),
                IconButton(
                  onPressed: () async {
                    final pickedFiles = await FilePicker.platform.pickFiles(
                      type: FileType.image,
                      allowMultiple: false,
                    );

                    if (pickedFiles != null && pickedFiles.files.isNotEmpty) {
                      final imageBytes = pickedFiles.files.single.bytes;
                      if (imageBytes != null && imageBytes.isNotEmpty) {
                        var storageRef = FirebaseStorage.instance.ref().child(
                              'images/${DateTime.now().toIso8601String()}.jpg',
                            );
                        try {
                          var uploadTask = storageRef.putData(imageBytes);
                          var snapshot = await uploadTask;
                          var imageUrl = await snapshot.ref.getDownloadURL();
                          if (imageUrl != null) {
                            print(
                                'Image uploaded successfully. URL: $imageUrl');
                            var messageData = {
                              'body': data,
                              'createdAt': DateTime.now(),
                              'sender': sender,
                              'receiver': reciver,
                              'imageUrl': imageUrl,
                            };

                            await sendmessages
                                .doc(sender)
                                .collection('chats')
                                .doc(reciver)
                                .collection('messages')
                                .add(messageData);
                            await sendmessages
                                .doc(reciver)
                                .collection('chats')
                                .doc(sender)
                                .collection('messages')
                                .add(messageData);
                          } else {
                            print('Image upload failed: Image URL is null.');
                          }
                        } catch (e) {
                          // Handle upload error
                          print('Upload failed: $e');
                        }
                      } else {
                        print(
                            'Image upload failed: Image bytes are null or empty.');
                      }
                    }

                    controller.clear();
                    chatcontroler.animateTo(0,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeIn);
                  },
                  icon: const Icon(
                    Icons.image,
                    color: icolor,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    if (data != null && data!.isNotEmpty) {
                      BlocProvider.of<ChatCubit>(context).sendMessage(
                          message: data!, sender: sender, receiver: reciver);
                      controller.clear();
                      chatcontroler.animateTo(0,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeIn);
                    }
                  },
                  icon: const Icon(
                    Icons.send,
                    color: icolor,
                  ),
                ),
              ],
            ),
          )
        ]),
      ),
    );
  }
}
// flutter run -d chrome --web-renderer html