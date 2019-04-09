
import 'package:flutter/material.dart';
import '../Model/KindMs.dart';
import 'package:flutter_app/Common/STStyle.dart';

//flutter闭包与android类似的
typedef void OnLeftNaviFontCellClickListener(KindData kindData);

class LeftNaviFontCell extends StatefulWidget {
	
	KindData kindData;
	
	int changeColor;
	
	OnLeftNaviFontCellClickListener onLeftNaviFontCellClickListener;
	
	LeftNaviFontCell({Key key, this.kindData, this.changeColor, this.onLeftNaviFontCellClickListener}) : super(key: key);
	@override
	_LeftNaviFontCellState createState() => _LeftNaviFontCellState();
}

class _LeftNaviFontCellState extends State<LeftNaviFontCell> {
	@override
	Widget build(BuildContext context) {
		return GestureDetector(
			onTap: (){
				widget.onLeftNaviFontCellClickListener(widget.kindData);
			},
			child: Container(
			  width: 119,
			  height: 44,
			  child: new Column(
				  children: <Widget>[
					  Container(
						width: 119,
						height: 43,
						child: Center(
							child: Text(
								"${widget.kindData.mallCategoryName}",
								style: TextStyle(
								  color: widget.changeColor == 1 ? Color(STColors.cardWhite) :Color(STColors.colorC04),
								  fontSize: 14
								),
								textAlign: TextAlign.center,
								maxLines: 1,
								overflow: TextOverflow.ellipsis,
							),
						)
					  ),
					  Container(
						  width: 119,
						  height: 1,
						  color: Colors.black12,
					  ),
				  ],
			  )
			)
		);
	}
}