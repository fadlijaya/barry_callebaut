import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/material.dart';

import '../../../../../theme/padding.dart';

class DetailPetaniPage extends StatefulWidget {
  const DetailPetaniPage({Key? key}) : super(key: key);

  @override
  State<DetailPetaniPage> createState() => _DetailPetaniPageState();
}

class _DetailPetaniPageState extends State<DetailPetaniPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Data Personal Petani"),),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
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
