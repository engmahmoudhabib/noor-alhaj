class EndPoint {
  static String baseUrl = "http://85.31.237.33/test/api/";
  static String logIn = "auth/login/";
  static String listEmployee = "list-employees";
  static String listPilgrims = "list-pilgrims";
  static String addTask(empId) {
    return "send-task/$empId/";
  }

  static String addNotification = "send-notification/";
  static String addEmployee = "create-employee/";
  static String getEmployee(empId) {
    return "get-employee/$empId";
  }

  static String listNotification = "list-notifications/";
  static String oneEmppoyee = "get-employee/";
  static String updateEmployee(id) {
    return "update-employee/$id/";
  }

  static String getPilgrim(id) {
    return "get-pilgrim/$id";
  }

  static String createPilgrim = "create-pilgrim/";
  static String listGuides = "list-guides/";
  static String updatePilgrim(id) {
    return "update-pilgrim/$id/";
  }
}

class ApiKeys {
  static String auth = "Authorization";
  static String username = "username";
  static String password = "password";
  static String deviceId = "device_token";
  static String title = "title";
  static String content = "content";
  static String email = "email";
  static String phonenumber = "phonenumber";
  static String firstName = "first_name";
  static String fatherName = "father_name";
  static String grandFather = "grand_father";
  static String family = "last_name";
  static String date = "birthday";
  static String ticket = "registeration_id";
  static String guide = "guide";
  static String boadringTime = "boarding_time";
  static String filghtNum = "flight_num";
  static String flightDate = "flight_date";
  static String flightCompany = "flight_company";
  static String gateNum = "gate_num";
  static String arrive = "arrival";
  static String departure = "departure";
  static String status = "status";
  static String hotelAddress = "hotel_address";
  static String hotel = "hotel";
  static String roomNum = "room_num";
  static String fromCity = "from_city";
  static String toCity = "to_city";
  static String logo = "company_logo";
}
