import 'package:floating_action_bubble/floating_action_bubble.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mt/source/data/Perbaikan/cubit/perbaikan_cubit.dart';
import 'package:flutter_mt/source/data/Perbaikan/cubit/save_perbaikan_cubit.dart';
import 'package:flutter_mt/source/router/string.dart';
import 'package:flutter_mt/source/widget/custom_banner.dart';
import 'package:flutter_mt/source/widget/custom_button3.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Perbaikan extends StatefulWidget {
  const Perbaikan({super.key});

  @override
  State<Perbaikan> createState() => _PerbaikanState();
}

class _PerbaikanState extends State<Perbaikan> with SingleTickerProviderStateMixin {
  Animation<double>? _animation;
  AnimationController? _animationController;
  bool isOpen = false;
  Future<void> scanQR(id_mesin, kode_penugasan, tgl_penugasan, nama_lokasi, nama_mesin) async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode('#ff6666', 'Cancel', true, ScanMode.QR);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
    if (!mounted) return;
    print(barcodeScanRes);
    if (barcodeScanRes != '-1') {
      if (id_mesin.toString() == barcodeScanRes) {
        BlocProvider.of<SavePerbaikanCubit>(context).save(barcodeScanRes, kode_penugasan, tgl_penugasan, nama_lokasi, nama_mesin);
        final materialBanner = MyBanner.bannerSuccess("ID Mesin Sama");
        ScaffoldMessenger.of(context)
          ..hideCurrentMaterialBanner()
          ..showSnackBar(materialBanner);
        await Future.delayed(Duration(seconds: 1));
        Navigator.pushNamed(context, ADD_PERBAIKAN);
      } else {
        final materialBanner = MyBanner.bannerFailed("ID Mesin Tidak Sama");
        ScaffoldMessenger.of(context)
          ..hideCurrentMaterialBanner()
          ..showSnackBar(materialBanner);
      }
    }
  }

  Future<void> qrInfoMesin() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode('#ff6666', 'Cancel', true, ScanMode.QR);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
    if (!mounted) return;
    print(barcodeScanRes);
    if (barcodeScanRes != '-1') {
      Navigator.pushNamed(context, INFO_MSN_PERBAIKAN, arguments: {'id_mesin': '$barcodeScanRes'});
    }
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 260),
    );

    final curvedAnimation = CurvedAnimation(curve: Curves.easeOut, parent: _animationController!);
    _animation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation);
    BlocProvider.of<PerbaikanCubit>(context).getPerbaikan();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionBubble(
        onPress: () {
          _animationController!.isCompleted ? _animationController!.reverse() : _animationController!.forward();
          setState(() {
            isOpen = !isOpen;
          });
        },
        iconColor: Colors.blue,
        backGroundColor: Colors.white,
        animation: _animation!,
        iconData: isOpen == false ? Icons.menu : Icons.close_rounded,
        items: <Bubble>[
          // Floating action menu item
          Bubble(
            title: "Riwayat Perbaikan",
            iconColor: Colors.white,
            bubbleColor: Colors.blue,
            icon: Icons.history,
            titleStyle: TextStyle(fontSize: 16, color: Colors.white),
            onPress: () {
              _animationController!.reverse();
              Navigator.pushNamed(context, RIWAYAT_PERBAIKAN);
            },
          ),
          Bubble(
            title: "Mesin Perbaikan",
            iconColor: Colors.white,
            bubbleColor: Colors.blue,
            icon: Icons.info_outline,
            titleStyle: TextStyle(fontSize: 16, color: Colors.white),
            onPress: () {
              _animationController!.reverse();
              qrInfoMesin();
            },
          ),
        ],
      ),
      body: BlocBuilder<PerbaikanCubit, PerbaikanState>(
        builder: (context, state) {
          if (state is PerbaikanLoading) {
            return Center(
              child: CupertinoActivityIndicator(),
            );
          }
          var data = (state as PerbaikanLoaded).json;
          if (data.isEmpty) {
            return Container(
              child: Text("Data kosong"),
            );
          }
          return ListView.builder(
              itemCount: data.length,
              itemBuilder: (BuildContext context, int index) {
                var perbaikan = data[index];
                return Container(
                  margin: const EdgeInsets.all(8.0),
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8.0), boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      blurRadius: 1.3,
                      spreadRadius: 1.3,
                      offset: Offset(1, 3),
                    ),
                  ]),
                  child: Column(
                    children: [
                      Table(
                        columnWidths: {
                          0: FixedColumnWidth(150),
                          1: FixedColumnWidth(20),
                          // 2: FixedColumnWidth(100),
                        },
                        children: [
                          TableRow(
                            children: [
                              // Icon(FontAwesomeIcons.folder),
                              Text(
                                " Kode Penugasan",
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                              ),
                              Text(
                                ":",
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                              ),
                              Text(
                                perbaikan['id'].toString(),
                                style: TextStyle(fontSize: 15),
                              ),
                            ],
                          ),
                          TableRow(
                            children: [
                              // Icon(FontAwesomeIcons.folder),
                              Text(
                                " Tanggal Penugasan",
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                              ),
                              Text(
                                ":",
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                              ),
                              Text(perbaikan['tgl_delegasi'], style: TextStyle(fontSize: 15)),
                            ],
                          ),
                          TableRow(
                            children: [
                              // Icon(FontAwesomeIcons.folder),
                              Text(
                                " Estimasi Selesai",
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                              ),
                              Text(
                                ":",
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                              ),
                              Text(perbaikan['estimasi_tgl_selesai_perbaikan'], style: TextStyle(fontSize: 15)),
                            ],
                          ),
                          TableRow(
                            children: [
                              // Icon(FontAwesomeIcons.folder),
                              Text(
                                " ID Mesin",
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                              ),
                              Text(
                                ":",
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                              ),
                              Text(perbaikan['id_mesin'].toString(), style: TextStyle(fontSize: 15)),
                            ],
                          ),
                          TableRow(
                            children: [
                              // Icon(FontAwesomeIcons.folder),
                              Text(
                                " Lokasi",
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                              ),
                              Text(
                                ":",
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                              ),
                              Text(perbaikan['nama_lokasi'].toString(), style: TextStyle(fontSize: 15)),
                            ],
                          ),
                          TableRow(
                            children: [
                              // Icon(FontAwesomeIcons.folder),
                              Text(
                                " Mesin",
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                              ),
                              Text(
                                ":",
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                              ),
                              Text(perbaikan['nama_mesin'].toString(), style: TextStyle(fontSize: 15)),
                            ],
                          ),
                          TableRow(
                            children: [
                              // Icon(FontAwesomeIcons.folder),
                              Text(
                                " Group Maintainer",
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                              ),
                              Text(
                                ":",
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                              ),
                              Text(perbaikan['nama_group'].toString(), style: TextStyle(fontSize: 15)),
                            ],
                          ),
                          TableRow(
                            children: [
                              // Icon(FontAwesomeIcons.folder),
                              Text(
                                " Maintainer Member",
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                              ),
                              Text(
                                ":",
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                              ),
                              Text(perbaikan['maintenance'].toString(), style: TextStyle(fontSize: 15)),
                            ],
                          ),
                          TableRow(
                            children: [
                              // Icon(FontAwesomeIcons.folder),
                              Text(
                                " Catatan Supervisor",
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                              ),
                              Text(
                                ":",
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                              ),
                              Text(perbaikan['catatan'].toString(), style: TextStyle(fontSize: 15)),
                            ],
                          ),
                          TableRow(
                            children: [
                              // Icon(FontAwesomeIcons.folder),
                              Text(
                                " Keterangan",
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                              ),
                              Text(
                                ":",
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                              ),
                              Text(perbaikan['keterangan_permintaan'].toString(), style: TextStyle(fontSize: 15)),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 20.0),
                      CustomButton3(
                        onPressed: perbaikan['status_delegasi'] == 1
                            ? () {}
                            : () {
                                // Navigator.pushNamed(context, QR_PERBAIKAN, arguments: {'id_mesin': perbaikan['id_mesin']});
                                scanQR(
                                  "${perbaikan['id_mesin']}",
                                  "${perbaikan['id']}",
                                  "${perbaikan['tgl_delegasi']}",
                                  "${perbaikan['nama_lokasi']}",
                                  "${perbaikan['nama_mesin']}",
                                );
                              },
                        text: perbaikan['status_delegasi'] == 1 ? "Dalam Review" : "Quick Scan",
                        icon: perbaikan['status_delegasi'] == 1
                            ? Icon(
                                FontAwesomeIcons.magnifyingGlass,
                                color: Colors.blue,
                              )
                            : Icon(
                                FontAwesomeIcons.qrcode,
                                color: Colors.blue,
                              ),
                      ),
                    ],
                  ),
                );
              });
        },
      ),
    );
  }
}
