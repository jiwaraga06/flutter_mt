import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mt/source/data/Perbaikan/Edit/cubit/edit_perbaikan_cubit.dart';
import 'package:flutter_mt/source/data/Perbaikan/Edit/cubit/save_edit_perbaikan_cubit.dart';
import 'package:flutter_mt/source/data/Perbaikan/cubit/material_cubit.dart';
import 'package:flutter_mt/source/data/Perbaikan/cubit/post_perbaikan_cubit.dart';
import 'package:flutter_mt/source/data/Perbaikan/cubit/save_perbaikan_cubit.dart';
import 'package:flutter_mt/source/data/Perbaikan/cubit/tree_view_cubit.dart';
import 'package:flutter_mt/source/pages/Home/Perbaikan/modelTable.dart';
import 'package:flutter_mt/source/widget/custom_banner.dart';
import 'package:flutter_mt/source/widget/custom_button2.dart';
import 'package:flutter_mt/source/widget/custom_loading.dart';
import 'package:flutter_treeview/flutter_treeview.dart';

class EditPerbaikan extends StatefulWidget {
  const EditPerbaikan({super.key});

  @override
  State<EditPerbaikan> createState() => _EditPerbaikanState();
}

class _EditPerbaikanState extends State<EditPerbaikan> {
  TreeViewController? _treeViewController;
  var id_delegasi, id_penangan_perbaikan;
  String? keys, kode_penugasan, _valDropdown;
  String? _selectedNode;
  String isiTreeView = '';
  bool docsOpen = true;
  bool _allowParentSelect = true;
  bool _supportParentDoubleTap = false;
  List<MyTable> tabels = [];
  List<MyTable> selectedtabel = [];
  final formkey = GlobalKey<FormState>();
  bool sort = false;
  onSelected(bool selected, MyTable tabel) async {
    setState(() {
      if (selected) {
        selectedtabel.add(tabel);
      } else {
        selectedtabel.remove(tabel);
      }
    });
  }

  deleteSelected() async {
    setState(() {
      if (selectedtabel.isNotEmpty) {
        List<MyTable> temp = [];
        temp.addAll(selectedtabel);
        for (MyTable tabel in temp) {
          tabels.remove(tabel);
          selectedtabel.remove(tabel);
        }
      }
    });
  }

  add() {
    MyTable table = MyTable(_treeViewController!.getNode(_selectedNode!)!.key, '', 0, '', '');
    table.id_struktur_mesin = _treeViewController!.getNode(_selectedNode!)!.key;
    table.nama = isiTreeView;
    tabels.add(table);
    print('MyTable: $tabels');
    setState(() {});
  }

  void save(id_penangan_perbaikan) {
    print(tabels);
    BlocProvider.of<SaveEditPerbaikanCubit>(context).postEditPerbaikan(
        id_penangan_perbaikan,
        tabels
            .map(
              (e) => MyTable(e.id_struktur_mesin, e.nama, e.id_material, e.jumlah, e.catatan),
            )
            .toList());
  }

  @override
  void initState() {
    super.initState();
    _treeViewController = TreeViewController();
    // selectedtabel = [];
    BlocProvider.of<TreeViewCubit>(context).getTreeView();
    BlocProvider.of<MaterialCubit>(context).getMaterial();
    BlocProvider.of<EditPerbaikanCubit>(context).getShowPerbaikan();
  }

