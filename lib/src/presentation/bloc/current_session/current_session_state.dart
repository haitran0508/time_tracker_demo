import 'package:equatable/equatable.dart';
import '../../../domain/entity/checkpoint.dart';

abstract class CurrentSessionState extends Equatable {
  final List<CheckPoint> checkPoints;

  const CurrentSessionState(this.checkPoints);

  @override
  List<Object?> get props => [checkPoints];
}

class CurrentSessionRunning extends CurrentSessionState {
  final String time;

  final bool isOnBreak;

  const CurrentSessionRunning(this.time, List<CheckPoint> checkPoints, this.isOnBreak) : super(checkPoints);

  @override
  List<Object?> get props => [time, checkPoints, isOnBreak];
}

class CurrentSessionStandBy extends CurrentSessionState {
  const CurrentSessionStandBy(super.checkPoints);

  @override
  List<Object?> get props => [checkPoints];
}
