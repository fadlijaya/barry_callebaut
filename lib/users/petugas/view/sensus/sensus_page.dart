import 'package:barry_callebaut/users/theme/colors.dart';
import 'package:barry_callebaut/users/theme/padding.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:im_stepper/stepper.dart';
import 'package:intl/intl.dart';

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
  final int _upperBound = 3;

  String? uid;

  JenisKelamin? _jekel = JenisKelamin.pria;

  DateTime _dateTime = DateTime.now();

  final List<String> _listStatus = ['Lajang', 'Menikah', 'Duda', 'Janda'];

  String? _selectedStatus;

  //form1
  final TextEditingController _controllerNama = TextEditingController();
  final TextEditingController _controllerJekel = TextEditingController();
  final TextEditingController _controllerTempatLahir = TextEditingController();
  final TextEditingController _controllerTglLahir = TextEditingController();
  final TextEditingController _controllerStatus = TextEditingController();
  final TextEditingController _controllerPendidikan = TextEditingController();
  final TextEditingController _controllerStatusPendidikan =
      TextEditingController();

  //form2
  final TextEditingController _controllerAlamat = TextEditingController();
  final TextEditingController _controllerDesa = TextEditingController();
  final TextEditingController _controllerKecamatan = TextEditingController();
  final TextEditingController _controllerKabupaten = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: kGrey,
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: SafeArea(
          child: Column(
            children: [
              header(),
              iconStepper(),
              const SizedBox(
                height: 20,
              ),
              Expanded(child: formstep())
            ],
          ),
        ),
      ),
    );
  }

  Widget header() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: padding),
      child: Center(
        child: Text(
          titlePage,
          style: const TextStyle(
              fontSize: 20, fontWeight: FontWeight.w700, color: kBlack),
        ),
      ),
    );
  }

  Widget iconStepper() {
    return IconStepper(
      icons: const [
        Icon(
          Icons.check,
          color: kWhite,
        ),
        Icon(
          Icons.check,
          color: kWhite,
        ),
        Icon(
          Icons.check,
          color: kWhite,
        ),
      ],
      activeStep: _activeStep,
      onStepReached: (index) {
        setState(() {
          _activeStep = index;
        });
      },
      stepRadius: 12,
      enableStepTapping: true,
      lineColor: kGreen,
      enableNextPreviousButtons: false,
    );
  }

  formstep() {
    switch (_activeStep) {
      case 0:
        return formSensus();
      case 1:
        return formSensus2();
      default:
    }
  }

  Widget formSensus() {
    return SingleChildScrollView(
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
              child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                        controller: _controllerTempatLahir,
                        cursorColor: kGreen,
                        textInputAction: TextInputAction.next,
                        decoration:
                            const InputDecoration(hintText: 'Tempat Lahir'),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Masukkan Tempat Lahir";
                          }
                          return null;
                        },
                        onSaved: (String? value) {
                          _controllerTglLahir.text = value!;
                        },
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      const Text(
                        "Tanggal Lahir",
                        style: TextStyle(color: kBlack, fontSize: 12),
                      ),
                      TextFormField(
                        controller: _controllerTglLahir,
                        cursorColor: kGreen,
                        textInputAction: TextInputAction.next,
                        decoration: const InputDecoration(
                            suffixIcon: Icon(Icons.today),
                            hintText: 'Tanggal/Bulan/Tahun'),
                        readOnly: true,
                        onTap: () => selectedDate(context),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Masukkan Tanggal lahir";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16,),
                      const Text("Status", style: TextStyle(color: kBlack, fontSize: 12),),
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
                        hint: const Text('Pilih Status'),
                      ),
                      TextFormField(
                        controller: _controllerPendidikan,
                        cursorColor: kGreen,
                        textInputAction: TextInputAction.next,
                        decoration:
                            const InputDecoration(hintText: 'Pendidikan'),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Masukkan Pendidikan";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        controller: _controllerStatusPendidikan,
                        cursorColor: kGreen,
                        textInputAction: TextInputAction.done,
                        decoration: const InputDecoration(
                            hintText: 'Status Pendidikan'),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Masukkan Status Pendidikan";
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
      ),
    );
  }

  Future<void> selectedDate(BuildContext context) async {
    DateTime today = DateTime.now();
    final DateTime? _datePicker = await showDatePicker(
        context: context,
        initialDate: _dateTime,
        firstDate: DateTime(1990),
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
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Card(
              margin: const EdgeInsets.symmetric(horizontal: padding),
              color: kWhite,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
              child: Container(
                width: double.infinity,
                height: 260,
                padding: const EdgeInsets.symmetric(horizontal: padding),
                child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
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
                        const SizedBox(
                          height: 16,
                        ),
                        TextFormField(
                          controller: _controllerDesa,
                          cursorColor: kGreen,
                          textInputAction: TextInputAction.next,
                          decoration: const InputDecoration(hintText: 'Desa'),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Masukkan Desa";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        TextFormField(
                          controller: _controllerKecamatan,
                          cursorColor: kGreen,
                          textInputAction: TextInputAction.next,
                          decoration:
                              const InputDecoration(hintText: 'Kecamatan'),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Masukkan Kecamatan";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        TextFormField(
                          controller: _controllerKabupaten,
                          cursorColor: kGreen,
                          textInputAction: TextInputAction.next,
                          decoration:
                              const InputDecoration(hintText: 'Kabupaten'),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Masukkan Kabupaten";
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
            buttonSubmit(),
            const SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
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
              'Submit',
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
        'uid': uid,
        'nama': _controllerNama.text,
        'jenis kelamin': _controllerJekel.text,
        'tempat lahir': _controllerTempatLahir.text,
        'tanggal lahir': _controllerTglLahir.text,
        'status': _controllerStatus.text,
        'pendidikan': _controllerPendidikan.text,
        'status pendidikan': _controllerStatusPendidikan.text,
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
                  onPressed: () => Navigator.pushNamed(context, '/agendaPage'),
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
