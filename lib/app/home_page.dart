import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Главная страница'),
        actions: <Widget>[
          FlatButton(
            child: Text('Выйти', style: TextStyle(color: Colors.white),),
            onPressed: (){},
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            'Вилена', style: TextStyle(fontSize: 40, color: Colors.red), textAlign: TextAlign.center,
          ),
          Image.asset('images/vilena.jpg', width: 300, height: 300,),
          Text(
            'Кристина', style: TextStyle(fontSize: 40, color: Colors.orange), textAlign: TextAlign.center,
          ),
          Image.asset('images/kristina.jpg', width: 300, height: 300,),

        ],
      ),

    );
  }
}
