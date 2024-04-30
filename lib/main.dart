import 'package:flutter/material.dart';
import 'levels.dart';

void main() {
  runApp(const MyApp());
}

var levelsList = levels;

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: const ColorScheme.dark(),
        primarySwatch: Colors.blue,
      ),
      home: RollingCubes(title: 'Rolling Cubes'),
    );
  }
}

class RollingCubes extends StatefulWidget {
  RollingCubes({super.key, required this.title, this.levelNum = 8});
  final String title;
  int levelNum;
  @override
  State<RollingCubes> createState() => _RollingCubesState();
}

class _RollingCubesState extends State<RollingCubes> {
  List cubes = [
    const Cube(),
    const Cube(),
    const Cube(),
    const Cube(),
    null,
    const Cube(),
    const Cube(),
    const Cube(),
    const Cube(),
  ];
  var level;

  @override
  void initState() {
    super.initState();
    level = levelsList[widget.levelNum - 1];
  }

  void resetRollingCubes() {
    setState(() {
      cubes = [
        const Cube(),
        const Cube(),
        const Cube(),
        const Cube(),
        null,
        const Cube(),
        const Cube(),
        const Cube(),
        const Cube(),
      ];
    });
  }

  List<String> moveLeft(lrtufb) {
    return [lrtufb[4], lrtufb[5], lrtufb[2], lrtufb[3], lrtufb[1], lrtufb[0]];
  }

  List<String> moveRight(lrtufb) {
    return [lrtufb[5], lrtufb[4], lrtufb[2], lrtufb[3], lrtufb[0], lrtufb[1]];
  }

  List<String> moveUp(lrtufb) {
    return [lrtufb[0], lrtufb[1], lrtufb[4], lrtufb[5], lrtufb[3], lrtufb[2]];
  }

  List<String> moveDown(lrtufb) {
    return [lrtufb[0], lrtufb[1], lrtufb[5], lrtufb[4], lrtufb[2], lrtufb[3]];
  }

  bool checkWin() {
    for (int i = 0; i < 9; i++) {
      var row = i ~/ 3;
      var col = i % 3;
      var end = level['end'];
      var cubeFrontColor;
      var cube = cubes[i];
      if (cube == null) {
        cubeFrontColor = "N";
      } else {
        cubeFrontColor = cube.lrtufb[4];
      }

      var endColor = end[row][col];
      if (cubeFrontColor != endColor) {
        return false;
      }
    }
    return true;
  }

  void handleMove(index) {
    var tempCube = cubes[index];
    var nullIndex = cubes.indexOf(null);
    List<String> newState;
    if (tempCube != null) {
      if (index - 1 == nullIndex) {
        print(cubes[index].lrtufb);
        setState(() {
          newState = moveLeft(cubes[index].lrtufb);
          cubes[index] = null;
          cubes[nullIndex] = Cube(lrtufb: newState);
        });
      } else if (index + 1 == nullIndex) {
        setState(() {
          newState = moveRight(cubes[index].lrtufb);
          cubes[index] = null;
          cubes[nullIndex] = Cube(lrtufb: newState);
        });
      } else if (index - 3 == nullIndex) {
        setState(() {
          newState = moveUp(cubes[index].lrtufb);
          cubes[index] = null;
          cubes[nullIndex] = Cube(lrtufb: newState);
        });
      } else if (index + 3 == nullIndex) {
        setState(() {
          newState = moveDown(cubes[index].lrtufb);
          cubes[index] = null;
          cubes[nullIndex] = Cube(lrtufb: newState);
        });
      }
      if (checkWin()) {
        showDialog(
            context: context,
            builder: (context) {
              return Dialog(
                child: Container(
                    width: 300,
                    height: 300,
                    constraints: const BoxConstraints(
                      minHeight: 300,
                      maxWidth: 300,
                    ),
                    child: Column(mainAxisSize: MainAxisSize.min, children: [
                      const Text('You Did it.'),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          }, child: const Text("Okay! On to The Next!"))
                    ])),
              );
            });
        widget.levelNum++;
        setState(() {
          level = levelsList[widget.levelNum - 1];
        });
        // resetRollingCubes();
        resetRollingCubes();

      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Rolling Cubes',
            ),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Select Level',
              ),
              onChanged: (value) {                
              },
            ),
            // 
            Text(
              "Level : " + widget.levelNum.toString(),
            ),
            Text(
              level['description'],
            ),
            SizedBox(
                height: 400, // Set a fixed height for the container
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3),
                  itemCount: 9,
                  itemBuilder: (BuildContext context, index) {
                    return Padding(
                        padding: const EdgeInsets.all(3),
                        child: GestureDetector(
                          onTap: () => {handleMove(index)},
                          child: cubes[index] ?? Container(),
                        ));
                  },
                )),
            TextButton(
                onPressed: resetRollingCubes,
                child: const Text("Reset Rolling Cubes Board"))
          ],
        ),
      ),
    );
  }
}

class Cube extends StatelessWidget {
  const Cube({super.key, this.lrtufb = const ['W', "W", "W", "W", "R", "B"]});
  Color returnColor(i) {
    return lrtufb[i] == "R"
        ? Colors.red
        : lrtufb[i] == "B"
            ? Colors.blue
            : Colors.white;
  }

  final List<String> lrtufb;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
          color: returnColor(4),
          border: Border(
            left: BorderSide(color: returnColor(0), width: 7),
            right: BorderSide(color: returnColor(1), width: 7),
            top: BorderSide(color: returnColor(2), width: 7),
            bottom: BorderSide(color: returnColor(3), width: 7),
          )),
    );
  }
}
