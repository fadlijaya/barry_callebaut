import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/material.dart';

import '../../../../../theme/colors.dart';
import '../../../../../theme/padding.dart';

class DetailPetaniPage extends StatefulWidget {
  final bool isEdit;
  final String uid;
  final String docId;
  final String namaPetani;
  final String alamat;
  final String noHp;
  final String jekel;
  final String statusNikah;
  final String tanggalLahir;
  final String kelompok;
  final String dusun;
  final String kecamatan;
  final String kabupaten;
  const DetailPetaniPage(
      {Key? key,
      required this.isEdit,
      required this.uid,
      required this.docId,
      required this.namaPetani,
      required this.alamat,
      required this.noHp,
      required this.jekel,
      required this.statusNikah,
      required this.tanggalLahir,
      required this.kelompok,
      required this.dusun,
      required this.kecamatan,
      required this.kabupaten})
      : super(key: key);

  @override
  State<DetailPetaniPage> createState() => _DetailPetaniPageState();
}

class _DetailPetaniPageState extends State<DetailPetaniPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _controllerUid = TextEditingController();
  final TextEditingController _controllerDocId = TextEditingController();
  final TextEditingController _controllerNamaPetani = TextEditingController();
  final TextEditingController _controllerAlamat = TextEditingController();
  final TextEditingController _controllerNoHp = TextEditingController();
  final TextEditingController _controllerJekel = TextEditingController();
  final TextEditingController _controllerStatusNikah = TextEditingController();
  final TextEditingController _controllerTanggalLahir = TextEditingController();
  final TextEditingController _controllerKelompok = TextEditingController();
  final TextEditingController _controllerDusun = TextEditingController();
  final TextEditingController _controllerKecamatan = TextEditingController();
  final TextEditingController _controllerKabupaten = TextEditingController();

  @override
  void initState() {
    if (widget.isEdit) {
      setState(() {
        _controllerUid.text = widget.uid;
        _controllerDocId.text = widget.docId;
        _controllerNamaPetani.text = widget.namaPetani;
        _controllerAlamat.text = widget.alamat;
        _controllerNoHp.text = widget.noHp;
        _controllerJekel.text = widget.jekel;
        _controllerStatusNikah.text = widget.statusNikah;
        _controllerTanggalLahir.text = widget.tanggalLahir;
        _controllerKelompok.text = widget.kelompok;
        _controllerDusun.text = widget.dusun;
        _controllerKecamatan.text = widget.kecamatan;
        _controllerKabupaten.text = widget.kabupaten;
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
                "Uid",
                style: TextStyle(color: kBlack, fontSize: 12),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: TextFormField(
                  readOnly: true,
                  controller: _controllerUid,
                  style: const TextStyle(color: kBlack6),
                  decoration: const InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: kGrey)),
                      hintText: ''),
                ),
              ),
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
                "Alamat",
                style: TextStyle(color: kBlack, fontSize: 12),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: TextFormField(
                  controller: _controllerAlamat,
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
                  textInputAction: TextInputAction.next,
                  maxLength: 13,
                  decoration: const InputDecoration(
                      hintStyle: TextStyle(color: kGreen2),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: kGreen2)),
                      hintText: ''),
                ),
              ),
              const Text(
                "Jenis Kelamin",
                style: TextStyle(color: kBlack, fontSize: 12),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: TextFormField(
                  controller: _controllerJekel,
                  readOnly: true,
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
                "Status Nikah",
                style: TextStyle(color: kBlack, fontSize: 12),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: TextFormField(
                  controller: _controllerStatusNikah,
                  readOnly: true,
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
                "Tanggal Lahir",
                style: TextStyle(color: kBlack, fontSize: 12),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: TextFormField(
                  controller: _controllerTanggalLahir,
                  readOnly: true,
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
                "Kelompok",
                style: TextStyle(color: kBlack, fontSize: 12),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: TextFormField(
                  controller: _controllerKelompok,
                  readOnly: true,
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
                "Dusun",
                style: TextStyle(color: kBlack, fontSize: 12),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: TextFormField(
                  controller: _controllerDusun,
                  readOnly: true,
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
                "Kecamatan",
                style: TextStyle(color: kBlack, fontSize: 12),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: TextFormField(
                  controller: _controllerKecamatan,
                  readOnly: true,
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
                "Kabupaten",
                style: TextStyle(color: kBlack, fontSize: 12),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: TextFormField(
                  controller: _controllerKabupaten,
                  readOnly: true,
                  cursorColor: kGreen2,
                  textInputAction: TextInputAction.done,
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
          .doc(widget.docId);

      FirebaseFirestore.instance.runTransaction((transaction) async {
        DocumentSnapshot documentSnapshot =
            await transaction.get(documentReference1);

        if (documentSnapshot.exists) {
          transaction.update(documentReference1, <String, dynamic>{
            'nama_petani': _controllerNamaPetani.text,
            'alamat': _controllerAlamat.text,
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

  CollectionReference dataSensus =
      FirebaseFirestore.instance.collection('data_sensus');

  Future updateDataSensus() {
    return dataSensus.doc(widget.docId).update({
      'nama_petani': _controllerNamaPetani.text,
      'alamat': _controllerAlamat.text,
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
