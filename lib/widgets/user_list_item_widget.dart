import 'package:part_user/colors.dart';
import 'package:part_user/models/user.dart';
import 'package:flutter/material.dart';
import 'package:part_user/widgets/image_viewr.dart';

class UserListItemWidget extends StatelessWidget {
  final User user;
  final VoidCallback? onTap;

  const UserListItemWidget({Key? key, required this.user,this.onTap,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      decoration: _decoration,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: ListTile(
          leading: _avatar,
          title: _title,
          subtitle: _subtitle,
        ),
      ),
    );
  }

  Text get _title => Text('${user.id?.toString()} _ ${user.firstName}');

  Text get _subtitle => Text(user.email ?? '');

  Widget get _avatar => user.avatar == null
      ? CircleAvatar(
          child: _title,
        )
      : SizedBox(
          width: 50,
          height: 50,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: ImageViewer(path: user.avatar),
          ),
        );

  BoxDecoration get _decoration =>
      BoxDecoration(borderRadius: BorderRadius.circular(16), border: Border.all(color: AppColors.listBorder));

}
