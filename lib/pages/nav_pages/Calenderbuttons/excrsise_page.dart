import 'package:flutter/material.dart';

class Add extends StatelessWidget {
  const Add({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
           backgroundColor:Colors.black,
        title: Text('Select exercise'),
        centerTitle: true,
         toolbarHeight: 80,
      ),
      backgroundColor: Color.fromARGB(255, 16, 16, 16),
      body: SafeArea(
        child: Column(
          children: [
            
          ],
        )
        ),
    );
  }
}