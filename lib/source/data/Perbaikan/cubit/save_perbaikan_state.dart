part of 'save_perbaikan_cubit.dart';

@immutable
abstract class SavePerbaikanState {}

class SavePerbaikanInitial extends SavePerbaikanState {}
class SavePerbaikanLoad extends SavePerbaikanState {
  final String? email, tgl_penugasan, nama_lokasi,nama_mesin,id_perbaikan, kode_penugasan;

  SavePerbaikanLoad(this.id_perbaikan, this.kode_penugasan, this.email, this.tgl_penugasan, this.nama_lokasi, this.nama_mesin);

}
