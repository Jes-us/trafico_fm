import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trafico_fm/models/timer_model/timer_model.dart';

class TimerViewModel extends Cubit<TimerModel> {
  TimerViewModel() : super(TimerModel(seconds: 0, minutes: 0, hours: 0));

  Timer? _timer;

  get timer => _timer;

  void startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (state.seconds > 0 || state.minutes > 0 || state.hours > 0) {
        emit(state.copyWith(
            seconds: state.seconds == 0 ? 59 : state.seconds - 1,
            minutes:
                state.seconds == 0 && state.hours >= 0 && state.minutes >= 0
                    ? state.minutes - 1
                    : state.minutes == 0
                        ? 59
                        : state.minutes,
            hours: state.minutes == 0 && (state.hours > 0 && state.seconds == 0)
                ? state.hours - 1
                : state.hours));
      } else {
        _timer?.cancel();
      }
    });
  }

  void pauseTimer() {
    _timer?.cancel();
  }

  void resetTimer(int seconds, int minutes, int hours) {
    _timer?.cancel();
    emit(state.copyWith(seconds: seconds, minutes: minutes, hours: hours));
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
