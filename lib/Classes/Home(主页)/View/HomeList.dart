import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../Model/HomeMs.dart';
import 'package:flutter_app/Macros.dart';
import 'package:flutter_app/Common/STStyle.dart';
//flutter闭包与android类似的

typedef void OnHomeItemClickListener(int reportId);

class HomeList extends StatelessWidget {
	
	final OnHomeItemClickListener onHomeItemClickListener;
	
	final HomeMs homeMs;
	
	const HomeList({Key key, this.onHomeItemClickListener,this.homeMs})
	  : super(key: key);
	
	void _launchURL(String url, BuildContext context) async {
		
		if (await canLaunch(url)) {
			await launch(url);
		} else {
			throw 'Could not launch $url';
		}
	}
	
	@override
	Widget build(BuildContext context) {
		return GestureDetector(
		    onTap: () { // 按下
			    this.onHomeItemClickListener(homeMs.reportId);
			},
			child: Container(
				color: Colors.white,
				child: Column(
					children: <Widget>[
						new Container(
							height: 265,
							padding:EdgeInsets.fromLTRB(0, 0, 0, 0),
							width: Macros.ScreenW(context), //- 30.0,
							child:new FadeInImage.assetNetwork(
								placeholder: "images/placeSite.jpg",
								fadeInDuration: const Duration(seconds: 1), // 持续时间，默认 700 ms
								image: homeMs.cover,
								fit: BoxFit.cover,
							)
						),
						new Container(
							padding:EdgeInsets.fromLTRB(0, 0, 0, 0),
							width: Macros.ScreenW(context),
							child: Row(
								children: <Widget>[
									Container(
										margin: EdgeInsets.fromLTRB(15.0, 8.0, 0.0, 8.0),
										width: Macros.ScreenW(context) - 30.0 - 80.0,
										child: Text(
											homeMs.title,
											style: TextStyle(color: Colors.black, fontSize: 15.0),
											maxLines: 1,
											textAlign: TextAlign.left,
											overflow:TextOverflow.ellipsis,
										),
									),
									Container(
										margin: EdgeInsets.fromLTRB(0.0, 8.0, 15.0, 8.0),
//										color:Colors.greenAccent,
										width: 80.0,
										child: Text(
											"￥${homeMs.salePrice}/元",
											style: TextStyle(color: Colors.red, fontSize: 15.0),
											maxLines: 1,
											textAlign: TextAlign.right,
											overflow:TextOverflow.ellipsis,
										),
									),
								],
							),
						),
						Container(
							margin: EdgeInsets.fromLTRB(15.0, 0, 15.0, 8.0),
							width: Macros.ScreenW(context) - 30.0,
							child: Text(
								homeMs.description,
								style: TextStyle(color: Colors.black54, fontSize: 12.0),
								maxLines: 2,
								overflow:TextOverflow.ellipsis,
							),
						),
						Container(
							width: Macros.ScreenW(context),
							height:10,
							color:Color(STColors.colorC07)
						)
					],
				),
			),
		);
	}
}