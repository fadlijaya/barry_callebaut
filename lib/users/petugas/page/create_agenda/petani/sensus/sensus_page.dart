import 'package:barry_callebaut/users/petugas/model/m_info_umum.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:im_stepper/stepper.dart';
import 'package:intl/intl.dart';

import '../../../../../../theme/colors.dart';
import '../../../../../../theme/padding.dart';
import '../../create_agenda_page.dart';

enum JenisKelamin { pria, wanita }

class SensusPage extends StatefulWidget {
  const SensusPage({Key? key}) : super(key: key);

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

  JenisKelamin? _jekel = JenisKelamin.pria;

  DateTime _dateTime = DateTime.now();

  final List<String> _listStatus = ['Lajang', 'Menikah', 'Duda', 'Janda'];

  String? _selectedStatus;

  List<Map> staticData1 = InfoUmum.data1;
  List<Map> staticData2 = InfoUmum.data2;
  List<Map> staticData3 = InfoUmum.data3;
  List<Map> staticData4 = InfoUmum.data4;
  List<Map> staticData5 = InfoUmum.data5;

  //form1
  final TextEditingController _controllerTglSensus = TextEditingController();
  final TextEditingController _controllerNama = TextEditingController();
  final TextEditingController _controllerNoTelp = TextEditingController();
  final TextEditingController _controllerJekel = TextEditingController();
  final TextEditingController _controllerTglLahir = TextEditingController();
  final TextEditingController _controllerStatusNikah = TextEditingController();
  final TextEditingController _controllerStatusPendidikan = TextEditingController();
  final TextEditingController _controllerKelompok = TextEditingController();

  //form2
  final TextEditingController _controllerAlamat = TextEditingController();
  final TextEditingController _controllerDusun = TextEditingController();
  final TextEditingController _controllerDesa = TextEditingController();
  final TextEditingController _controllerKecamatan = TextEditingController();
  final TextEditingController _controllerKabupaten = TextEditingController();
  final TextEditingController _controllerNamaSuamiIstri = TextEditingController();
  final TextEditingController _controllerTglLahirSuamiIstri = TextEditingController();
  final TextEditingController _controllerPendAkhirSuamiIstri = TextEditingController();
  final TextEditingController _controllerNamaAnak = TextEditingController();
  final TextEditingController _controllerTglLahirAnak = TextEditingController();
  final TextEditingController _controllerPendAkhirAnak = TextEditingController();

  //form3
  final TextEditingController _controllerLuas = TextEditingController();
  final TextEditingController _controllerKoordinat = TextEditingController();
  final TextEditingController _controllerLokal = TextEditingController();
  final TextEditingController _controllerS1 = TextEditingController();
  final TextEditingController _controllerS2 = TextEditingController();
  final TextEditingController _controllerLain = TextEditingController();
  final TextEditingController _controllerJarakTanam = TextEditingController();

  //form4
  final TextEditingController _controllerPendapatanLain = TextEditingController();
  final TextEditingController _controllerPendapatanBulan = TextEditingController();

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
      height: 160,
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
          Row(
            children: const [
              Padding(
                padding: EdgeInsets.only(left: 24),
                child: Text(
                  "Info Petani",
                  style: TextStyle(
                      color: kWhite, fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          )
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

  formstep() {
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
          height: 40,
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
          Card(
            margin: const EdgeInsets.symmetric(horizontal: padding),
            color: kWhite,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            child: Container(
              width: double.infinity,
              height: 430,
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
          const SizedBox(
            height: 20,
          ),
          Card(
            margin: const EdgeInsets.symmetric(horizontal: padding),
            color: kWhite,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            child: Container(
              width: double.infinity,
              height: 280,
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
          const SizedBox(
            height: 20,
          ),
          Card(
            margin: const EdgeInsets.symmetric(horizontal: padding),
            color: kWhite,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            child: Container(
              width: double.infinity,
              height: 280,
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

  Future<void> selectedDateSuamiIstri(BuildContext context) async {
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

  Future<void> selectedDateAnak(BuildContext context) async {
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

  Widget formSensus3() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
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
                    decoration: const InputDecoration(hintText: 'Luas'),
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
            height: 40,
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
                  Card(
                    margin: const EdgeInsets.symmetric(horizontal: padding * 2),
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
                          height: 360,
                          margin: const EdgeInsets.symmetric(
                              horizontal: padding, vertical: padding),
                          child: ListView.builder(
                              itemCount: staticData1.length,
                              itemBuilder: (context, i) {
                                Map data = staticData1[i];
                                return ListTile(
                                  title: Text(
                                    "${data['nama']}",
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                );
                              }),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Card(
                    margin: const EdgeInsets.symmetric(horizontal: padding * 2),
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
                          child: ListView.builder(
                              itemCount: staticData2.length,
                              itemBuilder: (context, i) {
                                Map data = staticData2[i];
                                return ListTile(
                                  title: Text(
                                    "${data['nama']}",
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                );
                              }),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Card(
                    margin: const EdgeInsets.symmetric(horizontal: padding * 2),
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
                          child: ListView.builder(
                              itemCount: staticData3.length,
                              itemBuilder: (context, i) {
                                Map data = staticData3[i];
                                return ListTile(
                                  title: Text(
                                    "${data['nama']}",
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                );
                              }),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Card(
                    margin: const EdgeInsets.symmetric(horizontal: padding * 2),
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
                          child: ListView.builder(
                              itemCount: staticData4.length,
                              itemBuilder: (context, i) {
                                Map data = staticData4[i];
                                return ListTile(
                                  title: Text(
                                    "${data['nama']}",
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                );
                              }),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Card(
                    margin: const EdgeInsets.symmetric(horizontal: padding * 2),
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
                          height: 260,
                          padding: const EdgeInsets.symmetric(
                              horizontal: padding, vertical: padding),
                          child: ListView.builder(
                              itemCount: staticData5.length,
                              itemBuilder: (context, i) {
                                Map data = staticData5[i];
                                return ListTile(
                                  title: Text(
                                    "${data['nama']}",
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                );
                              }),
                        ),
                      ],
                    ),
                  ),
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
                onTap: () => Navigator.pushNamed(context, '/sensusPage'),
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
          .doc(uid)
          .collection("petani")
          .add({
        //data personal
        'uid': uid,
        'tanggal sensus': _controllerTglSensus.text,
        'nama': _controllerNama.text,
        'no.telephone': _controllerNoTelp.text,
        'jenis kelamin': _controllerJekel.text,
        'tanggal lahir': _controllerTglLahir.text,
        'status nikah': _controllerStatusNikah.text,
        'status pendidikan': _controllerStatusPendidikan.text,
        'kelompok': _controllerKelompok.text,

        'alamat': _controllerAlamat.text,
        'desa': _controllerDesa.text,
        'kecamatan': _controllerKecamatan.text,
        'kabupaten': _controllerKabupaten.text
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
                  onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => CreateAgendaPage(uid: uid.toString(), username: username.toString(),))),
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
