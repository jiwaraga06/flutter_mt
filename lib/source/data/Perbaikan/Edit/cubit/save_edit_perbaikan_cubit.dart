import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter_mt/source/repository/repository.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'save_edit_perbaikan_state.dart';

class SaveEditPerbaikanCubit extends Cubit<SaveEditPerbaikanState> {
  final MyRepository? myRepository;
  SaveEditPerbaikanCubit({required this.myRepository})
      : super(SaveEditPerbaikanInitial());

  void postEditPerbaikan(id_penangan_perbaikan, detail_perbaikan) async {
    emit(SaveEditPerbaikanLoading());
    SharedPreferences pref = await SharedPreferences.getInstance();
    var email = pref.getString("email");
    var body = {
      'id_penanganan_perbaikan': id_penangan_perbaikan,
      'email': email,
      'detail_perbaikan': detail_perbaikan,
    };
    var encode = jsonEncode(body);
    print(encode);
    myRepository!.editPerbaikan(encode).then((value) {
      var json = jsonDecode(value.body);
      print("Json edit perbaikan: $json");
      print("Json edit perbaikan Code: ${value.statusCode}");
      emit(SaveEditPerbaikanLoaded(json: json, statusCode: value.statusCode));
    });
  }
}
