import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter_mt/source/repository/repository.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'tree_view_state.dart';

class TreeViewCubit extends Cubit<TreeViewState> {
  final MyRepository? myRepository;
  TreeViewCubit({required this.myRepository}) : super(TreeViewInitial());

  Future getTreeView() async {
    emit(TreeViewLoading());
    SharedPreferences pref = await SharedPreferences.getInstance();
    var id_perbaikan = pref.getString('id_perbaikan');
    myRepository!.getTreeView(id_perbaikan).then((value) {
      final json = value.body;
      if (value.statusCode == 200) {
        emit(TreeViewLoaded(json: json));
      }
        print("id_perbaikan: $id_perbaikan");
        // print("TreeView: $json");
    });
  }
}
