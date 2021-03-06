import 'package:barry_callebaut/users/petugas/page/create_agenda/petani/inspeksi/inspeksi_page.dart';
import 'package:barry_callebaut/users/petugas/page/create_agenda/petani/sensus/sensus_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../../../theme/colors.dart';
import '../../../../../theme/padding.dart';

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

  bool _isExpanded = false;

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
                style: const TextStyle(
                  color: kBlack,
                  fontWeight: FontWeight.w400,
                ),
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
      trailing: const Icon(
        Icons.create,
        color: kGreen,
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
        tabBarViewInspeksi(),
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

  Widget tabBarViewInspeksi() {
    final Stream<QuerySnapshot> _streamInspeksi = FirebaseFirestore.instance
        .collection("petugas")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("agenda_sensus")
        .doc(widget.docId)
        .collection("data_petani")
        .doc(widget.docIdPetani)
        .collection("inspeksi")
        .snapshots();

    return Stack(
      children: [
        StreamBuilder<QuerySnapshot>(
          stream: _streamInspeksi,
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text("${snapshot.error}"),
              );
            } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return const Center(
                child: Text("Belum ada data!"),
              );
            } else if (snapshot.hasData) {
              var document = snapshot.data!.docs;
              return ListView.builder(
                  itemCount: document.length,
                  itemBuilder: (context, i) {
                    return ExpansionPanelList(
                        expansionCallback: (context, isExpanded) {
                          _isExpanded = !isExpanded;
                          setState(() {
                          });
                        },
                        dividerColor: kGrey,
                        children: [
                          ExpansionPanel(
                              headerBuilder: (context, isExpanded) {
                                return ListTile(
                                  title: Text("${document[i]['subjek']}", style: const TextStyle(fontWeight: FontWeight.w600),),
                                  subtitle:
                                      Text("${document[i]['tanggal subjek']}"),
                                );
                              },
                              body: Container(
                                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: padding),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.only(bottom: 8),
                                      child: Text("Jumlah buah kakao",  style: TextStyle(fontWeight: FontWeight.w600),),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text("Lokal"),
                                        Text("${document[i]['jumlah kakao lokal']} Buah")
                                      ],
                                    ),
                                    const Divider(thickness: 1,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text("S1"),
                                        Text("${document[i]['jumlah kakao s1']} Buah")
                                      ],
                                    ),
                                    const Divider(thickness: 1,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text("S1"),
                                        Text("${document[i]['jumlah kakao s1']} Buah")
                                      ],
                                    ),
                                    const Divider(thickness: 1,),
                                     const Padding(
                                      padding: EdgeInsets.only(top: 8, bottom: 8),
                                      child: Text("Frekuensi pemangkasan",  style: TextStyle(fontWeight: FontWeight.w600),),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text("Berat"),
                                        Text("${document[i]['frekuensi berat']} Meter")
                                      ],
                                    ),
                                    const Divider(thickness: 1,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text("Ringan"),
                                        Text("${document[i]['frekuensi ringan']} Meter")
                                      ],
                                    ),
                                    const Divider(thickness: 1,),
                                     const Padding(
                                      padding: EdgeInsets.only(top: 8, bottom: 8),
                                      child: Text("Hama dan Penyakit",  style: TextStyle(fontWeight: FontWeight.w600),),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text("Hama"),
                                        Text("${document[i]['hama']}")
                                      ],
                                    ),
                                    const Divider(thickness: 1,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text("Penyakit"),
                                        Text("${document[i]['penyakit']}")
                                      ],
                                    ),
                                    const Divider(thickness: 1,),
                                    const Padding(
                                      padding: EdgeInsets.only(top: 8),
                                      child: Text("Mempunyai kotak penyimpanan pestisida", style: TextStyle(fontWeight: FontWeight.w600),),
                                    ),
                                     document[i]['mempunyai kotak penyimpanan pestisida'] == "Pilihan.ya"
                                     ? Row(
                                      children: const [
                                        Text("Ya"),
                                        SizedBox(width: 8,),
                                        Icon(Icons.check, color: kGreen2,)
                                      ],
                                     )
                                     : Row(
                                      children: const [
                                          Text("Tidak"),
                                        SizedBox(width: 8,),
                                        Icon(Icons.close, color: Colors.red,)
                                      ],
                                     ),
                                     const Padding(
                                      padding: EdgeInsets.only(top: 8),
                                      child: Text("Mempunyai kotak penyimpanan khusus pupuk", style: TextStyle(fontWeight: FontWeight.w600),),
                                    ),
                                    document[i]['mempunyai kotak penyimpanan khusus pupuk'] == "Pilihan.ya"
                                     ? Row(
                                      children: const [
                                        Text("Ya"),
                                        SizedBox(width: 8,),
                                        Icon(Icons.check, color: kGreen2,)
                                      ],
                                     )
                                     : Row(
                                      children: const [
                                          Text("Tidak"),
                                        SizedBox(width: 8,),
                                        Icon(Icons.close, color: Colors.red,)
                                      ],
                                     ),
                                      const Padding(
                                      padding: EdgeInsets.only(top: 8),
                                      child: Text("Membuang wadah bekas pestisida dengan benar", style: TextStyle(fontWeight: FontWeight.w600),),
                                    ),
                                     document[i]['membuang wadah bekas pestisida dengan benar'] == "Pilihan.ya"
                                     ? Row(
                                      children: const [
                                        Text("Ya"),
                                        SizedBox(width: 8,),
                                        Icon(Icons.check, color: kGreen2,)
                                      ],
                                     )
                                     : Row(
                                      children: const [
                                          Text("Tidak"),
                                        SizedBox(width: 8,),
                                        Icon(Icons.close, color: Colors.red,)
                                      ],
                                     ),
                                     const Padding(
                                      padding: EdgeInsets.only(top: 8),
                                      child: Text("Membuang buah yang terserang penyakit", style: TextStyle(fontWeight: FontWeight.w600),),
                                    ),
                                    document[i]['membuang buah yang terserang penyakit'] == "Pilihan.ya"
                                     ? Row(
                                      children: const [
                                        Text("Ya"),
                                        SizedBox(width: 8,),
                                        Icon(Icons.check, color: kGreen2,)
                                      ],
                                     )
                                     : Row(
                                      children: const [
                                          Text("Tidak"),
                                        SizedBox(width: 8,),
                                        Icon(Icons.close, color: Colors.red,)
                                      ],
                                     ),
                                       const Padding(
                                      padding: EdgeInsets.only(top: 8),
                                      child: Text("Memangkas dahan yang terserang penyakit", style: TextStyle(fontWeight: FontWeight.w600),),
                                    ),
                                  document[i]['memangkas dahan yang terserang penyakit'] == "Pilihan.ya"
                                     ? Row(
                                      children: const [
                                        Text("Ya"),
                                        SizedBox(width: 8,),
                                        Icon(Icons.check, color: kGreen2,)
                                      ],
                                     )
                                     : Row(
                                      children: const [
                                          Text("Tidak"),
                                        SizedBox(width: 8,),
                                        Icon(Icons.close, color: Colors.red,)
                                      ],
                                     ),
                                     const Padding(
                                      padding: EdgeInsets.only(top: 8),
                                      child: Text("Kulit buah yang sakit ditangani dengan cepat", style: TextStyle(fontWeight: FontWeight.w600),),
                                    ),
                                    document[i]['kulit buah yang sakit ditangani dengan cepat'] == "Pilihan.ya"
                                     ? Row(
                                      children: const [
                                        Text("Ya"),
                                        SizedBox(width: 8,),
                                        Icon(Icons.check, color: kGreen2,)
                                      ],
                                     )
                                     : Row(
                                      children: const [
                                          Text("Tidak"),
                                        SizedBox(width: 8,),
                                        Icon(Icons.close, color: Colors.red,)
                                      ],
                                     ),
                                    
                                    const Padding(
                                      padding: EdgeInsets.only(top: padding, bottom: 8),
                                      child: Text("Dokumentasi", style: TextStyle(fontWeight: FontWeight.w600),),
                                    ),
                                    SizedBox(
                                      width: double.infinity,
                                      height: 200,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: Image.network(document[i]['gambar'], width: double.infinity, fit: BoxFit.cover,)),
                                    )
                                  ],
                                ),
                              ),
                              isExpanded: _isExpanded,
                              canTapOnHeader: true),
                        ]);
                  });
            }
    
            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
          addInspeksi()
      ], 
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
                        builder: (context) => SensusPage(
                            docId: widget.docId,
                            docIdPetani: widget.docIdPetani))),
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
                              builder: (context) => InspeksiPage(
                                  docId: widget.docId,
                                  docIdPetani: widget.docIdPetani))),
                      icon: const Icon(
                        Icons.add,
                        color: kWhite,
                      ))),
            ))
      ],
    );
  }
}
