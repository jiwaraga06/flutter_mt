import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mt/source/data/Perawatan/Edit/cubit/edit_detail_task_perawatan_cubit.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class DetailRiwayatPerawatan extends StatefulWidget {
  const DetailRiwayatPerawatan({super.key});

  @override
  State<DetailRiwayatPerawatan> createState() => _DetailRiwayatPerawatanState();
}

class _DetailRiwayatPerawatanState extends State<DetailRiwayatPerawatan> with SingleTickerProviderStateMixin{
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
  }
  @override
  Widget build(BuildContext context) {
    final argument = ModalRoute.of(context)!.settings.arguments as Map;
    print(argument);
    BlocProvider.of<EditDetailTaskPerawatanCubit>(context).editDetailTaskPerawatan(argument['id_delegasi']);
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Perawatan'),
      ),
      body: BlocBuilder<EditDetailTaskPerawatanCubit, EditDetailTaskPerawatanState>(
        builder: (context, state) {
          if (state is EditDetailTaskPerawatanLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is EditDetailTaskPerawatanLoaded == false) {
            return Container(
              alignment: Alignment.center,
              child: Text('Data False'),
            );
          }
          var data = (state as EditDetailTaskPerawatanLoaded).json;
          var statusCode = (state as EditDetailTaskPerawatanLoaded).statusCode;
          if (data.isEmpty) {
            return Container(
              alignment: Alignment.center,
              child: Text('Data Kosong'),
            );
          }
          if (statusCode != 200) {
            return Container(
              alignment: Alignment.center,
              child: Text(data.toString()),
            );
          }
          return SmartRefresher(
             controller: _refreshController,
            onRefresh: () {
              BlocProvider.of<EditDetailTaskPerawatanCubit>(context).editDetailTaskPerawatan(argument['id_delegasi']);
            },
            child: ListView(
              children: [
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Table(
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
                          Text(data['id_delegasi'], style: TextStyle(fontSize: 15)),
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
                          Text(data['tgl_delegasi'], style: TextStyle(fontSize: 15)),
                        ]),
                        TableRow(children: [
                          SizedBox(
                            height: 35,
                            child: Text(
                              'Jadwal Perawatan',
                              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                            ),
                          ),
                          Text(
                            ':',
                            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                          ),
                          Text(data['jadwal_perawatan'], style: TextStyle(fontSize: 15)),
                        ]),
                        TableRow(children: [
                          SizedBox(
                            height: 35,
                            child: Text(
                              'Lokasi',
                              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                            ),
                          ),
                          Text(
                            ':',
                            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                          ),
                          Text(data['lokasi'], style: TextStyle(fontSize: 15)),
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
                          Text(data['mesin'], style: TextStyle(fontSize: 15)),
                        ]),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 8.0),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: data['detail_penugasan'].length,
                  itemBuilder: (context, index1) {
                    var a = data['detail_penugasan'][index1];
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(a['nama_komponen'], style: TextStyle(fontSize: 16)),
                          const Divider(color: Colors.grey, thickness: 2),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: a['perawatan'].length,
                            itemBuilder: (context, index2) {
                              var b = a['perawatan'][index2];
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 8.0),
                                  Text(b['nama_paket'], style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600)),
                                  const SizedBox(height: 8.0),
                                  SizedBox(
                                    height: 50,
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      itemCount: b['sub_perawatan'].length,
                                      itemBuilder: (context, index3) {
                                        var c = b['sub_perawatan'][index3];
                                        return Container(
                                          margin: const EdgeInsets.all(8.0),
                                          padding: const EdgeInsets.all(8.0),
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              border: Border.all(color: c['is_checked'] == true ? Colors.teal : Colors.grey, width: 1.5),
                                              borderRadius: BorderRadius.circular(8.0)),
                                          child: Text(
                                            c['nama_sub'],
                                            style: TextStyle(fontSize: 15, color: c['is_checked'] == true ? Colors.teal : Colors.grey),
                                          ),
                                        );
                                      },
                                    ),
                                  )
                                ],
                              );
                            },
                          ),
                        ],
                      ),
                    );
                  },
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
