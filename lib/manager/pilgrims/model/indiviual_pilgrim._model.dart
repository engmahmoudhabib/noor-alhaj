// To parse this JSON data, do
//
//     final indiviualPilgrim = indiviualPilgrimFromJson(jsonString);

import 'dart:convert';

IndiviualPilgrim indiviualPilgrimFromJson(String str) => IndiviualPilgrim.fromJson(json.decode(str));

String indiviualPilgrimToJson(IndiviualPilgrim data) => json.encode(data.toJson());

class IndiviualPilgrim {
  int? id;
  String? phonenumber;
  int? guideChat;
  int? managerChat;
  String? duration;
  String? image;
  bool? active;
  Guide? guide;
  List<HajSteps>? hajSteps;
  String? lastStep;
  String? registerationId;
  String? firstName;
  String? fatherName;
  String? grandFather;
  String? lastName;
  String? birthday;
  int? flightNum;
  String? flightDate;
  String? arrival;
  String? departure;
  String? fromCity;
  String? toCity;
  String? boardingTime;
  int? gateNum;
  String? flightCompany;
  String? companyLogo;
  bool? status;
  String? hotel;
  String? hotelAddress;
  int? roomNum;
  String? created;
  int? user;

  IndiviualPilgrim(
      {this.id,
      this.phonenumber,
      this.guideChat,
      this.managerChat,
      this.duration,
      this.image,
      this.active,
      this.guide,
      this.hajSteps,
      this.lastStep,
      this.registerationId,
      this.firstName,
      this.fatherName,
      this.grandFather,
      this.lastName,
      this.birthday,
      this.flightNum,
      this.flightDate,
      this.arrival,
      this.departure,
      this.fromCity,
      this.toCity,
      this.boardingTime,
      this.gateNum,
      this.flightCompany,
      this.companyLogo,
      this.status,
      this.hotel,
      this.hotelAddress,
      this.roomNum,
      this.created,
      this.user});

  IndiviualPilgrim.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    phonenumber = json['phonenumber'];
    guideChat = json['guide_chat'];
    managerChat = json['manager_chat'];
    duration = json['duration'];
    image = json['image'];
    active = json['active'];
    guide = json['guide'] != null ? new Guide.fromJson(json['guide']) : null;
    if (json['haj_steps'] != null) {
      hajSteps = <HajSteps>[];
      json['haj_steps'].forEach((v) {
        hajSteps!.add(new HajSteps.fromJson(v));
      });
    }
    lastStep = json['last_step'];
    registerationId = json['registeration_id'];
    firstName = json['first_name'];
    fatherName = json['father_name'];
    grandFather = json['grand_father'];
    lastName = json['last_name'];
    birthday = json['birthday'];
    flightNum = json['flight_num'];
    flightDate = json['flight_date'];
    arrival = json['arrival'];
    departure = json['departure'];
    fromCity = json['from_city'];
    toCity = json['to_city'];
    boardingTime = json['boarding_time'];
    gateNum = json['gate_num'];
    flightCompany = json['flight_company'];
    companyLogo = json['company_logo'];
    status = json['status'];
    hotel = json['hotel'];
    hotelAddress = json['hotel_address'];
    roomNum = json['room_num'];
    created = json['created'];
    user = json['user'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['phonenumber'] = this.phonenumber;
    data['guide_chat'] = this.guideChat;
    data['manager_chat'] = this.managerChat;
    data['duration'] = this.duration;
    data['image'] = this.image;
    data['active'] = this.active;
    if (this.guide != null) {
      data['guide'] = this.guide!.toJson();
    }
    if (this.hajSteps != null) {
      data['haj_steps'] = this.hajSteps!.map((v) => v.toJson()).toList();
    }
    data['last_step'] = this.lastStep;
    data['registeration_id'] = this.registerationId;
    data['first_name'] = this.firstName;
    data['father_name'] = this.fatherName;
    data['grand_father'] = this.grandFather;
    data['last_name'] = this.lastName;
    data['birthday'] = this.birthday;
    data['flight_num'] = this.flightNum;
    data['flight_date'] = this.flightDate;
    data['arrival'] = this.arrival;
    data['departure'] = this.departure;
    data['from_city'] = this.fromCity;
    data['to_city'] = this.toCity;
    data['boarding_time'] = this.boardingTime;
    data['gate_num'] = this.gateNum;
    data['flight_company'] = this.flightCompany;
    data['company_logo'] = this.companyLogo;
    data['status'] = this.status;
    data['hotel'] = this.hotel;
    data['hotel_address'] = this.hotelAddress;
    data['room_num'] = this.roomNum;
    data['created'] = this.created;
    data['user'] = this.user;
    return data;
  }
}

class Guide {
  String? username;
  String? image;

  Guide({this.username, this.image});

  Guide.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['image'] = this.image;
    return data;
  }
}

class HajSteps {
  String? hajStep;
  bool? completed;

  HajSteps({this.hajStep, this.completed});

  HajSteps.fromJson(Map<String, dynamic> json) {
    hajStep = json['haj_step'];
    completed = json['completed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['haj_step'] = this.hajStep;
    data['completed'] = this.completed;
    return data;
  }
}
