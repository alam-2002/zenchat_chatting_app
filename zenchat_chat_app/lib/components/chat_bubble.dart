import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zenchat_chat_app/components/text_widget.dart';
import 'package:zenchat_chat_app/services/chat/chat_service.dart';
import 'package:zenchat_chat_app/themes/theme_provider.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isCurrentUser;
  final String messageID;
  final String userID;

  const ChatBubble({
    super.key,
    required this.message,
    required this.isCurrentUser,
    required this.messageID,
    required this.userID,
  });

  // show options method
  void _showOptions(BuildContext context, String messageID, String userID) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Wrap(
            children: [
              // report msg button
              ListTile(
                leading: Icon(Icons.flag),
                title: Label(label: 'Report User'),
                onTap: () {
                  Navigator.pop(context);
                  _reportMessage(context, messageID, userID);
                },
              ),

              // block user button
              ListTile(
                leading: Icon(Icons.block),
                title: Label(label: 'Block User'),
                onTap: () {
                  Navigator.pop(context);
                  _blockUser(context, userID);
                },
              ),

              // cancel button
              ListTile(
                leading: Icon(Icons.cancel),
                title: Label(label: 'Cancel'),
                onTap: () => Navigator.pop(context),
              ),
            ],
          ),
        );
      },
    );
  }

  // report user method
  void _reportMessage(BuildContext context, String messageID, String userID) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Label(label: 'Report'),
        content: Label(label: 'Are you sure you want to report this user'),
        actions: [
          // cancel button
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Label(label: 'Cancel'),
          ),

          // report button
          TextButton(
            onPressed: () {
              ChatService().reportUser(messageID, userID);
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Label(
                      label: 'Report Successful,\nwe will verify this user'),
                ),
              );
            },
            child: Label(
              label: 'Report',
              color: Colors.redAccent,
            ),
          ),
        ],
      ),
    );
  }

  // block user method
  void _blockUser(BuildContext context, String userID) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Label(label: 'Block User'),
        content: Label(label: 'Are you sure you want to block this user'),
        actions: [
          // cancel button
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Label(label: 'Cancel'),
          ),

          // block button
          TextButton(
            onPressed: () {
              // perform block
              ChatService().blockUser(userID);

              // dismiss dialog
              Navigator.pop(context);

              // dismiss page
              Navigator.pop(context);

              // successful msg
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Label(label: 'User Blocked!'),
                ),
              );
            },
            child: Label(
              label: 'Block',
              color: Colors.redAccent,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode =
        Provider.of<ThemeProvider>(context, listen: false).isDarkMode;
    return GestureDetector(
      onLongPress: () {
        if (!isCurrentUser) {
          // show options
          _showOptions(context, messageID, userID);
        }
      },
      child: Container(
        margin: EdgeInsets.only(left: 10, right: 10, top: 15),
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: isCurrentUser
              ? (isDarkMode ? Colors.green.shade600 : Colors.green.shade500)
              : (isDarkMode ? Colors.grey.shade800 : Colors.grey.shade200),
          borderRadius: BorderRadius.only(
            topRight: isCurrentUser ? Radius.circular(0) : Radius.circular(12),
            // topRight: Radius.circular(1),
            topLeft: isCurrentUser ? Radius.circular(12) : Radius.circular(0),
            bottomRight: Radius.circular(12),
            bottomLeft: Radius.circular(12),
          ),
        ),
        child: Label(
          label: message,
          color: isCurrentUser
              ? Colors.white
              : (isDarkMode ? Colors.white : Colors.black),
        ),
      ),
    );
  }
}
