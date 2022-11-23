part of 'post_perbaikan_cubit.dart';

@immutable
abstract class PostPerbaikanState {}

class PostPerbaikanInitial extends PostPerbaikanState {}

class PostPerbaikanLoading extends PostPerbaikanState {}

class PostPerbaikanLoaded extends PostPerbaikanState {
  final int? statusCode;
  dynamic json;

  PostPerbaikanLoaded({this.statusCode, this.json});
}
