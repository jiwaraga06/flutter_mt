part of 'edit_detail_task_perawatan_cubit.dart';

@immutable
abstract class EditDetailTaskPerawatanState {}

class EditDetailTaskPerawatanInitial extends EditDetailTaskPerawatanState {}
class EditDetailTaskPerawatanLoading extends EditDetailTaskPerawatanState {}
class EditDetailTaskPerawatanLoaded extends EditDetailTaskPerawatanState {
  final int? statusCode;
  dynamic json;

  EditDetailTaskPerawatanLoaded({this.statusCode, this.json});
}
