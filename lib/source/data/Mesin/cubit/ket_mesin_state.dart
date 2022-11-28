part of 'ket_mesin_cubit.dart';

@immutable
abstract class KetMesinState {}

class KetMesinInitial extends KetMesinState {}

class KetMesinLoading extends KetMesinState {}

class KetMesinLoaded extends KetMesinState {
  int? statusCode;
  int? isAdd;
  dynamic json;
  KetMesinLoaded({this.json, this.statusCode, this.isAdd});
}
