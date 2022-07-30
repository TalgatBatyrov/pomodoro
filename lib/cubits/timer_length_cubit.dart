import 'package:flutter_bloc/flutter_bloc.dart';

enum TimerLengthState { red }

class TimerLength extends Cubit<TimerLengthState> {
  TimerLength() : super(TimerLengthState.red);
}
