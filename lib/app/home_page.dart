import 'package:flutter/material.dart';
import 'package:flutter_udemy_firebase/common_widgets/platform_alert_dialog.dart';
import 'package:flutter_udemy_firebase/services/auth.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  Future<void> _signOut(BuildContext context) async {
    try {
      final auth = Provider.of<AuthBase>(context);

      auth.signOut();
    } catch (e) {
      print(e);
    }
  }

  Future<void> _confirmSignOut(BuildContext context) async {
    final didRequestSignOut = await PlatformAlertDialog(
      title: 'Выход',
      content: 'Вы действительно хотите выйте?',
      cancelActionText: 'Отмена',
      defaultActionText: 'Выход',
    ).show(context);

    if (didRequestSignOut == true) {
      _signOut(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Главная страница'),
        actions: <Widget>[
          FlatButton(
            child: Text(
              'Выйти',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            onPressed: () => _confirmSignOut(context),
          )
        ],
      ),
    );
  }
}
