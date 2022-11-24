import 'package:floating_action_bubble/floating_action_bubble.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mt/source/data/Perawatan/cubit/perawatan_cubit.dart';
import 'package:flutter_mt/source/data/Perawatan/cubit/save_perawatan_cubit.dart';
import 'package:flutter_mt/source/router/string.dart';
import 'package:flutter_mt/source/widget/custom_banner.dart';
import 'package:flutter_mt/source/widget/custom_button3.dart';
import 'package:flutter_mt/source/widget/custom_button4.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class Perawatan extends StatefulWidget {
  const Perawatan({super.key});

  @override
  State<Perawatan> createState() => _PerawatanState();
}

class _PerawatanState extends State<Perawatan> with SingleTickerProviderStateMixin {
  Animation<double>? _animation;
  AnimationController? _animationController;
  bool isOpen = false;
  RefreshController _refreshController = RefreshController(initialRefresh: false);
  Future<void> scanQR(id_mesin, kode_penugasan, tgl_penugasan, nama_lokasi, nama_mesin, status_delegasi,  jadwal_perawatan) async {
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
        BlocProvider.of<SavePerawatanCubit>(context)
            .savePerawatan(barcodeScanRes, kode_penugasan, tgl_penugasan, nama_lokasi, nama_mesin, jadwal_perawatan);
        final materialBanner = MyBanner.bannerSuccess("ID Mesin Sama");
        ScaffoldMessenger.of(context)
          ..hideCurrentMaterialBanner()
          ..showSnackBar(materialBanner);
        await Future.delayed(Duration(seconds: 1));
        if (status_delegasi == 0) {
          Navigator.pushNamed(context, ADD_PERAWATAN);
        } else {
          Navigator.pushNamed(context, EDIT_PERAWATAN, arguments: {'id_perbaikan': id_mesin, 'id_delegasi': kode_penugasan});
        }
      } else {
        final materialBanner = MyBanner.bannerFailed("ID Mesin Tidak Sama");
        ScaffoldMessenger.of(context)
          ..hideCurrentMaterialBanner()
          ..showSnackBar(materialBanner);
      }
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
    BlocProvider.of<PerawatanCubit>(context).getPerawatan();
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
            title: "Riwayat Perawatan",
            iconColor: Colors.white,
            bubbleColor: Colors.blue,
            icon: Icons.history,
            titleStyle: TextStyle(fontSize: 16, color: Colors.white),
            onPress: () {
              _animationController!.reverse();
              Navigator.pushNamed(context, RIWAYAT_PERAWATAN);
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
              // qrInfoMesin();
            },
          ),
        ],
      ),
      body: BlocBuilder<PerawatanCubit, PerawatanState>(
        builder: (context, state) {
          if (state is PerawatanLoading) {
            return Center(
              child: CupertinoActivityIndicator(),
            );
          }
          var data = (state as PerawatanLoaded).json;
          var statusCode = (state as PerawatanLoaded).statusCode;
          if (data.isEmpty) {
            return Container(
              alignment: Alignment.center,
              child: Text("Data kosong"),
            );
          }
          return SmartRefresher(
            controller: _refreshController,
            onRefresh: () {
              BlocProvider.of<PerawatanCubit>(context).getPerawatan();
            },
            child: ListView.builder(
                itemCount: data['perawatan'].length,
                itemBuilder: (BuildContext context, int index) {
                  var perawatan = data['perawatan'][index];
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
                          columnWidths: const {
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
                                  perawatan['id'].toString(),
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
                                Text(perawatan['tgl_delegasi'], style: TextStyle(fontSize: 15)),
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
                                Text(perawatan['id_mesin'].toString(), style: TextStyle(fontSize: 15)),
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
                                Text(perawatan['nama_lokasi'].toString(), style: TextStyle(fontSize: 15)),
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
                                Text(perawatan['nama_mesin'].toString(), style: TextStyle(fontSize: 15)),
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
                                Text(perawatan['id_group'].toString(), style: TextStyle(fontSize: 15)),
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
                                Text(perawatan['maintenance'].toString(), style: TextStyle(fontSize: 15)),
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
                                Text(perawatan['catatan'].toString(), style: TextStyle(fontSize: 15)),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 20.0),
                        perawatan['status_delegasi'] == 3
                            ? CustomButton4(
                                text: "Sudah di Close",
                                color: Colors.red[600],
                                onPressed: () {},
                                icon: Icon(
                                  FontAwesomeIcons.close,
                                  color: Colors.red[600],
                                ))
                            : CustomButton3(
                                onPressed: perawatan['status_delegasi'] == 1
                                    ? () {}
                                    : () {
                                        scanQR(
                                          "${perawatan['id_mesin']}",
                                          "${perawatan['id']}",
                                          "${perawatan['tgl_delegasi']}",
                                          "${perawatan['nama_lokasi']}",
                                          "${perawatan['nama_mesin']}",
                                          perawatan['status_delegasi'],
                                          perawatan['jadwal_perawatan'],
                                        );
                                      },
                                text: perawatan['status_delegasi'] == 1 ? "Dalam Review" : "Quick Scan",
                                icon: perawatan['status_delegasi'] == 1
                                    ? Icon(
                                        FontAwesomeIcons.magnifyingGlass,
                                        color: Colors.blue,
                                      )
                                    : Icon(
                                        FontAwesomeIcons.qrcode,
                                        color: Colors.blue,
                                      ),
                              ),
                        perawatan['status_delegasi'] == 2
                            ? CustomButton4(
                                text: "Lihat Review",
                                color: Colors.orange[600],
                                onPressed: () {},
                                icon: Icon(
                                  FontAwesomeIcons.info,
                                  color: Colors.orange[600],
                                ))
                            : SizedBox.shrink()
                      ],
                    ),
                  );
                }),
          );
        },
      ),
    );
  }
}
