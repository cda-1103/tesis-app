
import 'package:app_logic/database.dart';
import 'package:firebase_auth/firebase_auth.dart';


class AuthenticationService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Database _db = Database();

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


  Future<String> sendPasswordResetEmail(String email) async {

    try{
      await _auth.sendPasswordResetEmail(email: email);
      return "success";
    } on FirebaseAuthException catch (e) {
      print(e.message);
      if (e.code == 'user-not-found'){
        return 'No se encontró ningun usuario con este correo.';
      } else if (e.code == 'invalid-email') {
        return 'El formato del correo no es válido,';
      }
      return 'Ocurrio un error. Intentalo de nuevo.';
    }
  }


  //cerrar sesion
  Future<void>signOut() async {
    await _auth.signOut();
  }
}
