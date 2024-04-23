// // ignore_for_file: unused_catch_clause
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';


// import '../../../../core/models/message_model.dart';

// part 'chat_state.dart';

// class ChatCubit extends Cubit<ChatState> {
//   ChatCubit() : super(ChatInitial());
//   List<MessageModel> messageList = [];

//   final sendmessages = FirebaseFirestore.instance.collection('users');
//   final messages = FirebaseFirestore.instance.collection('users');
//   void sendmessage(
//       {required String message,
//       required String sender,
//       required String reciver}) {
//     try {
//       sendmessages
//           .doc(sender)
//           .collection('chats')
//           .doc(reciver)
//           .collection('messages')
//           .add({
//         'body': message,
//         'CreatedAt': DateTime.now(),
//         'sender': sender,
//         'reciver': reciver
//       });
//       sendmessages
//           .doc(reciver)
//           .collection('chats')
//           .doc(sender)
//           .collection('messages')
//           .add({
//         'body': message,
//         'CreatedAt': DateTime.now(),
//         'sender': sender,
//         'reciver': reciver,
//       });
//     } on Exception catch (e) {}
//   }

//   void getmessage({required String sender, required String reciver}) {
//     messages
//         .doc(sender)
//         .collection('chats')
//         .doc(reciver)
//         .collection('messages')
//         .orderBy('CreatedAt', descending: true)
//         .snapshots()
//         .listen((event) {
//       messageList.clear();
//       for (var doc in event.docs) {
//         messageList.add(MessageModel.fromJson(doc));
//       }
//       emit(ChatSuccess(messages: messageList));
//     });
//   }
// }
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/models/message_model.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());
  List<MessageModel> messageList = [];

  final sendMessages = FirebaseFirestore.instance.collection('users');
  final messages = FirebaseFirestore.instance.collection('users');

  void sendMessage({
     String? message,
    required String sender,
    required String receiver,
    String? imageUrl, // Optional imageUrl parameter
  }) {
    try {
      final sentMessageData = {
        'body': message,
        'createdAt': DateTime.now(), // Changed from 'CreatedAt' to 'createdAt'
        'sender': sender,
        'receiver': receiver,
        'imageUrl': imageUrl, // Include imageUrl in the message data
      };

      final receivedMessageData = {
        'body': message,
        'createdAt': DateTime.now(), // Changed from 'CreatedAt' to 'createdAt'
        'sender': sender,
        'receiver': receiver,
        'imageUrl': imageUrl, // Include imageUrl in the message data
      };

      sendMessages
          .doc(sender)
          .collection('chats')
          .doc(receiver)
          .collection('messages')
          .add(sentMessageData);

      sendMessages
          .doc(receiver)
          .collection('chats')
          .doc(sender)
          .collection('messages')
          .add(receivedMessageData);
    } catch (e) {
      // Handle the error...
    }
  }
void getmessage({required String sender, required String reciver}) {
  messages
    .doc(sender)
    .collection('chats')
    .doc(reciver)
    .collection('messages')
    .orderBy('createdAt', descending: true)
    .snapshots()
    .listen((event) {
      messageList.clear();
      for (var doc in event.docs) {
        var imageUrl = doc['imageUrl']; // Get imageUrl from Firestore document
        messageList.add(MessageModel.fromJson(doc, imageUrl: imageUrl));
      }
      emit(ChatSuccess(messages: messageList));
    });
}

//   void getMessage({required String sender, required String receiver}) {
//     messages
//         .doc(sender)
//         .collection('chats')
//         .doc(receiver)
//         .collection('messages')
//         .orderBy('createdAt', descending: true) // Changed from 'CreatedAt' to 'createdAt'
//         .snapshots()
//         .listen((event) {
//       messageList.clear();
//       for (var doc in event.docs) {
//         messageList.add(MessageModel.fromJson(doc));
//       }
//       emit(ChatSuccess(messages: messageList));
//     });
//   }
}
