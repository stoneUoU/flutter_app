
import 'package:connectivity/connectivity.dart';

//flutter闭包与android类似的

typedef void OnNetUsefulListener(bool netUseful);

// 检测网络是否可用：
class NetworkCheck {
	
	Future<bool> check() async {
		
		var connectivityResult = await (Connectivity().checkConnectivity());
		
		if (connectivityResult == ConnectivityResult.mobile) {
			
			return true;
			
		} else if (connectivityResult == ConnectivityResult.wifi) {
			
			return true;
		}
			return false;
	}
	dynamic checkInternet(OnNetUsefulListener onNetUsefulListener) {
		
		check().then((intenet) {
			
			if (intenet != null && intenet) {
				if (onNetUsefulListener != null) {
					onNetUsefulListener(true);
				}
			} else{
				if (onNetUsefulListener != null) {
					onNetUsefulListener(false);
				}
			}
		});
	}
	
	fetchPrefrence(bool isNetworkPresent) {
		
		if(isNetworkPresent){
		
		}else{
		
		}
	}
}