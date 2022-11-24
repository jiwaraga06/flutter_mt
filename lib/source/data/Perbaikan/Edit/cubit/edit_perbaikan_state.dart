part of 'edit_perbaikan_cubit.dart';

@immutable
abstract class EditPerbaikanState {}

class EditPerbaikanInitial extends EditPerbaikanState {}
class EditPerbaikanLoading extends EditPerbaikanState {}
class EditPerbaikanLoaded extends EditPerbaikanState {
  final int? statusCode;
  dynamic json;

  EditPerbaikanLoaded({this.statusCode, this.json});
}
