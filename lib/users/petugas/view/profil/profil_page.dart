import 'package:barry_callebaut/users/opsi_login_page.dart';
import 'package:barry_callebaut/users/theme/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../theme/padding.dart';

class ProfilPage extends StatefulWidget {
  const ProfilPage({Key? key}) : super(key: key);

  @override
  _ProfilPageState createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: Stack(
          children: [backgroundHeader(), profil(), buttonOpsi()],
        ),
      ),
    );
  }

  Widget backgroundHeader() {
    return Container(
      width: double.infinity,
      height: 200,
      color: kGreen2,
      padding: const EdgeInsets.all(padding),
    );
  }

  Widget profil() {
    return Positioned(
      top: 60,
      left: 0,
      right: 0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipOval(
              child: Image.network(
            "https://bidinnovacion.org/economiacreativa/wp-content/uploads/2014/10/speaker-3.jpg",
            width: 72,
            height: 72,
            fit: BoxFit.cover,
          )),
          const SizedBox(
            height: 12,
          ),
          const Text(
            'Miswar Al-Qadri',
            style: TextStyle(
                color: kWhite, fontWeight: FontWeight.bold, fontSize: 20),
          )
        ],
      ),
    );
  }

  Widget buttonOpsi() {
    return Positioned(
      top: 200,
      left: 0,
      right: 0,
      child: Column(
        children: [
          GestureDetector(
            onTap: () {},
            child: ListTile(
              leading: const Icon(Icons.account_circle_rounded),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    'Data Pribadi',
                    style:
                        TextStyle(color: kBlack, fontWeight: FontWeight.w400),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                    color: kBlack,
                  )
                ],
              ),
            ),
          ),
          const Divider(
            thickness: 1,
          ),
          GestureDetector(
            onTap: (){},
            child: ListTile(
              leading: const Icon(Icons.exit_to_app),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    'Log out',
                    style:
                        TextStyle(color: kBlack, fontWeight: FontWeight.w400),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                    color: kBlack,
                  )
                ],
              ),
            ),
          ),
          const Divider(
            thickness: 1,
          ),
        ],
      ),
    );
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const OpsiLoginPage()),
        (route) => false);
  }
}
