import 'dart:async';
import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:trendfashion/dataProviders/error/failures.dart';
import 'package:trendfashion/features/Registration/data/model/RegistrationModel.dart';
import '../../data/repository/RegistrationRepository.dart';
import 'package:trendfashion/features/Registration/data/model/RegistrationModel.dart';

part 'Registration_event.dart';
part 'Registration_state.dart';

class Registration_bloc extends Bloc<RegistrationEvent, RegistrationState> {
  final RegistrationRepository repository;
  Registration_bloc({required this.repository}) : super(SingupInitial());
  @override
  Stream<RegistrationState> mapEventToState(RegistrationEvent event) async* {
    if (event is SingUpEvent) {
      yield SingupLoading();
      final failureOrData =
          await repository.singUp(event.email, event.username, event.password);

      yield* failureOrData.fold(
        (failure) async* {
          log('yield is error');
          yield SinguponError(errorMessage: mapFailureToMessage(failure));
        },
        (data) async* {
          log('yield is loaded');
          yield SingupLoaded(
            registrationModel: data,
          );
        },
      );
    }
  }
}
