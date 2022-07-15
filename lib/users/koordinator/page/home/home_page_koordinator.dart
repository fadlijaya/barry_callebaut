import 'package:barry_callebaut/users/koordinator/page/home/detail_petugas_page.dart';
import 'package:barry_callebaut/users/koordinator/page/profil/profil_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../theme/colors.dart';
import '../../../../theme/padding.dart';
import '../../../petugas/models/m_progress_ims.dart';

class HomePageKoordinator extends StatefulWidget {
  const HomePageKoordinator({Key? key}) : super(key: key);

  @override
  State<HomePageKoordinator> createState() => _HomePageKoordinatorState();
}

class _HomePageKoordinatorState extends State<HomePageKoordinator>
    with SingleTickerProviderStateMixin {
  String? uid;
  String? username;

  List<ModelProgressIms> data = [
    ModelProgressIms('Jan', 35),
    ModelProgressIms('Feb', 28),
    ModelProgressIms('Mar', 34),
    ModelProgressIms('Apr', 32),
    ModelProgressIms('May', 40)
  ];

  Future<dynamic> getUserKoordinator() async {
    await FirebaseFirestore.instance
        .collection('koordinator')
        .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((result) {
      if (result.docs.isNotEmpty) {
        setState(() {
          uid = result.docs[0].data()['uid'];
          username = result.docs[0].data()['username'];
        });
      }
    });
  }

  final Stream<QuerySnapshot> _streamPetugas =
      FirebaseFirestore.instance.collection("petugas").snapshots();

  @override
  void initState() {
    getUserKoordinator();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: size.height,
          width: size.width,
          child: SingleChildScrollView(
            child: Column(
              children: [
                headerAccount(),
                statisticAkumulasi(),
                titleDataPetugas(),
                listPetugas()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget headerAccount() {
    return Container(
      width: double.infinity,
      height: 80,
      color: kGreen2,
      padding:
          const EdgeInsets.symmetric(vertical: padding, horizontal: padding),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => const ProfilPage())),
            child: SizedBox(
              width: 48,
              height: 48,
              child: ClipOval(
                child: Image.network(
                  "https://bidinnovacion.org/economiacreativa/wp-content/uploads/2014/10/speaker-3.jpg",
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 12,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "$username",
                style: const TextStyle(
                    fontSize: 18, fontWeight: FontWeight.w700, color: kWhite),
              ),
              const Text(
                "Koordinator",
                style: TextStyle(
                    fontWeight: FontWeight.w400, color: kWhite, fontSize: 12),
              )
            ],
          ),
          const Spacer(),
          const Icon(
            Icons.notifications,
            color: kWhite,
          ),
        ],
      ),
    );
  }

  Widget statisticAkumulasi() {
    return SizedBox(
      width: double.infinity,
      height: 280,
      child: Stack(
        children: [
          Container(width: double.infinity, height: 100, color: kGreen2),
          Card(
            margin: const EdgeInsets.symmetric(horizontal: 24),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            child: Container(
              height: 240,
              padding: const EdgeInsets.all(padding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Akumulasi 100%",
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

  Widget titleDataPetugas() {
    return Container(
      width: double.infinity,
      height: 110,
      padding: const EdgeInsets.symmetric(horizontal: padding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Data Petugas",
            style: TextStyle(
                fontWeight: FontWeight.w600, fontSize: 18, color: kBlack6),
          ),
          search(),
          //listPetugas()
        ],
      ),
    );
  }

  Widget search() {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 16,
      ),
      width: double.infinity,
      height: 40,
      decoration: BoxDecoration(
          color: kGreySearch, borderRadius: BorderRadius.circular(5)),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          Text(
            "Cari",
            style: TextStyle(
                fontSize: 12, fontWeight: FontWeight.w500, color: kGrey5),
          ),
          Icon(
            Icons.search,
            color: kBlack,
          )
        ],
      ),
    );
  }

  Widget listPetugas() {
    return StreamBuilder<QuerySnapshot>(
        stream: _streamPetugas,
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

          return Container(
            width: double.infinity,
            height: 480,
            padding: const EdgeInsets.symmetric(horizontal: padding),
            child: ListView.builder(
                itemCount: document.length,
                itemBuilder: (context, i) {
                  return Card(
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
                                    borderRadius: BorderRadius.circular(5),
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
                            "${document[i]['username']}",
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
                                  Image.asset("assets/pin.png"),
                                  const SizedBox(
                                    width: 4,
                                  ),
                                  Flexible(
                                    child: Text(
                                      "${document[i]['lokasi kerja']}",
                                      style: const TextStyle(
                                          color: kBlack,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 12),
                                    ),
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
                                    "${document[i]['nomor hp']}",
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            LinearPercentIndicator(
                              width: 150,
                              lineHeight: 14,
                              percent: 0.5,
                              backgroundColor: kGrey,
                              progressColor: kOrange,
                              barRadius: const Radius.circular(12),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(kGreen2)),
                                  onPressed: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              DetailPetugasPage(
                                                uid: document[i]['uid'],
                                                username: document[i]
                                                    ['username'],
                                                fullname: document[i]
                                                    ['nama lengkap'],
                                                email: document[i]['email'],
                                                idNumber: document[i]
                                                    ['idNumber'],
                                                nik: document[i]['email'],
                                                nomorHp: document[i]
                                                    ['nomor hp'],
                                                lokasiKerja: document[i]
                                                    ['lokasi kerja'],
                                                jekel: document[i]
                                                    ['jenis kelamin'],
                                                agama: document[i]['agama'],
                                                tglLahir: document[i]
                                                    ['tanggal lahir'],
                                                alamat: document[i]['alamat'],
                                              ))),
                                  child: const Center(
                                      child: Text(
                                    "Lihat Detail",
                                    style: TextStyle(color: kWhite),
                                  ))),
                            )
                          ],
                        )
                      ],
                    ),
                  );
                }),
          );
        });
  }
}
