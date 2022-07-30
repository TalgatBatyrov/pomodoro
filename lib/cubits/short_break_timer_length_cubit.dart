import 'package:flutter_bloc/flutter_bloc.dart';

class ShortBreakTimerLengthCubit extends Cubit<int> {
  ShortBreakTimerLengthCubit() : super(5);

  void shortBreakTimerLengthChanged(int value) {
    emit(value);
  }
}
