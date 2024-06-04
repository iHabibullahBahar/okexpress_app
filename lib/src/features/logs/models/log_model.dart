class LogModel {
  int? totalpage;
  int? currentpage;
  int? itemsperpage;
  int? totallogs;
  List<Data>? data;

  LogModel(
      {this.totalpage,
      this.currentpage,
      this.itemsperpage,
      this.totallogs,
      this.data});

  LogModel.fromJson(Map<String, dynamic> json) {
    totalpage = json['totalpage'];
    currentpage = json['currentpage'];
    itemsperpage = json['itemsperpage'];
    totallogs = json['totallogs'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalpage'] = this.totalpage;
    data['currentpage'] = this.currentpage;
    data['itemsperpage'] = this.itemsperpage;
    data['totallogs'] = this.totallogs;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  String? message;
  String? referenceNo;
  String? logLevel;
  String? createdDate;

  Data(
      {this.id,
      this.message,
      this.referenceNo,
      this.logLevel,
      this.createdDate});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    message = json['message'];
    referenceNo = json['referenceNo'];
    logLevel = json['logLevel'];
    createdDate = json['createdDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['message'] = this.message;
    data['referenceNo'] = this.referenceNo;
    data['logLevel'] = this.logLevel;
    data['createdDate'] = this.createdDate;
    return data;
  }
}
