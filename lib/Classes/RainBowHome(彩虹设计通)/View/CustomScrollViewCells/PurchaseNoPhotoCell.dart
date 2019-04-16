import 'package:flutter/material.dart';
import '../../Model/RainBowHomeListMs.dart';
import 'package:flutter_app/Macros.dart';
import '../BoxLabelView.dart';
import 'package:flutter_app/Common/Config/STStyle.dart';

class PurchaseNoPhotoCell extends StatefulWidget {
  Rs rs;

  PurchaseNoPhotoCell({Key key, this.rs}) : super(key: key);
  @override
  _PurchaseNoPhotoCellState createState() => _PurchaseNoPhotoCellState();
}

class _PurchaseNoPhotoCellState extends State<PurchaseNoPhotoCell> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: Macros.ScreenW(context) - 30,
      margin: EdgeInsets.fromLTRB(15, 15, 15, 15),
      child: new Stack(
        children: <Widget>[
          Container(
            width: Macros.ScreenW(context) - 30,
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  width: Macros.ScreenW(context) - 30 - 100,
                  child: Text(
                    "${widget.rs.title}",
                    style: TextStyle(
                        color: Color(STColors.colorC04), fontSize: 16),
                    textAlign: TextAlign.left,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                _buildMidView(widget.rs),
                Container(child: BoxLabelView(boxStr: "采购需求")),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildMidView(Rs rs) {
    return Container(
      width: Macros.ScreenW(context) - 30,
      margin: EdgeInsets.fromLTRB(0, 15, 0, 15),
      child: Row(
        children: <Widget>[
          new Expanded(
              child: Text.rich(
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
          )),
          new Expanded(
            child: Text(
              "${widget.rs.time}截止报名",
              style: TextStyle(color: Color(STColors.colorC05), fontSize: 14),
              textAlign: TextAlign.right,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
