part of 'user_cubit.dart';

enum UserListStatus { loading, failed, success }

class UserListState {
  final List<User> users;
  final UserListStatus status;

  const UserListState(this.users, this.status);

  factory UserListState.initialize() {
    return const UserListState(
      [],
      UserListStatus.loading,
    );
  }

  UserListState copyWith({
    List<User>? users,
    UserListStatus? status,
  }) {
    return UserListState(
      users ?? List.generate(this.users.length, (index) => this.users[index]),
      status ?? this.status,
    );
  }
}
