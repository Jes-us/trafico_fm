import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trafico_fm/models/timer_model/timer_model.dart';
import 'package:trafico_fm/view_models/timer_view_model/timer_view_model.dart';

class TimerView extends StatelessWidget {
  TextStyle textStyle = TextStyle(
      fontSize: 58,
      fontWeight: FontWeight.bold,
      backgroundColor: Colors.black,
      color: Colors.amber);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('tit'),
      ),
      body: BlocBuilder<TimerViewModel, TimerModel>(
        builder: (context, timerModel) {
          return Column(
            children: [
              Center(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ChrnometerNumber(
                          text: timerModel.hours.toString(),
                          textStyle: textStyle),
                      ChrnometerNumber(
                          text: timerModel.minutes.toString(),
                          textStyle: textStyle),
                      ChrnometerNumber(
                          text: timerModel.seconds.toString(),
                          textStyle: textStyle),
                    ]),
              ),
              TimerSetter(),
            ],
          );
        },
      ),
    );
  }
}

class TimerSetter extends StatefulWidget {
  @override
  _TimerSetterState createState() => _TimerSetterState();
}

class _TimerSetterState extends State<TimerSetter> {
  int hours = 1;
  int minutes = 1;
  int seconds = 1;

  dynamic items1 = List.generate(24, (index) => index + 1)
      .map((hour) => DropdownMenuItem<int>(
            value: hour,
            child: Text(hour.toString()),
          ))
      .toList();

  dynamic items2 = List.generate(60, (index) => index)
      .map((minute) => DropdownMenuItem<int>(
            value: minute,
            child: Text(minute.toString()),
          ))
      .toList();

  dynamic items3 = List.generate(60, (index) => index)
      .map((second) => DropdownMenuItem<int>(
            value: second,
            child: Text(second.toString()),
          ))
      .toList();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Set Timer', style: TextStyle(fontSize: 24)),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Hours:'),
            SizedBox(width: 10),
            DropdownButton<int>(
              value: hours,
              onChanged: (value) {
                setState(() {
                  hours = value!;
                });
              },
              items: items1,
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Minutes:'),
            SizedBox(width: 10),
            DropdownButton<int>(
              value: minutes,
              onChanged: (value) {
                setState(() {
                  minutes = value!;
                });
              },
              items: items2,
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Seconds:'),
            SizedBox(width: 10),
            DropdownButton<int>(
              value: seconds,
              onChanged: (value) {
                setState(() {
                  seconds = value!;
                });
              },
              items: items3,
            ),
          ],
        ),
        ElevatedButton(
          onPressed: () {
            context.read<TimerViewModel>().resetTimer(seconds, minutes, hours);
            context.read<TimerViewModel>().startTimer();
          },
          child: Text('Set Timer'),
        ),
      ],
    );
  }
}

class ChrnometerNumber extends StatelessWidget {
  const ChrnometerNumber({
    super.key,
    required this.text,
    required this.textStyle,
  });

  final TextStyle textStyle;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Text(
        text ?? '00',
        style: textStyle,
      ),
    );
  }
}
