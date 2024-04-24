import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:scholar_chat/core/constants/colorconstant.dart';
import 'package:scholar_chat/core/models/message_model.dart';
import 'package:scholar_chat/feateures/chat/cubit/chat_cubit.dart';
import 'package:scholar_chat/feateures/chat/presentation/view/chat_screen.dart';
import 'package:scholar_chat/feateures/chat/presentation/widget/build_chat.dart';
import 'package:scholar_chat/feateures/chat/presentation/widget/story.dart';

class Messanger extends StatefulWidget {
  static String id = 'Messanger';

  const Messanger({Key? key}) : super(key: key);

  @override
  State<Messanger> createState() => _MessangerState();
}

class _MessangerState extends State<Messanger> {
  List<UserModel> userList = [];
  UserModel admin = UserModel('uid', '', '', '');
  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    var uid = ModalRoute.of(context)!.settings.arguments;
    final users = FirebaseFirestore.instance.collection('users');
    return StreamBuilder<QuerySnapshot>(
        stream: users.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            userList = [];
            for (int i = 0; i < snapshot.data!.docs.length; i++) {
              if (snapshot.data!.docs[i]['uid'] != uid) {
                userList.add(UserModel.fromJson(snapshot.data!.docs[i]));
              }
              if (snapshot.data!.docs[i]['uid'] == uid) {
                admin = UserModel.fromJson(snapshot.data!.docs[i]);
              }
            }
            return ModalProgressHUD(
              progressIndicator:const CircularProgressIndicator(backgroundColor: Colors.white,color: icolor,)
        ,color: icolor,
              inAsyncCall: false,
              child: Scaffold(
                appBar: AppBar(
                  backgroundColor: icolor,
                  automaticallyImplyLeading: false,
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/freepik-export-202404221730096pgB.png',
                        height: 60,
                        width: 60,
                      ),
                      const Text('Chats'),
                    ],
                  ),
                  centerTitle: true,
                  actions: [
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.login_sharp))
                  ],
                ),
                body: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 25,
                              backgroundImage: NetworkImage(admin.photo),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              admin.username,
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 25),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Container(
                          height: 2,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Colors.grey[400],
                              shape: BoxShape.rectangle),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        SizedBox(
                            height: 130,
                            child: ListView.separated(
                              itemBuilder: (context, index) => GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(context, Chat_Screen.id,
                                      arguments: userList[index].uid);
                                },
                                child: BuilStory(userList[index].username,
                                    userList[index].photo),
                              ),
                              separatorBuilder: (context, index) =>
                                  const SizedBox(
                                width: 20,
                              ),
                              itemCount: userList.length,
                              scrollDirection: Axis.horizontal,
                            )),
                        const SizedBox(
                          height: 25,
                        ),
                        ListView.separated(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) => GestureDetector(
                              onTap: () {
                                BlocProvider.of<ChatCubit>(context).getmessage(
                                    sender: uid as String,
                                    reciver: userList[index].uid);
                                Navigator.pushNamed(context, Chat_Screen.id,
                                    arguments: userList[index].uid);
                              },
                              child: BuilChat(userList[index].username,
                                  userList[index].photo)),
                          separatorBuilder: (context, index) => const SizedBox(
                            height: 15,
                          ),
                          itemCount: userList.length,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          } else {
            return const ModalProgressHUD(progressIndicator: CircularProgressIndicator(backgroundColor: Colors.white,color: icolor,)
        ,color: icolor,inAsyncCall: true, child: Scaffold());
          }
        });
  }
}
