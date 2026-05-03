class Transactionmodel {
  String? id;
  String? title;
  int? amount;
  String? note;
  String? transactiontype;

  Transactionmodel({
    this.id,
    this.title,
    this.amount,
    this.note,
    this.transactiontype,
  });

  Transactionmodel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    title = json["title"];
    amount = json["amount"];
    note = json["note"];
    transactiontype = json["transactiontype"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["title"] = title;
    data["amount"] = amount;
    data["note"] = note;
    data["transactiontype"] = transactiontype;
    return data;
  }
}