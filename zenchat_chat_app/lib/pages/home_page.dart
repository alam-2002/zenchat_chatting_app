import 'package:flutter/material.dart';
import 'package:zenchat_chat_app/components/drawer_widget.dart';
import 'package:zenchat_chat_app/components/text_widget.dart';
import 'package:zenchat_chat_app/components/user_tile.dart';
import 'package:zenchat_chat_app/pages/chat_page.dart';
import 'package:zenchat_chat_app/services/auth/auth_service.dart';
import 'package:zenchat_chat_app/services/chat/chat_service.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        title: Label(
          label: 'Home',
          color: Colors.white,
          fontSize: 22,
        ),
        centerTitle: true,
        backgroundColor: Colors.grey,
        elevation: 1,
      ),
      drawer: DrawerWidget(),
      body: _buildUserList(),
    );
  }

  // build a list of user except for the current user logged in user
  Widget _buildUserList() {
    return StreamBuilder(
      stream: _chatService.getUsersStreamExcludingBlocked(),
      builder: (context, snapshot) {
        // error
        if (snapshot.hasError) {
          return Center(child: Label(label: 'Error:- Something went wrong'));
        }

        // loading...
        else if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: Label(label: 'Loading... please wait'));
        }

        // else return list view
        return ListView(
          children: snapshot.data!
              .map<Widget>((userData) => _buildUserListItem(userData, context))
              .toList(),
        );
      },
    );
  }

  Widget _buildUserListItem(
      Map<String, dynamic> userData, BuildContext context) {
    // display all user except current user
    if (userData['email'] != _authService.getCurrentUser()!.email) {
      return UserTile(
        text: userData['email'],
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatPage(
                receiverEmail: userData['email'],
                receiverID: userData['uid'],
              ),
            ),
          );
        },
      );
    } else {
      return Container();
    }
  }
}
