import 'package:google_sign_in/google_sign_in.dart';
import 'package:app_logic/database.dart';
import 'package:firebase_auth/firebase_auth.dart';


class AuthenticationService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Database _db = Database();
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Stream<User?> get authStateChanges => _auth.authStateChanges();

  String? get currentUserId => _auth.currentUser?.uid;

  //inicio de sesion con correo electronico
  Future<User?> signInWithEmail(String email, String password) async {
    try{
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email, 
        password: password,
      );
      return result.user;
    } on FirebaseAuthException catch(e){
      print(e.message);
      return null;
    }
  }
  
  //registro de usuario con correo electronuco 
  Future<User?> registerWithEmail(
    String email,
    String password,
    String name,
    String lastname,
    String username,
    DateTime birthdate,
  ) async {
    try{
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email, 
        password: password,
      );
      User? user = result.user;

      if (user != null){
        await _db.updateUserData(
          uid: user.uid,
          email: email,
          name: name,
          lastname:lastname,
          username: username,
          birthdate: birthdate
        );
      }
      return user;
    } on FirebaseAuthException catch (e){
      print(e.message);
      return null;
    }
  }


  Future<User?>signInWithGoogle() async {

    try{
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null){
        return null;
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential = await _auth.signInWithCredential(credential);

      User? user = userCredential.user;

      if (user != null && userCredential.additionalUserInfo?.isNewUser == true){
        final nameParts = user.displayName?.split(' ') ?? [''];
        final name = nameParts.first;
        final lastname = nameParts.length > 1 ? nameParts.sublist(1). join(' '): '';
        final username = user.email?.split('@').first ?? user.uid;

        await _db.updateUserData(
          uid: user.uid, 
          email: user.email ?? '', 
          name: name, 
          lastname: lastname, 
          username: username, 
          birthdate: null,
          );
      }

      return user;
    }on FirebaseAuthException catch (e){
      print('Error de firebase Auth (Google): ${e.message}');
      return null;
    } catch (e){
      print('Error desconocido (Google): ${e.toString()}');
      return null;
    }


  }








  //cerrar sesion
  Future<void>signOut() async {
    await _auth.signOut();
  }
}
