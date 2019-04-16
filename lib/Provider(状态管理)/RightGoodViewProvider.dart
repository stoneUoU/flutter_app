
import 'package:flutter/material.dart';
import '../Classes/GoodKinds(商品类别)/Model/GoodMs.dart';

class RightGoodViewProvider with ChangeNotifier {
	
	List<int> _topClickFlag = [];
	
	GoodMs _goodMs;
	
	String _categorySubId;
	
	List<int> get topClickFlag => _topClickFlag;
	
	GoodMs get goodMs => _goodMs;
	
	String get categorySubId => _categorySubId;
	
	RightGoodViewProvider();
	
	void putTopClickFlag(List<int> value) {
		_topClickFlag = value;
		notifyListeners();
	}
	
	void putGoodMs(GoodMs value) {
		_goodMs = value;
		notifyListeners();
	}
	
	void putCategorySubId(String categorySubId) {
		_categorySubId = categorySubId;
		notifyListeners();
	}
}
