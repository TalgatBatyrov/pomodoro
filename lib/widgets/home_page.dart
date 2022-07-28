import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pomodoro'),
      ),
      body: Container(
        color: Colors.red,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            SizedBox(height: 70),
            PomodoroTitle(),
            SizedBox(height: 40),
            PomodoroTimer()
          ],
        ),
      ),
    );
  }
}

class PomodoroTimer extends StatelessWidget {
  const PomodoroTimer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        AnimatedDefaultTextStyle(
          style: TextStyle(
            height: .9,
            fontSize: 230,
            color: Colors.black,
            fontWeight: FontWeight.w900,
          ),
          duration: Duration(milliseconds: 200),
          child: Text('25'),
        ),
        AnimatedDefaultTextStyle(
          style: TextStyle(
            height: .9,
            fontSize: 230,
            color: Colors.black,
            fontWeight: FontWeight.w900,
          ),
          duration: Duration(milliseconds: 200),
          child: Text('00'),
        ),
      ],
    );
  }
}

class PomodoroTitle extends StatelessWidget {
  const PomodoroTitle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 60,
      decoration: BoxDecoration(
          border: const Border.fromBorderSide(BorderSide(width: 2)),
          color: Colors.red,
          borderRadius: BorderRadius.circular(26)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: const [
          Image(
            image: AssetImage('images/brain.png'),
          ),
          Text(
            'Focus',
            style: TextStyle(
              color: Colors.black,
              fontSize: 24,
              fontWeight: FontWeight.w500,
            ),
          )
        ],
      ),
    );
  }
}
