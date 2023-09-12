import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:mysql_app/components/custom_button.dart';
import 'package:mysql_app/components/custom_textfield.dart';
import 'package:mysql_app/models/user.dart';
import 'package:mysql_app/users/authentication/login_screen.dart';
import 'package:mysql_app/users/services/user_services.dart';

class SignUpScreen extends StatefulWidget {
  // static const String id = "/signUpScreen";
  static const routeName = '/signUpScreen';
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var isObscure = true.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign Up Screen"),
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
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
                        label: "Name",
                        controller: nameController,
                        prefixIcon: Icons.person,
                      ),
                      const SizedBox(
                        height: 20,
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
                        text: "Sign up",
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            User user = User(
                              name: nameController.text,
                              email: emailController.text,
                              pass: passwordController.text,
                              phoneNumber: "",
                              level: 0,
                            );
                            UserServices.registerUser(user, context);
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
                          const Text("Already have account?"),
                          GestureDetector(
                              onTap: () {
                                // Navigator.pushReplacementNamed(context, LoginScreen.id);
                                // Beamer.of(context)
                                //     .beamToReplacementNamed('/loginScreen');
                                // Navigator.pushReplacementNamed(
                                //     context, '/loginScreen');
                                context.go(LoginScreen.routeName);
                              },
                              child: const Text(
                                "Sign in",
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
