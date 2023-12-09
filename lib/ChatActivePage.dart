import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/FireStoreCollections.dart';
import 'package:flutter_project/Models/MessageModel.dart';
import 'package:flutter_project/User%20Authentication/UserAuthentication.dart';
import 'package:flutter_project/Models/UserModel.dart';

class Chat extends StatefulWidget {
  final UserModel user;
  const Chat({super.key, required this.user});

  @override
  State<Chat> createState() => _ChatState(user);
}

class _ChatState extends State<Chat> {
  List<MessageModel> messages = [];
  final UserModel recieverUser;
  TextEditingController messageController = TextEditingController();
  _ChatState(this.recieverUser);

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
              child: Icon(Icons.person,
              color: Colors.green.shade500,),
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
                messages = snapshot.data!.docs.map((message) => MessageModel.fromMap(message.data() as Map<String, dynamic>)).toList();
                return ListView.builder(
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      bool isSent = messages[index].senderId != recieverUser.id;
                      return Bubble(
                        margin: isSent
                            ? BubbleEdges.only(top: 10, right: 20)
                            : BubbleEdges.only(top: 10, left: 20),
                        padding: BubbleEdges.all(15),
                        elevation: 5,
                        nipRadius: 5,
                        nipWidth: 30,
                        nipHeight: 10,
                        alignment: isSent ? Alignment.topRight : Alignment.topLeft,
                        nip: isSent ? BubbleNip.rightBottom : BubbleNip.leftTop,
                        color: isSent ? Colors.green.shade400 : Colors.grey[200],
                        child: Text(
                          messages[index].messageBody,
                          style: TextStyle(
                              color: isSent ? Colors.white : Colors.black),
                        ),
                      );
                    });
              }
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Container(
              color: Colors.white,
              child: Row(children: [
                SizedBox(width: 1),
                Icon(Icons.tag_faces),
                SizedBox(width: 1,),
                Icon(Icons.attach_file),
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
                    onTap: () async {
                      UserModel currentUser =
                          await UserAuthentication.currentUser;
                      MessageModel message = MessageModel(
                          recieverId: recieverUser.id,
                          recieverName: recieverUser.username,
                          senderId: currentUser.id,
                          senderName: currentUser.username,
                          messageBody: messageController.text,
                          messageTime: DateTime.now().toString());
                      await FireStoreCollections().createMessage(message);
                      setState(() {
                        messageController.text = "";
                      });
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

}
