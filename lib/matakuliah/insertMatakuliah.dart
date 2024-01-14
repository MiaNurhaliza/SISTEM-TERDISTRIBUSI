// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:sistergui/matakuliah/matakuliah.dart';

class InsertMatakuliah extends StatefulWidget {
  const InsertMatakuliah({Key? key}) : super(key: key);

  @override
  State<InsertMatakuliah> createState() => _InsertMatakuliahState();
}

class _InsertMatakuliahState extends State<InsertMatakuliah> {
  final kode = TextEditingController();
  final nama = TextEditingController();
  final sks = TextEditingController();

  bool isNumeric(String str) {
    return int.tryParse(str) != null;
  }

  Future<void> insertMatakuliah() async {
  if (isNumeric(sks.text)) {
    String urlInsert = "http://192.168.140.103:9002/api/v1/matakuliah";
    final Map<String, dynamic> data = {
      "kode": kode.text,
      "nama": nama.text,
      "sks": int.parse(sks.text),
    };

    try {
      var response = await http.post(
        Uri.parse(urlInsert),
        body: jsonEncode(data),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        // Pindah ke halaman mahasiswa setelah berhasil menyimpan
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => DataMatakuliah(),
          ),
        );
      } else {
        print("Gagal");
      }
    } catch (e) {
      print('Error during insertMatakuliah: $e');
    }
  } else {
    print("Bukan Angka");
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Insert Data Matakuliah"),
        backgroundColor: Colors.green.shade400,
      ),
      body: Center(
        child: Container(
          margin: EdgeInsets.fromLTRB(0, 100, 0, 0),
          width: 800,
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextField(
                controller: kode,
                decoration: InputDecoration(
                  labelText: "Kode",
                  hintText: "Ketikkan Kode Matakuliah",
                  prefixIcon: Icon(Icons.code),
                  fillColor: Colors.deepPurple.shade200,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: nama,
                decoration: InputDecoration(
                  labelText: "Nama",
                  hintText: "Ketikkan Nama Matakuliah",
                  prefixIcon: Icon(Icons.book),
                  fillColor: Colors.deepPurple.shade200,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: sks,
                onChanged: (value) {
                  if (!isNumeric(value)) {
                    // Handle error or provide feedback to the user.
                  }
                },
                decoration: InputDecoration(
                  labelText: "SKS",
                  hintText: "Ketikkan Jumlah SKS",
                  prefixIcon: Icon(Icons.numbers_rounded),
                  fillColor: Colors.deepPurple.shade200,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 20),
              SizedBox(
                height: 50,
                width: 200,
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.deepPurple.shade400,
                  ),
                  onPressed: () {
                    insertMatakuliah();
                  },
                  child: Text(
                    "SIMPAN",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
