part of 'perbaikan_cubit.dart';

@immutable
abstract class PerbaikanState {}

class PerbaikanInitial extends PerbaikanState {}

class PerbaikanLoading extends PerbaikanState {}

class PerbaikanLoaded extends PerbaikanState {
  dynamic json;
  final int? statusCode;
  PerbaikanLoaded({this.json, this.statusCode});
}
