class TimerModel {
  int minutes;
  int hours;
  int seconds;

  TimerModel({this.minutes = 0, this.hours = 0, this.seconds = 0});

  TimerModel copyWith(
      {required int minutes, required int hours, required int seconds}) {
    return TimerModel(
      hours: hours,
      minutes: minutes,
      seconds: seconds,
    );
  }

  @override
  String toString() {
    return '$hours:$minutes:$seconds';
  }
}
