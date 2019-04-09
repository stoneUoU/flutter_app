import 'package:flutter/material.dart';

class Macros {
	static bool dark = true;
	static ThemeData themeData = new ThemeData.light();
	static Color searchBackgroundColor = Colors.white10;
	static Color cardBackgroundColor = new Color(0xFF222222);
	static Color fontColor = Colors.white30;
	
	static double NaviH= kToolbarHeight;
	
	static double TabBarH= kBottomNavigationBarHeight;
	
	static String CMarketUrl = "https://api.cht.znrmny.com/api/cht/app/v1/";
	
	static String RainBowUrl = "https://api.chdesign.cn";//"http://192.168.1.97:8885";
	
	static String BXLifeUrl = "http://test.baixingliangfan.cn/baixing/";
	
	static String PicUrl = "https://pic.cht.znrmny.com";
	
	/** 获取屏幕宽度 */
	static double ScreenW(BuildContext context) {
		return MediaQuery.of(context).size.width;
	}
	/** 获取屏幕高度 */
	static double ScreenH(BuildContext context) {
		return MediaQuery.of(context).size.height;
	}
	/** 获取系统状态栏高度 */
	static double StatusH(BuildContext context) {
		return MediaQuery.of(context).padding.top;
	}
	
	/**  Tabbar safe bottom margin */
	static double TabbarSafeBottomM(BuildContext context) {
		return MediaQuery.of(context).padding.bottom;
	}
	
}