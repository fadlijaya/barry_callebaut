import 'package:barry_callebaut/users/opsi_login_page.dart';
import 'package:barry_callebaut/users/theme/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../theme/padding.dart';

class ProfilPage extends StatefulWidget {
  const ProfilPage({Key? key}) : super(key: key);

  @override
  _ProfilPageState createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  String? uid;
  String? username;

  @override
  void initState() {
    getUser();
    super.initState();
  }

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
          Text(
            "$username",
            style: const TextStyle(
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
            onTap: exitDialog,
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

  exitDialog() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Konfirmasi'),
            content: const Text('Ingin Keluar ?'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Batal',
                    style: TextStyle(color: Colors.grey),
                  )),
              ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(kGreen2),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)))),
                  onPressed: signOut,
                  child: const Text(
                    'Ya',
                    style: TextStyle(color: kWhite),
                  )),
            ],
          );
        });
  }

  Future<dynamic> getUser() async {
    await FirebaseFirestore.instance
        .collection('petugas')
        .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((result) {
      if (result.docs.isNotEmpty) {
        setState(() {
          uid = result.docs[0].data()['uid'];
          username = result.docs[0].data()['username'];
        });
      }
    });
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const OpsiLoginPage()),
        (route) => false);
  }
}
