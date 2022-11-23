part of 'material_cubit.dart';

@immutable
abstract class MaterialStates {}

class MaterialInitial extends MaterialStates {}
class MaterialLoad extends MaterialStates{
  final List<MaterialModel>? material_model;

  MaterialLoad({this.material_model});
}
class MaterialData extends MaterialStates{
  dynamic material_model;

  MaterialData({this.material_model});
}
