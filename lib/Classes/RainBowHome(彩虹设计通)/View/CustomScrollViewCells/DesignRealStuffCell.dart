import 'package:flutter/material.dart';
import '../../Model/RainBowHomeListMs.dart';
import 'package:flutter_app/Macros.dart';
import '../BoxLabelView.dart';
import 'package:flutter_app/Common/Config/STStyle.dart';

class DesignRealStuffCell extends StatefulWidget {
	Rs rs;
	
	DesignRealStuffCell({Key key, this.rs}) : super(key: key);
  @override
  _DesignRealStuffCellState createState() => _DesignRealStuffCellState();
}


class _DesignRealStuffCellState extends State<DesignRealStuffCell> {
	@override
	Widget build(BuildContext context) {
		return Container(
			width: Macros.ScreenW(context) - 30,
			margin: EdgeInsets.fromLTRB(15, 15, 15, 15),
			child: new Stack(
				children: <Widget>[
					Container(
						width: Macros.ScreenW(context)- 30,
						child: new Container(
							child: new Column(
								crossAxisAlignment:CrossAxisAlignment.start,
								children: <Widget>[
									Container(
										margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
										width: Macros.ScreenW(context) - 30 - 100,
										child: Text(
											"${widget.rs.title}",
											style: TextStyle(color: Color(STColors.colorC04), fontSize: 16),
											textAlign: TextAlign.left,
											maxLines: 1,
											overflow: TextOverflow.ellipsis,
										),
									),
									_buildMidView(widget.rs),
									Container(
									  child: BoxLabelView(boxStr: "设计干货")
									),
								],
							),
						),
					),
					Positioned(
					  right: 0,
					  top: 0,
					  child: _buildIMV(widget.rs)
					)
				],
			),
		);
	}
	
	Widget _buildMidView(Rs rs) {
		return Container(
			width: Macros.ScreenW(context) - 30 - 100,
			margin: EdgeInsets.fromLTRB(0, 15, 0, 15),
			child: Row(
				children: <Widget>[
					new Expanded(
						flex:1,
						child: Text(
							"${rs.cateName}",
							style: TextStyle(color: Color(STColors.colorC05), fontSize: 14),
							textAlign: TextAlign.left,
							maxLines: 1,
							overflow: TextOverflow.ellipsis,
						),
					),
					new Expanded(
						flex:2,
						child: Text(
							"${rs.hits}" == "" ? "" :"阅读：${widget.rs.hits}",
							style: TextStyle(color: Color(STColors.colorC05), fontSize: 14),
							textAlign: TextAlign.left,
							maxLines: 1,
							overflow: TextOverflow.ellipsis,
						),
					),
				],
			),
		);
	}
	Widget _buildIMV(Rs rs) {
		return Container(
			width: 100.0,
			height: 75,
			child: new FadeInImage.assetNetwork(
				placeholder: "assets/images/placeSite.jpg",
				fadeInDuration: const Duration(seconds: 1), // 持续时间，默认 700 ms
				image: "${rs.bigImg}",
				fit: BoxFit.cover,
			),
		);
	}
}

