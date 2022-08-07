import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class CetakSensusPage extends StatefulWidget {
  final String luasKebun;
  final GeoPoint koordinat;
  final String tanamanPokok;
  final String tanamanLain;
  final String namaIstri;
  final String namaAnak;
  const CetakSensusPage(
      {Key? key,
      required this.luasKebun,
      required this.koordinat,
      required this.tanamanPokok,
      required this.tanamanLain,
      required this.namaIstri,
      required this.namaAnak})
      : super(key: key);

  @override
  State<CetakSensusPage> createState() => _CetakSensusPageState();
}

class _CetakSensusPageState extends State<CetakSensusPage> {
  String date = DateFormat('dd-MM-yyyy hh:mm').format(DateTime.now());

  String? uid;
  String? username;
  String? fullname;
  String? email;
  String? idNumber;
  String? nik;
  String? nomorHp;
  String? lokasiKerja;
  String? jekel;
  String? agama;
  String? tglLahir;
  String? alamat;

  Future<dynamic> getUserPetugas() async {
    await FirebaseFirestore.instance
        .collection('petugas')
        .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((result) {
      if (result.docs.isNotEmpty) {
        setState(() {
          uid = result.docs[0].data()['uid'];
          fullname = result.docs[0].data()['nama lengkap'];
          username = result.docs[0].data()['username'];
          email = result.docs[0].data()['email'];
          idNumber = result.docs[0].data()['idNumber'];
          nik = result.docs[0].data()['nik'];
          nomorHp = result.docs[0].data()['nomor hp'];
          lokasiKerja = result.docs[0].data()['lokasi kerja'];
          jekel = result.docs[0].data()['jenis kelamin'];
          agama = result.docs[0].data()['agama'];
          tglLahir = result.docs[0].data()['tanggal lahir'];
          alamat = result.docs[0].data()['alamat'];
        });
      }
    });
  }

  @override
  void initState() {
    getUserPetugas();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PdfPreview(build: (format) => generatePdf(format)),
    );
  }

  Future<Uint8List> generatePdf(PdfPageFormat format) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        pageFormat: format,
        build: (context) {
          return pw.Container(
              child: pw.Column(children: [
            header(),
            viewDataPetugas(),
            viewDataPetani(),
          ]));
        },
      ),
    );
    return pdf.save();
  }

  header() {
    return pw.Container(
      child:
          pw.Column(mainAxisAlignment: pw.MainAxisAlignment.center, children: [
        pw.Text('Barry Callebaut',
            style:
                pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 20.0)),
        pw.SizedBox(height: 8.0),
        pw.Text('Petugas',
            style:
                pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 14.0)),
        pw.SizedBox(height: 8.0),
        pw.Row(mainAxisAlignment: pw.MainAxisAlignment.end, children: [
          pw.Text('Tanggal '),
          pw.Text(date,),
          pw.SizedBox(height: 24.0),
        ]),
      ]),
    );
  }

  viewDataPetugas() {
    return pw.Container(
        child: pw.Column(children: [
      pw.Row(children: [
        pw.Text('Nama Petugas : '),
        pw.Text("$fullname",
            style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
      ]),
      pw.SizedBox(height: 4.0),
      pw.Row(children: [
        pw.Text('ID Number : '),
        pw.Text("$idNumber",
            style: pw.TextStyle(fontWeight: pw.FontWeight.bold))
      ]),
      pw.SizedBox(height: 4.0),
      pw.Row(children: [
        pw.Text('Nomor HP : '),
        pw.Text("$nomorHp",
            style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
      ]),
      pw.SizedBox(height: 4.0),
      pw.Row(children: [
        pw.Text('Lokasi Kerja : '),
        pw.Text("$lokasiKerja",
            style: pw.TextStyle(fontWeight: pw.FontWeight.bold))
      ]),
      pw.SizedBox(height: 40.0),
    ]));
  }

  viewDataPetani() {
    return pw.Container(
        child: pw
            .Column(mainAxisAlignment: pw.MainAxisAlignment.center, children: [
      pw.Text('Informasi Kebun',
          style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 14.0)),
      pw.SizedBox(height: 16.0),
      pw.Row(mainAxisAlignment: pw.MainAxisAlignment.spaceBetween, children: [
        pw.Text('Luas :'),
        pw.Text(widget.luasKebun),
      ]),
      pw.Divider(),
      pw.SizedBox(height: 4.0),
      pw.Row(mainAxisAlignment: pw.MainAxisAlignment.spaceBetween, children: [
        pw.Text('Koordinat Lokasi :'),
        pw.Text("${widget.koordinat.latitude}, ${widget.koordinat.longitude}")
      ]),
      pw.Divider(),
      pw.SizedBox(height: 4.0),
      pw.Row(mainAxisAlignment: pw.MainAxisAlignment.spaceBetween, children: [
        pw.Text('Tanaman Pokok :'),
        pw.Text(widget.tanamanPokok),
      ]),
      pw.Divider(),
      pw.SizedBox(height: 4.0),
      pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [pw.Text('Tanaman Lain :'), pw.Text(widget.tanamanLain)]),
      pw.Divider(),
      pw.SizedBox(height: 4.0),
      pw.Text('Informasi Keluarga',
          style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 14.0)),
      pw.SizedBox(height: 16.0),
      pw.Row(mainAxisAlignment: pw.MainAxisAlignment.spaceBetween, children: [
        pw.Text('Nama Istri :'),
        pw.Text(widget.namaIstri),
      ]),
      pw.Divider(),
      pw.SizedBox(height: 8.0),
      pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [pw.Text('Nama Anak :'), pw.Text(widget.namaAnak)]),
      pw.Divider(),
      pw.SizedBox(height: 8.0),
    ]));
  }
}
