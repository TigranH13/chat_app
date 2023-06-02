class Utils {
  String chatRoomId(int user1, int user2) {
    if (user1 > user2) {
      return '$user1$user2';
    } else {
      return '$user2$user1';
    }
  }
}
