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

  // TASK LIST PERBAIKAN DAN PERAWATAN
  Future getTaskPerbaikanPerawatan(email) async {
    var json = await myNetwork!.getTaskPerbaikanPerawatan(email);
    return json;
  }

  Future getTreeView(id_perbaikan) async {
    var json = await myNetwork!.getTreeView(id_perbaikan);
    return json;
  }
}
