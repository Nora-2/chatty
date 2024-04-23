// // ignore_for_file: unused_import

// import 'package:flutter/material.dart';
// class MessageModel {
//   final String body;
//   final String sender;
//   final String reciver;
   
//   MessageModel(this.body, this.sender, this.reciver);

//   factory MessageModel.fromjason(jsondata) {
//     return MessageModel(
//         jsondata['body'], jsondata['sender'], jsondata['reciver']);
//   }
// }

// class UserModel {
//    String uid;
//    String photo;
//    String username;
//    String email;

//   UserModel(this.uid, this.photo, this.username, this.email);
//   factory UserModel.fromjason(jsondata) {
//     return UserModel(jsondata['uid'], jsondata['photo'], jsondata['username'],
//         jsondata['email']);
//   }
// }
// ignore_for_file: unused_import

import 'package:flutter/material.dart';

// class MessageModel {
//   final String body;
//   final String sender;
//   final String receiver;
//   final String? imageUrl; // Added imageUrl field

//   MessageModel(this.body, this.sender, this.receiver, {this.imageUrl});

//   factory MessageModel.fromJson( jsondata) {
//     return MessageModel(
//       jsondata['body'],
//       jsondata['sender'],
//       jsondata['receiver'],
//       imageUrl: jsondata['imageUrl'], // Added imageUrl field
//     );
//   }
// }
class MessageModel {
  final String ?body;
  final String sender;
  final String receiver;
  final String? imageUrl;

  MessageModel( this.sender, this.receiver, {this.imageUrl,this.body});

  factory MessageModel.fromJson(
    jsondata, {
    String? imageUrl,
  }) {
    return MessageModel(
    
      jsondata['sender'],
      jsondata['receiver'],
      body:jsondata['body'],
      imageUrl: imageUrl,
    );
  }
}

class UserModel {
  final String uid;
  final String photo;
  final String username;
  final String email;

  UserModel(this.uid, this.photo, this.username, this.email);

  factory UserModel.fromJson(jsondata) {
    return UserModel(
      jsondata['uid'],
      jsondata['photo'],
      jsondata['username'],
      jsondata['email'],
    );
  }
}
