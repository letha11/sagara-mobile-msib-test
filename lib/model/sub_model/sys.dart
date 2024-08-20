import 'package:equatable/equatable.dart';

class Sys extends Equatable {
  const Sys({
    required this.pod,
  });

  final String? pod;

  factory Sys.fromJson(Map<String, dynamic> json) {
    return Sys(
      pod: json["pod"],
    );
  }

  Map<String, dynamic> toJson() => {
        "pod": pod,
      };

  @override
  String toString() {
    return "$pod, ";
  }

  @override
  List<Object?> get props => [
        pod,
      ];
}

