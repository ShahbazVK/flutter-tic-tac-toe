// ignore_for_file: deprecated_member_use, prefer_const_constructors, unnecessary_string_interpolations, unnecessary_brace_in_string_interps

import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

bool checkMove(currentPlayer, grid) {
  // print("object");
  // if ((grid[0]==currentPlayer && grid[1]==grid[2]) || grid[3]==currentPlayer && grid[4]==grid[5]||grid[6]==currentPlayer && grid[7]==grid[8]||grid[2]==currentPlayer && grid[2]==grid[4]||grid[6]==currentPlayer && grid[1]==grid[2]||grid[0]==currentPlayer && grid[1]==grid[2])
  if ([grid[0], grid[1], grid[2]].every((x) => x == currentPlayer) ||
      [grid[3], grid[4], grid[5]].every((x) => x == currentPlayer) ||
      [grid[6], grid[7], grid[8]].every((x) => x == currentPlayer) ||
      [grid[0], grid[3], grid[6]].every((x) => x == currentPlayer) ||
      [grid[1], grid[4], grid[7]].every((x) => x == currentPlayer) ||
      [grid[2], grid[5], grid[8]].every((x) => x == currentPlayer) ||
      [grid[2], grid[4], grid[6]].every((x) => x == currentPlayer) ||
      [grid[0], grid[4], grid[8]].every((x) => x == currentPlayer)) {
    return true;
  }
  return false;
}

class _MyAppState extends State<MyApp> {
  var grid = ["-", "-", "-", "-", "-", "-", "-", "-", "-"];
  var currentPlayer = "X";
  var winner = "";
  bool isWon = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Tic Tac Toe",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Color.fromARGB(255, 118, 212, 205),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: isWon
                  ? MaterialBanner(
                      content: Text("${winner} won"),
                      actions: [
                        FlatButton(
                          child: Text("OK"),
                          onPressed: () {
                            setState(() {
                              isWon = false;
                              grid = [
                                "-",
                                "-",
                                "-",
                                "-",
                                "-",
                                "-",
                                "-",
                                "-",
                                "-"
                              ];
                            });
                          },
                        ),
                      ],
                    )
                  : null,
            ),
            Container(
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(10),
              color: Colors.black,
              child: GridView.builder(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: grid.length,
                itemBuilder: (BuildContext context, int index) {
                  return Material(
                    color: Color.fromARGB(255, 195, 238, 227),
                    child: AnimatedContainer(
                      duration: Duration(seconds: 1),
                      // height: 150,
                      // width: 100,
                      child: InkWell(
                        splashColor: Colors.white,
                        onTap: () {
                          setState(() {
                            if (grid[index] == "-" && !isWon) {
                              grid[index] = currentPlayer;
                              if (checkMove(currentPlayer, grid)) {
                                setState(() {
                                  winner = currentPlayer;
                                  isWon = true;
                                });
                              }
                              currentPlayer = currentPlayer == "X" ? "O" : "X";
                            }
                          });
                        },
                        child: Center(
                          child: Text(
                            "${grid[index]}",
                            // "$index",
                            style: TextStyle(fontSize: 40),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            // Material(
            //   child: AlertDialog(
            //     content: Text("data"),
            //   ),
            // )
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    grid = ["-", "-", "-", "-", "-", "-", "-", "-", "-"];
                    isWon = false;
                  });
                },
                child: Text("Reset")),
          ],
        ),
      ),
    );
  }
}
