import 'package:equatable/equatable.dart';

class Wind extends Equatable {
  const Wind({
    required this.speed,
    required this.deg,
    required this.gust,
  });

  final double? speed;
  final int? deg;
  final double? gust;

  factory Wind.fromJson(Map<String, dynamic> json) {
    return Wind(
      speed: json["speed"],
      deg: json["deg"],
      gust: json["gust"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        "speed": speed,
        "deg": deg,
        "gust": gust,
      };

  @override
  String toString() {
    return "$speed, $deg, $gust, ";
  }

  @override
  List<Object?> get props => [
        speed,
        deg,
        gust,
      ];
}
