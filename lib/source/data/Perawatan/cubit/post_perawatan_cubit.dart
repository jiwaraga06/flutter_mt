import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter_mt/source/repository/repository.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'post_perawatan_state.dart';

class PostPerawatanCubit extends Cubit<PostPerawatanState> {
  final MyRepository? myRepository;
  PostPerawatanCubit({required this.myRepository}) : super(PostPerawatanInitial());

  void postPenanganan(detail_perawatan) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var email = pref.getString('email');
    var kode_penugasan = pref.getString('kode_penugasan');
    emit(PostPerawatanLoading());
    var body ={
      'email': email,
      'id_delegasi': kode_penugasan,
      'detail_perawatan': detail_perawatan,
    };
    var encode = jsonEncode(body);
    print(encode);
    myRepository!.postPerawatan(encode).then((value) {
      var json = jsonDecode(value.body);
      var statusCode = value.statusCode;
      print("JSON POST PERAWATAN: $json");
      emit(PostPerawatanLoaded(json: json, statusCode: statusCode));
    });
  }
}
