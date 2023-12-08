class MessageModel {
  String recieverId,
      recieverName,
      senderId,
      senderName,
      messageBody,
      messageTime;

  MessageModel(
      {required this.recieverId,
      required this.recieverName,
      required this.senderId,
      required this.senderName,
      required this.messageBody,
      required this.messageTime});

  Map<String, dynamic> toJSON() {
    return {
      'recieverId': recieverId,
      'recieverName': recieverName,
      'senderId': senderId,
      'senderName': senderName,
      'messageBody': messageBody,
      'messageTime': messageTime,
    };
  }

  static MessageModel fromMap(Map<String, dynamic> json) {
    return MessageModel(
        recieverId: json['recieverId'],
        recieverName: json['recieverName'],
        senderId: json['senderId'],
        senderName: json['senderName'],
        messageBody: json['messageBody'],
        messageTime: json['messageTime']);
  }
}
