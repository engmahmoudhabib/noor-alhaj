class EndPoint {
  static String baseUrl = "http://alnoor-hajj.com/api/";
  static String logIn = "auth/login/";
  static String listTask = "list-tasks/";
  static String acceptTask(taskId) {
    return "accept-task/$taskId/";
  }

  static String completeTask(taskId) {
    return "complete-task/$taskId/";
  }
}

class ApiKeys {
  static String auth = "Authorization";
  static String username = "username";
  static String password = "password";
  static String deviceId = "device_token";
  static String accepted = "accepted";
  static String completed = "completed";
}
