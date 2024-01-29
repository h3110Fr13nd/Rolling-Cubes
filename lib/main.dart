
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.dark(),
        primarySwatch: Colors.blue,
      ),
      home: const RollingCubes(title: 'Rolling Cubes'),
    );
  }
}

class RollingCubes extends StatefulWidget {
  const RollingCubes({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<RollingCubes> createState() => _RollingCubesState();
}

class _RollingCubesState extends State<RollingCubes> {
  List cubes = [
    Cube(),
    Cube(),
    Cube(),
    Cube(),
    null,
    Cube(),
    Cube(),
    Cube(),
    Cube(),
  ];

  void resetRollingCubes(){
    setState(() {
      cubes = [
        Cube(),
        Cube(),
        Cube(),
        Cube(),
        null,
        Cube(),
        Cube(),
        Cube(),
        Cube(),
      ];
    });
  }
  List<String> moveLeft(lrtufb){
      return [
        lrtufb[4], lrtufb[5], lrtufb[2], lrtufb[3], lrtufb[1], lrtufb[0]
      ];
  }
  List<String> moveRight(lrtufb){
      return [
        lrtufb[5], lrtufb[4], lrtufb[2], lrtufb[3], lrtufb[0], lrtufb[1]
      ];
  }

  List<String> moveUp(lrtufb){
      return [
        lrtufb[0], lrtufb[1], lrtufb[4], lrtufb[5], lrtufb[3], lrtufb[2]
      ];
  }

  List<String> moveDown(lrtufb){
      return [
        lrtufb[0], lrtufb[1], lrtufb[5], lrtufb[4], lrtufb[2], lrtufb[3]
      ];
  }
  bool checkWin(){
    for (int i=0; i<9; i++) {
      if (cubes[i] != null && cubes[i].lrtufb[4]!="B")
        return false;
    }
    return true;
  }
  void handleMove(index){
    var tempCube = cubes[index];
    var nullIndex = cubes.indexOf(null);
    var newState;
    if (tempCube != null) {
      if (index -1 == nullIndex){
        print(cubes[index].lrtufb);
        setState(() {
          newState = moveLeft(cubes[index].lrtufb);
          cubes[index] = null;
          cubes[nullIndex] = Cube(lrtufb: newState);
        });
      } else if(index +1 == nullIndex){
        setState(() {
          newState = moveRight(cubes[index].lrtufb);
          cubes[index] = null;
          cubes[nullIndex] = Cube(lrtufb: newState);
        });
      } else if(index -3 == nullIndex){
        setState(() {
          newState = moveUp(cubes[index].lrtufb);
          cubes[index] = null;
          cubes[nullIndex] = Cube(lrtufb: newState);
        });
      } else if(index +3 == nullIndex){
        setState(() {
          newState = moveDown(cubes[index].lrtufb);
          cubes[index] = null;
          cubes[nullIndex] =Cube(lrtufb: newState);
        });


      }
      if (checkWin()){
        showDialog(context: context, builder: (context){
          return Dialog(
            child: Container(
              width: 300,
              height: 300,
              constraints: const BoxConstraints(
                minHeight: 300,
                maxWidth: 300,
              ),
          child:Column(
          mainAxisSize:
          MainAxisSize
              .min,
          children: [
          Text('You Did it.'),
          ElevatedButton(
              onPressed: (){

              },
              child: const Text("kjsbrk")
          )]
            )

            ),
          );
        });
      };
    }
  }
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the RollingCubes object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Rolling Cubes',
            ),

        Container(
          height: 400, // Set a fixed height for the container
          child:
                GridView.builder(gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3
                ),
                  itemCount: 9,
                  itemBuilder: (
                      BuildContext context, index
                      ){
                    return Padding(padding: const EdgeInsets.all(3),

                      child: GestureDetector(
                        onTap: ()=>{
                          handleMove(index)
                        },
                        child: cubes[index] ?? Container(),
                      )
                    );
                  },
                )



        ),
            TextButton(onPressed: resetRollingCubes, child: Text(
              "Reset Rolling Cubes Board"
            ))
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _incrementCounter,
      //   tooltip: 'Increment',
      //   child: const Icon(Icons.add),
      // ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}


class Cube extends StatelessWidget {

  const Cube({super.key, this.lrtufb = const ['W',"W","W","W","R","B"] });
  Color returnColor(i){
    return lrtufb[i] == "R" ? Colors.red : lrtufb[i] == "B" ? Colors.blue : Colors.white;
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
            left: BorderSide(
                color: returnColor(0),
                width: 7
            ),
            right: BorderSide(
                color: returnColor(1),
                width: 7
            ),
            top: BorderSide(
                color: returnColor(2),
                width: 7
            ),
            bottom: BorderSide(
                color: returnColor(3),
                width: 7
            ),
          )
      ),
    );
  }
}

// class _Cube extends State<Cube> {
//   List<String> lrtufb = ['W',"W","W","W","R","B"];
//
//   @override
//   void initState() {
//     super.initState();
//     lrtufb = widget.lrtufb;
//   }
//



