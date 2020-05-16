import 'package:docshelper/myStorage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';


final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();

Future<void> signInWithGoogle() async {
  final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
  final GoogleSignInAuthentication googleSignInAuthentication =
  await googleSignInAccount.authentication;

  final AuthCredential credential = GoogleAuthProvider.getCredential(
    accessToken: googleSignInAuthentication.accessToken,
    idToken: googleSignInAuthentication.idToken,
  );

  final AuthResult authResult = await _auth.signInWithCredential(credential);
  final FirebaseUser user = authResult.user;

  assert(!user.isAnonymous);
  assert(await user.getIdToken() != null);

  final FirebaseUser currentUser = await _auth.currentUser();
  UserEmail=currentUser.email;
  assert(user.uid == currentUser.uid);
  if(UserEmail!=null){
    isSignedIn=true;
  }
}

void signOutGoogle() async{
  await googleSignIn.signOut();
  UserEmail=null;
  isSignedIn=false;
  myRooms=[];
  data=[];
  isInitialized=false;
  IDoFRoomStorage=null;
}
//Reference  : https://medium.com/flutter-community/flutter-implementing-google-sign-in-71888bca24ed