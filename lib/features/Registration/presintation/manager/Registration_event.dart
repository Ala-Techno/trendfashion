part of 'Registration_bloc.dart';

abstract class RegistrationEvent extends Equatable {
  const RegistrationEvent();
}

class SingUpEvent extends RegistrationEvent {
  final String username;
  final String email;
  final String password;
  @override
  List<Object> get props => [];
  const SingUpEvent(
      {required this.username, required this.email, required this.password});
}
