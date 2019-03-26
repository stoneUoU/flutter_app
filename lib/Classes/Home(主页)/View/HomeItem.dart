import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../Model/HomeMs.dart';


//flutter闭包与android类似的

typedef void OnHomeItemClickListener(int reportId);

class HomeItem extends StatelessWidget {
	
	final OnHomeItemClickListener onHomeItemClickListener;
	
	final HomeMs homeMs;
	
	const HomeItem({Key key, this.onHomeItemClickListener,this.homeMs})
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
		return Card(
			color: Colors.white,
			elevation: 4.0,
			margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
			child: ListTile(
				onTap: () {
//					_launchURL(homeMs.cover, context);
					this.onHomeItemClickListener(homeMs.reportId);
				},
				title: Padding(
					child: Text(
						homeMs.title,
						style: TextStyle(color: Colors.black, fontSize: 15.0),
					),
					padding: EdgeInsets.only(top: 10.0),
				),
				subtitle: Container(
					child: Padding(
						child: Text(homeMs.description,
						  style: TextStyle(color: Colors.black54, fontSize: 10.0)),
						padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
					)
				),
				trailing:
				Icon(Icons.keyboard_arrow_right, color: Colors.grey, size: 30.0),
			),
		);
	}
}