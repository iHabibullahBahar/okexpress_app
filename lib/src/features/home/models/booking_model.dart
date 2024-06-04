class BookingModel {
  int? totalpage;
  int? currentpage;
  List<Data>? data;

  BookingModel({this.totalpage, this.currentpage, this.data});

  BookingModel.fromJson(Map<String, dynamic> json) {
    totalpage = json['totalpage'];
    currentpage = json['currentpage'];
    if (json['data'] != null) {
      data = <Data>[];
      try {
        json['data'].forEach((v) {
          data!.add(new Data.fromJson(v));
        });
      } catch (e) {
        print('Error in BookingModel.fromJson: $e');
      }
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalpage'] = this.totalpage;
    data['currentpage'] = this.currentpage;
    if (this.data != null) {
      try {
        data['data'] = this.data!.map((v) => v.toJson()).toList();
      } catch (e) {
        print('Error in BookingModel data: $e');
      }
    }
    return data;
  }
}

class Data {
  int? id;
  String? slug;
  int? isLocationInside;
  Service? service;
  VehicleType? vehicleType;
  String? status;
  String? createdDatetime;
  String? assignedDatetime;
  String? pickedDatetime;
  String? deliveredDatetime;
  String? refundedDatetime;

  Data(
      {this.id,
      this.slug,
      this.isLocationInside,
      this.service,
      this.vehicleType,
      this.status,
      this.createdDatetime,
      this.assignedDatetime,
      this.pickedDatetime,
      this.deliveredDatetime,
      this.refundedDatetime});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    slug = json['slug'];
    isLocationInside = json['isLocationInside'];
    service =
        json['service'] != null ? new Service.fromJson(json['service']) : null;
    vehicleType = json['vehicleType'] != null
        ? new VehicleType.fromJson(json['vehicleType'])
        : null;
    status = json['status'];
    createdDatetime = json['createdDatetime'];
    assignedDatetime = json['assignedDatetime'];
    pickedDatetime = json['pickedDatetime'];
    deliveredDatetime = json['deliveredDatetime'];
    refundedDatetime = json['refundedDatetime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['slug'] = this.slug;
    data['isLocationInside'] = this.isLocationInside;
    if (this.service != null) {
      data['service'] = this.service!.toJson();
    }
    if (this.vehicleType != null) {
      data['vehicleType'] = this.vehicleType!.toJson();
    }
    data['status'] = this.status;
    data['createdDatetime'] = this.createdDatetime;
    data['assignedDatetime'] = this.assignedDatetime;
    data['pickedDatetime'] = this.pickedDatetime;
    data['deliveredDatetime'] = this.deliveredDatetime;
    data['refundedDatetime'] = this.refundedDatetime;
    return data;
  }
}

class Service {
  int? id;
  String? type;
  String? flatCost;
  String? description;
  String? rate;

  Service({this.id, this.type, this.flatCost, this.description, this.rate});

  Service.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    flatCost = json['flatCost'];
    description = json['description'];
    rate = json['rate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['flatCost'] = this.flatCost;
    data['description'] = this.description;
    data['rate'] = this.rate;
    return data;
  }
}

class VehicleType {
  int? id;
  String? type;
  String? rateInside;
  String? rateOutside;
  String? flatCostInside;
  String? flatCostOutside;

  VehicleType(
      {this.id,
      this.type,
      this.rateInside,
      this.rateOutside,
      this.flatCostInside,
      this.flatCostOutside});

  VehicleType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    rateInside = json['rateInside'];
    rateOutside = json['rateOutside'];
    flatCostInside = json['flatCostInside'];
    flatCostOutside = json['flatCostOutside'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['rateInside'] = this.rateInside;
    data['rateOutside'] = this.rateOutside;
    data['flatCostInside'] = this.flatCostInside;
    data['flatCostOutside'] = this.flatCostOutside;
    return data;
  }
}
