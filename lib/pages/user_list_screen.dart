import 'package:flutter/material.dart';
import 'package:part_user/cubits/user_cubit.dart';
import 'package:part_user/models/user.dart';
import 'package:part_user/pages/user_detail_screen.dart';
import 'package:part_user/widgets/user_list_item_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserListScreen extends StatefulWidget {
  const UserListScreen({Key? key}) : super(key: key);

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  @override
  Widget build(BuildContext context) {
    final UserListState state = context.watch<UserListCubit>().state;

    return Scaffold(
      appBar: AppBar(title: const Text('User Information')),
      body: _body(state),
    );
  }

  Widget _body(UserListState state) {
    switch (state.status) {
      case UserListStatus.loading:
        return const Center(child: CircularProgressIndicator());
      case UserListStatus.failed:
        return Center(child: ElevatedButton(onPressed: _refresh, child: const Text('Retry'),),);
      case UserListStatus.success:
        return ListView.builder(
          itemCount: state.users.length,
          itemBuilder: (context, index) {
            return UserListItemWidget(
              user: state.users[index],
              onTap: () {
                _openUser(state.users[index]);
              },
            );
          },
        );
    }
  }

  void _openUser(User user) {
    ///Open [UserDetailScreen]
    ///We should delete the selected item if returned value was a false boolean

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => UserDetailScreen(user: user),
      ),
    ).then((value) {
      if (value == null) return;
      if (value) {
        context.read<UserListCubit>().deleteUser(user);
      }
    });
  }

  void _refresh() {
    context.read<UserListCubit>().refreshData();
  }
}
