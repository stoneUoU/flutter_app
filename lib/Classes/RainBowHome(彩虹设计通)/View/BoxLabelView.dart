import 'package:flutter/material.dart';
import 'package:flutter_app/Common/Config/STStyle.dart';

class BoxLabelView extends StatefulWidget {
  String boxStr = "";
  BoxLabelView({Key key, this.boxStr}) : super(key: key);

  @override
  _BoxLabelViewState createState() => _BoxLabelViewState();
}

class _BoxLabelViewState extends State<BoxLabelView> {
  @override
  Widget build(BuildContext context) {
    return _makeBoxView(widget.boxStr);
  }
  
  Widget _makeBoxView(String boxStr) {
  	return Container(
	    margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
	    child: new Row(
		    children: <Widget>[
		    	Container(
				    width: 4.0,
				    height: 18.0,
				    color:Color(STColors.colorC12),
			    ),
			    Container(
				    height:18.0,
				    padding: EdgeInsets.fromLTRB(6, 0, 6, 0),
				    decoration: new BoxDecoration(
					    color: Color(STColors.white),
					    border: new Border.all(
						    color: Color(STColors.colorC12),
						    width: 1.0,
					    )
				    ),
				    child: Center(
					    child: Text(
						    boxStr,
						    style: TextStyle(color: Color(STColors.colorC12), fontSize: 11),
					    ),
				    ),
			    )
		    ],
	    ),
    );
  }
}
