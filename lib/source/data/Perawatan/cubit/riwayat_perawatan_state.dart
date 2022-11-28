part of 'riwayat_perawatan_cubit.dart';

@immutable
abstract class RiwayatPerawatanState {}

class RiwayatPerawatanInitial extends RiwayatPerawatanState {}
class RiwayatPerawatanLoading extends RiwayatPerawatanState {}
class RiwayatPerawatanLoaded extends RiwayatPerawatanState {
  final int? statusCode;
  dynamic json;

  RiwayatPerawatanLoaded({this.statusCode, this.json});
}
