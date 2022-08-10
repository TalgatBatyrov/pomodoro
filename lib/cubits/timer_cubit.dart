import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pomodoro/cubits/auto_resume_timer_cubit.dart';
import 'package:pomodoro/cubits/long_break_timer_length_cubit.dart';
import 'package:pomodoro/cubits/notificaton_cubit.dart';
import 'package:pomodoro/cubits/focus_timer_length_cubit.dart';
import 'package:pomodoro/cubits/short_break_timer_length_cubit.dart';
import 'package:pomodoro/cubits/timer_play_button_cubit.dart';
import 'package:pomodoro/cubits/timer_state_cubit.dart';

class TimerCubit extends Cubit<Duration> {
  final TimerStateCubit _timerStateCubit;
  final TimerPlayButtonCubit _timerPlayButtonCubit;
  final AutoResumeTimerCubit _autoResumeTimerCubit;
  final NotificationCubit _notificationCubit;
  final FocusTimerLengthCubit _focusTimerLengthCubit;
  final LongBreakTimerLengthCubit _longBreakTimerLengthCubit;
  final ShortBreakTimerLengthCubit _shortBreakTimerLengthCubit;

  late StreamSubscription _timerStateSub;
  late StreamSubscription _timerPlayButtonSub;
  late StreamSubscription _focusTimerLengthSub;
  late StreamSubscription _longBreakTimerLengthSub;
  late StreamSubscription _shortBreakTimerLengthSub;

  TimerCubit(
    this._timerStateCubit,
    this._timerPlayButtonCubit,
    this._autoResumeTimerCubit,
    this._notificationCubit,
    this._focusTimerLengthCubit,
    this._longBreakTimerLengthCubit,
    this._shortBreakTimerLengthCubit,
  ) : super(const Duration(minutes: 25)) {
    _timerStateSub = _timerStateCubit.stream.listen(_onTimerStateChanged);
    _timerPlayButtonSub =
        _timerPlayButtonCubit.stream.listen(_onTimerPlayButtonStateChanged);
    _focusTimerLengthSub =
        _focusTimerLengthCubit.stream.listen(_onFocusTimerLengthChanged);
    _longBreakTimerLengthSub = _longBreakTimerLengthCubit.stream
        .listen(_onLongBreakTimerLengthChanged);

    _shortBreakTimerLengthSub = _shortBreakTimerLengthCubit.stream
        .listen(_onShortBreakTimerLengthChanged);
  }

  void _onShortBreakTimerLengthChanged(_) {
    if (_timerStateCubit.state == TimerState.shortBreak) {
      emit(Duration(minutes: _shortBreakTimerLengthCubit.state));
    }
  }

  void _onLongBreakTimerLengthChanged(_) {
    if (_timerStateCubit.state == TimerState.longBreak) {
      emit(Duration(minutes: _longBreakTimerLengthCubit.state));
    }
  }

  void _onFocusTimerLengthChanged(_) {
    if (_timerStateCubit.state == TimerState.focus) {
      emit(Duration(minutes: _focusTimerLengthCubit.state));
    }
  }

  @override
  Future<void> close() {
    _timerStateSub.cancel();
    _timerPlayButtonSub.cancel();
    _focusTimerLengthSub.cancel();
    _longBreakTimerLengthSub.cancel();
    _shortBreakTimerLengthSub.cancel();
    return super.close();
  }

  late Timer? _lastTimer;

  void _onTimerStateChanged(TimerState event) {
    if (event == TimerState.focus) {
      _timerPlayButtonCubit.setPause();
      if (_autoResumeTimerCubit.state == AutoResumeState.enable) {
        _timerPlayButtonCubit.setPlay();
      }
      emit(Duration(minutes: _focusTimerLengthCubit.state));
      return;
    }
    if (event == TimerState.longBreak) {
      _timerPlayButtonCubit.setPause();
      if (_autoResumeTimerCubit.state == AutoResumeState.enable) {
        _timerPlayButtonCubit.setPlay();
      }
      emit(Duration(minutes: _longBreakTimerLengthCubit.state));
      return;
    }
    if (event == TimerState.shortBreak) {
      _timerPlayButtonCubit.setPause();
      if (_autoResumeTimerCubit.state == AutoResumeState.enable) {
        _timerPlayButtonCubit.setPlay();
      }
      emit(Duration(minutes: _shortBreakTimerLengthCubit.state));
      return;
    }
  }

  void _onTimerPlayButtonStateChanged(TimerPlayButtonState event) {
    if (event == TimerPlayButtonState.play) {
      _lastTimer = Timer.periodic(
        const Duration(seconds: 1),
        (timer) {
          if (state > const Duration(seconds: 0)) {
            final current = state - const Duration(seconds: 1);
            emit(current);

            final isFinished = current.inSeconds == 0;
            if (isFinished) {
              if (_notificationCubit.state == NotificationState.enable) {
                final player = AudioPlayer();
                const alarmAudioPath = "flutter_meloboom.mp3";
                player.play(AssetSource(alarmAudioPath));
              }
              if (_timerStateCubit.state == TimerState.focus) {
                emit(Duration(minutes: _focusTimerLengthCubit.state));
              }
              if (_timerStateCubit.state == TimerState.longBreak) {
                emit(Duration(minutes: _longBreakTimerLengthCubit.state));
              }
              if (_timerStateCubit.state == TimerState.shortBreak) {
                emit(Duration(minutes: _shortBreakTimerLengthCubit.state));
              }

              _timerPlayButtonCubit.setPause();
              timer.cancel();
              if (_autoResumeTimerCubit.state == AutoResumeState.enable) {
                _timerStateCubit.nextPage();
              }
            }
          } else {
            _timerPlayButtonCubit.setPause();
          }
        },
      );
    }
    if (event == TimerPlayButtonState.pause) {
      _lastTimer?.cancel();
    }
  }
}
