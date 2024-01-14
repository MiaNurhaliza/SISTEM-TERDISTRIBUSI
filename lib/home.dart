import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<String> homeList = []; // Change the variable name to avoid conflicts

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        backgroundColor: const Color.fromARGB(255, 20, 184, 170),
      ),
      body: homeList.isEmpty
          ? Center(
              child: Text(
                'Tugas Sister',
                style: TextStyle(fontSize: 20),
              ),
            )
          : ListView.builder(
              itemCount: homeList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(homeList[index]),
                );
              },
            ),
    );
  }
}
