import 'package:flutter/material.dart';
import '../../Model/RainBowHomeListMs.dart';
import 'package:flutter_app/Macros.dart';
import '../BoxLabelView.dart';
import 'package:flutter_app/Common/Config/STStyle.dart';

typedef void OnPrivateSchoolCellClickListener(String idStr);

class PrivateSchoolCell extends StatefulWidget {
	
	Rs rs;
	final OnPrivateSchoolCellClickListener onPrivateSchoolCellClickListener;
	PrivateSchoolCell({Key key, this.rs,this.onPrivateSchoolCellClickListener}) : super(key: key);
	
  @override
  _PrivateSchoolCellState createState() => _PrivateSchoolCellState();
}

class _PrivateSchoolCellState extends State<PrivateSchoolCell> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
	    onTap: () {
	    	this.widget.onPrivateSchoolCellClickListener("${widget.rs.dataID}");
	    },
	    child: Container(
//	    color: Color(STColors.colorC06),
		    width: Macros.ScreenW(context) - 30,
		    margin: EdgeInsets.fromLTRB(15, 15, 15, 15),
		    child: _makeCol(widget.rs),
	    ),
    );
  }
  
  Column _makeCol(Rs rs) {
  	return Column(
	    children: <Widget>[
		    Container(
			    width: Macros.ScreenW(context) - 30.0,
			    height: _makePhotoHeight(rs),
			    child: new FadeInImage.assetNetwork(
				    placeholder: "assets/images/placeSite.jpg",
				    fadeInDuration: const Duration(seconds: 1), // 持续时间，默认 700 ms
				    image: "${rs.bigImg}",
				    fit: BoxFit.cover,
			    ),
		    ),
		    Container(
			    margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
			    width: Macros.ScreenW(context) - 30.0,
			    child: Text(
				    "${rs.title}",
				    style: TextStyle(color: Color(STColors.colorC04), fontSize: 16),
				    textAlign: TextAlign.left,
				    maxLines: 2,
				    overflow: TextOverflow.ellipsis,
			    ),
		    ),
		    Container(
			  margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
			  child: BoxLabelView(boxStr: _makeBoxStr(widget.rs))
		    ),
	    ],
    );
  }
  
  double _makePhotoHeight(Rs rs) {
	  if (rs.type == 1 && rs.type == 2) {
		  return (Macros.ScreenW(context) - 30)*rs.imgWidth/rs.imgHeight;
	  } else if (rs.type == 11) {
		  return (Macros.ScreenW(context) - 30)*265/375;
	  }{
		  return (Macros.ScreenW(context) - 30)*3/5;
	  }
  }

  String _makeBoxStr(Rs rs) {
	  if (rs.type == 1) {
		  return "设计作品";
	  } else if (rs.type == 2) {
		  return "设计案例";
	  } else if (rs.type == 5) {
		  return "策划案";
	  } else if (rs.type == 6) {
		  return "作品私馆";
	  } else if (rs.type == 10) {
		  return "主题元素";
	  } else{
		  return "设计报告";
	  }
  }
  
  
}
