String baseUrl = "https://satu.sipatex.co.id:2087";
class MyApi {
  static token(){
    return "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjoxLCJuYW1hIjoicm9vdCIsImVtYWlsIjoicm9vdEBsb2NhbGhvc3QifSwiaWF0IjoxNTkyMjM1MzE2fQ.KHYQ0M1vcLGSjJZF-zvTM5V44hM0B8TqlTD0Uwdh9rY";
    
  }
  static login(){
    return "https://api2.sipatex.co.id:2096/imap-auth";
  }
  static getTaskPerbaikanPerawatan(email){
    return "$baseUrl/api/v1/mobile-app/mt/task-list?email=${email}";
  }
}