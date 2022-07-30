import 'package:flutter_bloc/flutter_bloc.dart';

class FocusTimerLengthCubit extends Cubit<int> {
  FocusTimerLengthCubit() : super(25);

  void focusTimerLengthChanged(int value) {
    emit(value);
  }
}
