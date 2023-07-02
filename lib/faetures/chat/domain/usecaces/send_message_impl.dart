import 'package:chat_application/faetures/chat/data/repository/chat_repository_impl.dart';
import 'package:chat_application/faetures/chat/domain/usecaces/send_message.dart';

class SendMessageImpl implements SendMessage {
  @override
  Future call(String message, String id) async {
    await ChatRepostiryImpl().sendMessage(message, id);
  }
}
