import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user/blocs/app_events.dart';
import 'package:user/blocs/app_states.dart';
import 'package:user/repos/repositories.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository _userRepository;
  String index;
  UserBloc(this._userRepository, this.index) : super(UserLoadingState()) {
    on<LoadUserEvent>(((event, emit) async {
      emit(UserLoadingState());
      try {
        if (index == "") {
          final users = await _userRepository.getDetails(index);
          emit(UserLoadedState(users));
        } else {
          final users = await _userRepository.getDetailsById(index);
          emit(UserLoadedState2(users));
        }
      } catch (e) {
        emit(UserErrorState(e.toString()));
      }
    }));
  }
}
