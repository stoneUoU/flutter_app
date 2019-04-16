import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/Common/Config/STStyle.dart';
import 'package:flutter_app/Macros.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_app/Common/Util/HudTips.dart';
import 'package:flutter_app/Common/Util/NetTools.dart';
import 'package:flutter_app/Common/Util/LocalData.dart';
import '../../Start(登录)/CodeLoginViewController.dart';

import 'package:flutter_app/Common/Util/EventBusTools.dart';
import '../../Start(登录)/Model/LoginEvent.dart';

import '../Model/MineMs.dart';
import 'package:flutter_marquee/flutter_marquee.dart';

class FollowViewController extends StatefulWidget {
  FollowViewController({Key key}) : super(key: key);

  @override
  _FollowViewController createState() => _FollowViewController();
}

class _FollowViewController extends State<FollowViewController> {
  //从手机中选择的图片
  File _image;

  String avaterNetStr = "";

  MineMs mineMs;

  MineChildMs mineChildMs;

  @override
  void initState() {
    super.initState();
    if (!mounted) return;
    _setNet(0);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
        body: new Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Color(STColors.colorC02),
            child: new Column(
              children: <Widget>[
                new Container(
                  margin: EdgeInsets.fromLTRB(0, 30.0, 0, 0),
                  child: GestureDetector(
                    onTap: () {
                      // 按下
                      showPickDialog();
                    },
                    child: new Center(
                      child: intoAvaterIMV(),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // 按下
                    print("按下了哈哈哈哈哈");
                  },
                  child: new Center(
                    child: new Text(mineMs == null ? "" : mineMs.nick_name,
                        style:
                            new TextStyle(fontSize: 24.0, color: Colors.white),
                        textAlign: TextAlign.left),
                  ),
                )
              ],
            )));
  }

  //渲染头像:
  Widget intoAvaterIMV() {
    if (mineMs == null) {
      if (_image == null) {
        return new Image.asset(
          "assets/images/avater_icon.png",
          width: 60.0,
          height: 60.0,
        );
      } else {
        return new Container(
          width: 60.0,
          height: 60.0,
          decoration: new BoxDecoration(
              shape: BoxShape.circle,
              image: new DecorationImage(
                  image: new FileImage(_image), fit: BoxFit.cover),
              border: new Border.all(color: Colors.white, width: 2.0)),
        );
      }
    } else {
      if (_image != null) {
        return new Container(
          width: 60.0,
          height: 60.0,
          decoration: new BoxDecoration(
              shape: BoxShape.circle,
              image: new DecorationImage(
                  image: new FileImage(_image), fit: BoxFit.cover),
              border: new Border.all(color: Colors.white, width: 2.0)),
        );
      } else {
        return new Container(
          width: 60.0,
          height: 60.0,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: FadeInImage.assetNetwork(
              placeholder: "assets/images/avater_icon.png",
              image: "${Macros.PicUrl}${mineMs.avatar}",
              fit: BoxFit.cover,
            ),
          ),
        );
      }
    }
  }

  // 显示弹窗
  showPickDialog() {
    showModalBottomSheet(context: context, builder: _bottomPick);
  }

// 构建弹窗
  Widget _bottomPick(BuildContext context) {
    return initImgPick();
  }

  Future<String> getImgPick(ImageSource source) async {
    var benIMG = await ImagePicker.pickImage(source: source);
    setState(() {
      _image = benIMG;
    });
    _uploadIMV(benIMG);
  }

  _uploadIMV(File f) {
    Future<String> loginFlagStr = LocalData.getPreference("AuthosStr");
    loginFlagStr.then((String loginFlagStr) {
      _intoDataBase(f, loginFlagStr);
    });
  }

  // 上传图片
  _intoDataBase(File f, String authosStr) async {
//		HudTips.showNetToast(context);
    String url = "upload";
    FormData formData =
        new FormData.from({"file": new UploadFileInfo(f, "avater.jpg")});
    var feedBack =
        await NetTools().post(url, data: formData, authosStr: authosStr);
    HudTips.showToast(json.decode(feedBack)["msg"]);
//		Navigator.pop(context);
    if (json.decode(feedBack)["code"] == 0) {
      avaterNetStr = json.decode(feedBack)["data"]["file_url"][0];
      //修改头像:
      _setNet(1);
    }
  }

  Widget initImgPick() {
    return new Container(
        height: 170.0,
        child: new Column(
          children: <Widget>[
            new InkWell(
              child: new Container(
                child: new Text(
                  '拍照',
                  style: new TextStyle(color: Colors.black, fontSize: 15.0),
                ),
                height: 60.0,
                alignment: Alignment.center,
              ),
              onTap: (() {
                Navigator.of(context).pop();
                getImgPick(ImageSource.camera);
              }),
            ),
            new Divider(
              height: 1.0,
            ),
            new InkWell(
              onTap: (() {
                Navigator.of(context).pop();
                getImgPick(ImageSource.gallery);
              }),
              child: new Container(
                child: new Text(
                  '从手机相册选择',
                  style: new TextStyle(color: Colors.black, fontSize: 15.0),
                ),
                height: 60.0,
                alignment: Alignment.center,
              ),
            ),
            new Container(
              height: 5.0,
              color: new Color(0xfff2f2f2),
            ),
            new Container(
              child: new Text(
                '取消',
                style: new TextStyle(color: Colors.black, fontSize: 15.0),
              ),
              height: 40.0,
              alignment: Alignment.center,
            )
          ],
        ));
  }

  _setNet(int intValue) {
    Future<String> loginFlagStr = LocalData.getPreference("AuthosStr");
    loginFlagStr.then((String loginFlagStr) {
      if (intValue == 0) {
        _setInfoData(loginFlagStr);
      } else if (intValue == 1) {
        _modifyPersonData(loginFlagStr);
      }
    });
  }

  _setInfoData(String authosStr) async {
    
    String url = "user/list";
    print("_FollowViewController  已发送请求");
//    var data = {};
//    var feedBack = await NetTools().get(url, data: data, authosStr: authosStr);
//    print("MMMMM____${json.decode(feedBack)}");
//    if (json.decode(feedBack)["code"] == 0) {
//      setState(() {
//        mineMs = new MineMs.fromJSON(json.decode(feedBack)["data"]);
//        mineChildMs = new MineChildMs.fromJSON(
//            json.decode(feedBack)["data"]["order_num"]);
//        mineMs.order_num = mineChildMs;
//      });
//    } else if (json.decode(feedBack)["code"] == 10009) {
//      HudTips.showToast(json.decode(feedBack)["msg"]);
//      LocalData.setPreference("AuthosStr", "");
//      EventBusTools.eventBus.fire(new LoginEvent(null));
//      Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
//        return new CodeLoginViewController(
//          code: 1,
//        );
//      }));
//    } else {
//      HudTips.showToast(json.decode(feedBack)["msg"]);
//    }
  }

  _modifyPersonData(String authosStr) async {
    if (avaterNetStr != "") {
      String url = "user/info/modify";
      var data = {"avatar": avaterNetStr};
      var feedBack =
          await NetTools().post(url, data: data, authosStr: authosStr);
      print(feedBack);
    }
  }

//  _setEventBus() {
//    EventBusTools.eventBus.on<LoginEvent>().listen((event) {
//      if (!mounted) return;
//      print("====================");
//      setState(() {
//        if (event != null && event.token != null) {
//          print("FollowViewController_setEventBus");
//          _setNet(0);
//        } else {
//          print("空空如也+++++++++++++++++++  ");
//        }
//      });
//    });
//  }
}
