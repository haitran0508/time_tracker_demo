import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:time_tracker_demo/src/presentation/bloc/authentication/authentication_bloc.dart';

import '../../../config/constants.dart';
import '../bloc/current_session/current_session_bloc.dart';
import '../bloc/current_session/current_session_event.dart';
import '../bloc/current_session/current_session_state.dart';
import '../widget/rounded_button.dart';
import '../widget/time_bage.dart';

import '../../../config/dependencies_container.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late final CurrentSessionBloc _currentSessionBloc;
  late final AuthenticationBloc _authBloc;

  @override
  void initState() {
    super.initState();

    _currentSessionBloc = getIt.get<CurrentSessionBloc>();
    _authBloc = getIt.get<AuthenticationBloc>();
  }

  @override
  Widget build(BuildContext context) {
    const double buttonsSpace = 10;
    const double buttonSize = 120;

    return Scaffold(
      body: Row(
        children: [
          SizedBox(
            width: 240,
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  const SizedBox(height: 100),
                  Text(
                    DateFormat.yMMMMEEEEd().format(DateTime.now()),
                  ),
                  const SizedBox(height: 30),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(40.0),
                    child: Image.asset(
                      'assets/images/profile.png',
                      height: 80,
                      width: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const Spacer(),
                  RoundedButton(
                    label: Texts.signOut,
                    color: Colors.blue,
                    size: const Size(100, 50),
                    onPressed: () {
                      _authBloc.signOut();
                      Navigator.of(context).pop();
                    },
                  )
                ],
              ),
            ),
          ),
          const VerticalDivider(
            color: Colors.grey,
            thickness: 3,
            width: 3,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  const SizedBox(height: 60),
                  BlocBuilder<CurrentSessionBloc, CurrentSessionState>(
                    bloc: _currentSessionBloc,
                    builder: (context, state) {
                      if (state is! CurrentSessionRunning) {
                        return const TimeBage(
                          size: 140,
                          time: '00:00:00',
                          color: Colors.grey,
                        );
                      }

                      final isOnBrake = state.isOnBreak;

                      return TimeBage(
                        size: 140,
                        time: state.time,
                        color: isOnBrake ? Colors.orange : Colors.green,
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: BlocBuilder<CurrentSessionBloc, CurrentSessionState>(
                      bloc: _currentSessionBloc,
                      builder: (context, state) {
                        return ListView.separated(
                          itemCount: state.checkPoints.length,
                          separatorBuilder: (BuildContext context, int index) => const Divider(
                            height: 1,
                            thickness: 1,
                            color: Colors.grey,
                          ),
                          itemBuilder: (BuildContext context, int index) {
                            late Color textColor;
                            final checkPoint = state.checkPoints[index];
                            switch (checkPoint.label) {
                              case Texts.clockIn:
                                textColor = Colors.green;
                                break;
                              case Texts.startBreak:
                              case Texts.resume:
                                textColor = Colors.orange;
                                break;
                              case Texts.clockOut:
                                textColor = Colors.red;
                                break;
                              default:
                            }

                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Row(
                                children: [
                                  Text(state.checkPoints[index].label, style: TextStyle(color: textColor)),
                                  const Spacer(),
                                  Text(state.checkPoints[index].time),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 120,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: BlocBuilder<CurrentSessionBloc, CurrentSessionState>(
                            bloc: _currentSessionBloc,
                            builder: (context, state) {
                              if (state is CurrentSessionStandBy) {
                                return RoundedButton(
                                  size: const Size.square(buttonSize),
                                  label: Texts.clockIn,
                                  color: Colors.green,
                                  onPressed: () {
                                    _currentSessionBloc.add(CurrentSessionClockInRequest());
                                  },
                                );
                              }

                              return RoundedButton(
                                size: const Size.square(buttonSize),
                                label: Texts.clockIn,
                                color: Colors.green,
                              );
                            },
                          ),
                        ),
                        const SizedBox(width: buttonsSpace),
                        Flexible(
                          child: BlocBuilder<CurrentSessionBloc, CurrentSessionState>(
                            bloc: _currentSessionBloc,
                            builder: (context, state) {
                              if (state is! CurrentSessionRunning) {
                                return RoundedButton(
                                  size: const Size.square(buttonSize),
                                  label: Texts.startBreak,
                                  color: Colors.orange,
                                );
                              }

                              final isOnBreak = state.isOnBreak;

                              if (isOnBreak) {
                                return RoundedButton(
                                  size: const Size.square(buttonSize),
                                  label: Texts.resume,
                                  color: Colors.orange,
                                  onPressed: () {
                                    _currentSessionBloc.add(CurrentSessionResumeRequest());
                                  },
                                );
                              }

                              return RoundedButton(
                                size: const Size.square(buttonSize),
                                label: Texts.startBreak,
                                color: Colors.orange,
                                onPressed: () {
                                  _currentSessionBloc.add(CurrentSessionBreakRequest());
                                },
                              );
                            },
                          ),
                        ),
                        const SizedBox(width: buttonsSpace),
                        Flexible(
                          child: BlocBuilder<CurrentSessionBloc, CurrentSessionState>(
                            bloc: _currentSessionBloc,
                            builder: (context, state) {
                              if (state is CurrentSessionRunning) {
                                return RoundedButton(
                                  size: const Size.square(buttonSize),
                                  label: Texts.clockOut,
                                  color: Colors.red,
                                  onPressed: () {
                                    _currentSessionBloc.add(CurrentSessionClockOutRequest());
                                  },
                                );
                              }
                              return RoundedButton(
                                size: const Size.square(buttonSize),
                                label: Texts.clockOut,
                                color: Colors.red,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
