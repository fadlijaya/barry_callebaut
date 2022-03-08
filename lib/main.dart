import 'package:barry_callebaut/users/koordinator/view/login_page.dart';
import 'package:barry_callebaut/users/opsi_login_page.dart';
import 'package:barry_callebaut/users/petugas/view/login_page.dart';
import 'package:barry_callebaut/users/petugas/view/add_agenda/add_agenda_page.dart';
import 'package:barry_callebaut/users/petugas/view/initial_page.dart';
import 'package:barry_callebaut/users/petugas/view/register_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Barry Callebaut',
      theme: ThemeData(
        primarySwatch: Colors.green,
        fontFamily: 'Poppins'
      ),
      routes: {
        '/loginPageKoordinator': (_) =>  const LoginPageKoordinator(),
        '/loginPagePetugas': (_) =>  const LoginPagePetugas(),
        '/registerPagePetugas': (_) =>  const RegisterPagePetugas(),
        '/initialPage': (_) =>  const InitialPage(),
        '/addAgendaPage': (_) =>  const AddAgendaPage()
      },
      home: const OpsiLoginPage(),
    );
  }
}