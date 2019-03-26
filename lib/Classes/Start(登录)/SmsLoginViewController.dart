import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:flutter_app/Macros.dart';
import 'package:flutter_app/Common/STStyle.dart';
import 'package:flutter_app/Common/EnsureVisibleWhenFocused.dart';
import 'package:flutter_app/Util/NetTools.dart';
import 'package:flutter_app/Util/ValidatedTools.dart';
import 'package:flutter_app/Util/HudTips.dart';
import 'package:flutter_app/Util/LocalData.dart';
import './CustomerTabBarPage.dart';
import 'package:flutter_app/Util/EventBusTools.dart';
import './Model/LoginEvent.dart';

class SmsLoginViewController extends StatefulWidget {
	
	int code;   //code == 1 code 1 ---> 登录失效跳转   code 2 ---> 点击发现    code 3 ---> 点击我的
	
	/// 倒计时的秒数，默认60秒。
	final int countdown = 60;
	
	SmsLoginViewController({Key key}) : super(key: key);
	
	@override
	
	_SmsLoginViewController createState() => _SmsLoginViewController();
}

class _SmsLoginViewController extends State<SmsLoginViewController> {
	
	/// 倒计时的计时器。
	Timer _timer;
	/// 当前倒计时的秒数。
	int _seconds;
	
	/// 当前墨水瓶（`InkWell`）的文本。
	String _verifyStr = '获取验证码';
	
	//手机号的控制器
	TextEditingController telController = TextEditingController();
	
	//密码的控制器
	TextEditingController smsController = TextEditingController();
	
	FocusNode _telFocusNode = FocusNode();
	
	FocusNode _smsFocusNode = FocusNode();
	
	@override
	void initState() {
		super.initState();
		_seconds = widget.countdown;
	}
	
	/// 启动倒计时的计时器。
	void _startTimer() {
		// 计时器（`Timer`）组件的定期（`periodic`）构造函数，创建一个新的重复计时器。
		_timer = Timer.periodic(
		  Duration(seconds: 1),
			(timer) {
			  if (_seconds == 0) {
				  _cancelTimer();
				  _seconds = widget.countdown;
				  if (!mounted) {
					  return;
				  }
				  setState(() {});
				  return;
			  }
			  _seconds--;
			  _verifyStr = '已发送$_seconds'+'s';
			  if (!mounted) {
				  return;
			  }
			  setState(() {});
			  if (_seconds == 0) {
				  _verifyStr = '重新发送';
			  }
		  });
	}
	
