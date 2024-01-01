import 'dart:io';

import 'package:bubble/bubble.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/FireStoreCollections.dart';
import 'package:flutter_project/Models/MessageModel.dart';
import 'package:flutter_project/User%20Authentication/UserAuthentication.dart';
import 'package:flutter_project/Models/UserModel.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class Chat extends StatefulWidget {
  final UserModel user;
  const Chat({super.key, required this.user});

  @override
  State<Chat> createState() => _ChatState(user);
}

class _ChatState extends State<Chat> {
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  List<MessageModel> messages = [];
  final UserModel recieverUser;
  TextEditingController messageController = TextEditingController();
  ScrollController scrollController = ScrollController();
  final ImagePicker imagePicker = ImagePicker();
  _ChatState(this.recieverUser);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 3,
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.green.shade100,
              radius: 18,
              child: Icon(
                Icons.person,
                color: Colors.green.shade500,
              ),
            ),
            SizedBox(
              width: 7,
            ),
            Text(recieverUser.username),
          ],
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: StreamBuilder(
                stream: FireStoreCollections().fetchMessages(recieverUser.id),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    messages = snapshot.data!.docs
                        .map((message) => MessageModel.fromMap(
                            message.data() as Map<String, dynamic>))
                        .toList();
                    WidgetsBinding.instance!.addPostFrameCallback((_) {
                      if (scrollController.hasClients) {
                        scrollController
                            .jumpTo(scrollController.position.maxScrollExtent);
                      }
                    });
                    return ListView.builder(
                        controller: scrollController,
                        itemCount: messages.length,
                        itemBuilder: (context, index) {
                          bool isSent =
                              messages[index].senderId != recieverUser.id;
                          return Bubble(
                            margin: isSent
                                ? BubbleEdges.only(top: 10, right: 20)
                                : BubbleEdges.only(top: 10, left: 20),
                            padding: BubbleEdges.all(15),
                            elevation: 5,
                            nipRadius: 5,
                            nipWidth: 30,
                            nipHeight: 10,
                            alignment:
                                isSent ? Alignment.topRight : Alignment.topLeft,
                            nip: isSent
                                ? BubbleNip.rightBottom
                                : BubbleNip.leftTop,
                            color: isSent
                                ? Colors.green.shade400
                                : Colors.grey[200],
                            child: messages[index].isImage
                                ? Image.network(messages[index].messageBody)
                                : Text(
                                    messages[index].messageBody,
                                    style: TextStyle(
                                        color: isSent
                                            ? Colors.white
                                            : Colors.black),
                                  ),
                          );
                        });
                  } else {
                    return Center(child: LinearProgressIndicator());
                  }
                }),
          ),
          SizedBox(
            height: 15,
          ),
          Container(
              color: Colors.white,
              child: Row(children: [
                SizedBox(
                  width: 1,
                ),
                InkWell(
                    onTap: () async {
                      String imageURL = await pickImage();
                      sendMessage(imageURL: imageURL, isImage: true);
                    },
                    child: Icon(Icons.attach_file)),
                SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: TextField(
                    controller: messageController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Send Message',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: InkWell(
                    onTap: () {
                      sendMessage(isImage: false);
                    },
                    child: Icon(
                      Icons.send,
                      color: Colors.green.shade500,
                    ),
                  ),
                ),
              ]))
        ],
      ),
    );
  }

  sendMessage({imageURL, isImage}) async {
    UserModel currentUser = UserAuthentication.currentUser;
    bool isMessageImage = isImage;
    String messageContent;
    if (imageURL != null) {
      messageContent = imageURL;
    } else {
      messageContent = messageController.text;
    }
    MessageModel message = MessageModel(
        recieverId: recieverUser.id,
        recieverName: recieverUser.username,
        senderId: currentUser.id,
        senderName: currentUser.username,
        messageBody: messageContent,
        messageTime: DateTime.now().toString(),
        isImage: isMessageImage);
    await FireStoreCollections().createMessage(message);
    scrollToBottom();
    setState(() {
      messageController.text = "";
    });
  }

  void scrollToBottom() {
    if (scrollController.hasClients) {
      scrollController.jumpTo(scrollController.position.maxScrollExtent);
    }
  }

  Future<String> pickImage() async {
    XFile? image = await imagePicker.pickImage(source: ImageSource.gallery);
    Reference rootFolder = FirebaseStorage.instance.ref();
    Reference imageFolder = rootFolder.child('images');
    final imageRef = imageFolder.child(Uuid().v4());
    imageRef.putFile(File(image!.path));
    String imageURL = await imageRef.getDownloadURL();
    return imageURL;
  }
}
