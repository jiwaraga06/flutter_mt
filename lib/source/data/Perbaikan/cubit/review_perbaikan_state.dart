part of 'review_perbaikan_cubit.dart';

@immutable
abstract class ReviewPerbaikanState {}

class ReviewPerbaikanInitial extends ReviewPerbaikanState {}
class ReviewPerbaikanLoading extends ReviewPerbaikanState {}
class ReviewPerbaikanLoaded extends ReviewPerbaikanState {
  final int? statusCode;
  dynamic json;

  ReviewPerbaikanLoaded({this.statusCode, this.json});
}
