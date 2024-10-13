import 'package:flutter/material.dart';

class EditPage extends StatelessWidget {
  const EditPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("แก้ไขข้อมูล"),
      ),
      body: Center(
        child: Text(
          "นี่คือหน้าจอแก้ไข",
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
