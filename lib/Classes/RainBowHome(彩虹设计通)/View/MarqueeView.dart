
import 'package:flutter/material.dart';
import 'package:flutter_marquee/flutter_marquee.dart';
import '../Model/RainBowHomeRotationMs.dart';
import 'package:flutter_app/Macros.dart';
import 'package:flutter_app/Common/STStyle.dart';

class MarqueeView extends StatefulWidget {
	List newLists = [];
	MarqueeView({Key key, this.newLists}) : super(key: key);
	@override
	_MarqueeView createState() => _MarqueeView();
}

class _MarqueeView extends State<MarqueeView> {
	
	Widget build(BuildContext context) {
		return Container(
		  margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
		  width: Macros.ScreenW(context) - 30.0,
		  height: 30.0,
		  decoration: new BoxDecoration(
			  color: Color(STColors.colorC07),
			  border: new Border.all(
				  color: Color(STColors.colorC07),
				  width: 1.0,
			  ),
			  borderRadius: new BorderRadius.all(new Radius.circular(15.0)),
		  ),
		  child: new Row(
			  children: <Widget>[
				  Container(
					  margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
					  child: new Image.asset('assets/images/fastReport.png'),
				  ),
				  Container(
					  height: 30,
					  //这个跑马灯我看很强:
					  child: FlutterMarquee(
						children: _makeMarquee(widget.newLists),
						onChange: (i) {
							print(i);
						},
						duration: 4),
				  )
			  ],
		  ));
	}
	
	List<Widget> _makeMarquee(List newLists) {
		List<Widget> widgetList = [];
		for (var i = 0; i < newLists.length; i++) {
			NewsList newsList = newLists[i];
			widgetList.add(Container(
			  margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
			  width: Macros.ScreenW(context) - 30.0 - 45.0 - 30,
			  alignment: Alignment.centerLeft,
			  child: Text(
				  newsList.news,
				  style: TextStyle(color: Colors.black, fontSize: 14),
				  textAlign: TextAlign.left,
				  maxLines: 1,
				  overflow: TextOverflow.ellipsis,
			  )));
		}
		return widgetList;
	}
}