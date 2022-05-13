import 'package:barry_callebaut/users/petugas/view/create_agenda/petani/add_petani_page.dart';
import 'package:barry_callebaut/users/theme/colors.dart';
import 'package:barry_callebaut/users/theme/padding.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class DetailAgendaPage extends StatefulWidget {
  const DetailAgendaPage({Key? key}) : super(key: key);

  @override
  _DetailAgendaPageState createState() => _DetailAgendaPageState();
}

class _DetailAgendaPageState extends State<DetailAgendaPage> {
  String titlePage = "Sensus Kec. Tapango";
  
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        body: SizedBox(
      width: size.width,
      height: size.height,
      child: SafeArea(
        child: Column(
          children: [
            header(),
            const SizedBox(
              height: 24,
            ),
            search(),
            list(),
            addPetani()
          ],
        ),
      ),
    ));
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
                color: kWhite, borderRadius: BorderRadius.circular(15)),
            padding: const EdgeInsets.only(left: 8),
            child: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(
                Icons.arrow_back_ios,
                size: 20,
                color: kBlack,
              ),
            ),
          ),
          const SizedBox(
            width: 24,
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

  Widget search() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
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

  Widget list() {
    return Expanded(
      child: ListView(
        children: [
          const SizedBox(
            height: 16,
          ),
          GestureDetector(
            onTap: () {},
            child: Card(
              margin: const EdgeInsets.symmetric(horizontal: padding),
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
                title: const Text(
                  "Irwan Deku",
                  style: TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w600, color: kBlack),
                ),
                subtitle: Row(
                  children: [
                    const Flexible(
                      child: Text(
                        "Dusun Lapejang",
                        style: TextStyle(
                            color: kGrey3, fontWeight: FontWeight.w400),
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
                  Icons.timelapse,
                  color: kGreen,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget addPetani() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Expanded(
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
                        builder: (context) => const AddPetaniPage())),
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
      ),
    );
  }
}
