// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:sistergui/matakuliah/insertMatakuliah.dart';
import 'package:sistergui/matakuliah/updateMatakuliah.dart';

class DataMatakuliah extends StatefulWidget {
  const DataMatakuliah({super.key});

  @override
  State<DataMatakuliah> createState() => _DataMatakuliahState();
}

class _DataMatakuliahState extends State<DataMatakuliah> {
  List listMatakuliah = [];

  @override
  void initState() {
    allMatakuliah();
    super.initState();
  }

  

  Future<void> allMatakuliah() async {
    String urlmatakuliah = "http://192.168.140.103:9002/api/v1/matakuliah";
    try {
      var response = await http.get(Uri.parse(urlmatakuliah));
      listMatakuliah = jsonDecode(response.body);
      setState(() {
        listMatakuliah = jsonDecode(response.body);
      });
    } catch (exc) {
      print(exc);
    }
  }

  Future<void> deleteMatakuliah(int id) async {
    String urlMatakuliah = "http://192.168.140.103:9002/api/v1/matakuliah/${id}";
    try {
      await http.delete(Uri.parse(urlMatakuliah));
      setState(() {
        allMatakuliah();
      });
    } catch (exc) {
      print(exc);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Data Matakuliah"),
        backgroundColor: const Color.fromARGB(255, 20, 184, 170),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => InsertMatakuliah()))
                    .then((value) {
                  allMatakuliah();
                });
              },
              icon: Icon(
                Icons.add,
                size: 30,
              ))
        ],
      ),
      body: listMatakuliah.isEmpty
          ? Center(
              child: Text(
                'Tidak ada data',
                style: TextStyle(fontSize: 20),
              ),
            )
          : ListView.builder(
              itemCount: listMatakuliah.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.all(5),
                  child: ListTile(
                    leading: Icon(
                      Icons.book_outlined,
                      color: Colors.green.shade500,
                      size: 24,
                    ),
                    title: Text(
                      listMatakuliah[index]["kode"]?.toString() ?? "",
                      style: TextStyle(
                          color: Colors.green,
                          fontSize: 17,
                          fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      "Nama : ${listMatakuliah[index]["nama"]?.toString() ?? ""}\nSKS : ${listMatakuliah[index]["sks"]?.toString() ?? ""}",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 13,
                          fontWeight: FontWeight.normal),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                            tooltip: "Hapus Data",
                            onPressed: () {
                              deleteMatakuliah(listMatakuliah[index]["id"]);
                            },
                            icon: Icon(
                              Icons.delete,
                              color: Colors.amber.shade300,
                              size: 24,
                            )),
                        IconButton(
                            tooltip: "Edit Data",
                            onPressed: () {
                              Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              UpdateMatakuliah(
                                                  listMatakuliah[index]["id"],
                                                  listMatakuliah[index]["kode"],
                                                  listMatakuliah[index]["nama"],
                                                  listMatakuliah[index]["sks"]
                                                      .toString())))
                                  .then((value) => allMatakuliah());
                            },
                            icon: Icon(
                              Icons.edit,
                              color: Colors.amber.shade800,
                              size: 24,
                            )),
                      ],
                    ),
                  ),
                );
              }),
    );
  }
}
