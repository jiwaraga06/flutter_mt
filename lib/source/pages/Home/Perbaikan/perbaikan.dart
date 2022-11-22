import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mt/source/data/Perbaikan/cubit/perbaikan_cubit.dart';
import 'package:flutter_mt/source/router/string.dart';
import 'package:flutter_mt/source/widget/custom_button3.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Perbaikan extends StatefulWidget {
  const Perbaikan({super.key});

  @override
  State<Perbaikan> createState() => _PerbaikanState();
}

class _PerbaikanState extends State<Perbaikan> {
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<PerbaikanCubit>(context).getPerbaikan();
    return Scaffold(
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
                          onPressed: () {
                            Navigator.pushNamed(context, QR_PERBAIKAN, arguments: {'id_mesin': perbaikan['id_mesin']});
                          },
                          text: "Quick Scan",
                          icon: Icon(
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
