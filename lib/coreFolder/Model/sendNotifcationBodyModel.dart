// To parse this JSON data, do
//
//     final sendNotifcationBodyModel = sendNotifcationBodyModelFromJson(jsonString);

import 'dart:convert';

SendNotifcationBodyModel sendNotifcationBodyModelFromJson(String str) =>
    SendNotifcationBodyModel.fromJson(json.decode(str));

String sendNotifcationBodyModelToJson(SendNotifcationBodyModel data) =>
    json.encode(data.toJson());

class SendNotifcationBodyModel {
  String deviceToken;
  String title;
  String body;
  String mentorId;

  SendNotifcationBodyModel({
    required this.deviceToken,
    required this.title,
    required this.body,
    required this.mentorId,
  });

  factory SendNotifcationBodyModel.fromJson(Map<String, dynamic> json) =>
      SendNotifcationBodyModel(
        deviceToken: json["device_token"],
        title: json["title"],
        body: json["body"],
        mentorId: json['mentor_id'],
      );

  Map<String, dynamic> toJson() => {
        "device_token": deviceToken,
        "title": title,
        "body": body,
        'mentor_id': mentorId
      };
}
