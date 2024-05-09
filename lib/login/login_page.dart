import 'package:anime_nation/login/bloc/login_bloc.dart';
import 'package:anime_nation/shared/data/user_credentials.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toast/toast.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _loginBloc = LoginBloc();

  @override
  void dispose() {
    _loginBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => SafeArea(
      child: Material(
        color: Color(int.parse("0xff181A20")),
        child: BlocProvider(
            create: (context) => _loginBloc, child: const LoginBody()),
      ),
    );
}

class LoginBody extends StatefulWidget {
  const LoginBody({super.key});

  @override
  State<LoginBody> createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> {
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var loginBloc = context.read<LoginBloc>();
    ToastContext().init(context);

    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is SignInCompleted) {
          Navigator.of(context).pushNamed("/dashboard");
        } else if (state is SignInError) {
          Toast.show(state.error,
              duration: Toast.lengthLong, gravity: Toast.bottom);
        }
      },
      child: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Column(
              children: [
                const SizedBox(height: 100),
                const Icon(
                  Icons.movie,
                  color: Colors.white,
                  size: 100,
                ),
                const Text(
                  "Let's in! Login your account and explore some interesting movies or series.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: "SfProTextMedium",
                      color: Colors.white,
                      fontSize: 28),
                ),
                const SizedBox(height: 50),
                TextField(
                  controller: _userController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.email),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.red),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(color: Colors.white),
                    ),
                    filled: true,
                    hintStyle: TextStyle(
                        color: Colors.grey[600], fontFamily: "SfProTextMedium"),
                    labelStyle: const TextStyle(
                        color: Colors.white, fontFamily: "SfProTextMedium"),
                    hintText: "Email",
                    fillColor: Color(int.parse("0xff20222A")),
                  ),
                ),
                const SizedBox(height: 24),
                TextField(
                  controller: _passwordController,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.lock),
                    focusColor: Colors.red,
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.red),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(color: Colors.white),
                    ),
                    filled: true,
                    hintStyle: TextStyle(
                        color: Colors.grey[600], fontFamily: "SfProTextMedium"),
                    labelStyle: const TextStyle(
                        color: Colors.white, fontFamily: "SfProTextMedium"),
                    hintText: "Password",
                    fillColor: Color(int.parse("0xff20222A")),
                  ),
                ),
                const SizedBox(height: 4),
                Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: SizedBox(
                        width: 180,
                        child: CheckboxListTile(
                          checkColor: Colors.grey[600],
                          activeColor: Colors.grey[600],
                          value: false,
                          onChanged: (value) {},
                          controlAffinity: ListTileControlAffinity.leading,
                          contentPadding: EdgeInsets.zero,
                          title: const Text(
                            "Remember Me",
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: "SfProTextMedium",
                                fontSize: 14),
                          ),
                        ),
                      ),
                    ),
                    const Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "Forgot your password?",
                        style: TextStyle(
                            fontFamily: "SfProTextMedium",
                            color: Colors.red,
                            fontSize: 14),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                      onPressed: () {
                        loginBloc.add(SignInUserEvent(
                            credentials: UserCredentials(
                                username: _userController.text,
                                password: _passwordController.text)));
                      },
                      style: ButtonStyle(
                          overlayColor:
                              MaterialStateProperty.all<Color>(Colors.grey),
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.red),
                          shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                  side: const BorderSide(color: Colors.red)))),
                      child: const Text("Sign In",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontFamily: "SfProTextMedium",
                          ))),
                ),
                const SizedBox(height: 32),
                Align(
                  alignment: Alignment.center,
                  child: InkWell(
                    onTap: () => Navigator.of(context).pushNamed("/register"),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Don't have an account? Sign Up",
                        style: TextStyle(
                            fontFamily: "SfProTextMedium",
                            color: Colors.red,
                            fontSize: 14),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
