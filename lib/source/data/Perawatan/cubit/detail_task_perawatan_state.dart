part of 'detail_task_perawatan_cubit.dart';

@immutable
abstract class DetailTaskPerawatanState {}

class DetailTaskPerawatanInitial extends DetailTaskPerawatanState {}
class DetailTaskPerawatanLoading extends DetailTaskPerawatanState {}
class DetailTaskPerawatanLoaded extends DetailTaskPerawatanState {
  final int? statusCode;
  dynamic json;

  DetailTaskPerawatanLoaded({this.statusCode, this.json});
}
