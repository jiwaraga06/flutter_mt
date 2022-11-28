part of 'profile_cubit.dart';

@immutable
abstract class ProfileState {}

class ProfileInitial extends ProfileState {}
class ProfileLoading extends ProfileState {}
class ProfileLoaded extends ProfileState {
  final int? statusCode;
  dynamic json;

  ProfileLoaded({this.statusCode, this.json});
}
