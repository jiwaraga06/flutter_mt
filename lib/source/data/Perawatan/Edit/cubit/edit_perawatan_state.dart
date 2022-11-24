part of 'edit_perawatan_cubit.dart';

@immutable
abstract class EditPerawatanState {}

class EditPerawatanInitial extends EditPerawatanState {}
class EditPerawatanLoading extends EditPerawatanState {}
class EditPerawatanLoaded extends EditPerawatanState {
  final int? statusCode;
  dynamic json;

  EditPerawatanLoaded({this.statusCode, this.json});
}
