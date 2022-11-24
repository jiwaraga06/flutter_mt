part of 'perawatan_cubit.dart';

@immutable
abstract class PerawatanState {}

class PerawatanInitial extends PerawatanState {}
class PerawatanLoading extends PerawatanState {}
class PerawatanLoaded extends PerawatanState {
  final int? statusCode;
  dynamic json;

  PerawatanLoaded({this.statusCode, this.json});
}
