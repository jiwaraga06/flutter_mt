String baseUrl = "https://satu.sipatex.co.id:2087";

class MyApi {
  static token() {
    return "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjoxLCJuYW1hIjoicm9vdCIsImVtYWlsIjoicm9vdEBsb2NhbGhvc3QifSwiaWF0IjoxNTkyMjM1MzE2fQ.KHYQ0M1vcLGSjJZF-zvTM5V44hM0B8TqlTD0Uwdh9rY";
  }

  static login() {
    return "https://api2.sipatex.co.id:2096/imap-auth";
  }

  static getTaskPerbaikanPerawatan(email) {
    return "$baseUrl/api/v1/mobile-app/mt/task-list?email=${email}";
  }

  static getTreeView(id_perbaikan) {
    return "$baseUrl/api/v1/mobile-app/mt/struktur-mesin?id=${id_perbaikan}";
  }
  static getMaterial(id_perbaikan){
    return "$baseUrl/api/v1/mobile-app/mt/material-mesin?id_mesin=${id_perbaikan}";
  }
  static getKetMesin(id_mesin){
    return "$baseUrl/api/v1/mobile-app/mt/mesin?id_mesin=${id_mesin}";
  }

  // PERBAIKAN
  static postPerbaikan(){
    return "$baseUrl/api/v1/mobile-app/mt/penanganan-perbaikan";
  }
  static riwayat_perbaikan(email,page,per_page){
    return "$baseUrl/api/v1/mobile-app/mt/history-perbaikan?email=${email}&page=$page&per_page=$per_page";
  }
  static mesin_history_perbaikan(id_mesin,page,per_page){
    return "$baseUrl/api/v1/mobile-app/mt/mesin-history-perbaikan?id_mesin=2021030733&page=1&per_page=5";
  }
  // update perbaikan
  static show_perbaikan(id_delegasi){
    return "$baseUrl/api/v1/mobile-app/mt/show-perbaikan?id_delegasi=${id_delegasi}";
  }
  // PERAWATAN
  static detail_task_perawatan(id_delegasi){
    return "$baseUrl/api/v1/mobile-app/mt/detail-task-perawatan?id_delegasi=$id_delegasi";
  }
  static postPerawatan(){
    return "$baseUrl/api/v1/mobile-app/mt/penanganan-perawatan";
  }
  static reviewPerawatan(id_delegasi){
    return "$baseUrl/api/v1/mobile-app/mt/review-perawatan?id_delegasi=$id_delegasi";
  }
  static showPerawatan(id_delegasi){
    return "$baseUrl/api/v1/mobile-app/mt/show-perawatan?id_delegasi=$id_delegasi";
  }
}
