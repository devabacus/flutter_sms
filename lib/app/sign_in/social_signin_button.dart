import 'package:flutter/material.dart';
import 'package:flutter_udemy_firebase/common_widgets/custom_raised_button.dart';

class SocialSignInButton extends CustomRaisedButton {
  SocialSignInButton({
    @required String text,
    Color color,
    Color textColor,
    @required String imageAsset,
    VoidCallback onPressed,
  }) : assert(imageAsset != null),
        assert(text != null),
        super(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Image.asset(imageAsset),
          Text(text, style: TextStyle(color: textColor),),
          Opacity(
            child: Image.asset(imageAsset),
            opacity: 0,
          ),
        ],
      ),
      color: color,
      onPressed: onPressed
  );

}