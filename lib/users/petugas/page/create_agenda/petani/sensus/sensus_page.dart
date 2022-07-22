import 'dart:io';

import 'package:barry_callebaut/users/petugas/models/m_info_umum.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:im_stepper/stepper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../../../../../theme/colors.dart';
import '../../../../../../theme/padding.dart';
import '../../create_agenda_page.dart';

enum JenisKelamin { pria, wanita }

class SensusPage extends StatefulWidget {
  final String docId;
  final String docIdPetani;
  const SensusPage({Key? key, required this.docId, required this.docIdPetani})
      : super(key: key);

  @override
  _SensusPageState createState() => _SensusPageState();
}

class _SensusPageState extends State<SensusPage> {
  String titlePage = "Form Sensus";

  final _formKey = GlobalKey<FormState>();

  int _activeStep = 0;
  final int _upperBound = 5;

  String? uid;
  String? username;

  JenisKelamin? _jekel;

  DateTime _dateTime = DateTime.now();

  final List<String> _listStatus = ['Lajang', 'Menikah', 'Duda', 'Janda'];

  Map? checkList1;
  Map? checkList2;
  Map? checkList3;
  Map? checkList4;
  Map? checkList5;

  String? _selectedStatus;
  var _imageFile;
  String? _imageUrl;

  //form1
  final TextEditingController _controllerTglSensus = TextEditingController();
  final TextEditingController _controllerNama = TextEditingController();
  final TextEditingController _controllerNoTelp = TextEditingController();
  final TextEditingController _controllerJekel = TextEditingController();
  final TextEditingController _controllerTglLahir = TextEditingController();
  final TextEditingController _controllerStatusNikah = TextEditingController();
  final TextEditingController _controllerStatusPendidikan =
      TextEditingController();
  final TextEditingController _controllerKelompok = TextEditingController();

  //form2
  final TextEditingController _controllerAlamat = TextEditingController();
  final TextEditingController _controllerDusun = TextEditingController();
  final TextEditingController _controllerDesa = TextEditingController();
  final TextEditingController _controllerKecamatan = TextEditingController();
  final TextEditingController _controllerKabupaten = TextEditingController();
  final TextEditingController _controllerNamaSuamiIstri =
      TextEditingController();
  final TextEditingController _controllerTglLahirSuamiIstri =
      TextEditingController();
  final TextEditingController _controllerPendAkhirSuamiIstri =
      TextEditingController();
  final TextEditingController _controllerNamaAnak = TextEditingController();
  final TextEditingController _controllerTglLahirAnak = TextEditingController();
  final TextEditingController _controllerPendAkhirAnak =
      TextEditingController();

  //form3
  final TextEditingController _controllerLuas = TextEditingController();
  final TextEditingController _controllerKoordinat = TextEditingController();
  final TextEditingController _controllerLokal = TextEditingController();
  final TextEditingController _controllerS1 = TextEditingController();
  final TextEditingController _controllerS2 = TextEditingController();
  final TextEditingController _controllerLain = TextEditingController();
  final TextEditingController _controllerJarakTanam = TextEditingController();

  //form4
  final TextEditingController _controllerPendapatanLain =
      TextEditingController();
  final TextEditingController _controllerPendapatanBulan =
      TextEditingController();

