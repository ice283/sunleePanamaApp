import 'dart:convert';

class DetailClientData {
  late List<Balance> document = [];
  late int facs;
  int facsPending = 0;
  late double total;
  late double pagos;
  late double pendientes;

  DetailClientData.fromJsonList(List<dynamic> json) {
    if (json == null) return;
    for (final item in json) {
      final balance = Balance.fromJson(item);
      document.add(balance);
      if (balance.pending > 0) {
        facsPending++;
      }
    }
  }
}

class Balance {
  Balance({
    required this.idCredit,
    required this.clientName,
    required this.docDate,
    required this.idClient,
    required this.clientCreditDays,
    required this.idDocument,
    required this.numDocument,
    required this.total,
    required this.pay,
    required this.pending,
    required this.lastPay,
    required this.since,
    required this.dayLastDate,
    required this.overCredit,
  });

  String idCredit;
  String clientName;
  DateTime docDate;
  String idClient;
  int clientCreditDays;
  String idDocument;
  int numDocument;
  double total;
  double pay;
  double pending;
  DateTime lastPay;
  int since;
  int dayLastDate;
  int overCredit;

  factory Balance.fromJson(Map<String, dynamic> json) => Balance(
        idCredit: json["id_credit"] == null ? '' : json["id_credit"].toString(),
        clientName:
            json["id_credit"] == null ? '' : json["client_name"].toString(),
        docDate: DateTime.parse(json["doc_date"]),
        idClient: json["id_client"] == null ? '' : json["id_client"].toString(),
        clientCreditDays:
            json["id_credit"] == null ? 0 : json["client_credit_days"],
        idDocument:
            json["id_document"] == null ? '' : json["id_document"].toString(),
        numDocument: json["num_document"] == null ? 0 : json["num_document"],
        total: json["total"] == null ? 0 : json["total"].toDouble(),
        pay: json["pay"] == null ? 0 : json["pay"].toDouble(),
        pending: json["pending"] == null ? 0 : json["pending"].toDouble(),
        lastPay: json["last_pay"] == null
            ? DateTime.parse(json["doc_date"])
            : DateTime.parse(json["last_pay"]),
        since: json["dias"] == null ? 0 : json["dias"],
        dayLastDate: json["dias_last_pay"] == null ? 0 : json["dias_last_pay"],
        overCredit: json["overcredit"] == null ? 0 : json["overcredit"],
      );

  Map<String, dynamic> toJson() => {
        "id_credit": idCredit,
        "client_name": clientName,
        "doc_date": docDate.toIso8601String(),
        "id_client": idClient,
        "client_credit_days": clientCreditDays,
        "id_document": idDocument,
        "num_document": numDocument,
        "total": total,
        "pay": pay,
        "pending": pending,
        "last_pay": lastPay.toIso8601String(),
        "dias": since,
        "dias_last_pay": dayLastDate,
        "overcredit": overCredit,
      };
}
