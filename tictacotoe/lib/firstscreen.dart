import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:tictacotoe/gamingscreen.dart';

class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFF5D5FEF),
            Color(0XFF843CE0),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        children: [
          SizedBox(
            height: 60,
          ),
          Image.asset("./assets/logo.png"),
          SizedBox(
            height: 120,
          ),
          Container(
            height: 50,
            width: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(60),
            ),
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Color(0XFF4FFAFF)),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TicTacToeScreen()),
                );
              },
              child: Text(
                "let's play !",
                style: TextStyle(fontSize: 25, color: Color(0xFF5D5FEF)),
              ),
            ),
          ),
          SizedBox(
            height: 100,
          ),
          Image.asset('./assets/rocket.png')
        ],
      ),
    ));
  }
}
