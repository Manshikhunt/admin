import 'dart:io';

import 'package:admin/views/screens/main_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: kIsWeb || Platform.isAndroid
    ? const FirebaseOptions(
      apiKey:"AIzaSyCLDY21OS3NcUqQY41EG5ouG71Pxr-dUyg", 
      appId: "1:529055002647:web:7b7e4a9f9f1e88af6eec52", 
      messagingSenderId: "529055002647", 
      projectId: "eshop-59b65",
      storageBucket: "eshop-59b65.appspot.com")
    : null 
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MainScreen(),
      builder: EasyLoading.init(),
    );
  }
}

