
import 'package:flutter/material.dart';

import 'package:flutter_app/Common/Config/STStyle.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class HudTips {
	
	static showToast(String str) {
		Fluttertoast.showToast(
		    msg: str,
		    toastLength: Toast.LENGTH_SHORT,
		    gravity: ToastGravity.CENTER,
		    timeInSecForIos: 1,
		    backgroundColor: Color(STColors.colorC03),
		    textColor: Colors.white
		);
	}
	
	static showNetToast(BuildContext context) {
		showDialog(
		  context: context,
		  barrierDismissible: false,
		  builder: (_) {
			  return SpinKitFadingCircle(
				  itemBuilder: (_, int index) {
					  return DecoratedBox(
						  decoration: BoxDecoration(
							  color: index.isEven ? Colors.red : Colors.green,
						  ),
					  );
				  },
			  );
		  });
	}
}