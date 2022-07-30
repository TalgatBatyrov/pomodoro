import 'package:flutter_bloc/flutter_bloc.dart';

enum NotificationState {
  enable,
  disable,
}

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit() : super(NotificationState.disable);

  void toggleNotification() {
    if (state == NotificationState.disable) {
      emit(NotificationState.enable);
    } else {
      emit(NotificationState.disable);
    }
  }
}
