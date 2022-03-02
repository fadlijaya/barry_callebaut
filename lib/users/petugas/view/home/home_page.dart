import 'package:barry_callebaut/users/petugas/model/m_progress_ims.dart';
import 'package:barry_callebaut/users/theme/colors.dart';
import 'package:barry_callebaut/users/theme/padding.dart';
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

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
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
                  leading: Padding(
                    padding: const EdgeInsets.only(left: padding, top: padding),
                    child: ClipOval(
                      child: Image.network(
                        "https://bidinnovacion.org/economiacreativa/wp-content/uploads/2014/10/speaker-3.jpg",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  title: Padding(
                    padding: const EdgeInsets.only(top: padding),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "Miswar Al-Qadri",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: kWhite),
                          ),
                          Text(
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
                "Progress ims",
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
              "Data Petani",
              style: TextStyle(
                  fontWeight: FontWeight.w600, fontSize: 20, color: kBlack6),
            ),
            
          ],
        ));
  }
}