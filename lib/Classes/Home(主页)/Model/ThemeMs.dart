class ThemeMs {
	List<DList> dList;
	String reference;
	
	ThemeMs({this.dList, this.reference});
	
	ThemeMs.fromJson(Map<String, dynamic> json) {
		if (json['dList'] != null) {
			dList = new List<DList>();
			json['dList'].forEach((v) {
				dList.add(new DList.fromJson(v));
			});
		}
		reference = json['reference'];
	}
	
	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		if (this.dList != null) {
			data['dList'] = this.dList.map((v) => v.toJson()).toList();
		}
		data['reference'] = this.reference;
		return data;
	}
}

class DList {
	String dUserIdRsa;
	bool isEnsure;
	String area;
	List<ImgInfos> imgInfos;
	String headimg;
	int duserId;
	String service;
	bool isForeign;
	String opinion;
	String serviceTitle;
	String duserName;
	bool isMaster;
	List<String> imgs;
	
	DList(
	  {this.dUserIdRsa,
		  this.isEnsure,
		  this.area,
		  this.imgInfos,
		  this.headimg,
		  this.duserId,
		  this.service,
		  this.isForeign,
		  this.opinion,
		  this.serviceTitle,
		  this.duserName,
		  this.isMaster,
		  this.imgs});
	
	DList.fromJson(Map<String, dynamic> json) {
		dUserIdRsa = json['dUserIdRsa'];
		isEnsure = json['isEnsure'];
		area = json['area'];
		if (json['imgInfos'] != null) {
			imgInfos = new List<ImgInfos>();
			json['imgInfos'].forEach((v) {
				imgInfos.add(new ImgInfos.fromJson(v));
			});
		}
		headimg = json['headimg'];
		duserId = json['duserId'];
		service = json['service'];
		isForeign = json['isForeign'];
		opinion = json['opinion'];
		serviceTitle = json['serviceTitle'];
		duserName = json['duserName'];
		isMaster = json['isMaster'];
		imgs = json['imgs'].cast<String>();
	}
	
	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['dUserIdRsa'] = this.dUserIdRsa;
		data['isEnsure'] = this.isEnsure;
		data['area'] = this.area;
		if (this.imgInfos != null) {
			data['imgInfos'] = this.imgInfos.map((v) => v.toJson()).toList();
		}
		data['headimg'] = this.headimg;
		data['duserId'] = this.duserId;
		data['service'] = this.service;
		data['isForeign'] = this.isForeign;
		data['opinion'] = this.opinion;
		data['serviceTitle'] = this.serviceTitle;
		data['duserName'] = this.duserName;
		data['isMaster'] = this.isMaster;
		data['imgs'] = this.imgs;
		return data;
	}
}

class ImgInfos {
	String imgUrl;
	String remark;
	int height;
	int width;
	int imgId;
	
	ImgInfos({this.imgUrl, this.remark, this.height, this.width, this.imgId});
	
	ImgInfos.fromJson(Map<String, dynamic> json) {
		imgUrl = json['imgUrl'];
		remark = json['remark'];
		height = json['height'];
		width = json['width'];
		imgId = json['imgId'];
	}
	
	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['imgUrl'] = this.imgUrl;
		data['remark'] = this.remark;
		data['height'] = this.height;
		data['width'] = this.width;
		data['imgId'] = this.imgId;
		return data;
	}
}