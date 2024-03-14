import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../config/constants.dart';
import '../../../domain/entity/checkpoint.dart';
import 'current_session_event.dart';
import 'current_session_state.dart';

class CurrentSessionBloc extends Bloc<CurrentSessionEvent, CurrentSessionState> {
  final List<CheckPoint> _checkPoints = [];

  bool _isOnBreak = false;

  late DateTime _start;

  late Timer timer;

  CurrentSessionBloc() : super(const CurrentSessionStandBy([])) {
    on<CurrentSessionClockInRequest>((event, emit) async {
      _start = DateTime.now();

      _checkPoints.add(CheckPoint(Texts.clockIn, _formatTimetoHM(_start)));

      emit(CurrentSessionRunning('00:00:00', _checkPoints, _isOnBreak));

      timer = Timer.periodic(const Duration(seconds: 1), (Timer _) {
        add(CurrentSessionTickRequest());
      });
    });

    on<CurrentSessionTickRequest>((event, emit) {
      final time = _formatDuration(DateTime.now().difference(_start));
      emit(CurrentSessionRunning(time, _checkPoints, _isOnBreak));
    });

    on<CurrentSessionBreakRequest>((event, emit) {
      _isOnBreak = true;
      _checkPoints.add(CheckPoint(Texts.startBreak, _formatTimetoHM(DateTime.now())));
    });

    on<CurrentSessionResumeRequest>((event, emit) {
      _isOnBreak = false;
      _checkPoints.add(CheckPoint(Texts.resume, _formatTimetoHM(DateTime.now())));
    });

    on<CurrentSessionClockOutRequest>((event, emit) {
      _isOnBreak = false;
      _checkPoints.add(CheckPoint(Texts.clockOut, _formatTimetoHM(DateTime.now())));
      timer.cancel();
      emit(CurrentSessionStandBy(_checkPoints));
    });
  }

  String _formatDuration(Duration duration) {
    String negativeSign = duration.isNegative ? '-' : '';
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60).abs());
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60).abs());
    return "$negativeSign${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  String _formatTimetoHM(DateTime dateTime) {
    return DateFormat.Hm().format(dateTime);
  }
}
