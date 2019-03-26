
import 'package:flutter/material.dart';
import 'package:flutter_app/Common/STStyle.dart';
import 'package:flutter_app/Macros.dart';

//flutter闭包与android类似的
enum PlaceholderViewType {
	noNetwork,    // 0
	noGoods,  // 1
	noOrders,   // 2
}

typedef void OnPlaceHolderViewClickListener(PlaceholderViewType viewType);

class PlaceHolderView extends StatelessWidget {
	
	final PlaceholderViewType viewType;
	
	final OnPlaceHolderViewClickListener onPlaceHolderViewClickListener;
	
	String picStr = "";
	
	String tipsStr = "";
	
	String btnStr = "";
	
	PlaceHolderView({Key key, this.onPlaceHolderViewClickListener,this.viewType})
	  : super(key: key);
	
	@override
	Widget build(BuildContext context) {
		//先设置图片、文字
		_setStr();
		return new Container(
			child: Column(
				children: <Widget>[
					new Container(
						margin: EdgeInsets.fromLTRB(0, 120, 0, 0),
						child: new Center(
						    child: new Image.asset(picStr)
						),
					),
					new Container(
						margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
						child: new Center(
							child:  new Text(tipsStr,
							  style: new TextStyle(fontSize: 16.0, color: Color(STColors.colorC03)),
							  textAlign: TextAlign.center
							),
						),
					),
					new Container(
						margin: EdgeInsets.fromLTRB((Macros.ScreenW(context)-200)/2, 30, (Macros.ScreenW(context)-200)/2, 0),
						height:45,
						width: 200,
						child: new RaisedButton(
							onPressed: (){
								if (onPlaceHolderViewClickListener != null) {
									onPlaceHolderViewClickListener(viewType);
								}
							},
							shape: StadiumBorder(),
							child: new Text(btnStr,style: TextStyle(fontSize: 16.0,color: Colors.white)),
							color:Color(STColors.colorC09),
						),
					)
				],
			),
		);
	}
	
	_setStr() {
		if (viewType == PlaceholderViewType.noNetwork) {
			picStr = "images/noNet.png";
		} else if (viewType == PlaceholderViewType.noGoods) {
			picStr = "images/noShopCart.png";
		} else {
			picStr = "images/noShopCart.png";
		}
		
		if (viewType == PlaceholderViewType.noNetwork) {
			tipsStr = "亲，网络不佳丫";
		} else if (viewType == PlaceholderViewType.noGoods) {
			tipsStr = "暂无订单";
		} else {
			tipsStr = "暂无订单";
		}
		
		if (viewType == PlaceholderViewType.noNetwork) {
			btnStr = "点击重试";
		} else if (viewType == PlaceholderViewType.noGoods) {
			btnStr = "重新加载";
		} else {
			btnStr = "重新加载";
		}
	}
	//this.onHomeItemClickListener(homeMs.reportId);
}