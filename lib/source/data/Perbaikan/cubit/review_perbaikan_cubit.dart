import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter_mt/source/repository/repository.dart';
import 'package:meta/meta.dart';

part 'review_perbaikan_state.dart';

class ReviewPerbaikanCubit extends Cubit<ReviewPerbaikanState> {
  final MyRepository? myRepository;
  ReviewPerbaikanCubit({required this.myRepository}) : super(ReviewPerbaikanInitial());

  void getReviewPerbaikan(id_delegasi)async {
    emit(ReviewPerbaikanLoading());
    myRepository!.getReviewPerbaikan(id_delegasi).then((value) {
      var json = jsonDecode(value.body);
      var statusCode = value.statusCode;
      print('Review Perbaikan Code: $statusCode');
      print('Review Perbaikan: $json');
      emit(ReviewPerbaikanLoaded(json: json, statusCode: statusCode));
    });
  }
}
