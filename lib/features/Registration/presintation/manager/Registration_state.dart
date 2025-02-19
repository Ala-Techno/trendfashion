part of 'Registration_bloc.dart';

abstract class RegistrationState extends Equatable {
  const RegistrationState();
}

class SingUpInitial extends RegistrationState {
  @override
  List<Object> get props => [];
}

class SingUpLoading extends RegistrationState {
  @override
  List<Object> get props => [];
}

class SingUpLoaded extends RegistrationState {
  RegistrationModel registrationModel;
  SingUpLoaded({required this.registrationModel});

  @override
  List<Object> get props => [registrationModel];
}

class SingUponError extends RegistrationState {
  String errorMessage;

  SingUponError({required this.errorMessage});

  @override
  List<Object> get props => [];
}

class LoginInitial extends RegistrationState {
  @override
  List<Object> get props => [];
}

class LoginLoading extends RegistrationState {
  @override
  List<Object> get props => [];
}

class LoginLoaded extends RegistrationState {
  RegistrationModel registrationModel;
  LoginLoaded({required this.registrationModel});

  @override
  List<Object> get props => [registrationModel];
}

class LoginonError extends RegistrationState {
  String errorMessage;

  LoginonError({required this.errorMessage});

  @override
  List<Object> get props => [];
}
