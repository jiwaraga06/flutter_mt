import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'save_perawatan_state.dart';

class SavePerawatanCubit extends Cubit<SavePerawatanState> {
  SavePerawatanCubit() : super(SavePerawatanInitial());
  void savePerawatan(id_perbaikan, kode_penugasan, tgl_penugasan, nama_lokasi, nama_mesin,jadwal_perawatan) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var email = pref.getString('email');
    pref.setString('kode_penugasan',kode_penugasan);
    emit(SavePerawatanLoaded(
      email: email,
      id_perbaikan: id_perbaikan,
      kode_penugasan: kode_penugasan,
      tgl_penugasan: tgl_penugasan,
      nama_lokasi: nama_lokasi,
      jadwal_perawatan: jadwal_perawatan,
      nama_mesin: nama_mesin,
    ));
  }
}
