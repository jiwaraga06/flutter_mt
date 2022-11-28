import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mt/source/data/Perbaikan/cubit/detail_riwayat_perbaikan_cubit.dart';

class DetailRiwayatPerbaikan extends StatefulWidget {
  const DetailRiwayatPerbaikan({super.key});

  @override
  State<DetailRiwayatPerbaikan> createState() => _DetailRiwayatPerbaikanState();
}

class _DetailRiwayatPerbaikanState extends State<DetailRiwayatPerbaikan> {
  @override
  Widget build(BuildContext context) {
    final argument = ModalRoute.of(context)!.settings.arguments as Map;
    print(argument);
    BlocProvider.of<DetailRiwayatPerbaikanCubit>(context)
        .getDetailRiwayatPerbaikan(argument['id_penanganan']);
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Riwayat Perbaikan'),
      ),
      body:
          BlocBuilder<DetailRiwayatPerbaikanCubit, DetailRiwayatPerbaikanState>(
        builder: (context, state) {
          if (state is DetailRiwayatPerbaikanLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is DetailRiwayatPerbaikanLoaded == false) {
            return Center(
              child: Text('Data False'),
            );
          }
          var data = (state as DetailRiwayatPerbaikanLoaded).json;
          if (data.isEmpty) {
            return Container(
              child: Text("Data Kosong"),
            );
          }
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              var detail = data[index];
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
                          offset: Offset(1, 3))
                    ]),
                child: Table(
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
                          "ID Struktur Mesin",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                      ),
                      Text(
                        ":",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        detail['id_struktur_mesin'],
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                    ]),
                    TableRow(children: [
                      SizedBox(
                        height: 35,
                        child: Text(
                          "Nama Komponen",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                      ),
                      Text(
                        ":",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        detail['nama_komponen'],
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                    ]),
                    TableRow(children: [
                      SizedBox(
                        height: 35,
                        child: Text(
                          "Nama Material",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                      ),
                      Text(
                        ":",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        detail['nama_material'],
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                    ]),
                    TableRow(children: [
                      SizedBox(
                        height: 35,
                        child: Text(
                          "Jumlah",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                      ),
                      Text(
                        ":",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        detail['jumlah'].toString(),
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                    ]),
                    TableRow(children: [
                      SizedBox(
                        height: 35,
                        child: Text(
                          "Catatan",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                      ),
                      Text(
                        ":",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        detail['catatan'],
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                    ]),
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
