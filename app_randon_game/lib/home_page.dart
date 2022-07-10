import 'dart:math';

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String valor = "clique para sortear";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.green.shade700,
        title: const Text('Random Game'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              valor,
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.green.shade700),
            ),
            const SizedBox(
              height: 80,
            ),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  _gerarNumero();
                },
                child: const Text("Gerar Randon"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _gerarNumero() {
    List<String> myGames = [
      "Unturned",
      "Intruder",
      "Valorant",
      "R6",
      "L4D2",
      "Palladins",
      "LOL",
      "Minecraft",
      "Counter Strike 1.6",
      "Counter Strike: \n Global Offensive",
      "Among Us",
      "Fall Guys",
      "Terraria",
      "BO2",
      "Poligon",
    ];
    int index = Random().nextInt(myGames.length);
    setState(() {
      valor = "Sorteando...";
    });
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        valor = "Sorteou!";
        Future.delayed(const Duration(seconds: 2), () {
          setState(() {
            valor = myGames[index];
          });
        });
      });
    });
  }
}
