import 'package:equatable/equatable.dart';

class CheckPoint extends Equatable {
  final String label;

  final String time;

  const CheckPoint(this.label, this.time);

  @override
  List<Object?> get props => [label, time];
}
