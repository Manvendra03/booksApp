class LeadInfo {
  final String type;
  final String createdOn;
  final String totalAppts;
  final String completedAppts;
  final String id;
  final String email;
  final String notary_id;
  final String name;
  final String companyName;
  final String phoneNumber;

  LeadInfo({
    required this.type,
    required this.createdOn,
    required this.totalAppts,
    required this.completedAppts,
    required this.id,
    required this.email,
    required this.notary_id,
    required this.name,
    required this.companyName,
    required this.phoneNumber,
  });

  factory LeadInfo.fromJson(Map<String, dynamic> json) {
    return LeadInfo(
      type: json["type"].toString(),
      createdOn: json["createdOn"].toString(),
      totalAppts: json["totalAppts"].toString(),
      completedAppts: json["completedAppts"].toString(),
      id: json["_id"].toString(),
      email: json["email"].toString(),
      notary_id: json["notaryId"].toString(),
      name: json["name"].toString(),
      companyName: json["companyName"].toString(),
      phoneNumber: json["PhoneNumber"].toString(),
    );
  }
}
