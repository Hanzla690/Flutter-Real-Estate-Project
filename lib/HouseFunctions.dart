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

  addActiveChat(String userID) {
    UserModel currentUser = UserAuthentication.currentUser;
    bool activeChatter = false, newChatter = false;
    if (userID != currentUser.id) {
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
        FireStoreCollections().updateUser();
      }
    }
  }
}
