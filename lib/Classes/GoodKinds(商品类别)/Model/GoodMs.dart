class GoodMs {
	String code;
	String message;
	List<GoodData> data;
	
	GoodMs({this.code, this.message, this.data});
	
	GoodMs.fromJson(Map<String, dynamic> json) {
		code = json['code'];
		message = json['message'];
		if (json['data'] != null) {
			data = new List<GoodData>();
			json['data'].forEach((v) {
				data.add(new GoodData.fromJson(v));
			});
		}
	}
	
	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['code'] = this.code;
		data['message'] = this.message;
		if (this.data != null) {
			data['data'] = this.data.map((v) => v.toJson()).toList();
		}
		return data;
	}
}

class GoodData {
	double oriPrice;
	String image;
	String goodsId;
	double presentPrice;
	String goodsName;
	
	GoodData(
	  {this.oriPrice,
		  this.image,
		  this.goodsId,
		  this.presentPrice,
		  this.goodsName});
	
	GoodData.fromJson(Map<String, dynamic> json) {
		oriPrice = json['oriPrice'];
		image = json['image'];
		goodsId = json['goodsId'];
		presentPrice = json['presentPrice'];
		goodsName = json['goodsName'];
	}
	
	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['oriPrice'] = this.oriPrice;
		data['image'] = this.image;
		data['goodsId'] = this.goodsId;
		data['presentPrice'] = this.presentPrice;
		data['goodsName'] = this.goodsName;
		return data;
	}
}