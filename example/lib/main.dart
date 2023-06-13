import 'package:flutter/material.dart';
import 'package:rounded_expansion_tile/rounded_expansion_tile.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rounded Expansion Tile Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rounded Expansion Tile Demo'),
      ),
      backgroundColor: Colors.grey.shade200,
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        children: [
          Card(
            elevation: 0,
            color: Colors.white,
            child: RoundedExpansionTile(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4)),
              title: Text('BorderRadius.circular(4)'),
              children: [
                for (var i = 0; i < 5; i++)
                  ListTile(
                    title: Text('Child $i'),
                  )
              ],
            ),
          ),
          Divider(height: 20),
          Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            child: RoundedExpansionTile(
              initiallyExpanded: true,
              leading: Icon(Icons.person),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              title: Text('BorderRadius.circular(8)'),
              subtitle: Text('In card'),
              children: [
                for (var i = 0; i < 5; i++)
                  ListTile(
                    title: Text('Child $i'),
                  )
              ],
            ),
          ),
          Divider(height: 20),
          Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: RoundedExpansionTile(
              leading: Icon(Icons.person),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              title: Text('BorderRadius.circular(16)'),
              subtitle: Text('In card'),
              children: [
                for (var i = 0; i < 5; i++)
                  ListTile(
                    title: Text('Child $i'),
                  )
              ],
            ),
          ),
          Divider(height: 20),
          Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
            child: RoundedExpansionTile(
              leading: Icon(Icons.person),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24)),
              title: Text('BorderRadius.circular(24)'),
              subtitle: Text('In card'),
              children: [
                for (var i = 0; i < 5; i++)
                  ListTile(
                    title: Text('Child $i'),
                  )
              ],
            ),
          ),
          Divider(height: 20),
          Card(
            color: Colors.blue,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
            child: RoundedExpansionTile(
              focusColor: Colors.green,
              leading: Icon(Icons.person),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28)),
              title: Text('Without trailing'),
              noTrailing: true,
              children: [
                for (var i = 0; i < 5; i++)
                  ListTile(
                    title: Text('Child $i'),
                  )
              ],
            ),
          ),
          Divider(height: 20),
          Card(
            color: Colors.green,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
            child: RoundedExpansionTile(
              focusColor: Colors.green,
              leading: Icon(Icons.person),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28)),
              title: Text('Custom trailing'),
              trailing: Icon(Icons.info_outline),
              rotateTrailing: false,
              children: [
                for (var i = 0; i < 5; i++)
                  ListTile(
                    title: Text('Child $i'),
                  )
              ],
            ),
          ),
          Divider(height: 20),
          Card(
            color: Colors.red,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
            child: RoundedExpansionTile(
              leading: Icon(Icons.person),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24)),
              title: Text('Default trailing'),
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 400,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 2),
                      color: Colors.grey.shade200,
                    ),
                    child: Center(
                      child: Text(
                        'Widget',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Divider(height: 20),
          Card(
            color: Colors.purple,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
            child: RoundedExpansionTile(
              leading: Icon(Icons.person),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28)),
              title: Text('Custom trailing with rotation'),
              trailing: Icon(Icons.keyboard_arrow_down),
              rotateTrailing: true,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 400,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 2),
                      color: Colors.grey.shade200,
                    ),
                    child: Center(
                      child: Text(
                        'Widget',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
