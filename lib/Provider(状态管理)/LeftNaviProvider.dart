
import 'package:flutter/material.dart';
import '../Classes/GoodKinds(商品类别)/Model/KindMs.dart';

class LeftNaviProvider with ChangeNotifier {
	
	List<int> _leftClickFlag = [];
	
	KindData _kindData;
	
	String _categoryId;
	
	List<int> get leftClickFlag => _leftClickFlag;
	
	KindData get kindData => _kindData;
	
	String get categoryId => _categoryId;
	
	LeftNaviProvider(this._kindData);
	
	
	void putKindDataValue(KindData kindData) {
		_kindData = kindData;
		notifyListeners();
	}
	
	void putLeftClickFlag(List<int> value) {
		_leftClickFlag = value;
		notifyListeners();
	}
	
	void putCategoryId(String categoryId) {
		_categoryId = categoryId;
		notifyListeners();
	}
}
