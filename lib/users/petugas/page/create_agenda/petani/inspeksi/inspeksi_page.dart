import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:im_stepper/stepper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:permission_handler/permission_handler.dart';

import '../../../../../../theme/colors.dart';
import '../../../../../../theme/padding.dart';
import '../../create_agenda_page.dart';

enum Pilihan { ya, tidak }

class InspeksiPage extends StatefulWidget {
  final String docIdAgendaSensus;
  final String docIdDataPetani;
  const InspeksiPage({Key? key, required this.docIdAgendaSensus, required this.docIdDataPetani})
      : super(key: key);

  @override
  State<InspeksiPage> createState() => _InspeksiPageState();
}

class _InspeksiPageState extends State<InspeksiPage> {
  String titlePage = "Form Inspeksi";

  final _formKey = GlobalKey<FormState>();

  int _activeStep = 0;
  final int _upperBound = 3;
  DateTime _dateTime = DateTime.now();
  var _imageFile;
  String? _imageUrl;
  String? uid;
  String? username;

  Pilihan? _pilihan1;
  Pilihan? _pilihan2;
  Pilihan? _pilihan3;
  Pilihan? _pilihan4;
  Pilihan? _pilihan5;
  Pilihan? _pilihan6;

  String? _selectedValue1;
  String? _selectedValue2;
  String? _selectedValue3;
  String? _selectedValue4;
  String? _selectedValue5;
  String? _selectedValue6;

  //formInspeksi
  final TextEditingController _controllerSubjek = TextEditingController();
  final TextEditingController _controllerTglSubjek = TextEditingController();
  final TextEditingController _controllerJumlahKakaoLokal = TextEditingController();
  final TextEditingController _controllerJumlahKakaoS1 = TextEditingController();
  final TextEditingController _controllerJumlahKakaoS2 = TextEditingController();
  final TextEditingController _controllerFrekuensiBerat = TextEditingController();
  final TextEditingController _controllerFrekuensiRingan = TextEditingController();
  final TextEditingController _controllerHama = TextEditingController();
  final TextEditingController _controllerPenyakit = TextEditingController();

  Future pickImage() async {
    var status = await Permission.camera.request();
    if (status.isGranted) {
      final ImagePicker _picker = ImagePicker();
      final XFile? image = await _picker.pickImage(source: ImageSource.camera);
      setState(() {
        _imageFile = File(image!.path);
        uploadImageToFirebase();
      });
    }
  }

  Future uploadImageToFirebase() async {
    File file = File(_imageFile.path);

    if (_imageFile != null) {
      firebase_storage.TaskSnapshot snapshot = await firebase_storage
          .FirebaseStorage.instance
          .ref('$_imageFile')
          .putFile(file);

      var downloadUrl = await snapshot.ref.getDownloadURL();
      setState(() {
        _imageUrl = downloadUrl;
      });
    } else {
      print('Tidak dapat ditampilkan');
    }
  }

