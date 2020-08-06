import 'package:geochat/user/user_dto.dart';

abstract class SessionEvent {}

class Unauthenticated extends SessionEvent {}

class LoggedIn extends SessionEvent {
  final User user;

  LoggedIn(this.user);
}

class LoggedOut extends SessionEvent {}
