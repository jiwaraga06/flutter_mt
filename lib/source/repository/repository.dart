import 'package:flutter_mt/source/data/Model/dropdown_model.dart';
import 'package:flutter_mt/source/network/network.dart';

class MyRepository {
  final MyNetwork? myNetwork;

  MyRepository({required this.myNetwork});

  Future login(email, password) async {
    var body = {
      'email': '$email',
      'password': '$password',
    };
    var json = await myNetwork!.login(body);
    return json;
  }

  Future getProfile(email)async {
    var json = await myNetwork!.getProfile(email);
    return json;
  }

  // TASK LIST PERBAIKAN DAN PERAWATAN
  Future getTaskPerbaikanPerawatan(email) async {
    var json = await myNetwork!.getTaskPerbaikanPerawatan(email);
    return json;
  }

  Future getTreeView(id_perbaikan) async {
    var json = await myNetwork!.getTreeView(id_perbaikan);
    return json;
  }

  Future getMaterial(id_perbaikan) async {
    var json = await myNetwork!.getMaterial(id_perbaikan);
    // if(json is List){
    //   json.map((e) => MaterialModel.fromJson(e)).toList();
    // }
    return json;
  }

  Future masterMesin(id_mesin) async {
    var json = await myNetwork!.masterMesin(id_mesin);
    return json;
  }

  Future getKetMesin(id_mesin) async {
    var json = await myNetwork!.getKetMesin(id_mesin);
    return json;
  }

  Future postPerbaikan(body) async {
    var json = await myNetwork!.postPerbaikan(body);
    return json;
  }

  Future editPerbaikan(body) async {
    var json = await myNetwork!.editPerbaikan(body);
    return json;
  }

  Future getRiwayatPerbaikan(email, page, per_page) async {
    var json = await myNetwork!.getRiwayatPerbaikan(email, page, per_page);
    return json;
  }

  Future getReviewPerbaikan(id_delegasi) async {
    var json = await myNetwork!.getReviewPerbaikan(id_delegasi);
    return json;
  }

  Future getDetailRiwayatPerbaikan(id_penanganan) async {
    var json = await myNetwork!.getDetailRiwayatPerbaikan(id_penanganan);
    return json;
  }

  Future getMesinHistoryPerbaikan(id_mesin, page, per_page) async {
    var json = await myNetwork!.getMesinHistoryPerbaikan(id_mesin, page, per_page);
    return json;
  }

  Future getShowPerbaikan(id_delegasi) async {
    var json = await myNetwork!.getShowPerbaikan(id_delegasi);
    return json;
  }

  Future getDetailTaskPerawatan(id_delegasi) async {
    var json = await myNetwork!.getDetailTaskPerawatan(id_delegasi);
    return json;
  }

  Future editDetailTaskPerawatan(id_delegasi) async {
    var json = await myNetwork!.editDetailTaskPerawatan(id_delegasi);
    return json;
  }

  Future postPerawatan(body) async {
    var json = await myNetwork!.postPerawatan(body);
    return json;
  }

  Future editPerawatan(body) async {
    var json = await myNetwork!.editPerawatan(body);
    return json;
  }

  Future historyPerawatan(email, page, per_page) async {
    var json = await myNetwork!.historyPerawatan(email, page, per_page);
    return json;
  }

  Future mesin_history_perawatan(id_mesin, page, per_page) async {
    var json = await myNetwork!.mesin_history_perawatan(id_mesin, page, per_page);
    return json;
  }

  Future reviewPerawatan(id_delegasi) async {
    var json = await myNetwork!.reviewPerawatan(id_delegasi);
    return json;
  }
}
