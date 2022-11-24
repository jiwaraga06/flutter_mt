part of 'save_perawatan_cubit.dart';

@immutable
abstract class SavePerawatanState {}

class SavePerawatanInitial extends SavePerawatanState {}

class SavePerawatanLoaded extends SavePerawatanState {
  final String? email, tgl_penugasan, nama_lokasi, nama_mesin, id_perbaikan, kode_penugasan, tgl_delegasi, jadwal_perawatan;

  SavePerawatanLoaded({
    this.email,
    this.tgl_penugasan,
    this.nama_lokasi,
    this.nama_mesin,
    this.id_perbaikan,
    this.kode_penugasan,
    this.tgl_delegasi,
    this.jadwal_perawatan,
  });
}
