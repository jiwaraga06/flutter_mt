import 'dart:convert';

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
      var response =
          await http.get(url, headers: {'Authorization': MyApi.token()});
      return response;
    } catch (e) {
      print("ERROR NETWORK perbaikan&perawatan: $e");
    }
  }

  Future getTreeView(id_perbaikan) async {
    try {
      var url = Uri.parse(MyApi.getTreeView(id_perbaikan));
      var response =
          await http.get(url, headers: {'Authorization': MyApi.token()});
      return response;
    } catch (e) {
      print("ERROR NETWORK treeview: $e");
    }
  }

  Future getMaterial(id_perbaikan) async {
    try {
      var url = Uri.parse(MyApi.getMaterial(id_perbaikan));
      var response =
          await http.get(url, headers: {'Authorization': MyApi.token()});
      return response;
    } catch (e) {
      print("ERROR NETWORK material: $e");
    }
  }

  Future getKetMesin(id_mesin) async {
    try {
      var url = Uri.parse(MyApi.getKetMesin(id_mesin));
      var response = await http.get(url, headers: {'Authorization': MyApi.token(), 'Accept': 'application/json'});
      return response;
    } catch (e) {
      print("ERROR NETWORK getMesin: $e");
    }
  }

  // PERBAIKAN
  Future postPerbaikan(body) async {
    try {
      var url = Uri.parse(MyApi.postPerbaikan());
      var response = await http.post(
        url,
        headers: {
          'Authorization': MyApi.token(),
          "Accept": "application/json",
          "Content-Type": "application/json",
        },
        body: body,
      );
      return response;
    } catch (e) {
      print("ERROR NETWORK postperbaikan: $e");
    }
  }

  Future editPerbaikan(body) async {
    try {
      var url = Uri.parse(MyApi.postPerbaikan());
      var response = await http.put(
        url,
        headers: {
          'Authorization': MyApi.token(),
          "Accept": "application/json",
          "Content-Type": "application/json",
        },
        body: body,
      );
      return response;
    } catch (e) {
      print("ERROR NETWORK editperbaikan: $e");
    }
  }

  Future getRiwayatPerbaikan(email, page, per_page) async {
    try {
      var url = Uri.parse(MyApi.riwayat_perbaikan(email, page, per_page));
      var response = await http.get(url, headers: {'Authorization': MyApi.token(), 'Accept': 'application/json'});
      return response;
    } catch (e) {
      print('ERROR NETWORK riwayat_perbaikan: $e');
    }
  }

  Future getMesinHistoryPerbaikan(id_mesin, page, per_page) async {
    try {
      var url =
          Uri.parse(MyApi.mesin_history_perbaikan(id_mesin, page, per_page));
      var response = await http.get(
        url,
        headers: {'Authorization': MyApi.token(), 'Accept': 'application/json'},
      );
      return response;
    } catch (e) {
      print('ERROR NETWORK msn_riwayat_perbaikan: $e');
    }
  }

  Future getShowPerbaikan(id_delegasi) async {
    try {
      var url = Uri.parse(MyApi.show_perbaikan(id_delegasi));
      var response = await http.get(url, headers: {'Authorization': MyApi.token(), 'Accept': 'application/json'});
      return response;
    } catch (e) {
      print('ERROR NETWORK SHOW PERBAIKAN: $e');
    }
  }

  // PERAWATAN
  Future getDetailTaskPerawatan(id_delegasi) async {
    try {
      var url = Uri.parse(MyApi.showPerawatan(id_delegasi));
      var response = await http.get(url, headers: {
        'Authorization': MyApi.token(),
        'Accept': 'application/json',
      });
      return response;
    } catch (e) {
      print('ERROR NETWORK DETAIL TASK PERAWATAN : \n $e');
    }
  }

  Future postPerawatan(body) async {
    try {
      var url = Uri.parse(MyApi.postPerawatan());
      var response = await http.post(
        url,
        headers: {
          'Authorization': MyApi.token(),
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: body,
      );
      return response;
    } catch (e) {
      print('ERROR NETWORK POST PERAWATAN: $e');
    }
  }
  Future editPerawatan(body) async {
    try {
      var url = Uri.parse(MyApi.postPerawatan());
      var response = await http.put(
        url,
        headers: {
          'Authorization': MyApi.token(),
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: body,
      );
      return response;
    } catch (e) {
      print('ERROR NETWORK EDIT PERAWATAN: $e');
    }
  }
}
