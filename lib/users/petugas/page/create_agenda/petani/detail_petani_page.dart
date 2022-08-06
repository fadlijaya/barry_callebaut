import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/material.dart';

import '../../../../../theme/colors.dart';
import '../../../../../theme/padding.dart';

class DetailPetaniPage extends StatefulWidget {
  final bool isEdit;
  final String docId;
  final String docIdPetani;
  final String namaPetani;
  final String desaKelurahan;
  final String noHp;
  const DetailPetaniPage(
      {Key? key,
      required this.isEdit,
      required this.docId,
      required this.docIdPetani,
      required this.namaPetani,
      required this.desaKelurahan,
      required this.noHp})
      : super(key: key);

  @override
  State<DetailPetaniPage> createState() => _DetailPetaniPageState();
}

class _DetailPetaniPageState extends State<DetailPetaniPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _controllerDocId = TextEditingController();
  final TextEditingController _controllerDocIdPetani = TextEditingController();
  final TextEditingController _controllerNamaPetani = TextEditingController();
  final TextEditingController _controllerDesaKelurahan = TextEditingController();
  final TextEditingController _controllerNoHp = TextEditingController();

  @override
  void initState() {
    if (widget.isEdit) {
      setState(() {
        _controllerDocId.text = widget.docId;
        _controllerDocIdPetani.text = widget.docIdPetani;
        _controllerNamaPetani.text = widget.namaPetani;
        _controllerDesaKelurahan.text = widget.desaKelurahan;
        _controllerNoHp.text = widget.noHp;
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kGreen2,
        title: const Text("Data Personal Petani"),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.all(padding),
        child: SingleChildScrollView(
          child: Column(
            children: [formDataPetani(), buttonUpdateForm()],
          ),
        ),
      ),
    );
  }

  Widget formDataPetani() {
    return Form(
        key: _formKey,
        child: Container(
          margin: const EdgeInsets.only(bottom: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "DocID",
                style: TextStyle(color: kBlack, fontSize: 12),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: TextFormField(
                  readOnly: true,
                  controller: _controllerDocId,
                  style: const TextStyle(color: kBlack6),
                  decoration: const InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: kGrey)),
                      hintText: ''),
                ),
              ),
              const Text(
                "DocID Petani",
                style: TextStyle(color: kBlack, fontSize: 12),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: TextFormField(
                  readOnly: true,
                  controller: _controllerDocIdPetani,
                  style: const TextStyle(color: kBlack6),
                  decoration: const InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: kGrey)),
                      hintText: ''),
                ),
              ),
              const Text(
                "Nama Petani",
                style: TextStyle(color: kBlack, fontSize: 12),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: TextFormField(
                  controller: _controllerNamaPetani,
                  cursorColor: kGreen2,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                      hintStyle: TextStyle(color: kGreen2),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: kGreen2)),
                      hintText: ''),
                ),
              ),
              const Text(
                "Desa Kelurahan",
                style: TextStyle(color: kBlack, fontSize: 12),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: TextFormField(
                  controller: _controllerDesaKelurahan,
                  cursorColor: kGreen2,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                      hintStyle: TextStyle(color: kGreen2),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: kGreen2)),
                      hintText: ''),
                ),
              ),
              const Text(
                "Nomor HP",
                style: TextStyle(color: kBlack, fontSize: 12),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: TextFormField(
                  controller: _controllerNoHp,
                  cursorColor: kGreen2,
                  keyboardType: TextInputType.phone,
                  textInputAction: TextInputAction.done,
                  maxLength: 13,
                  decoration: const InputDecoration(
                      hintStyle: TextStyle(color: kGreen2),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: kGreen2)),
                      hintText: ''),
                ),
              ),
            ],
          ),
        ));
  }

  Widget buttonUpdateForm() {
    return ElevatedButton(
        onPressed: updateFormData,
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(kGreen2),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8)))),
        child: Container(
          width: double.infinity,
          height: 48,
          margin: const EdgeInsets.only(
            left: 24,
            right: 24,
          ),
          child: const Center(
            child: Text("Update"),
          ),
        ));
  }

  Future<dynamic> updateFormData() async {
    if (widget.isEdit) {
      DocumentReference documentReference1 = FirebaseFirestore.instance
          .collection('petugas')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("agenda_sensus")
          .doc(widget.docId)
          .collection("data_petani")
          .doc(widget.docIdPetani);

      FirebaseFirestore.instance.runTransaction((transaction) async {
        DocumentSnapshot documentSnapshot =
            await transaction.get(documentReference1);

        if (documentSnapshot.exists) {
          transaction.update(documentReference1, <String, dynamic>{
            'nama_petani': _controllerNamaPetani.text,
            'desa_kelurahan': _controllerDesaKelurahan.text,
            'no_hp': _controllerNoHp.text,
          });
        }
      });

      updateDataSensus();
      infoUpdate();
    }

    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pop(context);
    });
  }

  CollectionReference dataSensus = FirebaseFirestore.instance.collection('data_sensus');

  Future updateDataSensus() {
    return dataSensus.doc(widget.docIdPetani).update({
      'nama_petani': _controllerNamaPetani.text,
      'desa_kelurahan': _controllerDesaKelurahan.text,
      'no_hp': _controllerNoHp.text,
    });
  }

  infoUpdate() {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Text(
                  "Data Berhasil di Update",
                  style: TextStyle(color: kBlack),
                ),
              ],
            ),
          );
        });
  }
}
