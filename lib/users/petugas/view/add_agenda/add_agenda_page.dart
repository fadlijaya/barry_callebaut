import 'package:barry_callebaut/users/petugas/view/add_agenda/detail_add_agenda_page.dart';
import 'package:barry_callebaut/users/theme/colors.dart';
import 'package:barry_callebaut/users/theme/padding.dart';
import 'package:flutter/material.dart';

class AddAgendaPage extends StatefulWidget {
  const AddAgendaPage({Key? key}) : super(key: key);

  @override
  _AddAgendaPageState createState() => _AddAgendaPageState();
}

class _AddAgendaPageState extends State<AddAgendaPage> {
  String titlePage = "Agenda Sensus";

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: SafeArea(
          child: Column(
            children: [header(), list()],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: kOrange,
        onPressed: () {},
        child: const Icon(
          Icons.add,
          color: kWhite,
        ),
      ),
    );
  }

  Widget header() {
    return Container(
      width: double.infinity,
      height: 90,
      color: kGrey,
      padding: const EdgeInsets.symmetric(horizontal: padding),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15), color: kWhite),
            padding: const EdgeInsets.only(left: 8),
            child: IconButton(
              onPressed: () => Navigator.pushNamed(context, '/initialPage'),
              icon: const Icon(
                Icons.arrow_back_ios,
                size: 20,
                color: kBlack,
              ),
            ),
          ),
          const SizedBox(
            width: 50,
          ),
          Text(
            titlePage,
            style: const TextStyle(
                fontSize: 20, fontWeight: FontWeight.w700, color: kBlack),
          )
        ],
      ),
    );
  }

  Widget list() {
    return Expanded(
      child: ListView(
        children: [
          const SizedBox(
            height: 16,
          ),
          GestureDetector(
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const DetailAddAgendaPage())),
            child: Card(
              margin: const EdgeInsets.symmetric(horizontal: padding),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
              child: Container(
                width: double.infinity,
                height: 80,
                padding: const EdgeInsets.all(padding),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        const Text("Sensus Kec. Tapango",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: kBlack)),
                        Row(
                          children: const [
                            Icon(
                              Icons.alarm,
                              size: 16,
                              color: kBlack,
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            Text(
                              "Jum'at, Feb 2 - Jum'at Maret 2 2021",
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: kBlack),
                            )
                          ],
                        )
                      ],
                    ),
                    const Icon(
                      Icons.check_circle_rounded,
                      color: kGreen,
                      size: 20,
                    )
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Card(
            margin: const EdgeInsets.symmetric(horizontal: padding),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            child: Container(
              width: double.infinity,
              height: 80,
              padding: const EdgeInsets.all(padding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      const Text("Sensus Dusun Malla",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: kBlack)),
                      Row(
                        children: const [
                          Icon(
                            Icons.alarm,
                            size: 16,
                            color: kBlack,
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Text(
                            "Jum'at, Feb 2 - Jum'at Maret 2 2021",
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: kBlack),
                          )
                        ],
                      )
                    ],
                  ),
                  const Icon(
                    Icons.check_circle_rounded,
                    color: kGrey,
                    size: 20,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
