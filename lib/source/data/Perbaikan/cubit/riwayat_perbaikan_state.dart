part of 'riwayat_perbaikan_cubit.dart';

@immutable
abstract class RiwayatPerbaikanState {}

class RiwayatPerbaikanInitial extends RiwayatPerbaikanState {}

class RiwayatPerbaikanLoading extends RiwayatPerbaikanState {}

class RiwayatPerbaikanLoaded extends RiwayatPerbaikanState {
  dynamic json;
  RiwayatPerbaikanLoaded({this.json});
}
