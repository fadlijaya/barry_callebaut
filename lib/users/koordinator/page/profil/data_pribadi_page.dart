import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../../theme/colors.dart';
import '../../../../theme/padding.dart';

class DataPribadiPage extends StatefulWidget {
  final String uid;
  final String fullname;
  final String username;
  final String idNumber;
  final String email;
  final String nik;
  final String nomorHp;
  final String lokasiKerja;
  final String jekel;
  final String agama;
  final String tglLahir;
  final String alamat;
  final bool isEdit;
  const DataPribadiPage(
      {Key? key,
      required this.uid,
      required this.fullname,
      required this.username,
      required this.idNumber,
      required this.email,
      required this.nik,
      required this.nomorHp,
      required this.lokasiKerja,
      required this.jekel,
      required this.agama,
      required this.tglLahir,
      required this.alamat,
      required this.isEdit})
      : super(key: key);

  @override
  State<DataPribadiPage> createState() => _DataPribadiPageState();
}

class _DataPribadiPageState extends State<DataPribadiPage> {
  String title = "Data Pribadi";

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _controllerFullname = TextEditingController();
  final TextEditingController _controllerUsername = TextEditingController();
  final TextEditingController _controllerIdNumber = TextEditingController();
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerNIK = TextEditingController();
  final TextEditingController _controllerNomorHp = TextEditingController();
  final TextEditingController _controllerLokasiKerja = TextEditingController();
  final TextEditingController _controllerJekel = TextEditingController();
  final TextEditingController _controllerAgama = TextEditingController();
  final TextEditingController _controllerTglLahir = TextEditingController();
  final TextEditingController _controllerAlamat = TextEditingController();

