import 'dart:convert';

Client clientFromJson(String str) => Client.fromJson(json.decode(str));

String clientToJson(Client data) => json.encode(data.toJson());

class Client {
  Client({
    required this.idClient,
    required this.codeClient,
    required this.clientName,
    required this.clientRuc,
    required this.clientDv,
    required this.clientMail,
    required this.clientPhotoUrl,
    required this.clientAddress,
    required this.createdAt,
    required this.updatedAt,
    required this.token,
    required this.contactName,
    required this.clientStatus,
    required this.lastlogin,
    required this.clientCreditDays,
    required this.topSale,
    required this.active,
    required this.appClient,
    required this.password,
  });

  final String idClient;
  final String codeClient;
  final String clientName;
  final String clientRuc;
  final String clientDv;
  final String clientMail;
  final String clientPhotoUrl;
  final dynamic clientAddress;
  final DateTime createdAt;
  final DateTime updatedAt;
  final dynamic token;
  final String contactName;
  final String clientStatus;
  final String lastlogin;
  final String clientCreditDays;
  final DateTime topSale;
  final String active;
  final String appClient;
  final String password;

  factory Client.fromJson(Map<String, dynamic> json) => Client(
        idClient: json["id_client"] == null ? '' : json["id_client"],
        codeClient: json["code_client"] == null ? '' : json["code_client"],
        clientName: json["client_name"] == null ? '' : json["client_name"],
        clientRuc: json["client_RUC"] == null ? '' : json["client_RUC"],
        clientDv: json["client_DV"] == null ? '' : json["client_DV"],
        clientMail: json["client_mail"] == null ? '' : json["client_mail"],
        clientPhotoUrl:
            json["client_photo_url"] == null ? '' : json["client_photo_url"],
        clientAddress: json["client_address"],
        createdAt: json["created_at"] == null
            ? DateTime.parse('0000-00-00 00:00:00')
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? DateTime.parse('0000-00-00 00:00:00')
            : DateTime.parse(json["updated_at"]),
        token: json["token"],
        contactName: json["contact_name"] == null ? '' : json["contact_name"],
        clientStatus:
            json["client_status"] == null ? '' : json["client_status"],
        lastlogin: json["lastlogin"] == null ? '' : json["lastlogin"],
        clientCreditDays: json["client_credit_days"] == null
            ? ''
            : json["client_credit_days"],
        topSale: json["top_sale"] == null
            ? DateTime.parse('0000-00-00 00:00:00')
            : DateTime.parse(json["top_sale"]),
        active: json["active"] == null ? '' : json["active"],
        appClient: json["app_client"] == null ? '' : json["app_client"],
        password: json["password"] == null ? '' : json["password"],
      );

  Map<String, dynamic> toJson() => {
        "id_client": idClient,
        "code_client": codeClient,
        "client_name": clientName,
        "client_RUC": clientRuc,
        "client_DV": clientDv,
        "client_mail": clientMail,
        "client_photo_url": clientPhotoUrl,
        "client_address": clientAddress,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "token": token,
        "contact_name": contactName,
        "client_status": clientStatus,
        "lastlogin": lastlogin,
        "client_credit_days": clientCreditDays,
        "top_sale": topSale.toIso8601String(),
        "active": active,
        "app_client": appClient,
        "password": password,
      };
}
