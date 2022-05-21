import 'package:flutter/material.dart';

import '../../../../../theme/colors.dart';
import '../../../../../theme/padding.dart';
import 'petani_page.dart';

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
      appBar: AppBar(
        title: Text(titlePage),
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
        child: Column(
          children: [
            list(),
          ],
        ),
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
                    onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const PetaniPage())),
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
