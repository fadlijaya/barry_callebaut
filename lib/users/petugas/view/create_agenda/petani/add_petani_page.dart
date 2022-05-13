import 'package:barry_callebaut/users/petugas/view/create_agenda/petani/petani_page.dart';
import 'package:barry_callebaut/users/theme/colors.dart';
import 'package:barry_callebaut/users/theme/padding.dart';
import 'package:flutter/material.dart';

class AddPetaniPage extends StatefulWidget {
  const AddPetaniPage({Key? key}) : super(key: key);

  @override
  _AddPetaniPageState createState() => _AddPetaniPageState();
}

class _AddPetaniPageState extends State<AddPetaniPage> {
  String titlePage = "Tambah Petani";

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
            ],
          ),
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
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: kBlack),
                  ),
                  subtitle: Row(
                    children: const [
                      Flexible(
                        child: Text(
                          "Dusun Lapejang",
                          style: TextStyle(
                              color: kGrey3, fontWeight: FontWeight.w400),
                        ),
                      ),
                      SizedBox(
                        width: 4,
                      ),
                    ],
                  ),
                  trailing: ElevatedButton(
                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const PetaniPage())),
                    child: const Text(
                      "Tambah",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(kGreen2),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)))),
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
