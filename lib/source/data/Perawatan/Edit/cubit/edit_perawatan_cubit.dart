import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter_mt/source/repository/repository.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'edit_perawatan_state.dart';

class EditPerawatanCubit extends Cubit<EditPerawatanState> {
  final MyRepository? myRepository;
  EditPerawatanCubit({required this.myRepository}) : super(EditPerawatanInitial());
  void editPenanganan(id_penanganan_perawatan,detail_perawatan) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var email = pref.getString('email');
    emit(EditPerawatanLoading());
    var body ={
      'id_penanganan_perawatan': id_penanganan_perawatan,
      'email': email,
      'detail_perawatan': detail_perawatan,
    };
    var encode = jsonEncode(body);
    print('Encode: $encode');
    myRepository!.editPerawatan(encode).then((value) {
      var json = jsonDecode(value.body);
      var statusCode = value.statusCode;
      print("JSON EDIT PERAWATAN: $json");
      emit(EditPerawatanLoaded(json: json, statusCode: statusCode));
    });
  }
}
