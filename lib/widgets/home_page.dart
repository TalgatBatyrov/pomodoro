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
            PomodoroTimer(),
            SizedBox(height: 20),
            PomodoroActionButtons(),
          ],
        ),
      ),
    );
  }
}

class PomodoroActionButtons extends StatelessWidget {
  const PomodoroActionButtons({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.blue,
          ),
          child: const Icon(
            Icons.settings,
            size: 40,
            color: Color.fromARGB(255, 47, 15, 15),
          ),
        ),
        const SizedBox(width: 10),
        GestureDetector(
          onTap: () => {},
          child: Container(
            width: 130,
            height: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(32),
              color: Colors.blueAccent,
            ),
            child: const Icon(
              Icons.play_arrow,
              size: 40,
              color: Color.fromARGB(255, 47, 15, 15),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.amber,
          ),
          child: const Icon(
            Icons.skip_next,
            size: 40,
            color: Color.fromARGB(255, 47, 15, 15),
          ),
        ),
      ],
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
