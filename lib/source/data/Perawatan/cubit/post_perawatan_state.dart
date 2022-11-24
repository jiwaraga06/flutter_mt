part of 'post_perawatan_cubit.dart';

@immutable
abstract class PostPerawatanState {}

class PostPerawatanInitial extends PostPerawatanState {}
class PostPerawatanLoading extends PostPerawatanState {}
class PostPerawatanLoaded extends PostPerawatanState {
  final int? statusCode;
  dynamic json;

  PostPerawatanLoaded({this.statusCode, this.json});
}
