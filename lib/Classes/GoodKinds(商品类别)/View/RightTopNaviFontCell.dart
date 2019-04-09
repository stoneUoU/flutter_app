
import 'package:flutter/material.dart';
import '../Model/KindMs.dart';
import 'package:flutter_app/Common/STStyle.dart';

//flutter闭包与android类似的
typedef void OnRightTopNaviFontCellClickListener(BxMallSubDto bxMallSubDto);

class RightTopNaviFontCell extends StatefulWidget {
	int changeColor;
	BxMallSubDto bxMallSubDto;
	OnRightTopNaviFontCellClickListener onRightTopNaviFontCellClickListener;
	RightTopNaviFontCell({Key key, this.bxMallSubDto,this.changeColor,this.onRightTopNaviFontCellClickListener}) : super(key: key);
	@override
	_RightTopNaviFontCellState createState() => _RightTopNaviFontCellState();
}

class _RightTopNaviFontCellState extends State<RightTopNaviFontCell> {
	
	@override
	Widget build(BuildContext context) {
		return GestureDetector(
			onTap: (){
				widget.onRightTopNaviFontCellClickListener(widget.bxMallSubDto);
			},
			child: Container(
			  height: 43,
			  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
			  child: Center(
				  child: Text(
					  "${widget.bxMallSubDto.mallSubName}",
					  style: TextStyle(color: widget.changeColor == 1 ? Colors.red :Color(STColors.colorC04),
					    fontSize: 14),
					  textAlign: TextAlign.center,
					  maxLines: 1,
					  overflow: TextOverflow.ellipsis,
				  ),
			  )
			),
		);
	}
}