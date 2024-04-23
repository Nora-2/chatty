
import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scholar_chat/feateures/chat/cubit/chat_cubit.dart';
import 'package:scholar_chat/core/helper/firebase_options.dart';
import 'package:scholar_chat/feateures/login/presentation/view/Login_screen.dart';
import 'package:scholar_chat/feateures/openeing/presentaion/view/splash_screen.dart';
import 'package:scholar_chat/feateures/register/presentation/view/Register_Screen.dart';
import 'package:scholar_chat/feateures/chat/presentation/view/chat_screen.dart';
import 'package:scholar_chat/feateures/login/presentation/cubit/login_cubit.dart';
import 'package:scholar_chat/feateures/register/presentation/cubit/register_cubit.dart';
import 'package:scholar_chat/feateures/chat/presentation/widget/messanger.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(DevicePreview( 
    enabled: true, 
    builder: (context) => MyApp() 
  )); 
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LoginCubit()),
        BlocProvider(create: (context) => RegisterCubit()),
        BlocProvider(create: (context) => ChatCubit()),
      ],
      child: MaterialApp(
        routes: {
          RegisterScreen.id: (context) => RegisterScreen(),
          LoginScreen.id: (context) => LoginScreen(),
          Chat_Screen.id: (context) =>const Chat_Screen(),
          Messanger.id: (context) => Messanger(),
          SplashScreen.id:(context) =>const SplashScreen(),
        },
        initialRoute: SplashScreen.id,
               
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
