class MessageModel {
  final String message;
  final bool isSentByUser;
  final DateTime timestamp;

  MessageModel({
    required this.message,
    required this.isSentByUser,
    required this.timestamp,
  });
}


List<MessageModel> dummyMessages = [
  MessageModel(message: "Good Evening!", isSentByUser: false, timestamp: DateTime.now().subtract(const Duration(minutes: 5))),
  MessageModel(message: "Welcome to Car2Go Customer Service", isSentByUser: false, timestamp: DateTime.now().subtract(const Duration(minutes: 4))),
  MessageModel(message: "Welcome to Car2Go Customer Service", isSentByUser: true, timestamp: DateTime.now().subtract(const Duration(minutes: 3))),
  MessageModel(message: "Welcome to Car2Go Customer Service", isSentByUser: false, timestamp: DateTime.now().subtract(const Duration(minutes: 2))),
  MessageModel(message: "Welcome to Car2Go Customer Service", isSentByUser: true, timestamp: DateTime.now()),
];
