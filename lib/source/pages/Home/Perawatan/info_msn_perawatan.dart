import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mt/source/data/Mesin/cubit/ket_mesin_cubit.dart';
import 'package:flutter_mt/source/data/Perawatan/cubit/mesin_history_perawatan_cubit.dart';

class InfoMesinPerawatan extends StatefulWidget {
  const InfoMesinPerawatan({super.key});

  @override
  State<InfoMesinPerawatan> createState() => _InfoMesinPerawatanState();
}

class _InfoMesinPerawatanState extends State<InfoMesinPerawatan> {
  @override
  Widget build(BuildContext context) {
    final argument = (ModalRoute.of(context)?.settings.arguments) as Map;
    print(argument);
    BlocProvider.of<MesinHistoryPerawatanCubit>(context).mesinHistoryPerawatan(argument['id_mesin']);
    return Scaffold(
      appBar: AppBar(
        title: Text('Informasi Mesin Perawatan'),
      ),
      body: ListView(
        children: [
          BlocBuilder<KetMesinCubit, KetMesinState>(
            builder: (context, state) {
              var json = (state as KetMesinLoaded).json;
              if (json.isEmpty) {
                return Container(
                  child: Text('Data Kosong'),
                );
              }
              return Container(
                margin: const EdgeInsets.all(8.0),
                padding: const EdgeInsets.all(8.0),
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
                            SizedBox(
                                height: 35,
                                child: Text(
                                  'Kode Mesin',
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                                )),
                            Text(
                              ':',
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                            Text(
                              json['id'].toString(),
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                        TableRow(
                          children: [
                            SizedBox(
                                height: 35,
                                child: Text(
                                  'Nama Mesin',
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                                )),
                            Text(
                              ':',
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                            Text(
                              json['nama_mesin'],
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                        TableRow(
                          children: [
                            SizedBox(
                                height: 35,
                                child: Text(
                                  'Tahun Pengakuan',
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                                )),
                            Text(
                              ':',
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                            Text(
                              json['tahun_pengakuan'],
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                        TableRow(
                          children: [
                            SizedBox(
                                height: 35,
                                child: Text(
                                  'Alias',
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                                )),
                            Text(
                              ':',
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                            Text(
                              json['alias'].toString(),
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              );
            },
          ),
          const SizedBox(height: 8.0),
          BlocBuilder<MesinHistoryPerawatanCubit, MesinHistoryPerawatanState>(
            builder: (context, state) {
              if (state is MesinHistoryPerawatanLoading) {
                return SizedBox(
                  height: 50,
                  child: Center(child: CircularProgressIndicator()),
                );
              }
              if (state is MesinHistoryPerawatanLoaded == false) {
                return Container(
                  child: Text("NUll"),
                );
              }
              var data = (state as MesinHistoryPerawatanLoaded).data;
              var json = (state as MesinHistoryPerawatanLoaded).json;
              var statusCode = (state as MesinHistoryPerawatanLoaded).statusCode;
              final DataTableSource pageTable = MyData(pageTable: data);
              if (data!.isEmpty) {
                return Container(
                  child: Text("NUll"),
                );
              }
              var list = [];
              list.add(data);
              print('List;:: $data');
              // return Text(data.toString());
              int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
              int _rowsPerPage1 = PaginatedDataTable.defaultRowsPerPage;
              var tableItemsCount = int.parse(json['total_records']);
              var defaultRowsPerPage = PaginatedDataTable.defaultRowsPerPage;
              var isRowCountLessDefaultRowsPerPage = tableItemsCount < defaultRowsPerPage;
              _rowsPerPage = isRowCountLessDefaultRowsPerPage ? tableItemsCount : defaultRowsPerPage;
              if (statusCode != 200) {
                return Container(
                  alignment: Alignment.center,
                  child: Text(data.toString()),
                );
              }
              return ListView(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  PaginatedDataTable(
                    rowsPerPage: !isRowCountLessDefaultRowsPerPage ? _rowsPerPage : _rowsPerPage1,
                    dataRowHeight: 80,
                    showCheckboxColumn: false,
                    onRowsPerPageChanged: isRowCountLessDefaultRowsPerPage
                        ? null
                        : ((value) {
                            setState(() {
                              _rowsPerPage1 = value!;
                            });
                          }),
                    columns: const [
                      DataColumn(label: Text("No")),
                      DataColumn(label: Text("Tanggal Penangann")),
                      DataColumn(label: Text("ID Mesin")),
                      DataColumn(label: Text("Nama Mesin")),
                      DataColumn(label: Text("id_struktur_mesin")),
                      DataColumn(label: Text("Nama Komponen")),
                      DataColumn(label: Text("Paket Concat")),
                    ],
                    source: pageTable,
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class MyData extends DataTableSource {
  final List? pageTable;

  MyData({this.pageTable});
  // final List _data = pageTable ;
  @override
  bool get isRowCountApproximate => false;
  @override
  int get rowCount => pageTable!.length;
  @override
  int get selectedRowCount => 0;
  @override
  DataRow getRow(int index) {
    return DataRow(cells: [
      DataCell(Text('${index + 1}')),
      DataCell(Text(pageTable![index]['tgl_penanganan'].toString())),
      DataCell(Text(pageTable![index]["id_mesin"].toString())),
      DataCell(Text(pageTable![index]["nama_mesin"].toString())),
      DataCell(Text(pageTable![index]["id_struktur_mesin"].toString())),
      DataCell(Text(pageTable![index]["nama_komponen"].toString())),
      DataCell(Text(pageTable![index]["paket_concat"].toString())),
    ]);
  }
}
