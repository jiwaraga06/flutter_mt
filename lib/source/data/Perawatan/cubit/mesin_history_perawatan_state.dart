part of 'mesin_history_perawatan_cubit.dart';

@immutable
abstract class MesinHistoryPerawatanState {}

class MesinHistoryPerawatanInitial extends MesinHistoryPerawatanState {}
class MesinHistoryPerawatanLoading extends MesinHistoryPerawatanState {}
class MesinHistoryPerawatanLoaded extends MesinHistoryPerawatanState {
  final int? statusCode;
  dynamic json;
  final List? data;

  MesinHistoryPerawatanLoaded({this.statusCode, this.json, this.data});
}
