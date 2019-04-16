
import 'package:flutter/material.dart';
import '../../Model/RainBowHomeListMs.dart';
import 'package:flutter_app/Macros.dart';
import '../BoxLabelView.dart';
import 'package:flutter_app/Common/Config/STStyle.dart';

class PurchasePhotoCell extends StatefulWidget {
	Rs rs;
	
	PurchasePhotoCell({Key key, this.rs}) : super(key: key);
	@override
	_PurchasePhotoCellState createState() => _PurchasePhotoCellState();
}


class _PurchasePhotoCellState extends State<PurchasePhotoCell> {
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
											maxLines: 2,
											overflow: TextOverflow.ellipsis,
										),
									),
									new Container(
										margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
										child:Text.rich(
											TextSpan(
												children: [
													TextSpan(
													  text: "项目预算:",
													  style: TextStyle(
														  color: Color(STColors.colorC05),
														  fontSize: 14,
													  )),
													TextSpan(
														text: "${widget.rs.budget}元左右",
														style: TextStyle(
															color: Colors.red,
															fontSize: 14,
														),
													),
												],
											),
										)
									),
									new Container(
										margin: EdgeInsets.fromLTRB(0, 15, 0, 15),
										child: Text(
											"${widget.rs.time}截止报名",
											style: TextStyle(color: Color(STColors.colorC05), fontSize: 14),
											textAlign: TextAlign.left,
											maxLines: 1,
											overflow: TextOverflow.ellipsis,
										),
									),
									Container(
									  child: BoxLabelView(boxStr: "采购需求")
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