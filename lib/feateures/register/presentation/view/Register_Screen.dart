// ignore_for_file: must_be_immutable, file_names, non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:scholar_chat/core/constants/colorconstant.dart';
import 'package:scholar_chat/core/constants/constants.dart';
import 'package:scholar_chat/core/constants/image_constant.dart';
import 'package:scholar_chat/core/utils/checker.dart';
import 'package:scholar_chat/core/utils/function/buttons.dart';
import 'package:scholar_chat/core/utils/styles.dart';
import 'package:scholar_chat/feateures/login/presentation/view/Login_screen.dart';
import 'package:scholar_chat/feateures/login/presentation/cubit/login_cubit.dart';
import 'package:scholar_chat/feateures/register/presentation/cubit/register_cubit.dart';
import 'package:scholar_chat/feateures/register/presentation/view/customformfield.dart';


class RegisterScreen extends StatefulWidget {
  static String id = 'RegisterPage';

  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final usercreate = FirebaseFirestore.instance.collection('users');

  String? email;

  String? username;

  String? password;

  TextEditingController Email = TextEditingController();

  TextEditingController Password = TextEditingController();

  TextEditingController Username = TextEditingController();

  bool isLoading = false;

  final GlobalKey<FormState> _formkey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state is RegisterLoading) {
          isLoading = true;
        } else if (state is RegisterSuccess) {
          Navigator.pop(context);
          isLoading = false;
        } else if (state is RegisterFailure) {
          show_Snackbar(context, state.error!);
          isLoading = false;
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: isLoading,
          child: Scaffold(
              body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: size.height * .07,
                  ),
                  Center(
                      child: Image.asset(
                    ImageConstant.signup,
                    width: 270,
                    height: 170,
                  )),
                  SizedBox(
                    height: size.height * .001,
                  ),
                  CustomTextfont24_900(text: 'Sign Up'),
                  SizedBox(
                    height: size.height * .003,
                  ),
                  Form(
                    key: _formkey,
                    child: Card(
                      shadowColor: black,
                      elevation: 8,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomTextfont16_500(text: 'UserName'),
                            SizedBox(
                              height: size.height * .015,
                            ),
                            CustomFormField(
                                onChanged: (data) {
                                  username = data;
                                },
                                ispass: false,
                                val: (name) {
                                  if (name == null ||
                                      name.isEmpty ||
                                      !Checker.checkName(name)) {
                                    return 'Invalid Name';
                                  }
                                  return null;
                                },
                                hint: 'Enter your Name',
                                preicon: const Icon(
                                  Icons.person,
                                  size: 24,
                                  color: kcolor,
                                ),
                                controller: Username),
                            SizedBox(
                              height: size.height * .02,
                            ),
                            CustomTextfont16_500(
                              text: 'Email',
                            ),
                            SizedBox(
                              height: size.height * .015,
                            ),
                            CustomFormField(
                                onChanged: (data) {
                                  email = data;
                                },
                                ispass: false,
                                hint: 'Enter your Email',
                                preicon: const Icon(
                                  Icons.email,
                                  size: 20,
                                  color: kcolor,
                                ),
                                val: (email) {
                                  if (email == null ||
                                      email.isEmpty ||
                                      !Checker.checkEmail(email)) {
                                    return 'Invalid email';
                                  }
                                  return null;
                                },
                                controller: Email),
                            SizedBox(
                              height: size.height * .02,
                            ),
                            CustomTextfont16_500(
                              text: 'Password',
                            ),
                            SizedBox(
                              height: size.height * .015,
                            ),
                            CustomFormField(
                                onChanged: (data) {
                                  password = data;
                                },
                                hint: 'Enter password',
                                ispass: RegisterCubit.get(context).ispassword,
                                preicon: const Icon(
                                  Icons.lock,
                                  size: 20,
                                  color: kcolor,
                                ),
                                val: (pass) {
                                  if (pass == null || pass.isEmpty) {
                                    return 'Invalid Password';
                                  }
                                  return null;
                                },
                                suffix: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        RegisterCubit.get(context).changepass();
                                      });
                                    },
                                    icon: LoginCubit.get(context).ispassword
                                        ? const Icon(
                                            Icons.visibility_off,
                                            size: 20,
                                            color: kcolor,
                                          )
                                        : const Icon(
                                            Icons.visibility,
                                            size: 20,
                                            color: kcolor,
                                          )),
                                controller: Password),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height * .02,
                  ),
                  Center(
                    child: GestureDetector(
                         onTap: () async {
                        if (_formkey.currentState!.validate()) {
                          BlocProvider.of<RegisterCubit>(context).CreateUser(
                              email: email!,
                              password: password!,
                              username: username!);
                        }
                      },
                        child:
                            customButtonContainer(size: size, text: 'Sign Up')),
                  ),
                  SizedBox(
                    height: size.height * .02,
                  ),
                  seprator(size: size),
                  SizedBox(
                    height: size.height * .02,
                  ),
                  socialmedia(size: size),
                  SizedBox(
                    height: size.height * .02,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const customtext50014(
                        text: "Already have an account?",
                      ),
                      SizedBox(
                        width: size.width * .009,
                      ),
                      GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const LoginScreen(),
                              ),
                            );
                          },
                          child: CustomTextfont12_700(
                            text: 'sign In',
                          )),
                    ],
                  ),
                ],
              ),
            ),
          )),
        );
      },
    );
  }

  void show_Snackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }
}
