import 'package:flutter/material.dart';
import 'package:zenchat_chat_app/services/auth/auth_service.dart';
import 'package:zenchat_chat_app/components/text_widget.dart';
import 'package:zenchat_chat_app/pages/settings_page.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  // logout method
  void logOut(){
    final authService = AuthService();
    authService.signOut();
  }

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;
    final surface = Theme.of(context).colorScheme.surface;
    return Drawer(
      backgroundColor: surface,
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                SizedBox(height: 50),

                // logo
                Icon(
                  Icons.message,
                  size: 70,
                  color: primary,
                ),
                SizedBox(height: 25),
                Divider(
                  color: Colors.black.withOpacity(0.2),
                ),
                SizedBox(height: 50),

                // home list tile
                Padding(
                  padding: EdgeInsets.only(left: 25),
                  child: ListTile(
                    title: Label(label: 'H O M E'),
                    leading: Icon(
                      Icons.home,
                      color: primary,
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ),

                SizedBox(height: 100),

                // settings list tile
                Padding(
                  padding: EdgeInsets.only(left: 25),
                  child: ListTile(
                    title: Label(label: 'S E T T I N G S'),
                    leading: Icon(
                      Icons.settings,
                      color: primary,
                    ),
                    onTap: () {
                      Navigator.pop(context);

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SettingsPage(),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),

            // logout list tile
            Padding(
              padding: EdgeInsets.only(left: 25, bottom: 25),
              child: ListTile(
                title: Label(label: 'L O G O U T'),
                leading: Icon(
                  Icons.logout,
                  color: primary,
                ),
                onTap: logOut,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
