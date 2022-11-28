import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mt/source/data/Perawatan/cubit/riwayat_perawatan_cubit.dart';
import 'package:flutter_mt/source/router/string.dart';
import 'package:flutter_mt/source/widget/custom_span.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class RiwayatPerawatan extends StatefulWidget {
  const RiwayatPerawatan({super.key});

  @override
  State<RiwayatPerawatan> createState() => _RiwayatPerawatanState();
}

class _RiwayatPerawatanState extends State<RiwayatPerawatan> with SingleTickerProviderStateMixin {
  Animation<double>? _animation;
  AnimationController? _animationController;
  RefreshController _refreshController = RefreshController(initialRefresh: false);
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 260),
    );

    final curvedAnimation = CurvedAnimation(curve: Curves.easeOut, parent: _animationController!);
    _animation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation);
    BlocProvider.of<RiwayatPerawatanCubit>(context).historyPerawatan();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Riwayat Perawatan')),
      body: BlocBuilder<RiwayatPerawatanCubit, RiwayatPerawatanState>(
        builder: (context, state) {
          if (state is RiwayatPerawatanLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is RiwayatPerawatanLoaded == false) {
            return Container(
              alignment: Alignment.center,
              child: Text('Data False'),
            );
          }
          var data = (state as RiwayatPerawatanLoaded).json;
          if (data.isEmpty) {
            return InkWell(
              onTap: () {},
              child: Container(
                alignment: Alignment.center,
                child: Text('Data Kosong'),
              ),
            );
          }
          return SmartRefresher(
            controller: _refreshController,
            onRefresh: () {
              BlocProvider.of<RiwayatPerawatanCubit>(context).historyPerawatan();
            },
            child: ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                var rp = data[index];
                return Container(
                  margin: const EdgeInsets.all(8.0),
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8.0), boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      blurRadius: 1.3,
                      spreadRadius: 1.3,
                      offset: Offset(1, 3),
                    )
                  ]),
                  child: Column(
                    children: [
                      Table(
                        columnWidths: const {
                          0: FixedColumnWidth(150),
                          1: FixedColumnWidth(20),
                        },
                        children: [
                          TableRow(children: [
                            SizedBox(
                              height: 35,
                              child: Text(
                                'ID Delegasi',
                                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                              ),
                            ),
                            Text(
                              ':',
                              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                            ),
                            Text(
                              rp['id_delegasi'],
                              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                            ),
                          ]),
                          TableRow(children: [
                            SizedBox(
                              height: 35,
                              child: Text(
                                'ID Mesin',
                                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                              ),
                            ),
                            Text(
                              ':',
                              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                            ),
                            Text(
                              rp['id_mesin'].toString(),
                              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                            ),
                          ]),
                          TableRow(children: [
                            SizedBox(
                              height: 35,
                              child: Text(
                                'Nama Mesin',
                                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                              ),
                            ),
                            Text(
                              ':',
                              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                            ),
                            Text(
                              rp['nama_mesin'],
                              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                            ),
                          ]),
                          TableRow(children: [
                            SizedBox(
                              height: 35,
                              child: Text(
                                'Tanggal Delegasi',
                                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                              ),
                            ),
                            Text(
                              ':',
                              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                            ),
                            CustomSpan(
                              color: Colors.red[700],
                              text: rp['tgl_delegasi'],
                            )
                          ]),
                          TableRow(children: [
                            SizedBox(
                              height: 35,
                              child: Text(
                                'Close by User',
                                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                              ),
                            ),
                            Text(
                              ':',
                              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                            ),
                            CustomSpan(
                              color: Colors.green[700],
                              text: rp['close_date_by_user'],
                            )
                          ]),
                          TableRow(children: [
                            SizedBox(
                              height: 35,
                              child: Text(
                                'Nama Lokasi',
                                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                              ),
                            ),
                            Text(
                              ':',
                              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                            ),
                            Text(
                              rp['nama_lokasi'],
                              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                            ),
                          ]),
                          TableRow(children: [
                            SizedBox(
                              height: 35,
                              child: Text(
                                'Maintainer',
                                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                              ),
                            ),
                            Text(
                              ':',
                              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                            ),
                            Text(
                              rp['maintainer'],
                              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                            ),
                          ]),
                          TableRow(children: [
                            SizedBox(
                              height: 35,
                              child: Text(
                                'Catatan',
                                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                              ),
                            ),
                            Text(
                              ':',
                              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                            ),
                            Text(
                              rp['catatan_penugasan'],
                              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                            ),
                          ]),
                        ],
                      ),
                      const SizedBox(height: 8.0),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, DETAIL_RIWAYAT_PERAWATAN, arguments: {'id_delegasi': rp['id_delegasi']});
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.info,
                                size: 16,
                              ),
                              Text('Info Detail'),
                            ],
                          )),
                      const SizedBox(height: 8.0),
                      Text(
                        "Ratting",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 8.0),
                      RatingBar.builder(
                        // initialRating: 1.0,
                        initialRating: rp['rating'] + .0,
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
                        initialRating: rp['nilai_kepuasan_user'] + .0,
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
            ),
          );
        },
      ),
    );
  }
}
