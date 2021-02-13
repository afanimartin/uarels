import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class UserModel extends Equatable {
  final String userId, email, username, photo;

  const UserModel(
      {@required this.userId,
      @required this.email,
      @required this.username,
      @required this.photo});

  UserModel copyWith(
          {String userId, String email, String username, String photo}) =>
      UserModel(
          userId: userId ?? this.userId,
          email: email ?? this.email,
          username: username ?? this.username,
          photo: photo ?? this.photo);

  static const empty =
      UserModel(userId: '', email: '', username: '', photo: '');

  factory UserModel.fromSnapshot(DocumentSnapshot doc) => UserModel(
      userId: doc.id,
      email: doc.data()['email'] as String,
      username: doc.data()['username'] as String,
      photo: doc.data()['photo'] as String);

  Map<String, dynamic> toDocument() => <String, dynamic>{
        'userId': userId,
        'email': email,
        'username': username,
        'photo': photo
      };

  @override
  List<Object> get props => [userId, email, username, photo];
}