  Future<void> selectedDate(BuildContext context) async {
    DateTime today = DateTime.now();
    final DateTime? _datePicker = await showDatePicker(
        context: context,
        initialDate: _dateTime,
        firstDate: DateTime(1900),
        lastDate: today);
    if (_datePicker != null) {
      _dateTime = _datePicker;
      _controllerTglSubjek.text = DateFormat('dd/MM/yyyy').format(_dateTime);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Form Inspeksi"),
        centerTitle: true,
        backgroundColor: kGreen,
        leading: IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.close)),
      ),
      body: Container(
        width: size.width,
        height: size.height,
        padding: const EdgeInsets.symmetric(vertical: padding),
        child: SingleChildScrollView(
          child: formSensus()
        ),
      ),
    );
  }

  Widget formSensus() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Card(
            color: kWhite,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            margin: const EdgeInsets.symmetric(
              horizontal: padding,
            ),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                  horizontal: padding, vertical: padding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: _controllerSubjek,
                    cursorColor: kGreen,
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(hintText: 'Subjek'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Masukkan Subjek";
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _controllerTglSubjek,
                    cursorColor: kGreen,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                        suffixIcon: Icon(Icons.today), hintText: 'Tanggal'),
                    readOnly: true,
                    onTap: () => selectedDate(context),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Masukkan Tanggal";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Card(
            color: kWhite,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            margin: const EdgeInsets.symmetric(
              horizontal: padding,
            ),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                  horizontal: padding, vertical: padding),
              child: Column(
                children: [
                  Row(
                    children: const [
                      Text(
                        "Jumlah buah kakao",
                        style: TextStyle(
                            color: kBlack, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  TextFormField(
                    controller: _controllerJumlahKakaoLokal,
                    cursorColor: kGreen,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(hintText: 'Lokal'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Masukkan Jumlah Kakao";
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _controllerJumlahKakaoS1,
                    cursorColor: kGreen,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(hintText: 'S1'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Masukkan Jumlah S1";
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _controllerJumlahKakaoS2,
                    cursorColor: kGreen,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(hintText: 'S2'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Masukkan Jumlah S2";
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Card(
            color: kWhite,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            margin: const EdgeInsets.symmetric(
              horizontal: padding,
            ),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                  horizontal: padding, vertical: padding),
              child: Column(
                children: [
                  Row(
                    children: const [
                      Text(
                        "Frekuensi pemangkasan",
                        style: TextStyle(
                            color: kBlack, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  TextFormField(
                    controller: _controllerFrekuensiBerat,
                    cursorColor: kGreen,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(hintText: 'Berat'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Masukkan Berat";
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _controllerFrekuensiRingan,
                    cursorColor: kGreen,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(hintText: 'Ringan'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Masukkan Ringan";
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Card(
            color: kWhite,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            margin: const EdgeInsets.symmetric(
              horizontal: padding,
            ),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                  horizontal: padding, vertical: padding),
              child: Column(
                children: [
                  Row(
                    children: const [
                      Text(
                        "Hama dan penyakit",
                        style: TextStyle(
                            color: kBlack, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  TextFormField(
                    controller: _controllerHama,
                    cursorColor: kGreen,
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(hintText: 'Hama'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Masukkan Hama";
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _controllerPenyakit,
                    cursorColor: kGreen,
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(hintText: 'Penyakit'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Masukkan Penyakit";
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Card(
            color: kWhite,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            margin: const EdgeInsets.symmetric(
              horizontal: padding,
            ),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                  horizontal: padding, vertical: padding),
              child: Column(
                children: [
                  const Text(
                    "Mempunyai kotak penyimpanan pestisida",
                    style:
                        TextStyle(color: kBlack, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Radio(
                          activeColor: kGreen2,
                          value: Pilihan.ya,
                          groupValue: _pilihan1,
                          onChanged: (Pilihan? value) {
                            setState(() {
                              _pilihan1 = value;
                              _selectedValue1 = Pilihan.ya.toString();
                            });
                          }),
                      const Text("Ya"),
                      const SizedBox(
                        width: 24,
                      ),
                      Radio(
                          activeColor: kGreen2,
                          value: Pilihan.tidak,
                          groupValue: _pilihan1,
                          onChanged: (Pilihan? value) {
                            setState(() {
                              _pilihan1 = value;
                              _selectedValue1 = Pilihan.tidak.toString();
                            });
                          }),
                      const Text("Tidak"),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            color: kWhite,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            margin: const EdgeInsets.symmetric(
              horizontal: padding,
            ),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                  horizontal: padding, vertical: padding),
              child: Column(
                children: [
                  const Text(
                    "Mempunyai kotak penyimpanan khusus pupuk",
                    style:
                        TextStyle(color: kBlack, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Radio(
                          activeColor: kGreen2,
                          value: Pilihan.ya,
                          groupValue: _pilihan2,
                          onChanged: (Pilihan? value) {
                            setState(() {
                              _pilihan2 = value;
                              _selectedValue2 = Pilihan.ya.toString();
                            });
                          }),
                      const Text("Ya"),
                      const SizedBox(
                        width: 24,
                      ),
                      Radio(
                          activeColor: kGreen2,
                          value: Pilihan.tidak,
                          groupValue: _pilihan2,
                          onChanged: (Pilihan? value) {
                            setState(() {
                              _pilihan2 = value;
                              _selectedValue2 = Pilihan.tidak.toString();
                            });
                          }),
                      const Text("Tidak"),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            color: kWhite,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            margin: const EdgeInsets.symmetric(
              horizontal: padding,
            ),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                  horizontal: padding, vertical: padding),
              child: Column(
                children: [
                  const Text(
                    "Membuang wadah bekas pestisida dengan benar",
                    style:
                        TextStyle(color: kBlack, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Radio(
                          activeColor: kGreen2,
                          value: Pilihan.ya,
                          groupValue: _pilihan3,
                          onChanged: (Pilihan? value) {
                            setState(() {
                              _pilihan3 = value;
                              _selectedValue3 = Pilihan.ya.toString();
                            });
                          }),
                      const Text("Ya"),
                      const SizedBox(
                        width: 24,
                      ),
                      Radio(
                          activeColor: kGreen2,
                          value: Pilihan.tidak,
                          groupValue: _pilihan3,
                          onChanged: (Pilihan? value) {
                            setState(() {
                              _pilihan3 = value;
                              _selectedValue3 = Pilihan.tidak.toString();
                            });
                          }),
                      const Text("Tidak"),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            color: kWhite,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            margin: const EdgeInsets.symmetric(
              horizontal: padding,
            ),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                  horizontal: padding, vertical: padding),
              child: Column(
                children: [
                  const Text(
                    "Membuang buah yang terserang penyakit",
                    style:
                        TextStyle(color: kBlack, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Radio(
                          activeColor: kGreen2,
                          value: Pilihan.ya,
                          groupValue: _pilihan4,
                          onChanged: (Pilihan? value) {
                            setState(() {
                              _pilihan4 = value;
                              _selectedValue4 = Pilihan.ya.toString();
                            });
                          }),
                      const Text("Ya"),
                      const SizedBox(
                        width: 24,
                      ),
                      Radio(
                          activeColor: kGreen2,
                          value: Pilihan.tidak,
                          groupValue: _pilihan4,
                          onChanged: (Pilihan? value) {
                            setState(() {
                              _pilihan4 = value;
                              _selectedValue4 = Pilihan.tidak.toString();
                            });
                          }),
                      const Text("Tidak"),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            color: kWhite,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            margin: const EdgeInsets.symmetric(
              horizontal: padding,
            ),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                  horizontal: padding, vertical: padding),
              child: Column(
                children: [
                  const Text(
                    "Memangkas dahan yang terserang penyakit",
                    style:
                        TextStyle(color: kBlack, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Radio(
                          activeColor: kGreen2,
                          value: Pilihan.ya,
                          groupValue: _pilihan5,
                          onChanged: (Pilihan? value) {
                            setState(() {
                              _pilihan5 = value;
                              _selectedValue5 = Pilihan.ya.toString();
                            });
                          }),
                      const Text("Ya"),
                      const SizedBox(
                        width: 24,
                      ),
                      Radio(
                          activeColor: kGreen2,
                          value: Pilihan.tidak,
                          groupValue: _pilihan5,
                          onChanged: (Pilihan? value) {
                            setState(() {
                              _pilihan5 = value;
                              _selectedValue5 = Pilihan.tidak.toString();
                            });
                          }),
                      const Text("Tidak"),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            color: kWhite,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            margin: const EdgeInsets.symmetric(
              horizontal: padding,
            ),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                  horizontal: padding, vertical: padding),
              child: Column(
                children: [
                  const Text(
                    "Kulit buah yang sakit ditangani dengan cepat",
                    style:
                        TextStyle(color: kBlack, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Radio(
                          activeColor: kGreen2,
                          value: Pilihan.ya,
                          groupValue: _pilihan6,
                          onChanged: (Pilihan? value) {
                            setState(() {
                              _pilihan6 = value;
                              _selectedValue6 = Pilihan.ya.toString();
                            });
                          }),
                      const Text("Ya"),
                      const SizedBox(
                        width: 24,
                      ),
                      Radio(
                          activeColor: kGreen2,
                          value: Pilihan.tidak,
                          groupValue: _pilihan6,
                          onChanged: (Pilihan? value) {
                            setState(() {
                              _pilihan6 = value;
                              _selectedValue6 = Pilihan.tidak.toString();
                            });
                          }),
                      const Text("Tidak"),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          _imageFile != null ? viewPhoto() : Container(),
          const SizedBox(
            height: 20,
          ),
          addPhoto(),
          const SizedBox(
            height: 20,
          ),
          buttonSubmit(),
        ],
      ),
    );
  }

  Widget viewPhoto() {
    return Container(
        width: double.infinity,
        height: 200,
        padding: const EdgeInsets.all(padding),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Center(child: Image.file(_imageFile, width: double.infinity, fit: BoxFit.cover,),),
        ));
  }

  Widget addPhoto() {
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
                onTap: pickImage,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.add_a_photo,
                      color: kGreen,
                      size: 40,
                    ),
                    Text(
                      'Ambil Gambar',
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

  Widget buttonSubmit() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: padding),
      child: ElevatedButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(kGreen2),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5)))),
        onPressed: () => Future.delayed(const Duration(seconds: 3), () => createFormInspeksi()),
        child: const SizedBox(
          width: double.infinity,
          height: 48,
          child: Center(
            child: Text(
              'Simpan',
              style: TextStyle(color: kWhite, fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ),
    );
  }

  Future<dynamic> createFormInspeksi() async {
    if (_formKey.currentState!.validate()) {
      await FirebaseFirestore.instance
          .collection("petugas")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("agenda_sensus")
          .doc(widget.docIdAgendaSensus)
          .collection("data_petani")
          .doc(widget.docIdDataPetani)
          .collection("inspeksi")
          .add({
        'subjek': _controllerSubjek.text,
        'tanggal subjek': _controllerTglSubjek.text,

        //jumlah buah kakao
        'jumlah kakao lokal': _controllerJumlahKakaoLokal.text,
        'jumlah kakao s1': _controllerJumlahKakaoS1.text,
        'jumlah kakao s2': _controllerJumlahKakaoS2.text,

        //frekuensi pemangkasan
        'frekuensi berat': _controllerFrekuensiBerat.text,
        'frekuensi ringan': _controllerFrekuensiRingan.text,

        //hama dan penyakit
        'hama': _controllerHama.text,
        'penyakit': _controllerPenyakit.text,

        'mempunyai kotak penyimpanan pestisida': _selectedValue1.toString(),
        'mempunyai kotak penyimpanan khusus pupuk': _selectedValue2.toString(),
        'membuang wadah bekas pestisida dengan benar': _selectedValue3.toString(),
        'membuang buah yang terserang penyakit': _selectedValue4.toString(),
        'memangkas dahan yang terserang penyakit': _selectedValue5.toString(),
        'kulit buah yang sakit ditangani dengan cepat': _selectedValue6.toString(),

        //gambar
        'gambar': _imageUrl.toString()
      });

      alertNotif();
    }
  }

  alertNotif() {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            content: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(
                  Icons.check_circle_outline,
                  color: kGreen,
                  size: 90,
                ),
                Text(
                  "Sukses",
                  style: TextStyle(
                      color: kBlack, fontSize: 24, fontWeight: FontWeight.w400),
                ),
              ],
            ),
            actions: [
              ElevatedButton(
                  onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CreateAgendaPage(
                                uid: uid.toString(),
                                username: username.toString(),
                              ))),
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(kGreen2),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)))),
                  child: Container(
                      width: double.infinity,
                      height: 60,
                      padding: const EdgeInsets.symmetric(horizontal: padding),
                      child: const Center(
                          child: Text(
                        "Kembali ke Agenda",
                        style: TextStyle(
                            color: kWhite, fontWeight: FontWeight.w600),
                      ))))
            ],
          );
        });
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
