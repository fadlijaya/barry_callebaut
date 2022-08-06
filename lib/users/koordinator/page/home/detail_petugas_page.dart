import 'package:barry_callebaut/theme/padding.dart';
import 'package:barry_callebaut/users/koordinator/page/home/petani/petani_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../theme/colors.dart';
import '../../../petugas/models/m_progress_ims.dart';

class DetailPetugasPage extends StatefulWidget {
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
  const DetailPetugasPage(
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
      required this.alamat})
      : super(key: key);

  @override
  State<DetailPetugasPage> createState() => _DetailPetugasPageState();
}

class _DetailPetugasPageState extends State<DetailPetugasPage>
    with TickerProviderStateMixin {
  String titlePage = "Data Petugas";

  late final TabController _tabController =
      TabController(length: 2, vsync: this);

  List<ModelProgressIms> data = [
    ModelProgressIms('Jan', 35),
    ModelProgressIms('Feb', 28),
    ModelProgressIms('Mar', 34),
    ModelProgressIms('Apr', 32),
    ModelProgressIms('May', 40)
  ];

  User? user = FirebaseAuth.instance.currentUser;
  late final Stream<QuerySnapshot> _streamPetugas = FirebaseFirestore.instance
      .collection('petugas')
      .doc(widget.uid)
      .collection('agenda_sensus')
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
          child: SingleChildScrollView(
            child: Column(
              children: [
                detailPetugas(),
                statisticKinerja(),
                progressPetugas(),
                listDataPetani(),
              ],
            ),
          ),
        ));
  }

  Widget detailPetugas() {
    return SizedBox(
      width: double.infinity,
      height: 120,
      child: ListTile(
        minVerticalPadding: padding,
        leading: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              image: const DecorationImage(
                  image: NetworkImage(
                      "https://bidinnovacion.org/economiacreativa/wp-content/uploads/2014/10/speaker-3.jpg"))),
        ),
        title: Text(
          widget.username,
          style: const TextStyle(
              fontSize: 16, fontWeight: FontWeight.w600, color: kBlack),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Image.asset("assets/pin.png"),
                const SizedBox(
                  width: 4,
                ),
                Text(
                  widget.lokasiKerja,
                  style: const TextStyle(
                      color: kBlack, fontWeight: FontWeight.w400, fontSize: 12),
                )
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Container(
              width: 80,
              height: 20,
              decoration: BoxDecoration(
                  color: kGreen2.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(5)),
              child: Center(
                child: Text(
                  widget.nomorHp,
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
      ),
    );
  }

  Widget statisticKinerja() {
    return SizedBox(
      width: double.infinity,
      height: 240,
      child: Stack(
        children: [
          Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            child: Container(
              height: 240,
              padding: const EdgeInsets.all(padding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Statistik Kinerja",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: kBlack6),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Expanded(
                    child: SfCartesianChart(
                        primaryXAxis: CategoryAxis(),
                        //title: ChartTitle(text: 'Half yearly sales analysis'),
                        legend: Legend(isVisible: true),
                        tooltipBehavior: TooltipBehavior(enable: true),
                        series: <ChartSeries<ModelProgressIms, String>>[
                          LineSeries<ModelProgressIms, String>(
                              color: kGreen,
                              dataSource: data,
                              xValueMapper:
                                  (ModelProgressIms modelProgressIms, _) =>
                                      modelProgressIms.year,
                              yValueMapper:
                                  (ModelProgressIms modelProgressIms, _) =>
                                      modelProgressIms.sales,
                              name: '',
                              // Enable data label
                              dataLabelSettings:
                                  const DataLabelSettings(isVisible: true))
                        ]),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget progressPetugas() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      child: Container(
        width: double.infinity,
        height: 80,
        margin: const EdgeInsets.only(top: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 12),
              child: Text(
                "Progress Petugas",
                style: TextStyle(
                    color: kBlack, fontWeight: FontWeight.w600, fontSize: 18),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            LinearPercentIndicator(
              width: 300,
              lineHeight: 14,
              percent: 0.5,
              backgroundColor: kGrey,
              progressColor: kOrange,
              barRadius: const Radius.circular(12),
              animationDuration: 500,
            ),
          ],
        ),
      ),
    );
  }

  Widget listDataPetani() {
    return Container(
      margin: const EdgeInsets.only(top: 24),
      width: double.infinity,
      height: 640,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 12),
            child: Text(
              "Data Petani",
              style: TextStyle(
                  color: kBlack, fontWeight: FontWeight.w600, fontSize: 18),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          search(),
          tabBarDataPetani(),
          tabBarView(context)
        ],
      ),
    );
  }

  Widget search() {
    return Container(
      width: double.infinity,
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(8), color: kGrey),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [Text("Cari"), Icon(Icons.search)],
      ),
    );
  }

  Widget tabBarDataPetani() {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      alignment: Alignment.center,
      child: TabBar(
          controller: _tabController,
          isScrollable: true,
          indicatorColor: kOrange,
          labelColor: kBlack,
          unselectedLabelColor: Colors.black26,
          labelPadding: const EdgeInsets.only(left: 40, right: 40, bottom: 8),
          tabs: const [Text("Belum"), Text("Sudah")]),
    );
  }

  Widget tabBarView(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      width: double.maxFinite,
      height: 480,
      child: TabBarView(controller: _tabController, children: [
        tabBarViewBelum(),
        tabBarViewSudah(),
      ]),
    );
  }

  Widget tabBarViewBelum() {
    return const Center(
      child: Text("Belum"),
    );
  }

  Widget tabBarViewSudah() {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("data_petani")
            .where("status", isEqualTo: "sudah")
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text("Error!"),
            );
          } else if (!snapshot.hasData && snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text("Data is Empty!"),
            );
          }

          var document = snapshot.data!.docs;
          print("Data : ${document.length}");

          return ListView.builder(
              itemCount: document.length,
              itemBuilder: (context, i) {
                return widget.uid == document[i]['uid']
                    ? GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PetaniPage(
                              docId: document[i]['docId'],
                              docIdPetani: document[i]['docId'],
                              namaPetani: document[i]['nama_petani'],
                              desaKelurahan: document[i]['desa_kelurahan'],
                              noHp: document[i]['no_hp'],
                            ),
                          ),
                        );
                      },
                      child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                          child: Column(
                            children: [
                              ListTile(
                                  leading: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: 48,
                                        height: 48,
                                        padding: const EdgeInsets.all(4),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            image: const DecorationImage(
                                                image: NetworkImage(
                                                    "https://bidinnovacion.org/economiacreativa/wp-content/uploads/2014/10/speaker-3.jpg"))),
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                    ],
                                  ),
                                  title: Text(
                                    "${document[i]['nama_petani']}",
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: kBlack),
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Flexible(
                                            child: Text(
                                              "${document[i]['desa_kelurahan']}",
                                              style: const TextStyle(
                                                  color: kBlack,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 12),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 8,
                                          ),
                                          Container(
                                            width: 80,
                                            height: 20,
                                            decoration: BoxDecoration(
                                                color: kGreen2.withOpacity(0.3),
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                            child: Center(
                                              child: Text(
                                                "${document[i]['no_hp']}",
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
                                    ],
                                  ),
                                  trailing: const Icon(
                                    Icons.check_circle_rounded,
                                    color: kGreen2,
                                    size: 16,
                                  )),
                            ],
                          ),
                        ),
                    )
                    : Container();
              });
        });
  }
}
