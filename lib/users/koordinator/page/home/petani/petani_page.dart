import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

import '../../../../../theme/colors.dart';
import '../../../../../theme/padding.dart';
import '../../../../petugas/page/create_agenda/petani/inspeksi/inspeksi_page.dart';
import '../../../../petugas/page/create_agenda/petani/sensus/sensus_page.dart';

class PetaniPage extends StatefulWidget {
  final String docId;
  final String docIdPetani;
  final String namaPetani;
  final String desaKelurahan;
  final String noHp;
  const PetaniPage(
      {Key? key,
      required this.docId,
      required this.docIdPetani,
      required this.namaPetani,
      required this.desaKelurahan,
      required this.noHp})
      : super(key: key);

  @override
  _PetaniPageState createState() => _PetaniPageState();
}

class _PetaniPageState extends State<PetaniPage> with TickerProviderStateMixin {
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

  late final TabController _tabController =
      TabController(length: 2, vsync: this);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text(titlePage),
        centerTitle: true,
        backgroundColor: kGreen2,
      ),
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: SingleChildScrollView(
          child: Column(
            children: [profil(), tabBar(), tabBarView()],
          ),
        ),
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
      title: Text(
        widget.namaPetani,
        style: const TextStyle(
            fontSize: 16, fontWeight: FontWeight.w600, color: kBlack),
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
              Text(
                widget.desaKelurahan,
                style:
                    const TextStyle(color: kBlack, fontWeight: FontWeight.w400,),
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
                widget.noHp,
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
    );
  }

  Widget tabBar() {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      alignment: Alignment.center,
      child: TabBar(
          controller: _tabController,
          isScrollable: true,
          indicatorColor: kOrange,
          labelColor: kBlack,
          unselectedLabelColor: Colors.black26,
          labelPadding: const EdgeInsets.only(left: 40, right: 40, bottom: 8),
          tabs: const [Text("Sensus"), Text("Inspeksi")]),
    );
  }

  Widget tabBarView() {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      width: double.maxFinite,
      height: 480,
      child: TabBarView(controller: _tabController, children: [
        //tabBarViewSensus(),
        addSensus(),
        addInspeksi()
      ]),
    );
  }

  Widget tabBarViewSensus() {
    return SingleChildScrollView(
      child: Column(
        children: [formInformasiKebun(), formInformasiKeluarga()],
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
        height: 260,
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

  Widget addSensus() {
    return Column(
      children: [
        Padding(
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
                        builder: (context) => SensusPage(docId: widget.docId, docIdPetani: widget.docIdPetani))),
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
                      'Mulai melakukan sensus',
                      style:
                          TextStyle(fontWeight: FontWeight.w500, color: kGrey5),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  addInspeksi() {
    return Stack(
      children: [
        Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: padding),
              child: CircleAvatar(
                  radius: 30,
                  backgroundColor: kOrange,
                  child: IconButton(
                      onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => InspeksiPage(docId: widget.docId, docIdPetani: widget.docIdPetani,))),
                      icon: const Icon(
                        Icons.add,
                        color: kWhite,
                      ))),
            ))
      ],
    );
  }
}
