import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../theme/colors.dart';
import '../../../../theme/padding.dart';
import '../../../petugas/model/m_progress_ims.dart';

class HomePageKoordinator extends StatefulWidget {
  const HomePageKoordinator({Key? key}) : super(key: key);

  @override
  State<HomePageKoordinator> createState() => _HomePageKoordinatorState();
}

class _HomePageKoordinatorState extends State<HomePageKoordinator> {
  List<ModelProgressIms> data = [
    ModelProgressIms('Jan', 35),
    ModelProgressIms('Feb', 28),
    ModelProgressIms('Mar', 34),
    ModelProgressIms('Apr', 32),
    ModelProgressIms('May', 40)
  ];
  
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SizedBox(
        height: size.height,
        width: size.width,
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
                            "Koordinator",
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
        right: 16,
        top: 380,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Data Petugas",
              style: TextStyle(
                  fontWeight: FontWeight.w600, fontSize: 20, color: kBlack6),
            ),
            search(),
            profil()
          ],
        ));
  }

  Widget search() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16,),
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

  Widget profil() {
    return Card(
      child: ListTile(
        minVerticalPadding: padding,
        leading: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 96,
              height: 96,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  image: const DecorationImage(
                      image: NetworkImage(
                          "http://learnyzen.com/wp-content/uploads/2017/08/test1-481x385.png"))),
            ),
            const SizedBox(height: 8,),
          ],
        ),
        title: const Text(
          "Irwan Deku",
          style:
              TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: kBlack),
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
                const Text(
                  "Dusun Lapejang",
                  style: TextStyle(color: kBlack, fontWeight: FontWeight.w400),
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
              child: const Center(
                child: Text(
                  "0684837365",
                  style: TextStyle(
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
          Icons.create,
          color: kGreen,
        ),
      ),
    );
  }

}
