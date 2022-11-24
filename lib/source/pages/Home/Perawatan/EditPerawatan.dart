import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mt/source/data/Perawatan/Edit/cubit/edit_detail_task_perawatan_cubit.dart';
import 'package:flutter_mt/source/data/Perawatan/Edit/cubit/edit_perawatan_cubit.dart';
import 'package:flutter_mt/source/data/Perawatan/cubit/save_perawatan_cubit.dart';
import 'package:flutter_mt/source/widget/custom_banner.dart';
import 'package:flutter_mt/source/widget/custom_button2.dart';
import 'package:flutter_mt/source/widget/custom_loading.dart';

class EditPerawatan extends StatefulWidget {
  const EditPerawatan({super.key});

  @override
  State<EditPerawatan> createState() => _EditPerawatanState();
}

class _EditPerawatanState extends State<EditPerawatan> {
  var id_struktur_mesin, id_paket_perawatan,id_penanganan_perawatan;
  var kode_penugasan;
  var perawatan = [];
  var sub_perawatan = [];
  List? selected_paket = [];
  var detail_List = [];

  void save(id_penanganan_perawatan) {
    print(detail_List);
    BlocProvider.of<EditPerawatanCubit>(context).editPenanganan(id_penanganan_perawatan,detail_List.toList());
  }

