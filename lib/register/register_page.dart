import 'package:anime_nation/register/bloc/register_bloc.dart';
import 'package:anime_nation/shared/data/user_credentials.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _registerBloc = RegisterBloc();

  @override
  void dispose() {
    _registerBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => SafeArea(
        child: Material(
      color: Color(int.parse("0xff181A20")),
      child: BlocProvider(
          create: (context) => _registerBloc, child: const RegisterBody()),
    ));
}

class RegisterBody extends StatefulWidget {
  const RegisterBody({super.key});

  @override
  State<RegisterBody> createState() => _RegisterBodyState();
}

class _RegisterBodyState extends State<RegisterBody> {
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var registerBloc = context.read<RegisterBloc>();

    return BlocListener<RegisterBloc, RegisterState>(
      listener: (context, state) {
        if (state is RegisterCompleted) {
          Navigator.of(context).pushNamed("/dashboard");
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
                  "Create your account now and enjoy watching popular movie or series!",
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
                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
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
                      onPressed: () => registerBloc.add(RegisterDetailsEvent(
                          credentials: UserCredentials(
                              username: _userController.text,
                              password: _passwordController.text))),
                      child: const Text("Sign Up",
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
                    onTap: () => Navigator.of(context).pop(),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Already have an account? Sign In",
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
