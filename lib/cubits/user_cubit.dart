import 'package:bloc/bloc.dart';
import 'package:part_user/models/user.dart';
import 'package:part_user/models/user_data_request.dart';
import 'package:part_user/repositories/api_repository.dart';

part 'user_state.dart';

class UserListCubit extends Cubit<UserListState> {
  final ApiRepository apiRepository;

  UserListCubit(this.apiRepository) : super(UserListState.initialize()) {
    refreshData();
  }

  ///Refreshing user list data from remote
  void refreshData() async {
    emit(UserListState.initialize());
    UsersDataResponse response = await apiRepository.getUsers();
    if (response.statusCode == 200) {
      emit(state.copyWith(users: response.data, status: UserListStatus.success));
    } else {
      emit(state.copyWith(users: response.data, status: UserListStatus.failed));
    }
  }

  ///Delete a [User] instance
  ///Immediately remove the user instance and update the UI
  ///If api request failed we return to previous state
  void deleteUser(User user) async {
    UserListState previousState = state.copyWith();
    emit(
      state.copyWith(users: state.users)..users.remove(user),
    );
    bool success = await apiRepository.deleteUser(user.id!);
    if (!success) {
      emit(previousState);
    }
  }
}
