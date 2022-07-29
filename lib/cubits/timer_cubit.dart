import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pomodoro/cubits/timer_play_button_cubit.dart';
import 'package:pomodoro/cubits/timer_state_cubit.dart';

class TimerCubit extends Cubit<Duration> {
  final TimerStateCubit _timerStateCubit;
  final TimerPlayButtonCubit _timerPlayButtonCubit;

  late StreamSubscription _timerStateSub;
  late StreamSubscription _timerPlayButtonSub;

  TimerCubit(
    this._timerStateCubit,
    this._timerPlayButtonCubit,
  ) : super(const Duration(seconds: 25)) {
    _timerStateSub = _timerStateCubit.stream.listen(_onTimerStateChanged);
    _timerPlayButtonSub =
        _timerPlayButtonCubit.stream.listen(_onTimerPlayButtonStateChanged);
  }

  @override
  Future<void> close() {
    _timerStateSub.cancel();
    _timerPlayButtonSub.cancel();
    return super.close();
  }

  late Timer? _lastTimer;

  void _onTimerStateChanged(TimerState event) {
    if (event == TimerState.focus) {
      emit(const Duration(seconds: 25));
      _timerPlayButtonCubit.setPlay();
      return;
    }
    if (event == TimerState.longBreak) {
      emit(const Duration(seconds: 15));
      _timerPlayButtonCubit.setPlay();
      return;
    }
    if (event == TimerState.shortBreak) {
      emit(const Duration(seconds: 5));
      _timerPlayButtonCubit.setPlay();
      return;
    }
  }

  void _onTimerPlayButtonStateChanged(TimerPlayButtonState event) {
    if (event == TimerPlayButtonState.play) {
      _lastTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
        final current = state - const Duration(seconds: 1);
        emit(current);
        final isFinished = current.inSeconds == 0;
        if (isFinished) {
          timer.cancel();
          _timerStateCubit.nextPage();
        }
      });
    }
    if (event == TimerPlayButtonState.pause) {
      _lastTimer?.cancel();
    }
  }
}
