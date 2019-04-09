
class RainBowHomeRotationMs {
	List<NewsList> newsList;
	List<BannerList> bannerList;
	List<NewBannerList> newBannerList;
	
	RainBowHomeRotationMs({this.newsList, this.bannerList, this.newBannerList});
	
	RainBowHomeRotationMs.fromJson(Map<String, dynamic> json) {
		if (json['newsList'] != null) {
			newsList = new List<NewsList>();
			json['newsList'].forEach((v) {
				newsList.add(new NewsList.fromJson(v));
			});
		}
		if (json['bannerList'] != null) {
			bannerList = new List<BannerList>();
			json['bannerList'].forEach((v) {
				bannerList.add(new BannerList.fromJson(v));
			});
		}
		if (json['newBannerList'] != null) {
			newBannerList = new List<NewBannerList>();
			json['newBannerList'].forEach((v) {
				newBannerList.add(new NewBannerList.fromJson(v));
			});
		}
	}
	
	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		if (this.newsList != null) {
			data['newsList'] = this.newsList.map((v) => v.toJson()).toList();
		}
		if (this.bannerList != null) {
			data['bannerList'] = this.bannerList.map((v) => v.toJson()).toList();
		}
		if (this.newBannerList != null) {
			data['newBannerList'] =
			  this.newBannerList.map((v) => v.toJson()).toList();
		}
		return data;
	}
}

class NewsList {
	String news;
	
	NewsList({this.news});
	
	NewsList.fromJson(Map<String, dynamic> json) {
		news = json['news'];
	}
	
	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['news'] = this.news;
		return data;
	}
}

class BannerList {
	String imgUrl;
	String linkUrl;
	String decript;
	String bannerName;
	String thumbnailImg;
	int bannerId;
	
	BannerList(
	  {this.imgUrl,
		  this.linkUrl,
		  this.decript,
		  this.bannerName,
		  this.thumbnailImg,
		  this.bannerId});
	
	BannerList.fromJson(Map<String, dynamic> json) {
		imgUrl = json['imgUrl'];
		linkUrl = json['linkUrl'];
		decript = json['decript'];
		bannerName = json['bannerName'];
		thumbnailImg = json['thumbnailImg'];
		bannerId = json['bannerId'];
	}
	
	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['imgUrl'] = this.imgUrl;
		data['linkUrl'] = this.linkUrl;
		data['decript'] = this.decript;
		data['bannerName'] = this.bannerName;
		data['thumbnailImg'] = this.thumbnailImg;
		data['bannerId'] = this.bannerId;
		return data;
	}
}

class NewBannerList {
	String imgUrl;
	String linkUrl;
	String decript;
	String bannerName;
	String thumbnailImg;
	int bannerId;
	
	NewBannerList(
	  {this.imgUrl,
		  this.linkUrl,
		  this.decript,
		  this.bannerName,
		  this.thumbnailImg,
		  this.bannerId});
	
	NewBannerList.fromJson(Map<String, dynamic> json) {
		imgUrl = json['imgUrl'];
		linkUrl = json['linkUrl'];
		decript = json['decript'];
		bannerName = json['bannerName'];
		thumbnailImg = json['thumbnailImg'];
		bannerId = json['bannerId'];
	}
	
	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['imgUrl'] = this.imgUrl;
		data['linkUrl'] = this.linkUrl;
		data['decript'] = this.decript;
		data['bannerName'] = this.bannerName;
		data['thumbnailImg'] = this.thumbnailImg;
		data['bannerId'] = this.bannerId;
		return data;
	}
}