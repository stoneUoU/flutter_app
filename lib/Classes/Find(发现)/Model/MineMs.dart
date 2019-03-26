class MineMs {
//	{
//		"tel":"15717914505",
//		"enable":true,
//		"nick_name":"User_E3w0Y8uT",
//		"gender":"0",
//		"avatar":"/static_file/upload/11/d6e12d3a4b8b11e989a602d73cffe87a.png",
//		"birthday":"2018-08-07",
//		"username":"15717914505",
//		"id":11,
//		"order_num":{
//			"no_pay":0,
//			"has_pay":0,
//			"no_delivery":0,
//			"over":0
//		},
//		"customer_service_tel":"0791-83957717"
//	},
	
	String  tel;
	bool    enable;
	String  nick_name;
	String  gender;
	String  avatar;
	String  birthday;
	String  username;
	int     id;
	MineChildMs  order_num;
	String  customer_service_tel;
	
	MineMs({
		this.tel,
		this.enable,
		this.nick_name,
		this.gender,
		this.avatar,
		this.birthday,
		this.username,
		this.id,
		this.order_num,
		this.customer_service_tel
	});
	
	MineMs.fromJSON(Map json)
	    :   tel = json['tel'],
		    enable = json['enable'],
		    nick_name = json['nick_name'],
		    gender = json['gender'],
		    avatar = json['avatar'],
			birthday = json['birthday'],
			username = json['username'],
		    id = json['id'],
		    customer_service_tel = json['customer_service_tel'];
	
	Map toMap() {
		return {
			'tel': tel,
			'enable': enable,
			'gender': gender,
			'avatar': avatar,
			'birthday': birthday,
			'username': username,
			'id': id,
			'customer_service_tel': customer_service_tel,
		};
	}
}



class MineChildMs {
//	    {
//			"no_pay":0,
//			"has_pay":0,
//			"no_delivery":0,
//			"over":0
//		}

	int     no_pay;
	int     has_pay;
	int     no_delivery;
	int     over;
	
	MineChildMs({
		this.no_pay,
		this.has_pay,
		this.no_delivery,
		this.over
	});
	
	MineChildMs.fromJSON(Map json)
	  :   no_pay = json['no_pay'],
		  has_pay = json['has_pay'],
		  no_delivery = json['no_delivery'],
		  over = json['over'];
	
	Map toMap() {
		return {
			'no_pay': no_pay,
			'has_pay': has_pay,
			'no_delivery': no_delivery,
			'over': over
		};
	}
}