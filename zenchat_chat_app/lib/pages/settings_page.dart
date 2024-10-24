import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zenchat_chat_app/components/text_widget.dart';
import 'package:zenchat_chat_app/pages/blocked_users.dart';
import 'package:zenchat_chat_app/themes/theme_provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;
    final secondary = Theme.of(context).colorScheme.secondary;
    final inversePrimary = Theme.of(context).colorScheme.inversePrimary;
    return Scaffold(
      appBar: AppBar(
        title: Label(
          label: 'Settings',
          color: Colors.white,
          fontSize: 22,
        ),
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: Colors.grey,
        elevation: 1,
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 600),
          child: Column(
            children: [
              // Dark Mode
              Container(
                margin: EdgeInsets.only(left: 25, right: 25, top: 25),
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: secondary,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Label(
                      label: 'Dark Mode',
                      fontWeight: FontWeight.bold,
                      color: inversePrimary,
                    ),

                    // switch toggle
                    CupertinoSwitch(
                      value: Provider.of<ThemeProvider>(context, listen: false)
                          .isDarkMode,
                      // value: Provider.of(context, listen: false).isDarkMode,
                      onChanged: (value) =>
                          Provider.of<ThemeProvider>(context, listen: false)
                              .toggleTheme(),
                    ),
                  ],
                ),
              ),

              // blocked user
              Container(
                margin: EdgeInsets.only(left: 25, right: 25, top: 10),
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: secondary,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Label(
                      label: 'Blocked Users',
                      fontWeight: FontWeight.bold,
                      color: inversePrimary,
                    ),

                    // go to blocked user page
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BlockedUsersPage(),
                          ),
                        );
                      },
                      icon: Icon(
                        Platform.isAndroid
                            ? Icons.arrow_forward
                            : Icons.arrow_forward_ios,
                        color: primary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
