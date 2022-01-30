// To parse this JSON data, do
//
//     final datamodal = datamodalFromJson(jsonString);

import 'dart:convert';

Datamodal datamodalFromJson(String str) => Datamodal.fromJson(json.decode(str));

String datamodalToJson(Datamodal data) => json.encode(data.toJson());

class Datamodal {
  Datamodal({
    this.data,
    this.msg,
    this.success,
    this.errorCode,
  });

  List<Datum>? data;
  String? msg;
  String? success;
  String? errorCode;

  factory Datamodal.fromJson(Map<String, dynamic> json) => Datamodal(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        msg: json["msg"],
        success: json["success"],
        errorCode: json["error_code"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
        "msg": msg,
        "success": success,
        "error_code": errorCode,
      };
}

class Datum {
  Datum({
    this.id,
    this.name,
    this.color,
  });

  String? id;
  String? name;
  String? color;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
        color: json["color"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "color": color,
      };
}
