import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:im_stepper/stepper.dart';
import 'package:intl/intl.dart';

import '../../../../../../theme/colors.dart';
import '../../../../../../theme/padding.dart';

enum Pilihan { ya, tidak }

class InspeksiPage extends StatefulWidget {
  const InspeksiPage({Key? key}) : super(key: key);

  @override
  State<InspeksiPage> createState() => _InspeksiPageState();
}

class _InspeksiPageState extends State<InspeksiPage> {
  String titlePage = "Form Inspeksi";

  final _formKey = GlobalKey<FormState>();

  int _activeStep = 0;
  final int _upperBound = 3;
  DateTime _dateTime = DateTime.now();

  Pilihan? _pilihan1 = Pilihan.ya;
  Pilihan? _pilihan2 = Pilihan.ya;
  Pilihan? _pilihan3 = Pilihan.ya;
  Pilihan? _pilihan4 = Pilihan.ya;
  Pilihan? _pilihan5 = Pilihan.ya;
  Pilihan? _pilihan6 = Pilihan.ya;

  //formInspeksi
  final TextEditingController _controllerSubjek = TextEditingController();
  final TextEditingController _controllerTglSubjek = TextEditingController();
  final TextEditingController _controllerJumlahKakaoLokal =
      TextEditingController();
  final TextEditingController _controllerJumlahKakaoS1 =
      TextEditingController();
  final TextEditingController _controllerJumlahKakaoS2 =
      TextEditingController();
  final TextEditingController _controllerFrekuensiBerat =
      TextEditingController();
  final TextEditingController _controllerFrekuensiRingan =
      TextEditingController();
  final TextEditingController _controllerHama = TextEditingController();
  final TextEditingController _controllerPenyakit = TextEditingController();

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
      lineLength: 75.0,
      enableNextPreviousButtons: false,
    );
  }

  formstep() {
    switch (_activeStep) {
      case 0:
        return formSensus();
      default:
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
                    decoration: const InputDecoration(hintText: 'Kakao'),
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
          //createFormSensus();
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
                  onPressed: () {},
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
