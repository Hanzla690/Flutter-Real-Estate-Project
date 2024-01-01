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

  Future<UserModel?> getUserByEmail(String email) async {
    var user = await userCollection.where('email', isEqualTo: email).get();
    if (user.docs.isNotEmpty) {
      return UserModel.fromMap(user.docs[0].data() as Map<String, dynamic>);
    } else {
      return null;
    }
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

  createHouseAd(HouseModel house) async {
    try {
      await propertiesCollection.doc(house.houseId).set(house.toJSON());
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  deleteHouseAd(String houseID) async {
    try {
      await propertiesCollection.doc(houseID).delete();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<List<HouseModel>?> fetchHouses(
      {userID,
      required bool searchMode,
      searchItem,
      String propertyType = 'House'}) async {
    QuerySnapshot documents;
    try {
      if (searchMode) {
        final snapshot = await FirebaseFirestore.instance
            .collection('properties')
            .where('propertyType', isEqualTo: propertyType)
            .get();

        List<HouseModel> houses = snapshot.docs
            .map(
                (doc) => HouseModel.fromMap(doc.data() as Map<String, dynamic>))
            .where((house) =>
                house.area.toLowerCase().contains(searchItem.toLowerCase()))
            .toList();

        return houses;
      } else {
        if (userID == null) {
          documents = await propertiesCollection
              .where('propertyType', isEqualTo: propertyType)
              .get();
        } else {
          documents = await propertiesCollection
              .where('userId', isEqualTo: userID)
              .get();
        }
        if (documents.docs.isNotEmpty) {
          List<HouseModel> houses = documents.docs
              .map((house) =>
                  HouseModel.fromMap(house.data() as Map<String, dynamic>))
              .toList();
          return houses;
        }
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  Future<List<HouseModel>> searchByArea(String searchItem) async {
    final snapshot =
        await FirebaseFirestore.instance.collection('properties').get();

    List<HouseModel> searchResults = snapshot.docs
        .map((doc) => HouseModel.fromMap(doc.data() as Map<String, dynamic>))
        .where((house) =>
            house.area.toLowerCase().contains(searchItem.toLowerCase()))
        .toList();

    return searchResults;
  }

  Future<List<HouseModel>> fetchFavorites() async {
    List houseIDs = UserAuthentication.currentUser.favorites;
    List<HouseModel> houses = [];
    for (var element in houseIDs) {
      var doc = await propertiesCollection.doc(element).get();
      if (doc.exists) {
        houses.add(HouseModel.fromMap(doc.data() as Map<String, dynamic>));
      }
    }
    return houses;
  }

  updateUser({otherUser}) async {
    if (otherUser == null) {
      UserModel user = UserAuthentication.currentUser;
      await userCollection.doc(user.id).set(user.toJSON());
    } else {
      await userCollection.doc(otherUser.id).set(otherUser.toJSON());
    }
  }
}
