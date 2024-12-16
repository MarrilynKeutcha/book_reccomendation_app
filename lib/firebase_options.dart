import 'package:firebase_core/firebase_core.dart';

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    return const FirebaseOptions(
      apiKey: 'AIzaSyAAO5kXF8U-2Mx4cst8SH5x5N6qRju9OWw', //API Key
      appId: '1:292250179052:android:873b0e3193c71012a3dcc9', // App ID 
      messagingSenderId: '292250179052', // Project Number
      projectId: 'bookrecommendation-55e02', // Project ID
      storageBucket: 'bookrecommendation-55e02.appspot.com', 
      authDomain: 'bookrecommendation-55e02.firebaseapp.com', // Auth Domain
      measurementId: null, 
    );
  }
}
