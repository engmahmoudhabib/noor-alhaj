class EndPoint {
  static String baseUrl = "http://alnoor-hajj.com/api/";
  static String logIn = "auth/login/";
  static String religousPost = "religious-posts/";
  static String guidnacePost = "guidance-posts/";
  static String indiviualReligiousPost = "religious-post/";
  static String getindiviualReligiousPost(id) {
    return "religious-post/$id";
  }

  static String indiviualGuidenacePost = "guidance-post/";
  static String getindiviualGuidnacePost(id) {
    return "guidance-post/$id";
  }

  static String pilgrimInfo = "get-pilgrim/";
  static String getPilgrimInfo(pilgremId) {
    return "get-pilgrim/$pilgremId";
  }

  static String listSteps = "list-steps/";
  static String prayerTime = "prayers-timings/";
}

class ApiKeys {
  static String auth = "Authorization";

  static String username = "username";
  static String password = "password";
  static String deviceId = "device_token";
  static String longitude = "longitude";
  static String latitude = "latitude";
  static String day = "day";
  static String month = "month";
  static String year = "year";

  static String phonenumber = "phonenumber";
  static String firstname = "first_name";
  static String fathername = "father_name";
  static String grandfather = "grand_father";
  static String lastname = "last_name";
  static String idnumber = "id_number";
  static String birthday = "birthday";
  static String jobposition = "job_position";
  static String gender = "gender";
  static String optionstrip = "options_trip";
  static String maritalstatus = "marital_status";
  static String address = "address";
  static String alhajj = "alhajj";
  static String traditionreference = "tradition_reference";
  static String counthajjas = "count_hajjas";
  static String lastyear = "last_year";
  static String meansjourney = "means_journey";
  static String bloodtype = "blood_type";
  static String illness = "illness";
  static String chronicdiseases = "chronic_diseases";
  static String tawaf = "tawaf";
  static String sai = "sai";
  static String wheelchair = "wheelchair";
  static String typehelp = "type_help";
}
