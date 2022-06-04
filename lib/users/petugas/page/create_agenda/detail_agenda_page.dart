import 'package:barry_callebaut/users/petugas/page/create_agenda/petani/petani_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../../theme/colors.dart';
import '../../../../theme/padding.dart';
import 'petani/add_petani_page.dart';

class DetailAgendaPage extends StatefulWidget {
  final String lokasiSensus;
  final String docId;
  const DetailAgendaPage(
      {Key? key, required this.lokasiSensus, required this.docId})
      : super(key: key);

  @override
  _DetailAgendaPageState createState() => _DetailAgendaPageState();
}

class _DetailAgendaPageState extends State<DetailAgendaPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    final Stream<QuerySnapshot> _streamDataPetani = FirebaseFirestore.instance
        .collection("petugas")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("agenda_sensus")
        .doc(widget.docId)
        .collection("data_petani")
        .snapshots();

    return Scaffold(
        appBar: AppBar(
          title: Text(widget.lokasiSensus),
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
          child: StreamBuilder<QuerySnapshot>(
              stream: _streamDataPetani,
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return const Center(
                    child: Text("Error!"),
                  );
                } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Stack(
                    children: [
                      const Center(child: Text("Belum Ada Data!")),
                      addPetani()
                    ],
                  );
                }

                var document = snapshot.data!.docs;

                return Stack(
                  children: [
                    addPetani(),
                    Container(
                      margin: const EdgeInsets.only(top: 166),
                      child: ListView.builder(
                          itemCount: document.length,
                          itemBuilder: (context, i) {
                            return GestureDetector(
                              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => PetaniPage(
                                docId: widget.docId,
                                docIdPetani: document[i]["docId"],
                                namaPetani: document[i]["nama_petani"],
                                desaKelurahan: document[i]["desa_kelurahan"],
                                noHp: document[i]["no_hp"]
                              ))),
                              child: Card(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: padding),
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
                                    document[i]['nama_petani'],
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                        color: kBlack),
                                  ),
                                  subtitle: Row(
                                    children: [
                                      Flexible(
                                        child: Text(
                                          document[i]["desa_kelurahan"],
                                          style: const TextStyle(
                                              color: kGrey3,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 4,
                                      ),
                                      Container(
                                        width: 80,
                                        height: 20,
                                        decoration: BoxDecoration(
                                            color: kGreen2.withOpacity(0.3),
                                            borderRadius: BorderRadius.circular(5)),
                                        child: Center(
                                          child: Text(
                                            document[i]["no_hp"],
                                            style: const TextStyle(
                                              color: kBlack,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  trailing: const Icon(
                                    Icons.timelapse,
                                    color: kGreen,
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
                  ],
                );
              }),
        ));
  }

  Widget addPetani() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: padding),
        child: DottedBorder(
          borderType: BorderType.RRect,
          dashPattern: const [10, 4],
          radius: const Radius.circular(8),
          strokeCap: StrokeCap.round,
          color: Colors.grey.shade300,
          child: Container(
            height: 150,
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.blue.shade50.withOpacity(.3),
                borderRadius: BorderRadius.circular(10)),
            child: GestureDetector(
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AddPetaniPage(docId: widget.docId))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(
                    Icons.add_circle_rounded,
                    color: kGreen,
                    size: 40,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    'Tambah Petani',
                    style:
                        TextStyle(fontWeight: FontWeight.w500, color: kGrey5),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
