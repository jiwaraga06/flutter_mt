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

  Future getProfile(email) async {
    try {
      var url = Uri.parse(MyApi.getProfile(email));
      var response = await http.get(url, headers: {
        'Authorization': MyApi.token()
      });
      return response;
    } catch (e) {
      print('ERROR NETWORK PROFILE: $e');
      
    }
  }

  Future masterMesin(id_mesin) async {
    try {
      var url = Uri.parse(MyApi.masterMesin(id_mesin));
      var response = await http.get(url, headers: {'Authorization': MyApi.token()});
      return response;
    } catch (e) {
      print('ERROR NETWORK MASTER MESIN: \N $e');
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

  Future getTreeView(id_perbaikan) async {
    try {
      var url = Uri.parse(MyApi.getTreeView(id_perbaikan));
      var response = await http.get(url, headers: {'Authorization': MyApi.token()});
      return response;
    } catch (e) {
      print("ERROR NETWORK treeview: $e");
    }
  }

  Future getMaterial(id_perbaikan) async {
    try {
      var url = Uri.parse(MyApi.getMaterial(id_perbaikan));
      var response = await http.get(url, headers: {'Authorization': MyApi.token()});
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

  Future getReviewPerbaikan(id_delegasi) async {
    try {
      var url = Uri.parse(MyApi.riview_perbaikan(id_delegasi));
      var response = await http.get(url, headers: {'Authorization': MyApi.token()});
      return response;
    } catch (e) {
      print('ERROR NETWORK REVIEW PERBAIKAN: $e');
    }
  }

  Future getDetailRiwayatPerbaikan(id_penanganan) async {
    try {
      var url = Uri.parse(MyApi.getDetailHistoryPerbaikan(id_penanganan));
      var response = await http.get(url, headers: {'Authorization': MyApi.token(), 'Accept': 'application/json'});
      return response;
    } catch (e) {
      print('ERROR NETWORK DETAIL_RIWAYAT_PERBAIKAN: \n $e');
    }
  }

  Future getMesinHistoryPerbaikan(id_mesin, page, per_page) async {
    try {
      var url = Uri.parse(MyApi.mesin_history_perbaikan(id_mesin, page, per_page));
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
      var url = Uri.parse(MyApi.detail_task_perawatan(id_delegasi));
      var response = await http.get(url, headers: {
        'Authorization': MyApi.token(),
        'Accept': 'application/json',
      });
      return response;
    } catch (e) {
      print('ERROR NETWORK DETAIL TASK PERAWATAN : \n $e');
    }
  }

  Future editDetailTaskPerawatan(id_delegasi) async {
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

  Future historyPerawatan(email, page, per_page) async {
    try {
      var url = Uri.parse(MyApi.history_perawatan(email, page, per_page));
      var response = await http.get(url, headers: {'Authorization': MyApi.token()});
      return response;
    } catch (e) {
      print('ERROR NETWORK HISTORY PERAWATAN: $e');
    }
  }

  Future mesin_history_perawatan(id_mesin, page, per_page) async {
    try {
      var url = Uri.parse(MyApi.mesin_history_perawatan(id_mesin, page, per_page));
      var response = await http.get(url, headers: {'Authorization': MyApi.token()});
      return response;
    } catch (e) {
      print('ERROR NETWORK MESIN HISTORY PERAWATAN: \n $e');
    }
  }

  Future reviewPerawatan(id_delegasi) async {
    try {
      var url = Uri.parse(MyApi.reviewPerawatan(id_delegasi));
      var response = await http.get(url, headers: {'Authorization': MyApi.token()});
      return response;
    } catch (e) {
      print('ERROR NETWORK REVIEW PERAWATAN: \n $e');
    }
  }
}
