import 'package:equatable/equatable.dart';

class Clouds extends Equatable {
  const Clouds({
    required this.all,
  });

  final int? all;

  factory Clouds.fromJson(Map<String, dynamic> json) {
    return Clouds(
      all: json["all"],
    );
  }

  Map<String, dynamic> toJson() => {
        "all": all,
      };

  @override
  String toString() {
    return "$all, ";
  }

  @override
  List<Object?> get props => [
        all,
      ];
}

