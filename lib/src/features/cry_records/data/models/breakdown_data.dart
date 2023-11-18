class BreakdownData {
  double value;
  DateTime from;
  DateTime to;

  BreakdownData({
    required this.value,
    required this.from,
    required this.to,
  });

  factory BreakdownData.fromJson(Map<String, dynamic> json) => BreakdownData(
    value: json["value"]?.toDouble(),
    from: DateTime.parse(json["from"]),
    to: DateTime.parse(json["to"]),
  );

  Map<String, dynamic> toJson() => {
    "value": value,
    "from": from.toIso8601String(),
    "to": to.toIso8601String(),
  };
}
