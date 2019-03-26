import 'package:flutter/material.dart';
import './CountBLoC.dart';

class BlocProvider extends InheritedWidget {
	
	CountBLoC bLoCTest = CountBLoC();
	
	BlocProvider({Key key, Widget child}) : super(key: key, child: child);
	
	@override
	bool updateShouldNotify(_) => true;
	
	static CountBLoC of(BuildContext context) =>
	  (context.inheritFromWidgetOfExactType(BlocProvider) as BlocProvider).bLoCTest;
}