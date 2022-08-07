import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../../../theme/colors.dart';
import '../../../../../theme/padding.dart';
import 'petani_page.dart';

class AddPetaniPage extends StatefulWidget {
  final String docId;
  const AddPetaniPage({Key? key, required this.docId}) : super(key: key);

  @override
  _AddPetaniPageState createState() => _AddPetaniPageState();
}

class _AddPetaniPageState extends State<AddPetaniPage> {
  String titlePage = "Tambah Petani";

  final Stream<QuerySnapshot> _streamDataPetani =
      FirebaseFirestore.instance.collection("petani").snapshots();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text(titlePage),
        centerTitle: true,
        backgroundColor: kGreen2,
        actions: const [
          Padding(
              padding: EdgeInsets.only(right: 12),
              child: Icon(
                Icons.search,
                color: kWhite,
              ))
        ],
      ),
      body: Container(
          width: size.width,
          height: size.height,
          padding: const EdgeInsets.all(padding),
          child: streamBuilder()),
    );
  }

  Widget streamBuilder() {
    return StreamBuilder<QuerySnapshot>(
        stream: _streamDataPetani,
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text("Belum Ada Data"),
            );
          }

          var document = snapshot.data!.docs;

          return ListView.builder(
              itemCount: document.length,
              itemBuilder: (context, i) {
                String docId = document[i]["uid"];
                String namaPetani = document[i]["nama lengkap"];
                String alamat = document[i]["alamat"];
                String noHp = document[i]["nomor hp"];
                String jekel = document[i]["jenis kelamin"];
                String statusNikah = document[i]["status pernikahan"];
                String tanggalLahir = document[i]["tanggal lahir"];
                String kelompok = document[i]["kelompok"];
                String dusun = document[i]["dusun"];
                //String desaKelurahan = document[i]["desa""/""kelurahan"];
                String kecamatan = document[i]["kecamatan"];
                String kabupaten = document[i]["kabupaten"];

                return Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                  child: ListTile(
                      leading: ClipOval(
                        clipBehavior: Clip.antiAlias,
                        child: Image.network(
                          "https://bidinnovacion.org/economiacreativa/wp-content/uploads/2014/10/speaker-3.jpg",
                          width: 32,
                          height: 32,
                        ),
                      ),
                      title: Text(
                        namaPetani,
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: kBlack),
                      ),
                      subtitle: Row(
                        children: [
                          Flexible(
                            child: Text(
                              alamat,
                              style: const TextStyle(
                                color: kGrey3,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                        ],
                      ),
                      trailing: ElevatedButton(
                        onPressed: () => createToFirebase(
                            docId, namaPetani, alamat, noHp, jekel, statusNikah, tanggalLahir, kelompok, dusun, /*desaKelurahan,*/ kecamatan, kabupaten),
                        child: const Text(
                          "Tambah",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 12),
                        ),
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(kGreen2),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5)))),
                      )),
                );
              });
        });
  }

  Future createToFirebase(String docId, String namaPetani, String alamat, String noHp, String jekel, String statusNikah,  String tanggalLahir, String kelompok,
      String dusun, /*String desaKelurahan,*/ String kecamatan, String kabupaten) async {
    await FirebaseFirestore.instance
        .collection("petugas")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("agenda_sensus")
        .doc(widget.docId)
        .collection("data_petani")
        .doc(docId)
        .set({
      "docId": docId,
      "nama_petani": namaPetani,
      "alamat": alamat,
      "no_hp": noHp,
      "jenis_kelamin": jekel,
      "status_pernikahan": statusNikah,
      "tanggal_lahir": tanggalLahir,
      "kelompok": kelompok,
      "dusun": dusun,
      //"desa_kelurahan": desaKelurahan,
      "kecamatan": kecamatan,
      "kabupaten": kabupaten,
      "status_sensus": false,
    });

    await FirebaseFirestore.instance.collection("data_sensus").doc(docId).set({
       "docId": docId,
      "nama_petani": namaPetani,
      "alamat": alamat,
      "no_hp": noHp,
      "jenis_kelamin": jekel,
      "status_pernikahan": statusNikah,
      "tanggal_lahir": tanggalLahir,
      "kelompok": kelompok,
      "dusun": dusun,
      //"desa_kelurahan": desaKelurahan,
      "kecamatan": kecamatan,
      "kabupaten": kabupaten,
      "status_sensus": false,
    }).then((_) {
      deleteDocument(docId);
      alertDialogSukses();
    });

    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pop(context);
    });
  }

  Future deleteDocument(String docId) async {
    await FirebaseFirestore.instance
        .collection("petani")
        .doc(docId)
        .delete();
  }

  alertDialogSukses() {
    showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            content: Text("Berhasil Menambahkan Data!"),
          );
        });
  }
}
