import 'package:equatable/equatable.dart';

abstract class CurrentSessionEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class CurrentSessionClockInRequest extends CurrentSessionEvent {}

class CurrentSessionTickRequest extends CurrentSessionEvent {}

class CurrentSessionBreakRequest extends CurrentSessionEvent {}

class CurrentSessionResumeRequest extends CurrentSessionEvent {}

class CurrentSessionClockOutRequest extends CurrentSessionEvent {}
