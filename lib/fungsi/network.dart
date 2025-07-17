// import 'dart:io';

// class NetworkHelper {
//   static final NetworkHelper _instance = NetworkHelper._internal();

//   factory NetworkHelper() {
//     return _instance;
//   }

//   NetworkHelper._internal();

//   Future<bool> isConnected() async {
//     try {
//       final connectivityResult = await Connectivity().checkConnectivity();

//       if (connectivityResult == ConnectivityResult.none) {
//         return false;
//       }

//       // Double check dengan ping ke Google DNS
//       final result = await InternetAddress.lookup('google.com');
//       return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
//     } catch (e) {
//       return false;
//     }
//   }

//   Stream<ConnectivityResult> get onConnectivityChanged {
//     return Connectivity().onConnectivityChanged;
//   }
// }
