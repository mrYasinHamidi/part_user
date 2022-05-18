import 'package:flutter/material.dart';
import 'package:part_user/models/user.dart';
import 'package:part_user/widgets/image_viewr.dart';

class UserDetailScreen extends StatefulWidget {
  final User user;

  const UserDetailScreen({Key? key, required this.user}) : super(key: key);

  @override
  State<UserDetailScreen> createState() => _UserDetailScreenState();
}

class _UserDetailScreenState extends State<UserDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: _delete,
            icon: const Icon(Icons.delete),
          ),
        ],
        title: Text('${widget.user.firstName} ${widget.user.lastName}'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: size.height * 0.35,
            child: ImageViewer(path: widget.user.avatar),
          ),
          _property('Id', '${widget.user.id}'),
          _property('Name', '${widget.user.firstName}'),
          _property('Last Name', '${widget.user.lastName}'),
          _property('Email', '${widget.user.email}'),
        ],
      ),
    );
  }

  Widget _property(String key, String value) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              child: Text(
                key,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              flex: 2,
              child: Text(
                value,
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      );

  void _delete() {
    Navigator.pop(context, true);
  }
}
