import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:flutter_app/Macros.dart';
import 'package:flutter_app/Common/Config/STStyle.dart';
import 'package:flutter_app/Common/EnsureVisibleWhenFocused.dart';
import './SmsLoginViewController.dart';
import './CustomerTabBarPage.dart';

import 'package:flutter_app/Common/Util/CommonUntil.dart';
import 'package:flutter_app/Common/Util/NetTools.dart';
import 'package:flutter_app/Common/Util/ValidatedTools.dart';
import 'package:flutter_app/Common/Util/HudTips.dart';
import 'package:flutter_app/Common/Util/LocalData.dart';
import 'package:flutter_app/Common/Util/EventBusTools.dart';

import './Model/LoginEvent.dart';

class CodeLoginViewController extends StatefulWidget {
	
	int code;   //code == 1 code 1 ---> 登录失效跳转   code 2 ---> 点击发现    code 3 ---> 点击我的
	
	CodeLoginViewController({Key key,this.code}) : super(key: key);
	
	@override
	
	_CodeLoginViewController createState() => _CodeLoginViewController();
}

class _CodeLoginViewController extends State<CodeLoginViewController> {
	
	//手机号的控制器
	TextEditingController telController = TextEditingController();
	
	//密码的控制器
	TextEditingController codeController = TextEditingController();
	
	FocusNode _telFocusNode = FocusNode();
	
	FocusNode _codeFocusNode = FocusNode();

	@override
	void initState() {
		super.initState();
	}
	
	@override
	Widget build(BuildContext context) {
		return new Scaffold(
		    body:new SingleChildScrollView(
			    child:_getBody() ,
		    )
		);
	}
	
