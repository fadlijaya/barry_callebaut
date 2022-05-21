import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../theme/colors.dart';
import '../../../../theme/padding.dart';
import 'detail_agenda_page.dart';

class CreateAgendaPage extends StatefulWidget {
  final String uid;
  final String username;
  const CreateAgendaPage({Key? key, required this.uid, required this.username})
      : super(key: key);

  @override
  _CreateAgendaPageState createState() => _CreateAgendaPageState();
}

class _CreateAgendaPageState extends State<CreateAgendaPage> {
  String titlePage = "Agenda Sensus";

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _lokasiController = TextEditingController();
  final TextEditingController _tanggal1Controller = TextEditingController();
  final TextEditingController _tanggal2Controller = TextEditingController();

  DateTime _selectedDate1 = DateTime.now();
  DateTime _selectedDate2 = DateTime.now();

  String get uid => widget.uid;
  String? docId;

  final Stream<QuerySnapshot> _streamAgendaSensus = FirebaseFirestore.instance
      .collection("petugas")
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection("agenda_sensus")
      .snapshots();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text(titlePage),
        centerTitle: true,
        backgroundColor: kGreen2,
      ),
      body: Container(
          width: size.width,
          height: size.height,
          padding: const EdgeInsets.all(padding),
          child: StreamBuilder<QuerySnapshot>(
              stream: _streamAgendaSensus,
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return const Center(
                    child: Text("Error!"),
                  );
                } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(
                    child: Text("Belum Ada Data!"),
                  );
                }

                var data = snapshot.data!.docs;

                return ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, i) {
                      return GestureDetector(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DetailAgendaPage(
                                      lokasiSensus: data[i]['lokasi sensus'],
                                      docId: docId.toString()
                                    ))),
                        child: Card(
                          child: ListTile(
                            title: Text(data[i]['lokasi sensus']),
                            subtitle: Row(
                              children: [
                                const Icon(
                                  Icons.timer,
                                  color: kBlack6,
                                  size: 16,
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  data[i]['mulai tanggal'],
                                  style: const TextStyle(fontSize: 12),
                                ),
                                const Text(" - "),
                                Text(data[i]['sampai tanggal'],
                                    style: const TextStyle(fontSize: 12)),
                              ],
                            ),
                          ),
                        ),
                      );
                    });
              })),
      floatingActionButton: FloatingActionButton(
        backgroundColor: kOrange,
        onPressed: bottomCreateAgenda,
        child: const Icon(
          Icons.add,
          color: kWhite,
        ),
      ),
    );
  }

  bottomCreateAgenda() {
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16), topRight: Radius.circular(16))),
        context: context,
        builder: (_) {
          return Form(
            key: _formKey,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(padding),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: _lokasiController,
                    decoration: const InputDecoration(
                        hintText: 'Masukkan Lokasi Sensus'),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          selectDate1(context);
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: padding),
                          width: 120,
                          height: 40,
                          color: kGrey,
                          child: const Center(
                            child: Text("Pilih Tanggal"),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Mulai Tanggal",
                              style: TextStyle(fontSize: 12),
                            ),
                            TextFormField(
                              controller: _tanggal1Controller,
                              decoration: const InputDecoration(hintText: ''),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          selectDate2(context);
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: padding),
                          width: 120,
                          height: 40,
                          color: kGrey,
                          child: const Center(
                            child: Text("Pilih Tanggal"),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Sampai Tanggal",
                            style: TextStyle(fontSize: 12),
                          ),
                          TextFormField(
                            controller: _tanggal2Controller,
                            decoration: const InputDecoration(hintText: ''),
                          ),
                        ],
                      ))
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all<Color>(Colors.red),
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5)))),
                          onPressed: () => Navigator.pop(context),
                          child: const SizedBox(
                            width: 120,
                            height: 40,
                            child: Center(
                              child: Text("Batal"),
                            ),
                          )),
                      ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all<Color>(kGreen2),
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5)))),
                          onPressed: createAgendaToFirebase,
                          child: const SizedBox(
                            width: 120,
                            height: 40,
                            child: Center(
                              child: Text("Tambah"),
                            ),
                          )),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }

  alertDialogSukses() {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: const [Text("Berhasil Menambahkan Agenda Sensus!")],
            ),
          );
        });
  }

  Future<void> selectDate1(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: _selectedDate1,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(2015),
        lastDate: DateTime(2101));
    if (picked != null) {
      setState(() {
        _selectedDate1 = picked;
        _tanggal1Controller.text = DateFormat.yMd().format(_selectedDate1);
      });
    }
  }

  Future<void> selectDate2(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: _selectedDate2,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(2015),
        lastDate: DateTime(2101));
    if (picked != null) {
      setState(() {
        _selectedDate2 = picked;
        _tanggal2Controller.text = DateFormat.yMd().format(_selectedDate2);
      });
    }
  }

  Future<dynamic> createAgendaToFirebase() async {
    docId = await FirebaseFirestore.instance
        .collection("petugas")
        .doc(uid)
        .collection("agenda_sensus")
        .add({
      'uid': uid,
      'username': widget.username,
      'lokasi sensus': _lokasiController.text,
      'mulai tanggal': _tanggal1Controller.text,
      'sampai tanggal': _tanggal2Controller.text
    }).then((data) {
      Navigator.pop(context);
      alertDialogSukses();
    });

    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pop(context);
    });
  }
}
