import 'package:barry_callebaut/users/petugas/models/m_progress_ims.dart';
import 'package:barry_callebaut/users/petugas/page/create_agenda/petani/petani_page.dart';
import 'package:barry_callebaut/users/petugas/page/notifikasi.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../theme/colors.dart';
import '../../../../theme/padding.dart';
import '../create_agenda/create_agenda_page.dart';
import '../profil/profil_page.dart';

class HomePagePetugas extends StatefulWidget {
  const HomePagePetugas({Key? key}) : super(key: key);

  @override
  _HomePagePetugasState createState() => _HomePagePetugasState();
}

class _HomePagePetugasState extends State<HomePagePetugas>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  List<ModelProgressIms> data = [
    ModelProgressIms('Juni', 20),
    ModelProgressIms('Juli', 23),
    ModelProgressIms('Aug', 15),
    ModelProgressIms('Sept', 20),
    ModelProgressIms('Okt', 13)
  ];

  String? uid;
  String? username;
  String? docId;

  Future<dynamic> getUserPetugas() async {
    await FirebaseFirestore.instance
        .collection('petugas')
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

  Future<dynamic> getDocIdAgendaSensus() async {
    await FirebaseFirestore.instance
        .collection('petugas')
        .doc(uid)
        .collection("agenda_sensus")
        .where('docId')
        .get()
        .then((result) {
      if (result.docs.isNotEmpty) {
        setState(() {
          docId = result.docs[0].data()['docId'];
        });
      }
    });
  }

  checkPermissions() async {
    var status = await Permission.location.status;
    if (status.isDenied) {
      var status = await Permission.location.request();
      if (status.isGranted) {
        var status = await Permission.storage.status;
        if (status.isDenied) {
          var status = await Permission.storage.request();
          if (status.isGranted) {
            var status = await Permission.camera.status;
            if (status.isDenied) {
              await Permission.camera.request();
            }
          }
        }
      }
    }
  }

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    getUserPetugas();
    getDocIdAgendaSensus();
    checkPermissions();
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: Stack(
          children: [
            CustomScrollView(
              slivers: [
                SliverAppBar(
                  expandedHeight: 160,
                  backgroundColor: kGreen2,
                  leading: GestureDetector(
                    onTap: () => Navigator.push(
                        context,
                        (MaterialPageRoute(
                            builder: (context) => const ProfilPage()))),
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: padding, top: padding),
                      child: ClipOval(
                        child: Image.network(
                          "https://bidinnovacion.org/economiacreativa/wp-content/uploads/2014/10/speaker-3.jpg",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  title: Padding(
                    padding: const EdgeInsets.only(top: padding),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "$username",
                            style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: kWhite),
                          ),
                          const Text(
                            "Petugas",
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: kWhite,
                                fontSize: 12),
                          )
                        ]),
                  ),
                  actions: [
                    Padding(
                      padding: const EdgeInsets.only(right: padding, top: padding),
                      child: IconButton(
                        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const NotifikasiPage())),
                        icon: const Icon(Icons.notifications),
                      ),
                    )
                  ],
                  flexibleSpace: const FlexibleSpaceBar(),
                ),
              ],
            ),
            progressIms(),
            title(),
            createAgenda()
          ],
        ),
      ),
    );
  }

  Widget progressIms() {
    return Positioned(
      left: 0,
      right: 0,
      top: 120,
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 24),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        child: Container(
          height: 240,
          padding: const EdgeInsets.all(padding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Akumulasi",
                style: TextStyle(
                    fontSize: 18, fontWeight: FontWeight.w600, color: kBlack6),
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
      ),
    );
  }

  Widget title() {
    return Positioned(
        left: 16,
        right: 0,
        top: 380,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Data Sensus Petani",
              style: TextStyle(
                  fontWeight: FontWeight.w600, fontSize: 18, color: kBlack6),
            ),
            tabBar(),
            tabBarView()
          ],
        ));
  }

  Widget tabBar() {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      alignment: Alignment.center,
      child: TabBar(
          controller: _tabController,
          isScrollable: true,
          indicatorColor: kOrange,
          labelColor: kBlack,
          unselectedLabelColor: Colors.black26,
          labelPadding: const EdgeInsets.only(left: 40, right: 40),
          tabs: const [Text("Belum"), Text("Sudah")]),
    );
  }

  Widget tabBarView() {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      width: double.maxFinite,
      height: 480,
      child: TabBarView(
          controller: _tabController, children: [belumSensus(), sudahSensus()]),
    );
  }

  Widget belumSensus() {
    final Stream<QuerySnapshot> _streamBelumSensus =
        FirebaseFirestore.instance.collection("data_sensus").snapshots();
    return StreamBuilder<QuerySnapshot>(
        stream: _streamBelumSensus,
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
            return Container(
              padding: const EdgeInsets.only(top: 100),
              child: Column(
                children: const [
                  Text("Belum ada data!"),
                ],
              ),
            );
          }

          var document = snapshot.data!.docs;

          return ListView.builder(
              itemCount: document.length,
              itemBuilder: (context, i) {
                return document[i]['status_sensus'] == false
                    ? GestureDetector(
                        onTap: () {},
                        /*=> Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PetaniPage(
                                    docId: docId.toString(),
                                    docIdPetani: document[i]["docId"],
                                    namaPetani: document[i]["nama_petani"],
                                    desaKelurahan: document[i]["desa_kelurahan"],
                                    noHp: document[i]["no_hp"]))),*/
                        child: Card(
                          margin: const EdgeInsets.fromLTRB(16, 0, 16, 4),
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
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: kBlack),
                              ),
                              subtitle: Row(
                                children: [
                                  Flexible(
                                    child: Text(
                                      document[i]["alamat"],
                                      style: const TextStyle(
                                          color: kGrey3,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 4,
                                  ),
                                  Container(
                                    width: 100,
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
                              trailing: document[i]["status_sensus"] == false
                                  ? const Icon(
                                      Icons.timelapse,
                                      color: kGreen,
                                    )
                                  : const Icon(
                                      Icons.check_circle_rounded,
                                      color: kGreen,
                                    )),
                        ),
                      )
                    : Container();
              });
        });
  }

  Widget sudahSensus() {
    final Stream<QuerySnapshot> _streamSudahSensus =
        FirebaseFirestore.instance.collection("data_sensus").snapshots();
    return StreamBuilder<QuerySnapshot>(
        stream: _streamSudahSensus,
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
            return Container(
              padding: const EdgeInsets.only(top: 100),
              child: Column(
                children: const [
                  Text("Belum ada data!"),
                ],
              ),
            );
          }

          var document = snapshot.data!.docs;

          return ListView.builder(
              itemCount: document.length,
              itemBuilder: (context, i) {
                return document[i]['status_sensus'] == true
                    ? GestureDetector(
                        onTap: () {},
                        /*=> Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PetaniPage(
                                    docId: docId.toString(),
                                    docIdPetani: document[i]["docId"],
                                    namaPetani: document[i]["nama_petani"],
                                    desaKelurahan: document[i]["desa_kelurahan"],
                                    noHp: document[i]["no_hp"]))),*/
                        child: Card(
                          margin: const EdgeInsets.fromLTRB(16, 0, 16, 4),
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
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: kBlack),
                              ),
                              subtitle: Row(
                                children: [
                                  Flexible(
                                    child: Text(
                                      document[i]["alamat"],
                                      style: const TextStyle(
                                          color: kGrey3,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 4,
                                  ),
                                  Container(
                                    width: 100,
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
                              trailing: document[i]["status_sensus"] == false
                                  ? const Icon(
                                      Icons.timelapse,
                                      color: kGreen,
                                    )
                                  : const Icon(
                                      Icons.check_circle_rounded,
                                      color: kGreen,
                                    )),
                        ),
                      )
                    : Container();
              });
        });
  }

  Widget createAgenda() {
    return Positioned(
        left: 0,
        right: 0,
        bottom: 0,
        child: Padding(
          padding: const EdgeInsets.all(padding),
          child: ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(kGreen2),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)))),
              onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CreateAgendaPage(
                          uid: uid.toString(), username: username.toString()))),
              child: SizedBox(
                  height: 48,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        "Buat Agenda",
                        style: TextStyle(color: kWhite),
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      Icon(
                        Icons.add_circle_rounded,
                        color: kWhite,
                      )
                    ],
                  ))),
        ));
  }
}
