import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter_mt/source/data/Model/dropdown_model.dart';
import 'package:flutter_mt/source/repository/repository.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'material_state.dart';

class MaterialCubit extends Cubit<MaterialStates> {
  final MyRepository? myRepository;
  MaterialCubit({required this.myRepository}) : super(MaterialInitial());

  void getMaterial() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var id_perbaikan = pref.getString('id_perbaikan');
    myRepository!.getMaterial(id_perbaikan).then((value) {
      var json = jsonDecode(value.body);
      print("JSON MATERIAL: $json");
      emit(MaterialData(material_model: json));
      // emit(MaterialLoad(material_model: json as List<MaterialModel>));
    });
  }
}
