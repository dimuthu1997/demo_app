// ignore_for_file: use_build_context_synchronously, unused_result

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:demo_app/services/provider/authentication.dart';
import 'package:demo_app/utils/common/email_validator.dart';
import 'package:demo_app/utils/common/screen.dart';
import 'package:demo_app/utils/widgets/app_textfield.dart';
import 'package:demo_app/views/auth/signup.dart';
import 'package:flutter/gestures.dart';

import 'package:flutter/material.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  late TextEditingController _passwordEditingController;
  late final TextEditingController _emailController;

  String? _emailError;
  String? _passError;

  void resetFields() {
    if (mounted) {
      setState(() {
        _emailError = null;
        _passError = null;
      });
    }
  }

  @override
  void initState() {
    _passwordEditingController = TextEditingController();
    _emailController = TextEditingController();
    super.initState();
  }

  Future<OkCancelResult> showOkErrorDialog(String title, String message) async {
    return await showOkAlertDialog(
      context: context,
      title: title,
      message: message,
    );
  }

  @override
  void dispose() {
    _passwordEditingController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.purple,
          centerTitle: true,
          title: const Text(
            "SignIn",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              fillOverscroll: true,
              hasScrollBody: false,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    ScreenUtil.verticalSpace(height: 24),
                    Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        color: Colors.purple,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Center(
                          child: Text(
                        "LOGO",
                        style: TextStyle(color: Colors.white),
                      )),
                    ),
                    ScreenUtil.verticalSpace(height: 24),
                    AppTextField(
                      controller: _emailController,
                      title: "Email",
                      hintText: "Enter your email address here",
                      keyboardType: TextInputType.text,
                      onTap: resetFields,
                      isError: _emailError != null ? true : false,
                    ),
                    ScreenUtil.verticalSpace(height: 26),
                    AppTextField(
                      controller: _passwordEditingController,
                      title: "Password",
                      hintText: "Enter your password here",
                      obscureText: true,
                      keyboardType: TextInputType.text,
                      onTap: resetFields,
                      isError: _passError != null ? true : false,
                    ),
                    ScreenUtil.verticalSpace(height: 32),
                    SizedBox(
                      height: 48,
                      width: 180,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.purple),
                        child: const Text('Sign In'),
                        onPressed: () async {
                          FocusScope.of(context).unfocus();
                          final String email = _emailController.text.trim();
                          final String password =
                              _passwordEditingController.text.trim();

                          if (email.isEmpty && password.isEmpty) {
                            setState(() {
                              _emailError = 'Error';
                              _passError = 'Error';
                            });
                            await showOkErrorDialog(
                                "Email & Password is required",
                                "Please enter a email & password");
                            return;
                          }

                          if (email.isNotEmpty) {
                            if (EmailValidator.validate(email)) {
                              setState(() {
                                _emailError = null;
                              });
                            } else {
                              setState(() {
                                _emailError = 'Valid Email Required';
                              });
                              await showOkErrorDialog(_emailError ?? "",
                                  "Please enter a valid email address");
                              return;
                            }
                          } else {
                            setState(() {
                              _emailError = "Email is required";
                            });
                            await showOkErrorDialog(
                                _emailError ?? "", "Please enter a email");
                            return;
                          }

                          if (password.isNotEmpty) {
                            if (password.length < 8) {
                              setState(() {
                                _passError = "Password is too short";
                              });
                              await showOkErrorDialog(_passError ?? "",
                                  "Please enter password at least 8 characters");
                              return;
                            }
                          } else {
                            setState(() {
                              _passError = "Password is required";
                            });
                            await showOkErrorDialog(
                                _passError ?? "", "Please enter a password");
                            return;
                          }

                          if (_emailError != null || _passError != null) {
                            return;
                          }
                          bool? result =
                              AuthService.instance.login(email, password);
                          if (!result) {
                            await showAlertDialog(
                                context: context,
                                message: "There is a no user in database");
                          }
                        },
                      ),
                    ),
                    ScreenUtil.verticalSpace(height: 36),
                    Text(
                      "Or continue with",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    ScreenUtil.verticalSpace(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: Image.asset(
                            "assets/images/png/apple.png",
                            height: 44,
                            width: 44,
                          ),
                          onPressed: () async {},
                        ),
                        IconButton(
                          icon: Image.asset(
                            "assets/images/png/google.png",
                            height: 44,
                            width: 44,
                          ),
                          onPressed: () async {},
                        ),
                        IconButton(
                          icon: Image.asset(
                            "assets/images/png/facebook.png",
                            height: 44,
                            width: 44,
                          ),
                          onPressed: () async {},
                        ),
                      ],
                    ),
                    const Spacer(),
                    RichText(
                      text: TextSpan(
                        text: "Don't have an account? ",
                        style: Theme.of(context).textTheme.bodyMedium,
                        children: [
                          TextSpan(
                            text: "Sign Up",
                            style: Theme.of(context).textTheme.bodyLarge,
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const SignUpPage()),
                                  ),
                          ),
                        ],
                      ),
                    ),
                    ScreenUtil.verticalSpace(height: 32),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
