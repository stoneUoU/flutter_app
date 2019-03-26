
import 'package:shared_preferences/shared_preferences.dart';

class LocalData {
	/*
        * 存储数据
        */
	static Future setPreference(String nameStr,String valueStr) async {
		SharedPreferences preferences = await SharedPreferences.getInstance();
		preferences.setString(nameStr, valueStr);
//		print('存储nameStr为:$nameStr    valueStr为:$valueStr');
	}
	/*
	    * 读取数据
	    */
	static Future<String> getPreference(String nameStr) async {
		SharedPreferences preferences = await SharedPreferences.getInstance();
		String valueStr = preferences.get(nameStr);
		return valueStr;
	}
}