	/// 取消倒计时的计时器。
	void _cancelTimer() {
		// 计时器（`Timer`）组件的取消（`cancel`）方法，取消计时器。
		_timer?.cancel();
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
		  behavior: HitTestBehavior.translucent,
		  onTap: () { // 按下
			  print("按下了哈哈哈哈哈");
			  _telFocusNode.unfocus();
			  _smsFocusNode.unfocus();
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
												  child: new Image.asset('images/login_pic.png'),
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
												  width: Macros.ScreenW(context) - 140,
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
											  ),GestureDetector(
												  onTap:(_seconds == widget.countdown) ? () {
														_telFocusNode.unfocus();
														_smsFocusNode.unfocus();
														_smsNet("15717914505");
														} : null,
												  child: new Container(
													    width: 105,
												        margin:EdgeInsets.fromLTRB(0, 32.0, 0,0),
												        padding:EdgeInsets.fromLTRB(0, 0, 20,0),
												        child: new Text(_verifyStr,
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
												color:Color(STColors.colorC11)
											  ),
										  ],
									  ),
									  new Row(
										  children: <Widget>[
											  new Container(
												  margin:EdgeInsets.fromLTRB(5, 15.0, 0,0),
												  height:50,
												  width: Macros.ScreenW(context)-30,
												  child:new EnsureVisibleWhenFocused(
													focusNode: _smsFocusNode,
													child: TextField(
														autocorrect: false,
														focusNode: _smsFocusNode,
														controller: smsController,
														obscureText: true,//是否是密码
														textAlign: TextAlign.left,//文本对齐方式
														style: TextStyle(fontSize: 16.0, color: Colors.black),//输入文本的样式
														decoration: InputDecoration(
															fillColor: Colors.white,
															filled: true,
															hintText: '请输入验证码',
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
											  )
										  ],
									  ),
									  new Row(
										  children: <Widget>[
											  new Container(
												margin:EdgeInsets.fromLTRB(0, 0, 0,0),
												height:1,
												width: Macros.ScreenW(context) - 30,
												color:Color(STColors.colorC11)
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
														_loginNet("15717914505","843679");
													},
													shape: StadiumBorder(),
													child: new Text("登录",style: TextStyle(fontSize: 16.0,color: Colors.white)),
													color:Color(STColors.colorC09),
												)
											  ),
										  ],
									  ),
									  new Row(
										  children: <Widget>[
											  new Container(
											        margin:EdgeInsets.fromLTRB(0, 30.0, 0,0),
											        width:Macros.ScreenW(context) - 30,
											        child:new Center(
												        child: new Text("未注册手机登录后自动注册",
												          style: new TextStyle(fontSize: 16.0, color: Colors.black45),
												          textAlign: TextAlign.right
												        ),
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
							    Navigator.pop(context,1);
						    },
						    child: new Container(
							    width:60,
							    color:Colors.white,
							    height: kToolbarHeight,
							    child: Row(
								    children: <Widget>[
									    new Image.asset('images/login_icon_guanbi.png')
								    ],
							    ),
						    ),
					    ),
				    ),
				    new Align(
					    alignment: FractionalOffset.centerRight,
					    child: GestureDetector(
						    onTap: () { // 按下
							    Navigator.pop(context,0);
						    },
						    child: new Text("密码登录",
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
	
	// 这个接口api有问题
	Future<Null> _smsNet(String telStr) async {
		
		if (!ValidatedTools.MobileIsValidated(telStr)) {
			HudTips.showToast("手机号不合规范");
			return;
		} else {
			print("-----------");
			String url = "user/code";    //"user/send_sms";
			var data = {"tel":telStr,"opr":"login"};
			var feedBack = await NetTools().get(url, data: data);
			HudTips.showToast(json.decode(feedBack)["msg"]);
			if (json.decode(feedBack)["code"] == 0) {
				HudTips.showToast(json.decode(feedBack)["msg"]);
				_startTimer();
				_verifyStr = '已发送$_seconds'+'s';
				if (!mounted) {
					return;
				}
				setState(() {});
			};
		}
	}
	
	Future<Null> _loginNet(String telStr,String smsStr) async {
		
		HudTips.showNetToast(context);

		if (!ValidatedTools.MobileIsValidated(telStr)) {
			HudTips.showToast("手机号不合规范");
			return;
		} else if (!ValidatedTools.PayCodeIsValidated(smsStr)) {
			HudTips.showToast("验证码不合规范");
			return;
		} else {
			String url = "user/login/code";     //"/user/sms_login";
			var data = {"username":telStr,"code":smsStr,"registration_id":""};
			var feedBack = await NetTools().post(url, data: data);
			HudTips.showToast(json.decode(feedBack)["msg"]);
			if (json.decode(feedBack)["code"] == 0) {
				LocalData.setPreference("AuthosStr", json.decode(feedBack)["data"]["token"]);
				EventBusTools.eventBus.fire(new LoginEvent(json.decode(feedBack)["data"]["token"]));
				Navigator.pop(context);
				Navigator.pop(context,1);
				if (widget.code == 2) {
					CustomerTabBarPage.getInstance().selectedSecondTab();
				} else {
					CustomerTabBarPage.getInstance().selectedThirdTab();
				}
			} else {
				Navigator.pop(context);
			};
		}
	}
}