  @override
  void initState() {
    if (widget.isEdit) {
      setState(() {
        _controllerFullname.text = widget.fullname;
        _controllerUsername.text = widget.username;
        _controllerIdNumber.text = widget.idNumber;
        _controllerEmail.text = widget.email;
        _controllerNIK.text = widget.nik;
        _controllerNomorHp.text = widget.nomorHp;
        _controllerLokasiKerja.text = widget.lokasiKerja;
        _controllerJekel.text = widget.jekel;
        _controllerAgama.text = widget.agama;
        _controllerTglLahir.text = widget.tglLahir;
        _controllerAlamat.text = widget.alamat;
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: kGreen2,
        centerTitle: true,
      ),
      body: Container(
        width: size.width,
        height: size.height,
        padding: const EdgeInsets.all(padding),
        child: SingleChildScrollView(
          child: Column(
            children: [
              formProfil(),
              const SizedBox(
                height: 24,
              ),
              buttonUpdateForm(),
              const SizedBox(
                height: 24,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget formProfil() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Nama Lengkap",
            style: TextStyle(color: kBlack, fontSize: 12),
          ),
          TextFormField(
            controller: _controllerFullname,
            cursorColor: kGreen2,
            textInputAction: TextInputAction.next,
            decoration: const InputDecoration(
                hintStyle: TextStyle(color: kGreen2),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: kGreen2)),
                hintText: ''),
          ),
          const SizedBox(
            height: 8,
          ),
          const Text(
            "Username",
            style: TextStyle(color: kBlack, fontSize: 12),
          ),
          TextFormField(
            controller: _controllerUsername,
            cursorColor: kGreen2,
            textInputAction: TextInputAction.next,
            decoration: const InputDecoration(
                hintStyle: TextStyle(color: kGreen2),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: kGreen2)),
                hintText: ''),
          ),
          const SizedBox(
            height: 8,
          ),
          const Text(
            "Id Number",
            style: TextStyle(color: kBlack, fontSize: 12),
          ),
          TextFormField(
            controller: _controllerIdNumber,
            cursorColor: kGreen2,
            textInputAction: TextInputAction.next,
            decoration: const InputDecoration(
                hintStyle: TextStyle(color: kGreen2),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: kGreen2)),
                hintText: ''),
          ),
          const SizedBox(
            height: 8,
          ),
          const Text(
            "Email",
            style: TextStyle(color: kBlack, fontSize: 12),
          ),
          TextFormField(
            controller: _controllerEmail,
            cursorColor: kGreen2,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            decoration: const InputDecoration(
                hintStyle: TextStyle(color: kGreen2),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: kGreen2)),
                hintText: ''),
          ),
          const SizedBox(
            height: 8,
          ),
          const Text(
            "NIK",
            style: TextStyle(color: kBlack, fontSize: 12),
          ),
          TextFormField(
            controller: _controllerNIK,
            cursorColor: kGreen2,
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.next,
            decoration: const InputDecoration(
                hintStyle: TextStyle(color: kGreen2),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: kGreen2)),
                hintText: ''),
          ),
          const SizedBox(
            height: 8,
          ),
          const Text(
            "Nomor HP",
            style: TextStyle(color: kBlack, fontSize: 12),
          ),
          TextFormField(
            controller: _controllerNomorHp,
            cursorColor: kGreen2,
            keyboardType: TextInputType.phone,
            textInputAction: TextInputAction.next,
            decoration: const InputDecoration(
                hintStyle: TextStyle(color: kGreen2),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: kGreen2)),
                hintText: ''),
          ),
          const SizedBox(
            height: 8,
          ),
          const Text(
            "Lokasi Kerja",
            style: TextStyle(color: kBlack, fontSize: 12),
          ),
          TextFormField(
            controller: _controllerLokasiKerja,
            cursorColor: kGreen2,
            textInputAction: TextInputAction.next,
            decoration: const InputDecoration(
                hintStyle: TextStyle(color: kGreen2),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: kGreen2)),
                hintText: ''),
          ),
          const SizedBox(
            height: 8,
          ),
          const Text(
            "Jenis Kelamin",
            style: TextStyle(color: kBlack, fontSize: 12),
          ),
          TextFormField(
            controller: _controllerJekel,
            cursorColor: kGreen2,
            textInputAction: TextInputAction.next,
            decoration: const InputDecoration(
                hintStyle: TextStyle(color: kGreen2),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: kGreen2)),
                hintText: ''),
          ),
          const SizedBox(
            height: 8,
          ),
          const Text(
            "Agama",
            style: TextStyle(color: kBlack, fontSize: 12),
          ),
          TextFormField(
            controller: _controllerAgama,
            cursorColor: kGreen2,
            textInputAction: TextInputAction.next,
            decoration: const InputDecoration(
                hintStyle: TextStyle(color: kGreen2),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: kGreen2)),
                hintText: ''),
          ),
          const SizedBox(
            height: 8,
          ),
          const Text(
            "Tanggal Lahir",
            style: TextStyle(color: kBlack, fontSize: 12),
          ),
          TextFormField(
            controller: _controllerTglLahir,
            cursorColor: kGreen2,
            keyboardType: TextInputType.datetime,
            textInputAction: TextInputAction.next,
            decoration: const InputDecoration(
                hintStyle: TextStyle(color: kGreen2),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: kGreen2)),
                hintText: ''),
          ),
          const SizedBox(
            height: 8,
          ),
          const Text(
            "Alamat",
            style: TextStyle(color: kBlack, fontSize: 12),
          ),
          TextFormField(
            controller: _controllerAlamat,
            cursorColor: kGreen2,
            keyboardType: TextInputType.streetAddress,
            textInputAction: TextInputAction.done,
            decoration: const InputDecoration(
                hintStyle: TextStyle(color: kGreen2),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: kGreen2)),
                hintText: ''),
          ),
        ],
      ),
    );
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
          margin: const EdgeInsets.only(left: 24, right: 24),
          child: const Center(
            child: Text("Update"),
          ),
        ));
  }

  Future<dynamic> updateFormData() async {
    if (widget.isEdit) {
      DocumentReference documentReference =
          FirebaseFirestore.instance.collection('koordinator').doc(widget.uid);

      FirebaseFirestore.instance.runTransaction((transaction) async {
        DocumentSnapshot documentSnapshot =
            await transaction.get(documentReference);

        if (documentSnapshot.exists) {
          transaction.update(documentReference, <String, dynamic>{
            'nama lengkap': _controllerFullname.text,
            'username': _controllerUsername.text,
            'email': _controllerEmail.text,
            'idNumber': _controllerIdNumber.text,
            'nik': _controllerNIK.text,
            'nomor hp': _controllerNomorHp.text,
            'lokasi kerja': _controllerLokasiKerja.text,
            'jenis kelamin': _controllerJekel.text,
            'agama': _controllerAgama.text,
            'tanggal lahir': _controllerTglLahir.text,
            'alamat': _controllerAlamat.text
          });
        }
      });

      infoUpdate();
    }

    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pop(context);
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
