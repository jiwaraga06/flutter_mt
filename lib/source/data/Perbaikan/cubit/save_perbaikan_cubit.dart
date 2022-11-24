import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'save_perbaikan_state.dart';

class SavePerbaikanCubit extends Cubit<SavePerbaikanState> {
  SavePerbaikanCubit() : super(SavePerbaikanInitial());

  void save(id_perbaikan, kode_penugasan, tgl_penugasan, nama_lokasi, nama_mesin) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var email = pref.getString('email');
    emit(SavePerbaikanLoad(id_perbaikan, kode_penugasan, email, tgl_penugasan, nama_lokasi, nama_mesin));
    pref.setString("id_perbaikan", id_perbaikan);
    // pref.setString("id_delegasi", kode_penugasan);
  }

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
    // myRepository!.postPerbaikan(encode).then((value) {
    //   var json = jsonDecode(value.body);
    //   print("Json post perbaikan: $json");
    // });
  }
}
