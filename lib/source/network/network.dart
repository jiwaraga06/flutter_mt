import 'package:flutter_mt/source/network/api.dart';
import 'package:http/http.dart' as http;

class MyNetwork {
  Future login(body) async {
    try {
      var url = Uri.parse(MyApi.login());
      var response = await http.post(
        url,
        headers: {'Authorization': MyApi.token(), 'Accept': 'application/json'},
        body: body,
      );
      return response;
    } catch (e) {
      print("ERROR NETWORK login: $e");
    }
  }

  // TASK LIST PERBAIKAN & PERAWATAN

  Future getTaskPerbaikanPerawatan(email) async {
    try {
      var url = Uri.parse(MyApi.getTaskPerbaikanPerawatan(email));
      var response = await http.get(url, headers: {'Authorization': MyApi.token()});
      return response;
    } catch (e) {
      print("ERROR NETWORK perbaikan&perawatan: $e");
    }
  }
}