  @override
  Widget build(BuildContext context) {
    final argument = (ModalRoute.of(context)?.settings.arguments) as Map;
    print("ARGUMENT: $argument");

    TreeViewTheme _treeViewTheme = TreeViewTheme(
      expanderTheme: ExpanderThemeData(
          type: ExpanderType.caret,
          modifier: ExpanderModifier.none,
          position: ExpanderPosition.start,
          // color: Colors.grey.shade800,
          size: 20,
          color: Colors.black),
      labelStyle: TextStyle(
        fontSize: 16,
        letterSpacing: 0.3,
      ),
      parentLabelStyle: TextStyle(
        fontSize: 16,
        letterSpacing: 0.3,
        fontWeight: FontWeight.w800,
        color: Colors.blue,
      ),
      iconTheme: IconThemeData(
        size: 18,
        color: Colors.grey,
      ),
      colorScheme: Theme.of(context).colorScheme,
    );
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Perbaikan"),
      ),
      body: BlocConsumer<EditPerbaikanCubit, EditPerbaikanState>(
        listener: (context, state) {
          if (state is EditPerbaikanLoading) {
            showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return const CustomLoading();
                });
          }
          if (state is EditPerbaikanLoaded) {
            Navigator.of(context).pop();
            var json = state.json;
            id_penangan_perbaikan = json['id_penanganan_perbaikan'];
            print('object');
            json['detail_perbaikan'].map((e) {
              print(e['nama_komponen']);
              MyTable table = MyTable(
                e['id_struktur_mesin'],
                e['nama_komponen'],
                e['id_material'],
                e['jumlah'].toString(),
                e['catatan'],
              );
              table.id_struktur_mesin = e['id_struktur_mesin'];
              table.nama = e['nama_komponen'];
              tabels.add(table);
              setState(() {});
            }).toList();
          }
        },
        builder: (context, state) {
          return BlocListener<SaveEditPerbaikanCubit, SaveEditPerbaikanState>(
            listener: (context, state) async {
              if (state is SaveEditPerbaikanLoading) {
                showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      return const CustomLoading();
                    });
              }
              if (state is SaveEditPerbaikanLoaded) {
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
                  final materialBanner = MyBanner.bannerFailed(json['message']);
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
                      BlocBuilder<SavePerbaikanCubit, SavePerbaikanState>(
                        builder: (context, state) {
                          if (state is SavePerbaikanLoad == false) {
                            return Container(
                              child: Text("Data"),
                            );
                          }
                          var data = (state as SavePerbaikanLoad);
                          if (data == null) {
                            return Text("Data Null");
                          }
                          kode_penugasan = data.kode_penugasan;
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
                                  TableRow(children: [Text("Lokasi"), Text(":"), Text('${data.nama_lokasi}')]),
                                  TableRow(children: [Text("Nama Mesin"), Text(":"), Text('${data.nama_mesin}')]),
                                ],
                              ));
                        },
                      ),
                      // TREEVIEW
                      BlocBuilder<TreeViewCubit, TreeViewState>(
                        builder: (context, state) {
                          if (state is TreeViewLoading) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          if (state is TreeViewLoaded == false) {
                            return Container(
                              child: Text("False"),
                            );
                          }
                          var json = (state as TreeViewLoaded).json;
                          // String JSON = json;
                          // print("ENCCC ");
                          if (json!.isEmpty) {
                            return Container(
                              child: Text("Empty"),
                            );
                          }
                          _treeViewController = _treeViewController!.loadJSON(json: json);
                          // return Container(
                          //   child: Text(json),
                          // );
                          return Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: EdgeInsets.all(10),
                            child: TreeView(
                              shrinkWrap: true,
                              primary: true,
                              physics: NeverScrollableScrollPhysics(),
                              controller: _treeViewController!,
                              allowParentSelect: _allowParentSelect,
                              supportParentDoubleTap: _supportParentDoubleTap,
                              onExpansionChanged: (key, expanded) {
                                print(', ');
                                // _expandNode(key, expanded);
                                // setState(() {
                                //   keys = key;
                                // });
                              },
                              onNodeTap: (key) {
                                print('Selected: ');
                                setState(() {
                                  keys = key;
                                  print(keys);
                                });
                                setState(() {
                                  _selectedNode = key;
                                  _treeViewController = _treeViewController!.copyWith(selectedKey: key);
                                  isiTreeView = _treeViewController!.getNode(_selectedNode!)!.label;
                                });
                              },
                              theme: _treeViewTheme,
                            ),
                          );
                        },
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 20),
                        alignment: Alignment.center,
                        child: Text("Pilih : ", style: TextStyle(fontSize: 15.0)),
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        // height: double.infinity,
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: tabels.length,
                          itemBuilder: (BuildContext context, int index) {
                            var data = tabels[index];
                            return InkWell(
                              onLongPress: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext) {
                                      return AlertDialog(
                                        content: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [Text("Anda ingin hapus kolom ini ?")],
                                        ),
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: Text("Batal")),
                                          TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                                onSelected(true, data);
                                                deleteSelected();
                                              },
                                              child: Text("Betul")),
                                        ],
                                      );
                                    });
                              },
                              child: Container(
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
                                child: Table(
                                  columnWidths: const {
                                    0: FixedColumnWidth(110),
                                    1: FixedColumnWidth(20),
                                    // 2: FixedColumnWidth(100),
                                  },
                                  children: [
                                    TableRow(children: [
                                      SizedBox(height: 50, child: Text("Komponen Perbaikan", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600))),
                                      Text(":", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                                      Text(data.id_struktur_mesin.toString(), style: TextStyle(fontSize: 16)),
                                    ]),
                                    TableRow(children: [
                                      SizedBox(height: 50, child: Text("Nama", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600))),
                                      Text(":", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                                      Text(data.nama.toString(), style: TextStyle(fontSize: 16)),
                                    ]),
                                    TableRow(children: [
                                      SizedBox(height: 80, child: Text("Material", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600))),
                                      Text(":", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                                      BlocBuilder<MaterialCubit, MaterialStates>(
                                        builder: (context, state) {
                                          if (state is MaterialData == false) {
                                            return Container();
                                          }
                                          List<dynamic> material = (state as MaterialData).material_model;
                                          if (material.isEmpty) {
                                            return Container(
                                              child: Text("NULL"),
                                            );
                                          }
                                          return DropdownButtonFormField<dynamic>(
                                            isExpanded: true,
                                            value: data.id_material,
                                            decoration: InputDecoration(constraints: BoxConstraints(maxHeight: 40)),
                                            items: material
                                                .map((e) => DropdownMenuItem(
                                                      child: Text(e['nama_material']),
                                                      value: e['id'],
                                                    ))
                                                .toList(),
                                            hint: Text("I DMaterial"),
                                            validator: (value) {
                                              if (value == null) {
                                                return "Kolom Masih Kosong";
                                              }
                                            },
                                            onChanged: (value) {
                                              setState(() {
                                                data.id_material = value;
                                                print("val: ${data.id_material}");
                                              });
                                            },
                                          );
                                        },
                                      )
                                      // Text(data.nama.toString(), style: TextStyle(fontSize: 16)),
                                    ]),
                                    TableRow(children: [
                                      SizedBox(height: 50, child: Text("Quantity", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600))),
                                      Text(":", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                                      TextFormField(
                                        initialValue: data.jumlah,
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                          hintText: "Quantity",
                                          constraints: BoxConstraints(maxHeight: 25),
                                        ),
                                        validator: (text) {
                                          if (text!.isEmpty) {
                                            return "Kolom Masih Kosong";
                                          }
                                        },
                                        onChanged: (text) {
                                          setState(() {
                                            data.jumlah = text;
                                          });
                                        },
                                      ),
                                    ]),
                                    TableRow(children: [
                                      SizedBox(height: 50, child: Text("Keterangan", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600))),
                                      Text(":", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                                      TextFormField(
                                        initialValue: data.catatan,
                                        decoration: InputDecoration(
                                          hintText: "Keterangan",
                                          constraints: BoxConstraints(maxHeight: 25),
                                        ),
                                        validator: (text) {
                                          if (text!.isEmpty) {
                                            return "Kolom Masih Kosong";
                                          }
                                        },
                                        onChanged: (text) {
                                          setState(() {
                                            data.catatan = text;
                                          });
                                        },
                                      ),
                                    ]),
                                  ],
                                ),
                              ),
                            );
                          },
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
                            save(id_penangan_perbaikan);
                          }),
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
