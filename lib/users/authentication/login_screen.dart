import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:mysql_app/components/custom_button.dart';
import 'package:mysql_app/components/custom_textfield.dart';
import 'package:mysql_app/models/user.dart';
import 'package:mysql_app/users/authentication/signup_screen.dart';
import 'package:mysql_app/users/fragments/dashboard.dart';
import 'package:mysql_app/users/fragments/profile_screen.dart';
import 'package:mysql_app/users/services/user_services.dart';

class LoginScreen extends StatefulWidget {
  // static const String id="/loginScreen";
  static const routeName = '/loginScreen';
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var isObscure = true.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login Screen"),
      ),
      body: LayoutBuilder(builder: (context, constraint) {
        return ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 450,
            minWidth: 300,
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.person_outlined,
                        color: Colors.blueAccent,
                        size: 150,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      CustomTextField(
                        label: "Email",
                        controller: emailController,
                        prefixIcon: Icons.email,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Obx(
                        () => CustomTextField(
                          label: "Password",
                          obscure: isObscure.value,
                          controller: passwordController,
                          prefixIcon: Icons.vpn_key,
                          suffixIcon: Obx(() => GestureDetector(
                                child: Icon(isObscure.value
                                    ? Icons.visibility_off
                                    : Icons.visibility),
                                onTap: () {
                                  isObscure.value = !isObscure.value;
                                },
                              )),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      CustomButton(
                        text: "Login",
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            User user = User(
                                name: "unknown",
                                email: emailController.text.trim(),
                                pass: passwordController.text.trim(),
                                id: 0);
                            UserServices.userLogin(user, context);
                            // context.go(ProfileScreen.routeName);
                          }
                        },
                        width: constraint.maxWidth,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Don't have account?"),
                          GestureDetector(
                              onTap: () {
                                context.go(SignUpScreen.routeName);
                                // Navigator.pushReplacementNamed(
                                //     context, '/signUpScreen');
                                // Beamer.of(context)
                                //     .beamToReplacementNamed('/signUpScreen');
                              },
                              child: const Text(
                                "Sign up",
                                style: TextStyle(color: Colors.blue),
                              )),
                        ],
                      ),
                      const Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Are you a Admin?"),
                          GestureDetector(
                              onTap: () {},
                              child: const Text(
                                "Admin panel",
                                style: TextStyle(color: Colors.blue),
                              )),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
