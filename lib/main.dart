import 'package:flutter/foundation.dart';  // To detect platform
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:login/notes_page.dart';
import 'login_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'register_page.dart';
import 'util/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyCtQWSkhvHgu6HCHWe3uDjjGbNhI2pnFnA",
        authDomain: "noteapp-41fc2.firebaseapp.com",
        projectId: "noteapp-41fc2",
        storageBucket: "noteapp-41fc2.firebasestorage.app",
        messagingSenderId: "434419901821",
        appId: "1:434419901821:web:7056ddc157e21ab9805814",
      ),
    );
  } else {
    await Firebase.initializeApp();
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


 

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        primaryTextTheme: GoogleFonts.poppinsTextTheme()),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => Loginpage(),
        MyRoutes.notes: (context) => NotesPage(),
         MyRoutes.register: (context) => RegisterPage(),
      }
     
    );
  }
}




