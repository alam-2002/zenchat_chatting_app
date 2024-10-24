import 'package:flutter/material.dart';
import 'package:zenchat_chat_app/components/text_widget.dart';
import 'package:zenchat_chat_app/components/user_tile.dart';
import 'package:zenchat_chat_app/services/auth/auth_service.dart';
import 'package:zenchat_chat_app/services/chat/chat_service.dart';

class BlockedUsersPage extends StatelessWidget {
  BlockedUsersPage({super.key});

  final ChatService chatService = ChatService();
  final AuthService authService = AuthService();

  // unblock box
  void _showUnblockUser(BuildContext context, String userID) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Label(label: 'Unblock User'),
        content: Label(label: 'Are you sure you want to unblock this user ?'),
        actions: [
          // cancel button
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Label(label: 'Cancel'),
          ),

          // block button
          TextButton(
            onPressed: () {
              ChatService().unblockUser(userID);
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Label(label: 'User Unblocked'),
                ),
              );
            },
            child: Label(
              label: 'Block',
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    String userID = authService.getCurrentUser()!.uid;

    return Scaffold(
      appBar: AppBar(
        title: Label(
          label: 'Blocked Users',
          fontSize: 22,
        ),
        centerTitle: true,
      ),
      body: StreamBuilder<List<Map<String, dynamic>>>(
        stream: chatService.getBlockedUsersStream(userID),
        builder: (context, snapshot) {
          // error...
          if (snapshot.hasError) {
            return Center(child: Label(label: 'Error..'));
          }

          // loading..
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          final blockedUsers = snapshot.data ?? [];
          // if no user
          if (blockedUsers.isNotEmpty) {
            return Center(child: Label(label: 'No Blocked Users'));
          }

          // load complete
          return ListView.builder(
            itemCount: blockedUsers.length,
            itemBuilder: (context, index) {
              final user = blockedUsers[index];
              return UserTile(
                text: user['email'],
                onTap: () => _showUnblockUser(context, user['uid']),
              );
            },
          );
        },
      ),
    );
  }
}
