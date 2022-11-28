import 'package:floating_action_bubble/floating_action_bubble.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mt/source/data/Auth/cubit/profile_cubit.dart';
import 'package:flutter_mt/source/data/Mesin/cubit/ket_mesin_cubit.dart';
import 'package:flutter_mt/source/data/Perbaikan/cubit/perbaikan_cubit.dart';
import 'package:flutter_mt/source/data/Perbaikan/cubit/save_perbaikan_cubit.dart';
import 'package:flutter_mt/source/router/string.dart';
import 'package:flutter_mt/source/widget/custom_banner.dart';
import 'package:flutter_mt/source/widget/custom_button3.dart';
import 'package:flutter_mt/source/widget/custom_button4.dart';
import 'package:flutter_mt/source/widget/custom_loading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class Perbaikan extends StatefulWidget {
  const Perbaikan({super.key});

  @override
  State<Perbaikan> createState() => _PerbaikanState();
}

class _PerbaikanState extends State<Perbaikan> with SingleTickerProviderStateMixin {
  Animation<double>? _animation;
  AnimationController? _animationController;
  RefreshController _refreshController = RefreshController(initialRefresh: false);
  bool isOpen = false;
  Future<void> scanQR(id_mesin, kode_penugasan, tgl_penugasan, nama_lokasi, nama_mesin, status_delegasi) async {
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
        BlocProvider.of<KetMesinCubit>(context).getMesin(barcodeScanRes, 1);
        final materialBanner = MyBanner.bannerSuccess("ID Mesin Sama");
        ScaffoldMessenger.of(context)
          ..hideCurrentMaterialBanner()
          ..showSnackBar(materialBanner);
        await Future.delayed(Duration(seconds: 1));
        if (status_delegasi == 0) {
          Navigator.pushNamed(context, ADD_PERBAIKAN);
        } else {
          Navigator.pushNamed(context, EDIT_PERBAIKAN, arguments: {'id_perbaikan': id_mesin, 'id_delegasi': kode_penugasan});
        }
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
      BlocProvider.of<KetMesinCubit>(context).getMesin(barcodeScanRes, 2);
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
    BlocProvider.of<ProfileCubit>(context).getProfile();
  }

  Widget fab() {
    return FloatingActionBubble(
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
    );
  }

  Widget fab2() {
    return FloatingActionBubble(
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
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          if (state is ProfileLoading) {
            return Container();
          }
          if (state is ProfileLoaded == false) {
            return Container(
              alignment: Alignment.center,
              child: Text('Data Profile False'),
            );
          }
          var profile = (state as ProfileLoaded).json;
          if (profile.isEmpty) {
            return Container(
              alignment: Alignment.center,
              child: Text('Data Profile Kosong'),
            );
          }
          List<String> sample = ["adm_maintainer", "atasan", "finance", "maintainer", "user"];
          var atasan = profile['roles'].indexWhere((element) => element == 'atasan');
          var adm_maintainer = profile['roles'].indexWhere((element) => element == 'adm_maintainer');
          var maintainer = profile['roles'].indexWhere((element) => element == 'maintainer');
          var user = profile['roles'].indexWhere((element) => element == 'user');
          var finance = profile['roles'].indexWhere((element) => element == 'finance');
          if (atasan != -1) {
            return fab();
          } else if (adm_maintainer != -1) {
            return fab();
          } else if (maintainer != -1) {
            return fab2();
          } else if (finance != -1) {
            return Container();
          } else if (user != -1) {
            return FloatingActionBubble(
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
              ],
            );
          } else {
            return Container();
          }
        },
      ),
      body: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          if (state is ProfileLoading) {
            return const Center(
              child: CupertinoActivityIndicator(),
            );
          }
          if (state is ProfileLoaded == false) {
            return Container(
              alignment: Alignment.center,
              child: Text('Data Profile False'),
            );
          }
          var profile = (state as ProfileLoaded).json;
          if (profile.isEmpty) {
            return Container(
              alignment: Alignment.center,
              child: Text('Data Profile Kosong'),
            );
          }
          // List<String> sample = ["adm_maintainer", "atasan", "finance", "maintainer", "user"];
          var maintainer = profile['roles'].indexWhere((element) => element == 'maintainer');
          print('maintainer');
          print(maintainer);
          if (maintainer == -1) {
            return Container(
              alignment: Alignment.center,
              child: Text(
                'Maaf, Anda Bukan Maintainer',
                style: TextStyle(fontSize: 16),
              ),
            );
          }
          return BlocListener<KetMesinCubit, KetMesinState>(
            listener: (context, state) async {
              if (state is KetMesinLoading) {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) {
                    return CustomLoading();
                  },
                );
              }
              if (state is KetMesinLoaded) {
                Navigator.of(context).pop();
                var json = state.json;
                var statusCode = state.statusCode;
                var page = state.isAdd;
                if (statusCode == 200) {
                  final materialBanner = MyBanner.bannerSuccess('Success !');
                  ScaffoldMessenger.of(context)
                    ..hideCurrentMaterialBanner()
                    ..showSnackBar(materialBanner);
                  await Future.delayed(Duration(seconds: 1));
                  if (page == 2) {
                    Navigator.pushNamed(context, INFO_MSN_PERBAIKAN, arguments: {'id_mesin': json['id']});
                  }
                } else {
                  final materialBanner = MyBanner.bannerFailed(json['errors']['id_mesin']);
                  ScaffoldMessenger.of(context)
                    ..hideCurrentMaterialBanner()
                    ..showSnackBar(materialBanner);
                }
              }
            },
            child: BlocBuilder<PerbaikanCubit, PerbaikanState>(
              builder: (context, state) {
                if (state is PerbaikanLoading) {
                  return Center(
                    child: CupertinoActivityIndicator(),
                  );
                }
                var data = (state as PerbaikanLoaded).json;
                var statusCode = (state as PerbaikanLoaded).statusCode;
                if (data.isEmpty) {
                  return Container(
                    alignment: Alignment.center,
                    child: Text("Data kosong"),
                  );
                }
                if (statusCode == 200) {
                  return SmartRefresher(
                    controller: _refreshController,
                    onRefresh: () {
                      BlocProvider.of<PerbaikanCubit>(context).getPerbaikan();
                    },
                    child: ListView.builder(
                        itemCount: data['perbaikan'].length,
                        itemBuilder: (BuildContext context, int index) {
                          var perbaikan = data['perbaikan'][index];
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
                                perbaikan['status_delegasi'] == 3
                                    ? CustomButton4(
                                        text: "Sudah di Close",
                                        color: Colors.red[600],
                                        onPressed: () {},
                                        icon: Icon(
                                          FontAwesomeIcons.close,
                                          color: Colors.red[600],
                                        ))
                                    : CustomButton3(
                                        onPressed: perbaikan['status_delegasi'] == 1
                                            ? () {}
                                            : () {
                                                scanQR("${perbaikan['id_mesin']}", "${perbaikan['id']}", "${perbaikan['tgl_delegasi']}",
                                                    "${perbaikan['nama_lokasi']}", "${perbaikan['nama_mesin']}", perbaikan['status_delegasi']);
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
                                perbaikan['status_delegasi'] == 2
                                    ? CustomButton4(
                                        text: "Lihat Review",
                                        color: Colors.orange[600],
                                        onPressed: () {
                                          Navigator.pushNamed(context, REVIEW_PERBAIKAN, arguments: {'id_delegasi': perbaikan['id']});
                                        },
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
                } else {
                  return Container(
                    alignment: Alignment.center,
                    child: Text(data.toString()),
                  );
                }
              },
            ),
          );
        },
      ),
    );
  }
}
