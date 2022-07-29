import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pomodoro/cubits/auto_resume_timer_cubit.dart';
import 'package:pomodoro/cubits/timer_play_button_cubit.dart';
import 'package:pomodoro/cubits/timer_state_cubit.dart';

class TimerCubit extends Cubit<Duration> {
  final TimerStateCubit _timerStateCubit;
  final TimerPlayButtonCubit _timerPlayButtonCubit;
  final AutoResumeTimerCubit _autoResumeTimerCubit;

  late StreamSubscription _timerStateSub;
  late StreamSubscription _timerPlayButtonSub;

  TimerCubit(
    this._timerStateCubit,
    this._timerPlayButtonCubit,
    this._autoResumeTimerCubit,
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
      if (_autoResumeTimerCubit.state == AutoResumeState.enable) {
        _timerPlayButtonCubit.setPlay();
      }
      emit(const Duration(seconds: 25));
      return;
    }
    if (event == TimerState.longBreak) {
      if (_autoResumeTimerCubit.state == AutoResumeState.enable) {
        _timerPlayButtonCubit.setPlay();
      }
      emit(const Duration(seconds: 15));
      return;
    }
    if (event == TimerState.shortBreak) {
      if (_autoResumeTimerCubit.state == AutoResumeState.enable) {
        _timerPlayButtonCubit.setPlay();
      }
      emit(const Duration(seconds: 5));
      return;
    }
  }

  void _onTimerPlayButtonStateChanged(TimerPlayButtonState event) {
    if (event == TimerPlayButtonState.play) {
      _lastTimer = Timer.periodic(
        const Duration(seconds: 1),
        (timer) {
          final current = state - const Duration(seconds: 1);
          emit(current);
          final isFinished = current.inSeconds == 0;
          if (isFinished) {
            timer.cancel();
            _timerPlayButtonCubit.setPause();
            if (_autoResumeTimerCubit.state == AutoResumeState.enable) {
              _timerStateCubit.nextPage();
            }
          }
        },
      );
    }
    if (event == TimerPlayButtonState.pause) {
      _lastTimer?.cancel();
    }
  }
}
