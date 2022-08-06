import 'package:barry_callebaut/theme/colors.dart';
import 'package:barry_callebaut/theme/padding.dart';
import 'package:flutter/material.dart';

class NotifikasiPage extends StatefulWidget {
  const NotifikasiPage({Key? key}) : super(key: key);

  @override
  State<NotifikasiPage> createState() => _NotifikasiPageState();
}

class _NotifikasiPageState extends State<NotifikasiPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: kGreen2,
        title: const Text("Notifikasi"), centerTitle: true,),
      body: Container(
        width: size.width,
        height: size.height,
        padding: const EdgeInsets.all(padding),
        child: SingleChildScrollView(
          child: Column(
            children: [],
          ),
        ),
      ),
    );
  }
}
