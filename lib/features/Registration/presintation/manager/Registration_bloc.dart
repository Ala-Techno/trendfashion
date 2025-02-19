import 'dart:async';
import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:trendfashion/dataProviders/error/failures.dart';
import 'package:trendfashion/features/Registration/data/model/RegistrationModel.dart';
import '../../data/repository/RegistrationRepository.dart';

part 'Registration_event.dart';
part 'Registration_state.dart';

class Registration_bloc extends Bloc<RegistrationEvent, RegistrationState> {
  final RegistrationRepository repository;
  Registration_bloc({required this.repository}) : super(SingUpInitial());
  @override
  Stream<RegistrationState> mapEventToState(RegistrationEvent event) async* {
    if (event is SingUpEvent) {
      yield SingUpLoading();
      final failureOrData =
          await repository.singUp(event.username, event.email, event.password);

      yield* failureOrData.fold(
        (failure) async* {
          log('yield is error');
          yield SingUponError(errorMessage: mapFailureToMessage(failure));
        },
        (data) async* {
          log('yield signUp is loaded');
          yield SingUpLoaded(
            registrationModel: data,
          );
        },
      );
    }

    if (event is LoginEvent) {
      yield LoginLoading();
      final failureOrData =
          await repository.login(event.username, event.password);

      yield* failureOrData.fold(
        (failure) async* {
          yield LoginonError(errorMessage: mapFailureToMessage(failure));
        },
        (data) async* {
          log('yield login is loaded');
          yield LoginLoaded(
            registrationModel: data,
          );
        },
      );
    }
  }
}
