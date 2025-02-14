part of 'Registration_bloc.dart';

abstract class RegistrationState extends Equatable {
  const RegistrationState();
}

class SingupInitial extends RegistrationState {
  @override
  List<Object> get props => [];
}

class SingupLoading extends RegistrationState {
  @override
  List<Object> get props => [];
}

class SingupLoaded extends RegistrationState {
  RegistrationModel registrationModel;
  SingupLoaded({required this.registrationModel});

  @override
  List<Object> get props => [registrationModel];
}

class SinguponError extends RegistrationState {
  String errorMessage;

  SinguponError({required this.errorMessage});

  @override
  List<Object> get props => [];
}