	Widget _getBody() {
		return GestureDetector(
		    onTap: () { // 按下
			    print("按下了哈哈哈哈哈");
			    _telFocusNode.unfocus();
			    _codeFocusNode.unfocus();
		    },
		    child: new Column(
				children: <Widget>[
					new Stack(
						children: <Widget>[
							new Container(
								height:Macros.ScreenH(context) - Macros.TabbarSafeBottomM(context),
								width: Macros.ScreenW(context),
								padding: EdgeInsets.fromLTRB(15, Macros.StatusH(context) + kToolbarHeight, 0, 0),
								color:Color(STColors.textWhite),
								child: new Column(
									children: <Widget>[
										new Row(
											children: <Widget>[
												new Container(
													margin:EdgeInsets.fromLTRB(0, 15.0, 0,0),
													child: new Image.asset('assets/images/login_pic.png'),
												),
											],
										),
										new Row(
											children: <Widget>[
												new Container(
													margin:EdgeInsets.fromLTRB(0, 50.0, 0,0),
													child: new Text("欢迎回来",
													  style: new TextStyle(fontSize: 18.0,fontWeight: FontWeight.w500, color: Color(STColors.colorC10)),
													  textAlign: TextAlign.left
													),
												),
											],
										),
										new Row(
											children: <Widget>[
												new Container(
												    margin:EdgeInsets.fromLTRB(5, 32.0, 0,0),
												    height:50,
												    width: Macros.ScreenW(context) - 30,
												    child:new EnsureVisibleWhenFocused(
													    focusNode: _telFocusNode,
													    child: TextField(
														    autocorrect: false,
														    focusNode: _telFocusNode,
														    controller: telController,
														    textAlign: TextAlign.left,//文本对齐方式
														    style: TextStyle(fontSize: 16.0, color: Colors.black),//输入文本的样式
														    decoration: InputDecoration(
															    fillColor: Colors.white,
															    contentPadding: const EdgeInsets.symmetric(vertical: 15.0),
															    filled: true,
															    hintText: '手机号',
															    hintStyle: TextStyle(fontSize: 16.0, color: Colors.black38),
															    border: OutlineInputBorder(
															      borderRadius: BorderRadius.circular(15),
															      borderSide: BorderSide.none
															    ),
														    ),
														    cursorColor: Color(STColors.colorC09),
													    )
												    ),
												),
											],
										),
										new Row(
											children: <Widget>[
												new Container(
													margin:EdgeInsets.fromLTRB(0, 0, 0,0),
													height:1,
													width: Macros.ScreenW(context) - 30,
													color:Color(STColors.colorC07)
												),
											],
										),
										new Row(
											children: <Widget>[
												new Container(
												    margin:EdgeInsets.fromLTRB(5, 15.0, 0,0),
												    height:50,
												    width: Macros.ScreenW(context)-120,
												    child:new EnsureVisibleWhenFocused(
													    focusNode: _codeFocusNode,
													    child: TextField(
														    autocorrect: false,
														    focusNode: _codeFocusNode,
														    controller: codeController,
														    obscureText: true,//是否是密码
														    textAlign: TextAlign.left,//文本对齐方式
														    style: TextStyle(fontSize: 16.0, color: Colors.black),//输入文本的样式
														    decoration: InputDecoration(
															    fillColor: Colors.white,
															    filled: true,
															    hintText: '登录密码',
															    contentPadding: const EdgeInsets.symmetric(vertical: 15.0),
															    hintStyle: TextStyle(fontSize: 16.0, color: Colors.black38),
															    border: OutlineInputBorder(
															      borderRadius: BorderRadius.circular(15),
															      borderSide: BorderSide.none
															    ),
														    ),
														    cursorColor: Color(STColors.colorC09),
													    )
												    ),
												),GestureDetector(
												    onTap: () { // 按下
													    _telFocusNode.unfocus();
													    _codeFocusNode.unfocus();
														print("忘记密码");
													},
													child: new Container(
											            margin:EdgeInsets.fromLTRB(0, 15.0, 0,0),
														child: new Text("忘记密码",
															style: new TextStyle(fontSize: 16.0, color: Color(STColors.colorC09)),
															textAlign: TextAlign.right
														)
													),
												)
											],
										),
										new Row(
											children: <Widget>[
												new Container(
												  margin:EdgeInsets.fromLTRB(0, 0, 0,0),
												  height:1,
												  width: Macros.ScreenW(context) - 30,
												  color:Color(STColors.colorC07)
												),
											],
										),
										new Row(
											children: <Widget>[
												new Container(
												    margin:EdgeInsets.fromLTRB(0, 58.0, 0,0),
												    height:45,
												    width: Macros.ScreenW(context) - 30,
												    child:new RaisedButton(
													    onPressed: (){
														    _loginNet("15717914505","000000");
													    },
														shape: StadiumBorder(),
													    child: new Text("登录",style: TextStyle(fontSize: 16.0,color: Colors.white)),
													    color:Color(STColors.colorC09),
												    )
												),
											],
										),
									],
								),
							),
							new Positioned(
								left: 0.0,
								right: 0.0,
								top: 0.0,
								child: _makeStatusAndNaviBar(),
							),
						],
					)
				],
			)
		);
	}
	
	
	Widget _makeStatusAndNaviBar() {
		return new Container(
		    width:Macros.ScreenW(context),
		    height:Macros.StatusH(context) + kToolbarHeight,
		    child: new Container(
			    margin: EdgeInsets.fromLTRB(15.0, Macros.StatusH(context), 15.0, 0),
			    width:Macros.ScreenW(context) - 30.0,
			    height: kToolbarHeight,
			    child:new Stack(
					children: <Widget>[
						new Align(
							alignment: FractionalOffset.centerLeft,
							child:GestureDetector(
								onTap: () { // 按下
									if (widget.code == 1) {
										Navigator.pop(context);
										CustomerTabBarPage.getInstance().selectedFirstTab();
									} else {
										Navigator.pop(context);
									}
								},
								child: new Container(
									width:60,
									color:Colors.white,
									height: kToolbarHeight,
									child: Row(
										children: <Widget>[
											new Image.asset('assets/images/login_icon_guanbi.png')
										],
									),
								),
							),
						),
						new Align(
							alignment: FractionalOffset.centerRight,
							child: GestureDetector(
								onTap: () { // 按下
									Navigator.of(context).push<Object>(new MaterialPageRoute(
									    builder: (context) {
										    return new SmsLoginViewController(
										  
										  );
									    }
									)).then((Object result) {
										if (result.toString() == "1") {
											Navigator.pop(context);
										}
									});
								},
								child: new Text("短信登录",
								    style: new TextStyle(fontSize: 14.0, color: Color(STColors.colorC09)),
								    textAlign: TextAlign.right
								),
							),
						),
					]
			    ),
		    )
		);
	}
	
	Future<Null> _loginNet(String telStr,String codeStr) async {
		
		HudTips.showNetToast(context);
		
		if (!ValidatedTools.MobileIsValidated(telStr)) {
			HudTips.showToast("手机号不合规范");
			return;
		} else if (!ValidatedTools.LoginCodeIsValidated(codeStr)) {
			HudTips.showToast("密码不合规范");
			return;
		} else {
			String url = "user/login/password"; //"/user/login";
			String md5Str = CommonUtil.generateMd5(CommonUtil.generateMd5(CommonUtil.generateMd5(codeStr)));
//			print(md5Str);
			var data = {"username":telStr,"password":md5Str,"registration_id":""};
			var feedBack = await NetTools().post(url, data: data);
			//这儿返回的是jsonStr，需转成字典：
			Navigator.pop(context);
			HudTips.showToast(json.decode(feedBack)["msg"]);
			if (json.decode(feedBack)["code"] == 0) {
				LocalData.setPreference("AuthosStr", json.decode(feedBack)["data"]["token"]);
				EventBusTools.eventBus.fire(new LoginEvent(json.decode(feedBack)["data"]["token"]));
				Navigator.pop(context);
				if (widget.code == 1) {
					CustomerTabBarPage.getInstance().selectedFirstTab();
				} else if (widget.code == 2) {
					CustomerTabBarPage.getInstance().selectedSecondTab();
				} else {
					CustomerTabBarPage.getInstance().selectedThirdTab();
				}
				
			}
		}
	}
}