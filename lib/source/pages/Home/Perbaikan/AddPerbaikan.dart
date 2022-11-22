import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mt/source/data/Perbaikan/cubit/save_perbaikan_cubit.dart';
import 'package:flutter_mt/source/data/Perbaikan/cubit/tree_view_cubit.dart';
import 'package:flutter_treeview/flutter_treeview.dart';

class AddPerbaikan extends StatefulWidget {
  const AddPerbaikan({super.key});

  @override
  State<AddPerbaikan> createState() => _AddPerbaikanState();
}

class _AddPerbaikanState extends State<AddPerbaikan> {
  TreeViewController? _treeViewController;
  String? keys;
  String? _selectedNode;
  bool docsOpen = true;
  bool _allowParentSelect = true;
  bool _supportParentDoubleTap = false;
  @override
  void initState() {
    _treeViewController = TreeViewController(
        // children: _nodes!,
        );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<TreeViewCubit>(context).getTreeView();
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
        title: Text("Perbaikan"),
      ),
      body: ListView(
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
                        Text("Kode Penugasan"),
                        Text(":"),
                        Text('${data.kode_penugasan}')
                      ]),
                      TableRow(children: [
                        Text("Tanggal Penugasan"),
                        Text(":"),
                        Text('${data.tgl_penugasan}')
                      ]),
                      TableRow(children: [
                        Text("Lokasi"),
                        Text(":"),
                        Text('${data.nama_lokasi}')
                      ]),
                      TableRow(children: [
                        Text("Nama Mesin"),
                        Text(":"),
                        Text('${data.nama_mesin}')
                      ]),
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
              print("ENCCC $json");
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
                    print('$key, $expanded');
                    // _expandNode(key, expanded);
                    // setState(() {
                    //   keys = key;
                    // });
                  },
                  onNodeTap: (key) {
                    print('Selected: $key');
                    setState(() {
                      keys = key;
                      print(keys);
                    });
                    setState(() {
                      _selectedNode = key;
                      _treeViewController =
                          _treeViewController!.copyWith(selectedKey: key);
                    });
                  },
                  theme: _treeViewTheme,
                ),
              );
            },
          ),
          _treeViewController!.getNode(_selectedNode!) == null
              ? Container()
              : Container(
                  padding: EdgeInsets.only(top: 20),
                  alignment: Alignment.center,
                  child: Text(
                      "Pilih : ${_treeViewController!.getNode(_selectedNode!) == null ? "" : _treeViewController!.getNode(_selectedNode!)!.label}",
                      style: TextStyle(fontSize: 15.0)),
                ),
        ],
      ),
    );
  }

  _expandNode(String key, bool expanded) {
    String msg = '${expanded ? "Expanded" : "Collapsed"}: $key';
    String msg1 = 'Expanded key : $key';

    debugPrint(msg);
    debugPrint(msg1);
    Node? node = _treeViewController!.getNode(key);
    if (node != null) {
      List<Node> updated;
      if (key == 'docs') {
        updated = _treeViewController!.updateNode(
          key,
          node.copyWith(
            expanded: expanded,
          ),
        );
      } else {
        updated = _treeViewController!
            .updateNode(key, node.copyWith(expanded: expanded));
      }
      setState(() {
        if (key == 'docs') docsOpen = expanded;
        _treeViewController =
            _treeViewController!.copyWith(children: updated, selectedKey: key);
      });
    }
  }
}
