part of 'review_perawatan_cubit.dart';

@immutable
abstract class ReviewPerawatanState {}

class ReviewPerawatanInitial extends ReviewPerawatanState {}
class ReviewPerawatanLoading extends ReviewPerawatanState {}
class ReviewPerawatanLoaded extends ReviewPerawatanState {
  final int? statusCode;
  dynamic json;

  ReviewPerawatanLoaded({this.statusCode, this.json});
}
