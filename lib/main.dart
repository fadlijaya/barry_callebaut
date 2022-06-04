import 'package:barry_callebaut/users/koordinator/page/login_page.dart';
import 'package:barry_callebaut/users/petugas/page/agenda/agenda_page.dart';
import 'package:barry_callebaut/users/petugas/page/login_page.dart';
import 'package:barry_callebaut/users/petugas/page/initial_page.dart';
import 'package:barry_callebaut/users/petugas/page/register_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'opsi_login_users.dart';

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
      theme: ThemeData(primarySwatch: Colors.green, fontFamily: 'Poppins'),
      routes: {
        '/loginPageKoordinator': (_) => const LoginPageKoordinator(),
        '/loginPagePetugas': (_) => const LoginPagePetugas(),
        '/registerPagePetugas': (_) => const RegisterPagePetugas(),
        '/initialPage': (_) => const InitialPage(),
        '/agendaPage': (_) => const AgendaPage(),
      },
      home: const OpsiLoginUsers(),
    );
  }
}
