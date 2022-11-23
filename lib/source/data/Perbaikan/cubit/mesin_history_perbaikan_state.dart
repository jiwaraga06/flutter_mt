part of 'mesin_history_perbaikan_cubit.dart';

@immutable
abstract class MesinHistoryPerbaikanState {}

class MesinHistoryPerbaikanInitial extends MesinHistoryPerbaikanState {}

class MesinHistoryPerbaikanLoading extends MesinHistoryPerbaikanState {}

class MesinHistoryPerbaikanLoaded extends MesinHistoryPerbaikanState {
  final List? data;
  dynamic json;
  int? statusCode;
  MesinHistoryPerbaikanLoaded({this.data, this.statusCode, this.json});
}
