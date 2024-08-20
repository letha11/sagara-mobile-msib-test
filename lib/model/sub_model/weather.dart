import 'package:equatable/equatable.dart';

class Weather extends Equatable {
  const Weather({
    required this.id,
    required this.main,
    required this.description,
    required this.icon,
  });

  final int? id;
  final String? main;
  final String? description;
  final String? icon;

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      id: json["id"],
      main: json["main"],
      description: json["description"],
      icon: json["icon"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "main": main,
        "description": description,
        "icon": icon,
      };

  @override
  String toString() {
    return "$id, $main, $description, $icon, ";
  }

  @override
  List<Object?> get props => [
        id,
        main,
        description,
        icon,
      ];
}

