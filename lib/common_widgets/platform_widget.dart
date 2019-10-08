import 'dart:io';

import 'package:flutter/material.dart';

abstract class PlatformWidget extends StatelessWidget {

  Widget buildCupetinoWidget (BuildContext context);
  Widget buildMaterialWidget (BuildContext context);
  @override
  Widget build(BuildContext context) {
    if(Platform.isIOS){
      return buildCupetinoWidget(context);
    }
    return buildMaterialWidget(context);
  }
}
