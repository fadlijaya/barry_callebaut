import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'theme/colors.dart';
import 'theme/padding.dart';

class OpsiLoginUsers extends StatefulWidget {
  const OpsiLoginUsers({Key? key}) : super(key: key);

  @override
  State<OpsiLoginUsers> createState() => _OpsiLoginUsersState();
}

class _OpsiLoginUsersState extends State<OpsiLoginUsers> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor: kGrey,
        body: SizedBox(
          width: size.width,
          height: size.height,
          child: Stack(
            children: [header(), body()],
          ),
        ));
  }

  Widget header() {
    return Positioned(
      top: 160,
      left: 0,
      right: 0,
      child: Column(
        children: [
          SvgPicture.asset(
            "assets/logo.svg",
          ),
          const SizedBox(
            height: 16,
          ),
          const Text(
            "Barry Callebaut",
            style: TextStyle(
                fontWeight: FontWeight.w700, fontSize: 25, color: kBlack6),
          )
        ],
      ),
    );
  }

  Widget body() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: double.infinity,
        height: 360,
        padding: const EdgeInsets.all(padding),
        decoration: const BoxDecoration(
            color: kWhite,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            textDeskripsi(),
            const SizedBox(
              height: 48,
            ),
            buttonLoginPetugas(),
            const SizedBox(
              height: 16,
            ),
            buttonLoginKoordinator()
          ],
        ),
      ),
    );
  }

  Widget textDeskripsi() {
    return const Text(
      "Welcome Back!",
      style:
          TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: kBlack),
    );
  }

  //button login petugas
  Widget buttonLoginPetugas() {
    return ElevatedButton(
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(kGreen),
          shape: MaterialStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)))),
      onPressed: () => Navigator.pushNamed(context, '/loginPagePetugas'),
      child: Container(
        margin: const EdgeInsets.only(left: 24, right: 24),
        width: double.infinity,
        height: 48,
        child: const Center(
          child: Text(
            'Login sebagai Petugas',
            style: TextStyle(color: kWhite, fontSize: 16.0),
          ),
        ),
      ),
    );
  }

  //button login koordinator
  Widget buttonLoginKoordinator() {
    return ElevatedButton(
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(kWhite),
          shape: MaterialStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)))),
      onPressed: () => Navigator.pushNamed(context, '/loginPageKoordinator'),
      child: Container(
        margin: const EdgeInsets.only(left: 24, right: 24),
        width: double.infinity,
        height: 48,
        child: const Center(
          child: Text(
            'Login sebagai Koordinator',
            style: TextStyle(color: kGreen2, fontSize: 16.0),
          ),
        ),
      ),
    );
  }
}
