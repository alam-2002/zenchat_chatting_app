import 'package:flutter/material.dart';
import 'package:zenchat_chat_app/services/auth/auth_service.dart';
import 'package:zenchat_chat_app/components/custom_text_field.dart';
import 'package:zenchat_chat_app/components/rectangular_botton.dart';
import 'package:zenchat_chat_app/components/text_widget.dart';

class RegisterPage extends StatelessWidget {
  final void Function() onTap;
  RegisterPage({super.key, required this.onTap});

  // final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  // register method
  void register(BuildContext context) {
    final authService = AuthService();

    // if password match
    if (_passwordController.text == _confirmPasswordController.text) {
      try {
        authService.signUpWithEmailAndPassword(
          _emailController.text,
          _passwordController.text,
        );
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Label(label: 'Registration Successful'),
          ),
        );
      } catch (e) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Label(label: e.toString()),
          ),
        );
      }
    }
    // if password doesn't match
    else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Label(label: "Password doesn't match !!"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 75),

                  // logo
                  Icon(
                    Icons.message,
                    size: 70,
                    color: primary,
                  ),
                  SizedBox(height: 25),

                  // welcome back msg
                  Label(
                    label: "Let's create an account for you",
                    color: primary,
                    fontSize: 16,
                  ),
                  SizedBox(height: 50),

                  // // name text field
                  // CustomTextField(
                  //   controller: _nameController,
                  //   hintText: 'Full Name',
                  // ),
                  // SizedBox(height: 10),

                  // email text field
                  CustomTextField(
                    controller: _emailController,
                    hintText: 'Email',
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(height: 10),

                  // password text field
                  CustomTextField(
                    controller: _passwordController,
                    hintText: 'Password',
                    obscureText: true,
                  ),
                  SizedBox(height: 10),

                  // confirm password text field
                  CustomTextField(
                    controller: _confirmPasswordController,
                    hintText: 'Confirm Password',
                    obscureText: true,
                  ),
                  SizedBox(height: 25),

                  // login button
                  RectangularButton(
                    title: 'Register',
                    onPressed: () => register(context),
                  ),
                  SizedBox(height: 15),

                  // register button
                  Padding(
                    padding: const EdgeInsets.only(right: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Label(
                          label: "Already have an account? ",
                          fontSize: 14,
                          color: primary,
                        ),
                        InkWell(
                          onTap: onTap,
                          child: Label(
                            label: 'Login',
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
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
        ),
      ),
    );
  }
}
