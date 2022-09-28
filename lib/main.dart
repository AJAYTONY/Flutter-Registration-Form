import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo_registration_page/screens/register/RegisterScreen.dart';
import 'package:neo_registration_page/screens/your_address/your_address.dart';
import 'package:neo_registration_page/screens/your_info/your_info.dart';
import 'package:neo_registration_page/utils/app_colors.dart';
import 'package:neo_registration_page/viewModel/provider/register_notifier.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  //runApp(const MyApp());
  runApp(ChangeNotifierProvider(
    create: (_) => RegisterNotifier(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: AppColors.primaryColor,
        primarySwatch: AppColors.primarySwatch,
        textTheme: TextTheme(
          headline3: const TextStyle(
            color: AppColors.secondaryColor,
            fontSize: 40,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.8,
          ),
          labelMedium:
              TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[500]!),
          bodyText1: TextStyle(
            color: Colors.grey[400]!,
            fontSize: 16,
          ),
          bodyText2: TextStyle(
            fontWeight: FontWeight.w900,
            color: Colors.grey[700]!,
            fontSize: 20,
          ),
          subtitle2: TextStyle(
            color: Colors.grey[500],
            letterSpacing: 0.5,
            fontSize: 14,
          ),
        ),
      ),
      home: RegisterScreen(),

    );
  }
}

/*
*
 Container(
        height: 70,
        width: 70,
        decoration: BoxDecoration(
            //color: Colors.grey,
            //image: Icon(Icons.person),
            borderRadius: BorderRadius.circular(50),
            border: Border.all(color: Colors.black87, width: 1)),
      )
      *
*/


