class KindMs {
	String code;
	String message;
	List<KindData> data;
	
	KindMs({this.code, this.message, this.data});
	
	KindMs.fromJson(Map<String, dynamic> json) {
		code = json['code'];
		message = json['message'];
		if (json['data'] != null) {
			data = new List<KindData>();
			json['data'].forEach((v) {
				data.add(new KindData.fromJson(v));
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

class KindData {
	String mallCategoryId;
	String mallCategoryName;
	List<BxMallSubDto> bxMallSubDto;
	Null comments;
	String image;
	
	KindData(
	  {this.mallCategoryId,
		  this.mallCategoryName,
		  this.bxMallSubDto,
		  this.comments,
		  this.image});
	
	KindData.fromJson(Map<String, dynamic> json) {
		mallCategoryId = json['mallCategoryId'];
		mallCategoryName = json['mallCategoryName'];
		if (json['bxMallSubDto'] != null) {
			bxMallSubDto = new List<BxMallSubDto>();
			json['bxMallSubDto'].forEach((v) {
				bxMallSubDto.add(new BxMallSubDto.fromJson(v));
			});
		}
		comments = json['comments'];
		image = json['image'];
	}
	
	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['mallCategoryId'] = this.mallCategoryId;
		data['mallCategoryName'] = this.mallCategoryName;
		if (this.bxMallSubDto != null) {
			data['bxMallSubDto'] = this.bxMallSubDto.map((v) => v.toJson()).toList();
		}
		data['comments'] = this.comments;
		data['image'] = this.image;
		return data;
	}
}

class BxMallSubDto {
	String mallSubId;
	String mallCategoryId;
	String mallSubName;
	String comments;
	
	BxMallSubDto(
	  {this.mallSubId, this.mallCategoryId, this.mallSubName, this.comments});
	
	BxMallSubDto.fromJson(Map<String, dynamic> json) {
		mallSubId = json['mallSubId'];
		mallCategoryId = json['mallCategoryId'];
		mallSubName = json['mallSubName'];
		comments = json['comments'];
	}
	
	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['mallSubId'] = this.mallSubId;
		data['mallCategoryId'] = this.mallCategoryId;
		data['mallSubName'] = this.mallSubName;
		data['comments'] = this.comments;
		return data;
	}
}