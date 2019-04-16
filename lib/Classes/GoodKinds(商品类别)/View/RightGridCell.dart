import 'package:flutter/material.dart';
import '../Model/GoodMs.dart';
import 'package:flutter_app/Common/Config/STStyle.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

//flutter闭包与android类似的
typedef void OnRightGridCellClickListener(GoodData goodData);

class RightGridCell extends StatefulWidget {
  
  GoodData goodData;

  OnRightGridCellClickListener onRightGridCellClickListener;

  RightGridCell({Key key, this.goodData, this.onRightGridCellClickListener}) : super(key: key);
  @override
  _RightGridCellState createState() => _RightGridCellState();
}

class _RightGridCellState extends State<RightGridCell> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onRightGridCellClickListener(widget.goodData);
      },
      child: Container(
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: Container(
                margin: EdgeInsets.only(top: 10),
                height: 88,
                child: new FadeInImage.assetNetwork(
                  placeholder: "assets/images/placeSite.jpg",
                  fadeInDuration: const Duration(seconds: 1), // 持续时间，默认 700 ms
                  image: "${widget.goodData.image}",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(10, 5.00, 10, 0),
              child: Text(
                "${widget.goodData.goodsName}",
                style: TextStyle(color: Colors.red, fontSize: ScreenUtil().setSp(24)),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Container(
              child: Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.fromLTRB(10, 5.0, 0, 0),
                    child: Text(
                      "￥${widget.goodData.presentPrice}",
                      style: TextStyle(
                        color: Color(STColors.colorC10), fontSize: ScreenUtil().setSp(24)),
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(10, 5.0, 0, 0),
                    child: Text(
                      "￥${widget.goodData.oriPrice}",
                      style: new TextStyle(
                        fontSize: ScreenUtil().setSp(24),
                        color: Colors.black26,
                        decorationColor: Colors.black26, //线的颜色
                        decoration: TextDecoration
                          .lineThrough, //none无文字装饰   lineThrough删除线   overline文字上面显示线    underline文字下面显示线
                        decorationStyle: TextDecorationStyle.solid,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  )
                ],
              ),
            ),
          ],
        )),
    );
  }
}
