import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_project/Models/HouseModel.dart';
import 'package:flutter_project/Models/MessageModel.dart';
import 'package:flutter_project/User%20Authentication/UserAuthentication.dart';
import 'package:flutter_project/Models/UserModel.dart';

class FireStoreCollections {
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');
  final CollectionReference chatRoomCollection =
      FirebaseFirestore.instance.collection('chat_rooms');
  final CollectionReference propertiesCollection =
      FirebaseFirestore.instance.collection('properties');
  late CollectionReference reference;

  Future createUser(UserModel user) async {
    try {
      await userCollection.doc(user.id).set(user.toJSON());
    } catch (e) {
      if (e is PlatformException) {
        return e.message;
      }
    }
  }

  Future createMessage(MessageModel message) async {
    try {
      List<String> ids = [message.senderId, message.recieverId];
      ids.sort();
      String chatRoomId = ids.join('_');
      await chatRoomCollection
          .doc(chatRoomId)
          .collection('messages')
          .doc()
          .set(message.toJSON());
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<UserModel> getUser(String userid) async {
    var user = await userCollection.doc(userid).get();
    return UserModel.fromMap(user.data() as Map<String, dynamic>);
  }

  Future<List<UserModel>?> fetchUsers() async {
    UserModel currentUser = UserAuthentication.currentUser;
    List userIds = currentUser.activeChats;
    List<UserModel> users = [];
    try {
      for (var element in userIds) {
        var doc = await userCollection.doc(element).get();
        users.add(UserModel.fromMap(doc.data() as Map<String, dynamic>));
      }
      return users;
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  Stream<QuerySnapshot> fetchMessages(String recieverId) {
    UserModel currentUser = UserAuthentication.currentUser;
    List<String> ids = [currentUser.id, recieverId];
    ids.sort();
    String chatRoomId = ids.join('_');

    return chatRoomCollection
        .doc(chatRoomId)
        .collection('messages')
        .orderBy('messageTime', descending: false)
        .snapshots();
  }

  createHouseAd(String adPurpose, HouseModel house) async {
    if (adPurpose == "Sell") {
      reference =
          propertiesCollection.doc('properties').collection("house_sell");
    } else if (adPurpose == "Rent") {
      reference =
          propertiesCollection.doc('properties').collection("house_rent");
    }
    try {
      await reference.doc(house.houseId).set(house.toJSON());
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<List<HouseModel>?> fetchHouses(String adPurpose) async {
    if (adPurpose == "Buy") {
      reference =
          propertiesCollection.doc('properties').collection("house_sell");
    } else if (adPurpose == "Rent") {
      reference =
          propertiesCollection.doc('properties').collection("house_rent");
    }
    try {
      final documents = await reference.get();
      if (documents.docs.isNotEmpty) {
        List<HouseModel> houses = documents.docs
            .map((house) =>
                HouseModel.fromMap(house.data() as Map<String, dynamic>))
            .toList();
        return houses;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  Future<List<HouseModel>> fetchFavorites() async {
    List houseIDs = UserAuthentication.currentUser.favorites;
    List<HouseModel> houses = [];
    for (var element in houseIDs) {
      var doc = await propertiesCollection
          .doc("properties")
          .collection("house_rent")
          .doc(element)
          .get();
      if (doc.exists) {
        houses.add(HouseModel.fromMap(doc.data() as Map<String, dynamic>));
      }
    }
    // for (var element in houseIDs) {
    //   var doc = await propertiesCollection
    //       .doc("properties")
    //       .collection("house_sell")
    //       .doc(element)
    //       .get();
    //   if (doc.exists) {
    //     houses.add(HouseModel.fromMap(doc.data() as Map<String, dynamic>));
    //   }
    // }
    return houses;
  }

  updateUser() async {
    UserModel user = UserAuthentication.currentUser;
    await userCollection.doc(user.id).set(user.toJSON());
  }

}
