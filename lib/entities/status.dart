class Status {
  String status;
  String header;
  String message;

  Status(this.status, this.header, this.message);

  Status.fromJson(Map<String, dynamic> json) : this(
    json['status'],
    json['header'],
    json['message'],
  );
}