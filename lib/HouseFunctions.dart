import 'package:flutter_project/FireStoreCollections.dart';
import 'package:flutter_project/Models/UserModel.dart';
import 'package:flutter_project/User%20Authentication/UserAuthentication.dart';

class HouseFunctions {
  toggleFavorite(String houseID) {
    UserModel currentUser = UserAuthentication.currentUser;
    bool favoriteFound = false;
    if (currentUser.favorites.isEmpty) {
      currentUser.favorites.add(houseID);
    } else {
      for (var element in currentUser.favorites) {
        if (houseID == element) {
          currentUser.favorites.remove(houseID);
          favoriteFound = true;
        }
      }
      if (!favoriteFound) {
        currentUser.favorites.add(houseID);
      }
    }
    FireStoreCollections().updateUser();
  }

  addActiveChat(String userID) async {
    UserModel currentUser = UserAuthentication.currentUser;
    UserModel otherUser;
    bool activeChatter = false, newChatter = false;
    if (currentUser.activeChats.isEmpty) {
      currentUser.activeChats.add(userID);
      newChatter = true;
    } else {
      for (var element in currentUser.activeChats) {
        if (userID == element) {
          activeChatter = true;
          break;
        }
      }
      if (!activeChatter) {
        currentUser.activeChats.add(userID);
        newChatter = true;
      }
    }
    if (newChatter) {
      otherUser = await FireStoreCollections().getUser(userID);
      otherUser.activeChats.add(currentUser.id);
      FireStoreCollections().updateUser();
      FireStoreCollections().updateUser(otherUser: otherUser);
    }
  }

  String formatPrice(int price) {
    if (price < 1000) {
      return '$price PKR';
    } else if (price < 1000000) {
      double k = price / 1000.0;
      return '${k.toStringAsFixed(k.truncateToDouble() == k ? 0 : 2)}k PKR';
    } else {
      double m = price / 1000000.0;
      return '${m.toStringAsFixed(m.truncateToDouble() == m ? 0 : 2)}M PKR';
    }
  }
}
