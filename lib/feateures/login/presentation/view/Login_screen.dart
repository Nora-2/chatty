// ignore_for_file: must_be_immutable, file_names, non_constant_identifier_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:scholar_chat/core/constants/colorconstant.dart';
import 'package:scholar_chat/core/constants/constants.dart';
import 'package:scholar_chat/core/constants/image_constant.dart';
import 'package:scholar_chat/core/utils/checker.dart';
import 'package:scholar_chat/core/utils/function/buttons.dart';
import 'package:scholar_chat/core/utils/styles.dart';
import 'package:scholar_chat/feateures/register/presentation/view/Register_Screen.dart';
import 'package:scholar_chat/feateures/login/presentation/cubit/login_cubit.dart';
import 'package:scholar_chat/feateures/register/presentation/view/customformfield.dart';
import 'package:scholar_chat/feateures/chat/presentation/widget/messanger.dart';



class LoginScreen extends StatefulWidget {
  static String id = 'LoginPage';

  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
    TextEditingController Email = TextEditingController();
  TextEditingController Password = TextEditingController();

  final user = FirebaseAuth.instance.currentUser;

  String? email;

  String? uid;

  String? password;

  bool isLoading = false;

  GlobalKey<FormState> formkey = GlobalKey();

  @override
  Widget build(BuildContext context) {
        final size = MediaQuery.of(context).size;
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginLoading) {
          isLoading = true;
        } else if (state is LoginSuccess) {
          uid = BlocProvider.of<LoginCubit>(context).uid;

          Navigator.pushNamed(context, Messanger.id, arguments: uid);
          isLoading = false;
        } else if (state is LoginFailure) {
          show_Snackbar(context, state.error.toString());
          isLoading = false;

        }
      },
      child: ModalProgressHUD(
        inAsyncCall: isLoading,
        child:Scaffold(
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
                          ImageConstant.signin,
                          width: 250,
                          height: 210,
                        )),
                        SizedBox(
                          height: size.height * .001,
                        ),
                        CustomTextfont24_900(
                          text: 'Sign In',
                        ),
                        SizedBox(
                          height: size.height * .001,
                        ),
                        Form(
                          key: formkey,
                          child: Card(
                            shadowColor:   black,
                            elevation: 8,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
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
                                      ispass: LoginCubit.get(context).ispassword,
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
                                              LoginCubit.get(context)
                                                  .changepass();
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                              onTap: () {
                                {
                                  
                                }
                              },
                              child: const customtext50014(
                                text: 'forgot password?',
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: size.height * .02,
                        ),
                        Center(
                          child: GestureDetector(
                             onTap: () async {
                      if (formkey.currentState!.validate()) {
                        BlocProvider.of<LoginCubit>(context)
                            .sign_in(email: email!, password: password!);
                      }
                    
                            },
                            child: customButtonContainer(
                              size: size,
                              text: 'Sign In',
                            ),
                          ),
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
                              text: "Don't have an account?",
                            ),
                            SizedBox(
                              width: size.width * .009,
                            ),
                            GestureDetector(
                                onTap: ()  {
                                
                                   Navigator.pushNamed(context, RegisterScreen.id);
                                    
                                  
                                },
                                child: CustomTextfont12_700(
                                  text: 'sign up',
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
  }

  Future<void> sign_in() async {
    // ignore: unused_local_variable
    final user = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email!,
      password: password!,
    );
    uid = user.user!.uid;
  }
}

void show_Snackbar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
    ),
  );
}
