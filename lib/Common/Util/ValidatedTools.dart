


class ValidatedTools {
	
	static bool MobileIsValidated(String str) {
		
		/**
		 * 移动号段正则表达式
		 */
		String CM_NUM = "^((13[4-9])|(147)|(15[0-2,7-9])|(178)|(18[2-4,7-8]))\\d{8}\$|(1705)\\d{7}\$";
		/**
		 * 联通号段正则表达式
		 */
		String CU_NUM = "^((13[0-2])|(145)|(15[5-6])|(176)|(18[5,6]))\\d{8}\$|(1709)\\d{7}\$";
		/**
		 * 电信号段正则表达式
		 */
		String CT_NUM = "^((133)|(153)|(177)|(18[0,1,9]))\\d{8}\$";

		bool isMatch1 = new RegExp(CM_NUM).hasMatch(str);

		bool isMatch2 = new RegExp(CU_NUM).hasMatch(str);

		bool isMatch3 = new RegExp(CT_NUM).hasMatch(str);

		if (isMatch1 || isMatch2 || isMatch3) {

			return true;

		} else {

			return false;
		}
		
//		String telCheck = '^((13[0-9])|(15[^4])|(166)|(17[0-8])|(18[0-9])|(19[8-9])|(147,145))\\d{8}\$';
//
//		bool isMatch = new RegExp(telCheck).hasMatch(str);
//
//		print(isMatch);
//
//		return isMatch;
	}
	
	//邮箱
	static bool EmailIsValidated(String str) {
		
		String emailCheck = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
		
		bool isMatch = new RegExp(emailCheck).hasMatch(str);
		
		return isMatch;
	}
	
	//身份证
	static bool IdCardIsValidated(String str) {
		
		String idCardCheck = "^(\\d{14}|\\d{17})(\\d|[xX])\$";
		
		bool isMatch = new RegExp(idCardCheck).hasMatch(str);
		
		return isMatch;
	}
	
	//登录密码
	static bool LoginCodeIsValidated(String str) {
		
		String loginCodeCheck = "^([a-zA-Z0-9]|[._\\-\\/\\:\\;\\(\\)\$\\&\\@\\,\\?\\!\\'\\{\\}\\#\\%\\^\\*\\+\\=\\|\\~\\<\\>\\[\\]\"]){6,16}";
		
		bool isMatch = new RegExp(loginCodeCheck).hasMatch(str);
		
		return isMatch;
	}
	
	//支付密码
	static bool PayCodeIsValidated(String str) {
		
		String payCodeCheck = "^\\d{6}\$";
		
		bool isMatch = new RegExp(payCodeCheck).hasMatch(str);
		
		return isMatch;
	}
	
	//银行卡密码
	static bool BankCardIsValidated(String str) {
		
		String bankCardCheck = "(^[1-9]\\d{5}(18|19|([23]\\d))\\d{2}((0[1-9])|(10|11|12))(([0-2][1-9])|10|20|30|31)\\d{3}[0-9Xx]\$)|(^[1-9]\\d{5}\\d{2}((0[1-9])|(10|11|12))(([0-2][1-9])|10|20|30|31)\\d{2}[0-9Xx]\$)";
		
		bool isMatch = new RegExp(bankCardCheck).hasMatch(str);
		
		return isMatch;
	}
	
	//正则校验URL
	static bool URLIsValidated(String str) {
		
		String urlCheck = "^[0-9A-Za-z]{1,50}";
		
		bool isMatch = new RegExp(urlCheck).hasMatch(str);
		
		return isMatch;
	}
	
	//正则只能输入数字和字母
	static bool CNumIsValidated(String str) {
		
		String cNumCheck = "^[A-Za-z0-9]+\$";
		
		bool isMatch = new RegExp(cNumCheck).hasMatch(str);
		
		return isMatch;
	}
}