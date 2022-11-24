part of 'save_edit_perbaikan_cubit.dart';

@immutable
abstract class SaveEditPerbaikanState {}

class SaveEditPerbaikanInitial extends SaveEditPerbaikanState {}

class SaveEditPerbaikanLoading extends SaveEditPerbaikanState {}

class SaveEditPerbaikanLoaded extends SaveEditPerbaikanState {
  final int? statusCode;
  dynamic json;

  SaveEditPerbaikanLoaded({this.statusCode, this.json});
}