  void adding(valSub) {
    if (!selected_paket!.contains(valSub['id_sub'])) {
      setState(() {
        selected_paket!.add(valSub['id_sub']);
        var body = {
          'id_struktur_mesin': id_struktur_mesin,
          'id_paket_perawatan': id_paket_perawatan,
          'id_sub_paket': valSub['id_sub'],
        };
        detail_List.add(body);
      });
    } else {
      setState(() {
        selected_paket!.removeWhere((element) => element == valSub['id_sub']);
        detail_List.removeWhere((element) => element['id_sub_paket'] == valSub['id_sub']);
      });
      print(selected_paket);
    }
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<EditDetailTaskPerawatanCubit>(context).getDetailTaskPerawatan();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Perawatan'),
      ),
      body: BlocListener<EditPerawatanCubit, EditPerawatanState>(
        listener: (context, state)async {
          if (state is EditPerawatanLoading) {
            showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return const CustomLoading();
                });
          }
          if (state is EditPerawatanLoaded) {
            Navigator.of(context).pop();
            var json = state.json;
            var statusCode = state.statusCode;
            if (statusCode == 200) {
              final materialBanner = MyBanner.bannerSuccess(json['message']);
              ScaffoldMessenger.of(context)
                ..hideCurrentMaterialBanner()
                ..showSnackBar(materialBanner);
                await Future.delayed(Duration(seconds: 1));
                Navigator.of(context).pop();
            } else {
              final materialBanner = MyBanner.bannerFailed('${json['message']} \n ${json['errors']}');
              ScaffoldMessenger.of(context)
                ..hideCurrentMaterialBanner()
                ..showSnackBar(materialBanner);
            }
          }
        },
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                children: [
                  BlocBuilder<SavePerawatanCubit, SavePerawatanState>(
                    builder: (context, state) {
                      if (state is SavePerawatanLoaded == false) {
                        return Container(
                          child: Text("Data False"),
                        );
                      }
                      var data = (state as SavePerawatanLoaded);
                      if (data == null) {
                        return Text("Data Null");
                      }
                      // BlocProvider.of<DetailTaskPerawatanCubit>(context).getDetailTaskPerawatan(data.kode_penugasan);
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
                              TableRow(children: [Text("Kode Penugasan"), Text(":"), Text('${data.kode_penugasan}')]),
                              TableRow(children: [Text("Tanggal Penugasan"), Text(":"), Text('${data.tgl_penugasan}')]),
                              TableRow(children: [Text("Jadwal Perawatan"), Text(":"), Text('${data.jadwal_perawatan}')]),
                              TableRow(children: [Text("Lokasi"), Text(":"), Text('${data.nama_lokasi}')]),
                              TableRow(children: [Text("Nama Mesin"), Text(":"), Text('${data.nama_mesin}')]),
                            ],
                          ));
                    },
                  ),
                  BlocConsumer<EditDetailTaskPerawatanCubit, EditDetailTaskPerawatanState>(
                    listener: (context, state) {
                      if (state is EditDetailTaskPerawatanLoaded) {
                        var json = state.json;
                        print('Result\n $json');
                        setState(() {
                        id_penanganan_perawatan=json['id_penanganan_perawatan'];
                          json['detail_penugasan'].forEach((a) {
                            a['perawatan'].forEach((b) {
                              b['sub_perawatan'].forEach((c) {
                                if (c['is_checked'] == true) {
                                  var body = {
                                    "id_struktur_mesin": a['id_struktur_mesin'],
                                    "id_paket_perawatan": b['id_paket_perawatan'],
                                    'id_sub_paket': c['id_sub'],
                                  };
                                  detail_List.add(body);
                                  selected_paket!.add(c['id_sub']);
                                }
                              });
                            });
                          });
                          print('Detail LIst: $detail_List');
                        });
                      }
                    },
                    builder: (context, state) {
                      if (state is EditDetailTaskPerawatanLoading) {
                        return SizedBox(
                          height: 50,
                          child: Center(child: CircularProgressIndicator()),
                        );
                      }
                      if (state is EditDetailTaskPerawatanLoaded == false) {
                        return SizedBox(
                          height: 50,
                          child: Center(child: Text("Data False")),
                        );
                      }
                      var data = (state as EditDetailTaskPerawatanLoaded).json;
                      var status = (state as EditDetailTaskPerawatanLoaded).statusCode;

                      if (data.isEmpty) {
                        return SizedBox(
                          height: 50,
                          child: Center(child: Text("Data Kosong")),
                        );
                      }
                      if (status == 200) {
                        return Column(
                          children: [
                            const SizedBox(height: 12),
                            Text(
                              'Pilih Detail Penugasan',
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(height: 12),
                            Container(
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: data['detail_penugasan'].length,
                                itemBuilder: (context, index) {
                                  var detail_penugasan = data['detail_penugasan'][index];
                                  return Container(
                                    margin: const EdgeInsets.all(8.0),
                                    padding: const EdgeInsets.all(8.0),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(6.0),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          blurRadius: 1.3,
                                          spreadRadius: 1.3,
                                          offset: Offset(1, 3),
                                        )
                                      ],
                                    ),
                                    child: Column(
                                      children: [
                                        Table(
                                          columnWidths: const {
                                            0: FixedColumnWidth(80),
                                            1: FixedColumnWidth(20),
                                            // 2: FixedColumnWidth(100),
                                          },
                                          children: [
                                            TableRow(
                                              children: [
                                                Text('Komponen'),
                                                Text(':'),
                                                Text(detail_penugasan['nama_komponen']),
                                              ],
                                            ),
                                            TableRow(
                                              children: [
                                                Text('Paket'),
                                                Text(':'),
                                                Text(detail_penugasan['list_nama_paket']),
                                              ],
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          width: 200,
                                          child: ElevatedButton(
                                            onPressed: () {
                                              setState(() {
                                                id_struktur_mesin = detail_penugasan['id_struktur_mesin'];
                                                perawatan = detail_penugasan['perawatan'];
                                                perawatan.forEach((element) {
                                                  id_paket_perawatan = element['id_paket_perawatan'];
                                                  sub_perawatan = element['sub_perawatan'];
                                                });
                                                print(sub_perawatan);
                                              });
                                            },
                                            child: Text("PILIH"),
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        );
                      } else {
                        return Container(child: Text(data['message']));
                      }
                    },
                  ),
                  sub_perawatan.length == 0
                      ? SizedBox.shrink()
                      : Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            margin: const EdgeInsets.all(8.0),
                            padding: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                border: Border.all(
                                  color: Colors.red,
                                  width: 1.5,
                                )),
                            child: Column(
                              children: [
                                Text(
                                  perawatan[0]['nama_paket'],
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                                ),
                                const SizedBox(height: 8),
                                Wrap(
                                  children: sub_perawatan.map(
                                    (valSub) {
                                      bool isSelected = false;
                                      if (selected_paket!.contains(valSub['id_sub'])) {
                                        isSelected = true;
                                      }
                                      return InkWell(
                                        onTap: () {
                                          adding(valSub);
                                        },
                                        child: Container(
                                            margin: EdgeInsets.symmetric(horizontal: 5, vertical: 4),
                                            child: Container(
                                              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 12),
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius: BorderRadius.circular(18),
                                                  border: Border.all(color: isSelected ? Colors.red : Colors.grey, width: 2)),
                                              child: Text(
                                                valSub['nama_sub'],
                                                style: TextStyle(color: isSelected ? Colors.red : Colors.grey, fontSize: 15, fontWeight: FontWeight.w600),
                                              ),
                                            )),
                                      );
                                    },
                                  ).toList(),
                                ),
                              ],
                            ),
                          ),
                        ),
                ],
              ),
            ),
            SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CustomButton2(
                      text: "SIMPAN",
                      onPressed: () {
                        save(id_penanganan_perawatan);
                      }),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
