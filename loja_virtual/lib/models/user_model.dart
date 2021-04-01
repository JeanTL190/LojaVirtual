import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:loja_virtual/screens/signupGoogle_screen.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter/material.dart';

class UserModel extends Model {
  final GoogleSignIn googleSignIn = GoogleSignIn();

  FirebaseAuth _auth = FirebaseAuth.instance;
  User firebaseUser;
  Map<String, dynamic> userData = Map();
  bool isLoading = false;
  bool withGoogle = false;

  static UserModel of(BuildContext context) =>
      ScopedModel.of<UserModel>(context);

  @override
  void addListener(listener) {
    super.addListener(listener);
    _loadCurrentUser();
  }

  Future<User> _getUser() async {
    try {
      final GoogleSignInAccount googleSignInAccount =
          await googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken);
      final UserCredential authResult =
          await FirebaseAuth.instance.signInWithCredential(credential);
      final User user = authResult.user;
      return user;
    } catch (error) {
      return null;
    }
  }

  void signInWithGoogle(
      {@required VoidCallback onFail, @required BuildContext context}) async {
    isLoading = true;
    notifyListeners();
    firebaseUser = await _getUser();
    isLoading = false;
    notifyListeners();

    if (firebaseUser == null) {
      onFail();
    } else {
      withGoogle = true;
      DocumentSnapshot docUser = await FirebaseFirestore.instance
          .collection("users")
          .doc(firebaseUser.uid)
          .get();
      print(docUser.exists);
      if (docUser.exists) {
        await _loadCurrentUser();
        Navigator.of(context).pop();
      } else {
        Navigator.of(context).pop();
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => SignUpScreenGoogle(firebaseUser)));
      }
    }
  }

  Future<Null> saveUserDataGoogle(
      Map<String, dynamic> userData, User usuario, BuildContext context) async {
    isLoading = true;
    notifyListeners();
    this.userData = userData;
    await FirebaseFirestore.instance
        .collection("users")
        .doc(usuario.uid)
        .set(userData);
    isLoading = false;
    notifyListeners();
    Navigator.of(context).pop();
  }

  void signUp(
      {@required Map<String, dynamic> userData,
      @required String pass,
      @required VoidCallback onSucess,
      @required VoidCallback onFail}) {
    isLoading = true;
    notifyListeners();
    _auth
        .createUserWithEmailAndPassword(
            email: userData["email"], password: pass)
        .then((user) async {
      firebaseUser = user.user;
      await _saveUserData(userData);
      onSucess();
      isLoading = false;
      notifyListeners();
    }).catchError((e) {
      onFail();
      isLoading = false;
      notifyListeners();
    });
  }

  void signIn(
      {@required String email,
      @required String pass,
      @required VoidCallback onSucess,
      @required VoidCallback onFail}) async {
    isLoading = true;
    notifyListeners();
    _auth
        .signInWithEmailAndPassword(email: email, password: pass)
        .then((user) async {
      firebaseUser = user.user;
      await _loadCurrentUser();
      onSucess();
      isLoading = false;
      notifyListeners();
    }).catchError((e) {
      onFail();
      isLoading = false;
      notifyListeners();
    });
  }

  void signOut() async {
    if (!withGoogle) {
      await _auth.signOut();
      userData = Map();
      firebaseUser = null;
      notifyListeners();
    } else {
      withGoogle = false;
      await googleSignIn.signOut();
      await _auth.signOut();
      userData = Map();
      firebaseUser = null;
      notifyListeners();
    }
  }

  void recoverPass(String email, BuildContext context) {
    _auth.sendPasswordResetEmail(email: email).then((value) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Confira seu e-mail!"),
        backgroundColor: Theme.of(context).primaryColor,
        duration: Duration(seconds: 2),
      ));
    }).catchError((e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("E-mail inválido ou não cadastrado!"),
        backgroundColor: Colors.redAccent,
        duration: Duration(seconds: 2),
      ));
    });
  }

  bool isLoggedIn() {
    return firebaseUser != null;
  }

  Future<Null> _loadCurrentUser() async {
    if (firebaseUser == null) firebaseUser = await _auth.currentUser;
    if (firebaseUser != null) {
      if (userData["name"] == null) {
        DocumentSnapshot docUser = await FirebaseFirestore.instance
            .collection("users")
            .doc(firebaseUser.uid)
            .get();
        userData = docUser.data();
      }
    }
    notifyListeners();
  }

  Future<Null> _saveUserData(Map<String, dynamic> userData) async {
    this.userData = userData;
    await FirebaseFirestore.instance
        .collection("users")
        .doc(firebaseUser.uid)
        .set(userData);
  }
}
