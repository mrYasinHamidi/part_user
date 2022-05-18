import 'package:flutter/material.dart';
import 'package:part_user/cubits/user_cubit.dart';
import 'package:part_user/pages/user_list_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:part_user/repositories/api_repository.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => ApiRepository(),
      child: MaterialApp(
        title: 'Users Information',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: BlocProvider(
          create: (context) => UserListCubit(context.read<ApiRepository>()),
          child: const UserListScreen(),
        ),
      ),
    );
  }
}
