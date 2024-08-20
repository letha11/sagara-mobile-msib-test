import 'package:equatable/equatable.dart';

class Rain extends Equatable {
  const Rain({
    required this.the3H,
  });

  final double? the3H;

  factory Rain.fromJson(Map<String, dynamic> json) {
    return Rain(
      the3H: json["3h"],
    );
  }

  Map<String, dynamic> toJson() => {
        "3h": the3H,
      };

  @override
  String toString() {
    return "$the3H, ";
  }

  @override
  List<Object?> get props => [
        the3H,
      ];
}

