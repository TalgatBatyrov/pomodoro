import 'package:flutter_bloc/flutter_bloc.dart';

class LongBreakTimerLengthCubit extends Cubit<int> {
  LongBreakTimerLengthCubit() : super(15);

  void longBreakTimerLengthChanged(int value) {
    emit(value);
  }
}
