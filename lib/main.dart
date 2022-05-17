import 'package:barry_callebaut/users/koordinator/view/login_page.dart';
import 'package:barry_callebaut/users/opsi_login_page.dart';
import 'package:barry_callebaut/users/petugas/view/agenda/agenda_page.dart';
import 'package:barry_callebaut/users/petugas/view/create_agenda/create_agenda_page.dart';
import 'package:barry_callebaut/users/petugas/view/login_page.dart';
import 'package:barry_callebaut/users/petugas/view/initial_page.dart';
import 'package:barry_callebaut/users/petugas/view/register_page.dart';
import 'package:barry_callebaut/users/petugas/view/sensus/sensus_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
        '/agendaPage': (_) => const AgendaPage(),
        //'/addAgendaPage': (_) =>  const CreateAgendaPage()
        '/sensusPage': (_) => const SensusPage()
      },
      home: const OpsiLoginPage(),
    );
  }
}