import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter_mt/source/repository/repository.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'edit_perbaikan_state.dart';

class EditPerbaikanCubit extends Cubit<EditPerbaikanState> {
  final MyRepository? myRepository;
  EditPerbaikanCubit({required this.myRepository}) : super(EditPerbaikanInitial());

  void getShowPerbaikan()async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var id_delegasi = pref.getString('id_delegasi');
    print("ID Delegasi: $id_delegasi");
    emit(EditPerbaikanLoading());
    myRepository!.getShowPerbaikan(id_delegasi).then((value) {
      var json = jsonDecode(value.body);
      print(id_delegasi);
      print('JSON EDIT: $json');
      print('Status EDIT: ${value.statusCode}');
      emit(EditPerbaikanLoaded(json: json, statusCode: value.statusCode));
    });
  }

}
