part of 'tree_view_cubit.dart';

@immutable
abstract class TreeViewState {}

class TreeViewInitial extends TreeViewState {}
class TreeViewLoading extends TreeViewState {}

class TreeViewLoaded extends TreeViewState {
  String? json;
  TreeViewLoaded({this.json});
}
