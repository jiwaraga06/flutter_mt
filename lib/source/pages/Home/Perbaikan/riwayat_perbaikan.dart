import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mt/source/data/Perbaikan/cubit/riwayat_perbaikan_cubit.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RiwayatPerbaikan extends StatefulWidget {
  const RiwayatPerbaikan({super.key});

  @override
  State<RiwayatPerbaikan> createState() => _RiwayatPerbaikanState();
}

class _RiwayatPerbaikanState extends State<RiwayatPerbaikan> {
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<RiwayatPerbaikanCubit>(context).getRiwayatPerbaikan();
    return Scaffold(
      appBar: AppBar(
        title: Text("Riwayat Perbaikan"),
      ),
      body: BlocBuilder<RiwayatPerbaikanCubit, RiwayatPerbaikanState>(
        builder: (context, state) {
          if (state is RiwayatPerbaikanLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          var data = (state as RiwayatPerbaikanLoaded).json;
          if (data.isEmpty) {
            return Container(
              child: Text("Data Kosong"),
            );
          }
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              var load = data[index];
              return Container(
                margin: const EdgeInsets.all(8.0),
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      blurRadius: 1.3,
                      spreadRadius: 1.3,
                      offset: Offset(1, 3),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Table(
                      columnWidths: const {
                        0: FixedColumnWidth(150),
                        1: FixedColumnWidth(20),
                        // 2: FixedColumnWidth(100),
                      },
                      children: [
                        TableRow(children: [
                          SizedBox(
                            height: 35,
                            child: Text(
                              "Nama Mesin",
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                          ),
                          Text(
                            ":",
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                          Text(
                            load['nama_mesin'],
                            style: TextStyle(fontSize: 16),
                          )
                        ]),
                        TableRow(children: [
                          SizedBox(
                            height: 35,
                            child: Text(
                              "Lokasi",
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                          ),
                          Text(
                            ":",
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                          Text(
                            load['nama_lokasi'],
                            style: TextStyle(fontSize: 16),
                          )
                        ]),
                        TableRow(children: [
                          SizedBox(
                            height: 35,
                            child: Text(
                              "Kode Penugasan",
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                          ),
                          Text(
                            ":",
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                          Text(
                            load['id_delegasi'],
                            style: TextStyle(fontSize: 16),
                          )
                        ]),
                        TableRow(children: [
                          SizedBox(
                            height: 35,
                            child: Text(
                              "Tanggal Permintaan",
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                          ),
                          Text(
                            ":",
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                          Container(
                            // margin: const EdgeInsets.all(4.0),
                            padding: const EdgeInsets.all(4.0),
                            decoration: BoxDecoration(
                              color: Colors.red[700],
                              borderRadius: BorderRadius.circular(6.0),
                            ),
                            child: Text(
                              load['tgl_permintaan'],
                              style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w600),
                            ),
                          )
                        ]),
                        TableRow(children: [
                          SizedBox(
                            height: 35,
                            child: Text(
                              "Tanggal Penugasan",
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                          ),
                          Text(
                            ":",
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                          Container(
                            // margin: const EdgeInsets.all(4.0),
                            padding: const EdgeInsets.all(4.0),
                            decoration: BoxDecoration(
                              color: Colors.blue[700],
                              borderRadius: BorderRadius.circular(6.0),
                            ),
                            child: Text(
                              load['tgl_penugasan'],
                              style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w600),
                            ),
                          )
                        ]),
                        TableRow(children: [
                          SizedBox(
                            height: 35,
                            child: Text(
                              "Tanggal Closing",
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                          ),
                          Text(
                            ":",
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                          Container(
                            // margin: const EdgeInsets.all(4.0),
                            padding: const EdgeInsets.all(4.0),
                            decoration: BoxDecoration(
                              color: Colors.teal[700],
                              borderRadius: BorderRadius.circular(6.0),
                            ),
                            child: Text(
                              load['tgl_closing'],
                              style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w600),
                            ),
                          )
                        ]),
                        TableRow(children: [
                          SizedBox(
                            height: 35,
                            child: Text(
                              "Maintainer",
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                          ),
                          Text(
                            ":",
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                          Text(
                            load['maintainer'],
                            style: TextStyle(fontSize: 16),
                          )
                        ]),
                        TableRow(children: [
                          SizedBox(
                            height: 40,
                            child: Text(
                              "Keterangan",
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                          ),
                          Text(
                            ":",
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                          Text(
                            load['keterangan_permintaan'],
                            style: TextStyle(fontSize: 16),
                          )
                        ]),
                        TableRow(children: [
                          SizedBox(
                            height: 40,
                            child: Text(
                              "Catatan",
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                          ),
                          Text(
                            ":",
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                          Text(
                            load['catatan_penugasan'],
                            style: TextStyle(fontSize: 16),
                          )
                        ]),
                      ],
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      "Ratting SPV",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 8.0),
                    RatingBar.builder(
                      // initialRating: 1.0,
                      initialRating: load['rating_supervisor'] + .0,
                      minRating: 1, maxRating: 5.0,
                      allowHalfRating: true,
                      unratedColor: Colors.grey[350],
                      direction: Axis.horizontal,
                      ignoreGestures: true,
                      itemCount: 5,
                      itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, index) {
                        switch (index) {
                          case 0:
                            return Icon(
                              // Icons.sentiment_very_dissatisfied,
                              Icons.star,
                              color: Colors.red[600],
                            );

                          case 1:
                            return Icon(
                              // Icons.sentiment_dissatisfied,
                              Icons.star,
                              color: Colors.orange,
                            );
                          case 2:
                            return Icon(
                              // Icons.sentiment_neutral,
                              Icons.star,
                              color: Colors.amber,
                            );
                          case 3:
                            return Icon(
                              // Icons.sentiment_satisfied,
                              Icons.star,
                              color: Colors.green,
                            );

                          case 4:
                            return Icon(
                              // Icons.sentiment_very_satisfied,
                              Icons.star,
                              color: Colors.blue,
                            );
                          default:
                            return Container();
                        }
                      },
                      onRatingUpdate: (rating) {
                        print(rating);
                      },
                    ),
                    Divider(),
                    const SizedBox(height: 8.0),
                    Text(
                      "Kepuasan USER",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 8.0),
                    RatingBar.builder(
                      // initialRating: 1.0,
                      initialRating: load['nilai_kepuasan_user'] + .0,
                      minRating: 1, maxRating: 5.0,
                      allowHalfRating: true,
                      unratedColor: Colors.grey[350],
                      direction: Axis.horizontal,
                      ignoreGestures: true,
                      itemCount: 5,
                      itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, index) {
                        switch (index) {
                          case 0:
                            return Icon(
                              Icons.sentiment_very_dissatisfied,
                              // Icons.star,
                              color: Colors.red[600],
                            );
                          case 1:
                            return Icon(
                              Icons.sentiment_dissatisfied,
                              // Icons.star,
                              color: Colors.orange,
                            );
                          case 2:
                            return Icon(
                              Icons.sentiment_neutral,
                              // Icons.star,
                              color: Colors.amber,
                            );
                          case 3:
                            return Icon(
                              Icons.sentiment_satisfied,
                              // Icons.star,
                              color: Colors.green,
                            );
                          case 4:
                            return Icon(
                              Icons.sentiment_very_satisfied,
                              // Icons.star,
                              color: Colors.blue,
                            );
                          default:
                            return Container();
                        }
                      },
                      // itemBuilder: (context, _) => Icon(
                      //   Icons.star,
                      //   color: Colors.blue,
                      // ),
                      onRatingUpdate: (rating) {
                        print(rating);
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