  Future pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    setState(() {
      _imageFile = File(image!.path);
      uploadImageToFirebase();
    });
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

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [header(), formstep()],
            ),
          ),
        ),
      ),
    );
  }

  Widget header() {
    return Container(
      width: double.infinity,
      height: 140,
      margin: const EdgeInsets.only(bottom: 20),
      color: kGreen2,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: padding),
            child: Center(
              child: Text(
                titlePage,
                style: const TextStyle(
                    fontSize: 20, fontWeight: FontWeight.w700, color: kWhite),
              ),
            ),
          ),
          iconStepper(),
          const SizedBox(
            height: 16,
          ),
        ],
      ),
    );
  }

  Widget iconStepper() {
    return IconStepper(
      icons: const [
        Icon(
          Icons.check,
          color: kGreen2,
        ),
        Icon(
          Icons.check,
          color: kGreen2,
        ),
        Icon(
          Icons.check,
          color: kGreen2,
        ),
        Icon(
          Icons.check,
          color: kGreen2,
        ),
        Icon(
          Icons.check,
          color: kGreen2,
        ),
      ],
      activeStep: _activeStep,
      onStepReached: (index) {
        setState(() {
          _activeStep = index;
        });
      },
      activeStepBorderColor: kWhite,
      activeStepColor: kWhite,
      stepColor: kGrey3,
      stepRadius: 12,
      enableStepTapping: true,
      lineColor: kWhite,
      lineLength: 40.0,
      enableNextPreviousButtons: false,
    );
  }

  formstep() async {
    switch (_activeStep) {
      case 0:
        return formSensus();
      case 1:
        return formSensus2();
      case 2:
        return formSensus3();
      case 3:
        return formSensus4();
      case 4:
        return formSensus5();
      default:
    }
  }

  Widget formSensus() {
    return Column(
      children: [
        Row(
          children: const [
            Padding(
              padding: EdgeInsets.only(left: 24, bottom: 12),
              child: Text(
                "Info Petani",
                style: TextStyle(
                    color: kGreen2, fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
        Card(
          color: kWhite,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          margin: const EdgeInsets.symmetric(
            horizontal: padding,
          ),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
                horizontal: padding, vertical: padding),
            child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Data Personal",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    TextFormField(
                      controller: _controllerTglSensus,
                      cursorColor: kGreen,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                          suffixIcon: Icon(Icons.today),
                          hintText: 'Tanggal Sensus'),
                      readOnly: true,
                      onTap: () => selectedDateSensus(context),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Masukkan Tanggal";
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _controllerNama,
                      cursorColor: kGreen,
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(hintText: 'Nama'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Masukkan Nama";
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _controllerNoTelp,
                      cursorColor: kGreen,
                      keyboardType: TextInputType.phone,
                      textInputAction: TextInputAction.next,
                      decoration:
                          const InputDecoration(hintText: 'No. Telephone'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Masukkan No. Telephone";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    const Text(
                      "Jenis Kelamin",
                      style: TextStyle(color: kBlack),
                    ),
                    Row(
                      children: [
                        Radio(
                            activeColor: kGreen2,
                            value: JenisKelamin.pria,
                            groupValue: _jekel,
                            onChanged: (JenisKelamin? value) {
                              setState(() {
                                _jekel = value;
                              });
                            }),
                        const Text("Pria"),
                        const SizedBox(
                          width: 24,
                        ),
                        Radio(
                            activeColor: kGreen2,
                            value: JenisKelamin.wanita,
                            groupValue: _jekel,
                            onChanged: (JenisKelamin? value) {
                              setState(() {
                                _jekel = value;
                              });
                            }),
                        const Text("Wanita"),
                      ],
                    ),
                    TextFormField(
                      controller: _controllerTglLahir,
                      cursorColor: kGreen,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                          suffixIcon: Icon(Icons.today),
                          hintText: 'Tanggal Lahir'),
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
                    DropdownButton(
                      items: _listStatus
                          .map((value) => DropdownMenuItem(
                                child: Text(value),
                                value: value,
                              ))
                          .toList(),
                      onChanged: (String? selected) {
                        setState(() {
                          _selectedStatus = selected;
                        });
                      },
                      value: _selectedStatus,
                      isExpanded: true,
                      hint: const Text('Status Pernikahan'),
                    ),
                    TextFormField(
                      controller: _controllerStatusPendidikan,
                      cursorColor: kGreen,
                      textInputAction: TextInputAction.next,
                      decoration:
                          const InputDecoration(hintText: 'Status Pendidikan'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Masukkan Status Pendidikan";
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _controllerKelompok,
                      cursorColor: kGreen,
                      textInputAction: TextInputAction.done,
                      decoration: const InputDecoration(hintText: 'Kelompok'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Masukkan Kelompok";
                        }
                        return null;
                      },
                    ),
                  ],
                )),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        buttonNext(),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }

  Future<void> selectedDateSensus(BuildContext context) async {
    DateTime today = DateTime.now();
    final DateTime? _datePicker = await showDatePicker(
        context: context,
        initialDate: _dateTime,
        firstDate: DateTime(1990),
        lastDate: today);
    if (_datePicker != null) {
      _dateTime = _datePicker;
      _controllerTglSensus.text = DateFormat('dd/MM/yyyy').format(_dateTime);
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
      _controllerTglLahir.text = DateFormat('dd/MM/yyyy').format(_dateTime);
    }
  }

  Widget buttonNext() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: padding),
      child: ElevatedButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(kGreen2),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5)))),
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            if (_activeStep < _upperBound) {
              setState(() {
                _activeStep++;
              });
            } else if (_activeStep > 0) {
              setState(() {
                setState(() {
                  _activeStep--;
                });
              });
            }
          }
        },
        child: const SizedBox(
          width: double.infinity,
          height: 48,
          child: Center(
            child: Text(
              'Next',
              style: TextStyle(color: kWhite, fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ),
    );
  }

  Widget formSensus2() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Row(
            children: const [
              Padding(
                padding: EdgeInsets.only(left: 24, bottom: 12),
                child: Text(
                  "Info Petani",
                  style: TextStyle(
                      color: kGreen2,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
          Card(
            margin: const EdgeInsets.symmetric(
                horizontal: padding, vertical: padding),
            color: kWhite,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                  horizontal: padding, vertical: padding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Alamat",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                  ),
                  TextFormField(
                    controller: _controllerAlamat,
                    cursorColor: kGreen,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(hintText: 'Alamat'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Masukkan Alamat";
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _controllerDusun,
                    cursorColor: kGreen,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(hintText: 'Dusun'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Masukkan Dusun";
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _controllerDesa,
                    cursorColor: kGreen,
                    textInputAction: TextInputAction.next,
                    decoration:
                        const InputDecoration(hintText: 'Desa/Kelurahan'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Masukkan Desa";
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _controllerKecamatan,
                    cursorColor: kGreen,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(hintText: 'Kecamatan'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Masukkan Kecamatan";
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _controllerKabupaten,
                    cursorColor: kGreen,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(hintText: 'Kabupaten'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Masukkan Kabupaten";
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ),
          Card(
            margin: const EdgeInsets.symmetric(
                horizontal: padding, vertical: padding),
            color: kWhite,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                  horizontal: padding, vertical: padding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Data Istri/Suami",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                  ),
                  TextFormField(
                    controller: _controllerNamaSuamiIstri,
                    cursorColor: kGreen,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(hintText: 'Nama'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Masukkan Nama";
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _controllerTglLahirSuamiIstri,
                    cursorColor: kGreen,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                        suffixIcon: Icon(Icons.today),
                        hintText: 'Tanggal Lahir'),
                    readOnly: true,
                    onTap: () => selectedDateSuamiIstri(context),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Masukkan Tanggal";
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _controllerPendAkhirSuamiIstri,
                    cursorColor: kGreen,
                    textInputAction: TextInputAction.next,
                    decoration:
                        const InputDecoration(hintText: 'Pendidikan Terakhir'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Masukkan Pendidikan Terakhir";
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ),
          Card(
            margin: const EdgeInsets.symmetric(
                horizontal: padding, vertical: padding),
            color: kWhite,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                  horizontal: padding, vertical: padding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Data Anak",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                  ),
                  TextFormField(
                    controller: _controllerNamaAnak,
                    cursorColor: kGreen,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(hintText: 'Nama'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Masukkan Nama";
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _controllerTglLahirAnak,
                    cursorColor: kGreen,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                        suffixIcon: Icon(Icons.today),
                        hintText: 'Tanggal Lahir'),
                    readOnly: true,
                    onTap: () => selectedDateAnak(context),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Masukkan Tanggal";
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _controllerPendAkhirAnak,
                    cursorColor: kGreen,
                    textInputAction: TextInputAction.next,
                    decoration:
                        const InputDecoration(hintText: 'Pendidikan Terakhir'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Masukkan Pendidikan Terakhir";
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ),
          buttonNext(),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  Future<void> selectedDateSuamiIstri(BuildContext context) async {
    DateTime today = DateTime.now();
    final DateTime? _datePicker = await showDatePicker(
        context: context,
        initialDate: _dateTime,
        firstDate: DateTime(1930),
        lastDate: today);
    if (_datePicker != null) {
      _dateTime = _datePicker;
      _controllerTglLahirSuamiIstri.text =
          DateFormat('dd/MM/yyyy').format(_dateTime);
    }
  }

  Future<void> selectedDateAnak(BuildContext context) async {
    DateTime today = DateTime.now();
    final DateTime? _datePicker = await showDatePicker(
        context: context,
        initialDate: _dateTime,
        firstDate: DateTime(1900),
        lastDate: today);
    if (_datePicker != null) {
      _dateTime = _datePicker;
      _controllerTglLahirAnak.text = DateFormat('dd/MM/yyyy').format(_dateTime);
    }
  }

  Widget formSensus3() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Row(
            children: const [
              Padding(
                padding: EdgeInsets.only(left: 24, bottom: 12),
                child: Text(
                  "Info Kebun",
                  style: TextStyle(
                      color: kGreen2,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
          Card(
            margin: const EdgeInsets.symmetric(horizontal: padding),
            color: kWhite,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                  horizontal: padding, vertical: padding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Kebun 1",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                  ),
                  TextFormField(
                    controller: _controllerLuas,
                    cursorColor: kGreen,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(hintText: 'Luas (m2)'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Masukkan Luas";
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _controllerKoordinat,
                    cursorColor: kGreen,
                    textInputAction: TextInputAction.next,
                    decoration:
                        const InputDecoration(hintText: 'Letak/Koordinat'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Masukkan Letak/Koordinat";
                      }
                      return null;
                    },
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 24, bottom: 8),
                    child: Text(
                      "Kakao yang berproduksi",
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                    ),
                  ),
                  TextFormField(
                    controller: _controllerLokal,
                    cursorColor: kGreen,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(hintText: 'Lokal'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Masukkan Lokal";
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _controllerS1,
                    cursorColor: kGreen,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(hintText: 'S1'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Masukkan S1";
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _controllerS2,
                    cursorColor: kGreen,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(hintText: 'S2'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Masukkan S2";
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _controllerLain,
                    cursorColor: kGreen,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(hintText: 'Lain-lain'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Masukkan Lain-lain";
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _controllerJarakTanam,
                    cursorColor: kGreen,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(hintText: 'Jarak Tanam'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Masukkan Jarak Tanam";
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          buttonNext(),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  Widget formSensus4() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Row(
            children: const [
              Padding(
                padding: EdgeInsets.only(left: 24, bottom: 12),
                child: Text(
                  "Info Keuangan",
                  style: TextStyle(
                      color: kGreen2,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
          Card(
            margin: const EdgeInsets.symmetric(horizontal: padding),
            color: kWhite,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                  horizontal: padding, vertical: padding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Pendapatan 1",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                  ),
                  TextFormField(
                    controller: _controllerPendapatanLain,
                    cursorColor: kGreen,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    decoration:
                        const InputDecoration(hintText: 'Pendapatan lain'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Masukkan Pendapatan lain";
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _controllerPendapatanBulan,
                    cursorColor: kGreen,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                    decoration:
                        const InputDecoration(hintText: 'Pendapatan/Bulan'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Masukkan Pendapatan/Bulan";
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          buttonNext(),
          const SizedBox(
            height: 40,
          ),
        ],
      ),
    );
  }

  Widget formSensus5() {
    return Form(
      key: _formKey,
      child: Stack(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    children: const [
                      Padding(
                        padding: EdgeInsets.only(left: 24, bottom: 12),
                        child: Text(
                          "Info Umum",
                          style: TextStyle(
                              color: kGreen2,
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                  Card(
                    margin: const EdgeInsets.symmetric(
                        horizontal: padding * 2, vertical: padding / 2),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 8, horizontal: padding),
                          child: Text(
                            "Alat transportasi petani saat membawa kakao",
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                        ),
                        Container(
                            width: double.infinity,
                            height: 340,
                            margin: const EdgeInsets.symmetric(
                                horizontal: padding, vertical: padding),
                            child: Column(
                              children: checkBoxList1.map((list1) {
                                if (list1["isChecked"] == true) {
                                  checkList1 = list1["name"];
                                }

                                return CheckboxListTile(
                                    title: Text(
                                      list1["name"],
                                      style: const TextStyle(
                                          fontSize: 12, color: kBlack6),
                                    ),
                                    value: list1["isChecked"],
                                    onChanged: (value) {
                                      setState(() {
                                        list1["isChecked"] = value;
                                      });
                                    });
                              }).toList(),
                            )),
                        Wrap(
                          children: checkBoxList1.map((list1) {
                            if (list1["isChecked"] == true) {
                              return Card(
                                elevation: 3,
                                color: kGreen2,
                                margin: const EdgeInsets.only(left: padding, bottom: 8),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(list1["name"], style: const TextStyle(color: kWhite, fontSize: 12),),
                                ),
                              );
                            }

                            return Container();
                          }).toList(),
                        ),
                      const SizedBox(height: 8,)
                      ],
                    ),
                  ),
                  Card(
                    margin: const EdgeInsets.symmetric(
                        horizontal: padding * 2, vertical: padding / 2),
                    color: kWhite,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 8, horizontal: padding),
                          child: Text(
                            "Material utama rumah petani",
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          height: 370,
                          padding: const EdgeInsets.symmetric(
                              horizontal: padding, vertical: padding),
                          child: Column(
                            children: checkBoxList2.map((list2) {
                              if (list2["isChecked"] == true) {
                                checkList2 = list2["name"];
                              }

                              return CheckboxListTile(
                                  title: Text(
                                    list2["name"],
                                    style: const TextStyle(
                                        fontSize: 12, color: kBlack6),
                                  ),
                                  value: list2["isChecked"],
                                  onChanged: (value) {
                                    setState(() {
                                      list2["isChecked"] = value;
                                    });
                                  });
                            }).toList(),
                          ),
                        ),
                        Wrap(
                          children: checkBoxList2.map((list2) {
                            if (list2["isChecked"] == true) {
                              return Card(
                                elevation: 3,
                                color: kGreen2,
                                margin: const EdgeInsets.only(left: padding, bottom: 8),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(list2["name"], style: const TextStyle(color: kWhite, fontSize: 12),),
                                ),
                              );
                            }

                            return Container();
                          }).toList(),
                        
                        ),
                        const SizedBox(height: 8,)
                      ],
                    ),
                  ),
                  Card(
                    margin: const EdgeInsets.symmetric(
                        horizontal: padding * 2, vertical: padding / 2),
                    color: kWhite,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 8, horizontal: padding),
                          child: Text(
                            "Alat yang digunakan petani untuk memasak",
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          height: 320,
                          padding: const EdgeInsets.symmetric(
                              horizontal: padding, vertical: padding),
                          child: Column(
                            children: checkBoxList3.map((list3) {
                              if (list3["isChecked"] == true) {
                                checkList3 = list3["name"];
                              }

                              return CheckboxListTile(
                                  title: Text(
                                    list3["name"],
                                    style: const TextStyle(
                                        fontSize: 12, color: kBlack6),
                                  ),
                                  value: list3["isChecked"],
                                  onChanged: (value) {
                                    setState(() {
                                      list3["isChecked"] = value;
                                    });
                                  });
                            }).toList(),
                          ),
                        ),
                        Wrap(
                          children: checkBoxList3.map((list3) {
                            if (list3["isChecked"] == true) {
                              return Card(
                                elevation: 3,
                                color: kGreen2,
                                 margin: const EdgeInsets.only(left: padding, bottom: 8),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(list3["name"], style: const TextStyle(color: kWhite, fontSize: 12),),
                                ),
                              );
                            }

                            return Container();
                          }).toList(),
                        ),
                        const SizedBox(height: 8,)
                      ],
                    ),
                  ),
                  Card(
                    margin: const EdgeInsets.symmetric(
                        horizontal: padding * 2, vertical: padding / 2),
                    color: kWhite,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 8, horizontal: padding),
                          child: Text(
                            "Barang yang ada di rumah petani",
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          height: 320,
                          padding: const EdgeInsets.symmetric(
                              horizontal: padding, vertical: padding),
                          child: Column(
                            children: checkBoxList4.map((list4) {
                              if (list4["isChecked"] == true) {
                                checkList4 = list4["name"];
                              }

                              return CheckboxListTile(
                                  title: Text(
                                    list4["name"],
                                    style: const TextStyle(
                                        fontSize: 12, color: kBlack6),
                                  ),
                                  value: list4["isChecked"],
                                  onChanged: (value) {
                                    setState(() {
                                      list4["isChecked"] = value;
                                    });
                                  });
                            }).toList(),
                          ),
                        ),
                        Wrap(
                          children: checkBoxList4.map((list4) {
                            if (list4["isChecked"] == true) {
                              return Card(
                                elevation: 3,
                                color: kGreen2,
                                 margin: const EdgeInsets.only(left: padding, bottom: 8),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(list4["name"], style: const TextStyle(color: kWhite, fontSize: 12),),
                                ),
                              );
                            }

                            return Container();
                          }).toList(),
                        ),
                        const SizedBox(height: 8,)
                      ],
                    ),
                  ),
                  Card(
                    margin: const EdgeInsets.symmetric(
                        horizontal: padding * 2, vertical: padding / 2),
                    color: kWhite,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 8, horizontal: padding),
                          child: Text(
                            "Toilet yang digunakan petani",
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          height: 320,
                          padding: const EdgeInsets.symmetric(
                              horizontal: padding, vertical: padding),
                          child: Column(
                            children: checkBoxList5.map((list5) {
                              if (list5["isChecked"] == true) {
                                checkList5 = list5["name"];
                              }

                              return CheckboxListTile(
                                  title: Text(
                                    list5["name"],
                                    style: const TextStyle(
                                        fontSize: 12, color: kBlack6),
                                  ),
                                  value: list5["isChecked"],
                                  onChanged: (value) {
                                    setState(() {
                                      list5["isChecked"] = value;
                                    });
                                  });
                            }).toList(),
                          ),
                        ),
                        Wrap(
                          children: checkBoxList5.map((list5) {
                            if (list5["isChecked"] == true) {
                              return Card(
                                elevation: 3,
                                color: kGreen2,
                                 margin: const EdgeInsets.only(left: padding, bottom: 8),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(list5["name"], style: const TextStyle(color: kWhite, fontSize: 12),),
                                ),
                              );
                            }

                            return Container();
                          }).toList(),
                        ),
                        const SizedBox(height: 8,)
                      ],
                    ),
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
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
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
          child: Image.file(_imageFile, fit: BoxFit.cover,),
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
        onPressed: () {
          if (_activeStep < _upperBound) {
            setState(() {
              _activeStep++;
            });
          }
          createFormSensus();
        },
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

  Future<dynamic> createFormSensus() async {
    if (_formKey.currentState!.validate()) {
      await FirebaseFirestore.instance
          .collection("petugas")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("agenda_sensus")
          .doc(widget.docId)
          .collection("data_petani")
          .doc(widget.docIdPetani)
          .collection("sensus")
          .doc(widget.docIdPetani)
          .set({
        //info petani
        'tanggal sensus': _controllerTglSensus.text,
        'nama': _controllerNama.text,
        'no.telephone': _controllerNoTelp.text,
        'jenis kelamin': _controllerJekel.text,
        'tanggal lahir': _controllerTglLahir.text,
        'status nikah': _controllerStatusNikah.text,
        'status pendidikan': _controllerStatusPendidikan.text,
        'kelompok': _controllerKelompok.text,

        //info petani
        'alamat': _controllerAlamat.text,
        'dusun': _controllerDusun.text,
        'desa': _controllerDesa.text,
        'kecamatan': _controllerKecamatan.text,
        'kabupaten': _controllerKabupaten.text,
        'nama suami/istri': _controllerNamaSuamiIstri.text,
        'tgl.lahir suami/istri': _controllerTglLahirSuamiIstri.text,
        'pend.akhir suami/istri': _controllerPendAkhirSuamiIstri.text,
        'nama anak': _controllerNamaAnak.text,
        'tgl.lahir anak': _controllerTglLahirAnak.text,
        'pend.akhir anak': _controllerPendAkhirAnak.text,

        //info kebun
        'luas kebun': _controllerLuas.text,
        'koordinat': _controllerKoordinat.text,
        'lokal': _controllerLokal.text,
        's1': _controllerS1.text,
        's2': _controllerS2.text,
        'lain-lain': _controllerLain.text,
        'jarak tanam': _controllerJarakTanam.text,

        //info keuangan
        'pendapatan lain': _controllerPendapatanLain.text,
        'pendapatan bulan': _controllerPendapatanBulan.text,

        //info umum
        'alat transportasi petani': checkList1,
        'material utama rumah petani': checkList2,
        'alat petani untuk memasak': checkList3,
        'barang di rumah petani': checkList4,
        'toilet petani': checkList5,

        //gambar
        'gambar': _imageUrl.toString(),
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
}
