import 'package:flutter/material.dart';
import 'package:zenchat_chat_app/components/text_widget.dart';

class UserTile extends StatelessWidget {
  final String text;
  final void Function() onTap;

  const UserTile({
    super.key,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final secondary = Theme.of(context).colorScheme.secondary;
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.only(top: 15, left: 15, right: 15),
        padding: EdgeInsets.symmetric(vertical: 25,horizontal: 15),
        decoration: BoxDecoration(
          color: secondary,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 2,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            // icon
            Icon(Icons.person),

            SizedBox(width: 20),

            // user name
            Label(label: text),
          ],
        ),
      ),
    );
  }
}
