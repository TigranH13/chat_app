import 'package:flutter/physics.dart';

abstract class RemoveMembers {
  Future call(int index, List membersList, String id);
}
