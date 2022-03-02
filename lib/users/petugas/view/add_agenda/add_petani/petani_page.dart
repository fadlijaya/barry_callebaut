import 'package:flutter/material.dart';

import '../../../../theme/colors.dart';
import '../../../../theme/padding.dart';

class PetaniPage extends StatefulWidget {
  const PetaniPage({Key? key}) : super(key: key);

  @override
  _PetaniPageState createState() => _PetaniPageState();
}

class _PetaniPageState extends State<PetaniPage> {
  String titlePage = "Data Personal Petani";

  final _formKey = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();

  //form informasi kebun
  final TextEditingController _controllerLuas = TextEditingController();
  final TextEditingController _controllerLokasi = TextEditingController();
  final TextEditingController _controllerTanamanPokok = TextEditingController();
  final TextEditingController _controllerTanamanLain = TextEditingController();

  //form informasi keluarga
  final TextEditingController _controllerNamaIstri = TextEditingController();
  final TextEditingController _controllerAnak1 = TextEditingController();
  final TextEditingController _controllerAnak2 = TextEditingController();

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
            Expanded(
                child: SingleChildScrollView(
              child: Column(
                children: [
                  profil(),
                  formInformasiKebun(),
                  formInformasiKeluarga()
                ],
              ),
            ))
          ],
        )),
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

  Widget profil() {
    return ListTile(
      minVerticalPadding: padding,
      leading: Container(
        width: 117,
        height: 117,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            image: const DecorationImage(
                image: NetworkImage(
                    "http://learnyzen.com/wp-content/uploads/2017/08/test1-481x385.png"))),
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
    );
  }

  Widget formInformasiKebun() {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: padding),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      child: Container(
        width: double.infinity,
        height: 300,
        padding: const EdgeInsets.all(padding),
        child: Form(
            key: _formKey,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      "Informasi Kebun",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: kBlack),
                    ),
                    Icon(
                      Icons.create,
                      color: kGreen,
                    )
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  controller: _controllerLuas,
                  cursorColor: kGreen,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(hintText: 'Luas'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Masukkan Luas";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  controller: _controllerLokasi,
                  cursorColor: kGreen,
                  keyboardType: TextInputType.streetAddress,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(hintText: 'Lokasi'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Masukkan Lokasi";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  controller: _controllerTanamanPokok,
                  cursorColor: kGreen,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(hintText: 'Tanaman Pokok'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Masukkan Tanaman Pokok";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  controller: _controllerTanamanLain,
                  cursorColor: kGreen,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(hintText: 'Tanaman Lain'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Masukkan Tanaman Lain";
                    }
                    return null;
                  },
                ),
              ],
            )),
      ),
    );
  }

  Widget formInformasiKeluarga() {
    return Card(
      margin:
          const EdgeInsets.symmetric(horizontal: padding, vertical: padding),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      child: Container(
        width: double.infinity,
        height: 300,
        padding: const EdgeInsets.all(padding),
        child: Form(
            key: _formKey2,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      "Informasi Keluarga",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: kBlack),
                    ),
                    Icon(
                      Icons.create,
                      color: kGreen,
                    )
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  controller: _controllerNamaIstri,
                  cursorColor: kGreen,
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(hintText: 'Nama Istri'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Masukkan Nama Istri";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  controller: _controllerAnak1,
                  cursorColor: kGreen,
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(hintText: 'Anak Pertama'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Masukkan Nama Anak Pertama";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  controller: _controllerAnak2,
                  cursorColor: kGreen,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(hintText: 'Anak Kedua'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Masukkan Nama Anak Kedua";
                    }
                    return null;
                  },
                ),
              ],
            )),
      ),
    );
  }
}
