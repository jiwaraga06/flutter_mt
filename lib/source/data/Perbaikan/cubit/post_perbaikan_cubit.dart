import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter_mt/source/repository/repository.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'post_perbaikan_state.dart';

class PostPerbaikanCubit extends Cubit<PostPerbaikanState> {
  final MyRepository? myRepository;
  PostPerbaikanCubit({required this.myRepository}) : super(PostPerbaikanInitial());
  void postPerbaikan(id_delegasi, detail_perbaikan) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var email = pref.getString("email");
    var body = {
      'email': email,
      'id_delegasi': id_delegasi,
      'detail_perbaikan': detail_perbaikan,
    };
    var encode = jsonEncode(body);
    print(encode);
    emit(PostPerbaikanLoading());
    myRepository!.postPerbaikan(encode).then((value) {
      var json = jsonDecode(value.body);
      print("Json post perbaikan: $json");
      emit(PostPerbaikanLoaded(json: json, statusCode: value.statusCode));
    });
  }
}
