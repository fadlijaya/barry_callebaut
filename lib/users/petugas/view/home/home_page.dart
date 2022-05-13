import 'package:barry_callebaut/users/petugas/model/m_progress_ims.dart';
import 'package:barry_callebaut/users/petugas/view/create_agenda/create_agenda_page.dart';
import 'package:barry_callebaut/users/petugas/view/profil/profil_page.dart';
import 'package:barry_callebaut/users/theme/colors.dart';
import 'package:barry_callebaut/users/theme/padding.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  List<ModelProgressIms> data = [
    ModelProgressIms('Jan', 35),
    ModelProgressIms('Feb', 28),
    ModelProgressIms('Mar', 34),
    ModelProgressIms('Apr', 32),
    ModelProgressIms('May', 40)
  ];

  String? uid;
  String? username;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    getUser();
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
                            "Internal Management",
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: kWhite,
                                fontSize: 12),
                          )
                        ]),
                  ),
                  actions: const [
                    Padding(
                      padding: EdgeInsets.only(right: padding, top: padding),
                      child: Icon(
                        Icons.notifications,
                        color: kWhite,
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
                "Akumulasi 100%",
                style: TextStyle(
                    fontSize: 20, fontWeight: FontWeight.w600, color: kBlack6),
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
          children: const [
            Text(
              "Data Sensus Petani",
              style: TextStyle(
                  fontWeight: FontWeight.w600, fontSize: 20, color: kBlack6),
            ),
          ],
        ));
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
            shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)))
          ),
          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => CreateAgendaPage(uid: uid.toString(), username: username.toString()))), child: SizedBox(
            height: 48,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text("Buat Agenda", style: TextStyle(color: kWhite),),
                SizedBox(width: 4,),
                Icon(Icons.add_circle_rounded, color: kWhite,)
              ],
            )
        )),
      ));
  }

  Future<dynamic> getUser() async {
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
}
