import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter_mt/source/repository/repository.dart';
import 'package:meta/meta.dart';

part 'review_perawatan_state.dart';

class ReviewPerawatanCubit extends Cubit<ReviewPerawatanState> {
  final MyRepository? myRepository;
  ReviewPerawatanCubit({this.myRepository}) : super(ReviewPerawatanInitial());

  void reviewPerawatan(id_delegasi)async {
    emit(ReviewPerawatanLoading());
    myRepository!.reviewPerawatan(id_delegasi).then((value) {
      var json = jsonDecode(value.body);
      var statusCode = value.statusCode;
      emit(ReviewPerawatanLoaded(json: json, statusCode: statusCode));
    });
  }
}
