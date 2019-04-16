import 'package:flutter/material.dart';
import '../../Model/RainBowHomeListMs.dart';
import 'package:flutter_app/Macros.dart';
import '../BoxLabelView.dart';
import 'package:flutter_app/Common/Config/STStyle.dart';

class DesignerPhotoCell extends StatefulWidget {
	Rs rs;
	DesignerPhotoCell({Key key, this.rs}) : super(key: key);
	
  @override
  _DesignerPhotoCellState createState() => _DesignerPhotoCellState();
}

class _DesignerPhotoCellState extends State<DesignerPhotoCell> {
  @override
  Widget build(BuildContext context) {
    return Container(
//      color: Color(STColors.colorC09),
      width: Macros.ScreenW(context) - 30,
      margin: EdgeInsets.fromLTRB(15, 15, 15, 15),
	    child:new Column(
		    children: <Widget>[
			    _makeTopView(widget.rs),
			    _makePhotoView(widget.rs),
			    _makeBottomView(widget.rs),
		    ],
	    )
    );
  }
  
  Widget _makeTopView(Rs rs){
    return Row(
	    children: <Widget>[
            new Container(
		        width: 45.0,
			    height: 45.0,
			    child: ClipRRect(
				    borderRadius: BorderRadius.circular(22.5),
				    child: FadeInImage.assetNetwork(
					    placeholder: "assets/images/avater_icon.png",
					    image: "${rs.headImage}",
					    fit: BoxFit.cover,
				    ),
			    ),
		    ),
            new Container(
	            margin: EdgeInsets.fromLTRB(15, 0, 0, 0),
	            child: Column(
		            children:<Widget>[
		                new Container(
			                width: Macros.ScreenW(context) - 30.0 - 60.0,
			                child: Text(
				                "${widget.rs.userName}",
				                style: TextStyle(color: Color(STColors.colorC04), fontSize: 14),
				                textAlign: TextAlign.left,
				                maxLines: 1,
				                overflow: TextOverflow.ellipsis,
			                ),
		                ),
		                new Container(
			                width: Macros.ScreenW(context) - 30.0 - 60.0,
			                child: Row(
				                children: <Widget>[
					                new Expanded(
						                flex:1,
						                child: Text(
							                "${widget.rs.city}",
							                style: TextStyle(color: Color(STColors.colorC05), fontSize: 14),
							                textAlign: TextAlign.left,
							                maxLines: 1,
							                overflow: TextOverflow.ellipsis,
						                ),
					                ),
					                new Expanded(
						                flex:2,
						                child: Text(
							                "${widget.rs.priceUnit}" == "" ? "" :"服务：${widget.rs.priceUnit}",
							                style: TextStyle(color: Color(STColors.colorC05), fontSize: 14),
							                textAlign: TextAlign.left,
							                maxLines: 1,
							                overflow: TextOverflow.ellipsis,
						                ),
					                ),
				                ],
			                ),
		                )
		            ],
	            )
            ),
	    ],
    );
  }

  Widget _makePhotoView(Rs rs){
	return Container(
	    margin: EdgeInsets.fromLTRB(0, 15.0, 0, 0),
		child:new Row(
			children: <Widget>[
				Container(
					width:(Macros.ScreenW(context) - 60.0) / 3,
					height: 70,
					child:new FadeInImage.assetNetwork(
						placeholder: "assets/images/placeSite.jpg",
						fadeInDuration: const Duration(seconds: 1), // 持续时间，默认 700 ms
						image: "${widget.rs.listImg[0]}",
						fit: BoxFit.cover,
					),
				),
				Container(
					margin: EdgeInsets.fromLTRB(15, 0, 0, 0),
					width:(Macros.ScreenW(context) - 60.0) / 3,
					height: 70,
					child:new FadeInImage.assetNetwork(
						placeholder: "assets/images/placeSite.jpg",
						fadeInDuration: const Duration(seconds: 1), // 持续时间，默认 700 ms
						image: "${widget.rs.listImg[1]}",
						fit: BoxFit.cover,
					),
				),
				Container(
					margin: EdgeInsets.fromLTRB(15, 0, 0, 0),
					width:(Macros.ScreenW(context) - 60.0) / 3,
					height: 70,
					child:new FadeInImage.assetNetwork(
						placeholder: "assets/images/placeSite.jpg",
						fadeInDuration: const Duration(seconds: 1), // 持续时间，默认 700 ms
						image: "${widget.rs.listImg[2]}",
						fit: BoxFit.cover,
					),
				)
			],
		)
	);
  }

  Widget _makeBottomView(Rs rs){
  	if (rs.title == "") {
	    return Container(
	      margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
	      child: BoxLabelView(boxStr: "设计师")
	    );
    } else {
	    return Container(
		    child: Column(
			    children: <Widget>[
				    Container(
					    margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
					    width: Macros.ScreenW(context) - 30.0,
					    child: Text(
						    "${widget.rs.title}",
						    style: TextStyle(color: Color(STColors.colorC04), fontSize: 16),
						    textAlign: TextAlign.left,
						    maxLines: 2,
						    overflow: TextOverflow.ellipsis,
					    ),
				    ),
				    Container(
					  margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
					  child: BoxLabelView(boxStr: "设计师")
				    ),
			    ],
		    ),
	    );
    }
	
  }
}
