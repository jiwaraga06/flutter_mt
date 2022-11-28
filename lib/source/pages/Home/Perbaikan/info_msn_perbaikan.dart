import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mt/source/data/Mesin/cubit/ket_mesin_cubit.dart';
import 'package:flutter_mt/source/data/Perbaikan/cubit/mesin_history_perbaikan_cubit.dart';

class InfoMesinPerbaikan extends StatefulWidget {
  const InfoMesinPerbaikan({super.key});

  @override
  State<InfoMesinPerbaikan> createState() => _InfoMesinPerbaikanState();
}

class _InfoMesinPerbaikanState extends State<InfoMesinPerbaikan> {
  var id_mesin;
  var array = [
    {
      'tgl_penanganan': 1,
      'keterangan_permintaan': 1,
      'komponen': 1,
      'nama_material': 1,
      'jumlah': 1,
      'catatan_perbaikan_maintainer': 1,
    }
  ];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final argument = (ModalRoute.of(context)?.settings.arguments) as Map;
    print("ARGUMENT: $argument");
    id_mesin = argument['id_mesin'];
    // BlocProvider.of<KetMesinCubit>(context).getMesin(id_mesin);
    BlocProvider.of<MesinHistoryPerbaikanCubit>(context).getMesinHistoryPerbaikan(id_mesin);
    return Scaffold(
      appBar: AppBar(
        title: Text('Informasi Mesin Perbaikan'),
      ),
      body: ListView(
        children: [
          BlocBuilder<KetMesinCubit, KetMesinState>(
            builder: (context, state) {
              if (state is KetMesinLoading) {
                return SizedBox(
                  height: 50,
                  child: Center(child: CircularProgressIndicator()),
                );
              }
              // if (state is KetMesinLoaded == false){
              //   return Container(
              //     child: Text('Data Failed'),
              //   );
              // }
              var data = (state as KetMesinLoaded).json;
              if (data.isEmpty) {
                return SizedBox(
                  height: 50,
                  child: Center(child: Text("Data Kosong")),
                );
              }
              return Container(
                margin: const EdgeInsets.all(8.0),
                padding: const EdgeInsets.all(8.0),
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
                          "Kode Mesin",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                      ),
                      Text(
                        ":",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        data['id'].toString(),
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                    ]),
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
                        data['nama_mesin'].toString(),
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                    ]),
                    TableRow(children: [
                      SizedBox(
                        height: 35,
                        child: Text(
                          "Tahun Pengakuan",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                      ),
                      Text(
                        ":",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        data['tahun_pengakuan'].toString(),
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                    ]),
                    TableRow(children: [
                      SizedBox(
                        height: 35,
                        child: Text(
                          "Alias",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                      ),
                      Text(
                        ":",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        data['alias'].toString(),
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                    ]),
                  ],
                ),
              );
            },
          ),
          const SizedBox(height: 8.0),
          BlocBuilder<MesinHistoryPerbaikanCubit, MesinHistoryPerbaikanState>(
            builder: (context, state) {
              if (state is MesinHistoryPerbaikanLoading) {
                return SizedBox(
                  height: 50,
                  child: Center(child: CircularProgressIndicator()),
                );
              }
              if (state is MesinHistoryPerbaikanLoaded == false) {
                return Container(
                  child: Text("NUll"),
                );
              }
              var data = (state as MesinHistoryPerbaikanLoaded).data;
              var json = (state as MesinHistoryPerbaikanLoaded).json;
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
              var tableItemsCount = json['total_records'];
              var defaultRowsPerPage = PaginatedDataTable.defaultRowsPerPage;
              var isRowCountLessDefaultRowsPerPage = tableItemsCount < defaultRowsPerPage;
              _rowsPerPage = isRowCountLessDefaultRowsPerPage ? tableItemsCount : defaultRowsPerPage;
              return Expanded(
                child: ListView(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    Container(
                      margin: const EdgeInsets.all(3.0),
                      // padding: const EdgeInsets.all(8.0),
                      child: PaginatedDataTable(
                        rowsPerPage: !isRowCountLessDefaultRowsPerPage ? _rowsPerPage : _rowsPerPage1,
                        dataRowHeight: 80,
                        showCheckboxColumn: false,
                        onRowsPerPageChanged:isRowCountLessDefaultRowsPerPage?null: ((value) {
                          setState(() {
                            _rowsPerPage1 = value!;
                          });
                        }),
                        columns: const [
                          DataColumn(label: Text("No")),
                          DataColumn(label: Text("Tanggal")),
                          DataColumn(label: Text("Ket. Kerusakan")),
                          DataColumn(label: Text("Komponen")),
                          DataColumn(label: Text("Material")),
                          DataColumn(label: Text("Jumlag")),
                          DataColumn(label: Text("Catatan")),
                        ],
                        source: pageTable,
                      ),
                    ),
                  ],
                ),
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
      DataCell(Text('${index+1}')),
      DataCell(Text(pageTable![index]['tgl_penanganan'].toString())),
      DataCell(Text(pageTable![index]["keterangan_permintaan"])),
      DataCell(Text(pageTable![index]["komponen"].toString())),
      DataCell(Text(pageTable![index]["nama_material"].toString())),
      DataCell(Text(pageTable![index]["jumlah"].toString())),
      DataCell(Text(pageTable![index]["catatan_perbaikan_maintainer"].toString())),
    ]);
  }
}
