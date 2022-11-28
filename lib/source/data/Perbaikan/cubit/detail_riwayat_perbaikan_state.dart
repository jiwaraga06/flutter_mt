part of 'detail_riwayat_perbaikan_cubit.dart';

@immutable
abstract class DetailRiwayatPerbaikanState {}

class DetailRiwayatPerbaikanInitial extends DetailRiwayatPerbaikanState {}

class DetailRiwayatPerbaikanLoading extends DetailRiwayatPerbaikanState {}

class DetailRiwayatPerbaikanLoaded extends DetailRiwayatPerbaikanState {
  final int? statusCode;
  dynamic json;

  DetailRiwayatPerbaikanLoaded({this.statusCode, this.json});
}
