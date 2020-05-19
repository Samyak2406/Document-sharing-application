import 'package:docshelper/myStorage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';


final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();

Future<void> signInWithGoogle(BuildContext context) async {
  try{final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
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
  Provider.of<emails>(context,listen: false).setemail(currentUser.email);
  userImage=currentUser.photoUrl;
  assert(user.uid == currentUser.uid);
  if(Provider.of<emails>(context,listen: false).UserEmail!=null){
    isSignedIn=true;
  }}catch(e){}
}

//void signOutGoogle(BuildContext context) async{
//  await googleSignIn.signOut();
//  Provider.of<emails>(context,listen: false).removeEmail();
//  isSignedIn=false;
//  myRooms=[];
//  data=[];
//  isInitialized=false;
//  IDoFRoomStorage=null;
//}
//Reference  : https://medium.com/flutter-community/flutter-implementing-google-sign-in-71888bca24ed