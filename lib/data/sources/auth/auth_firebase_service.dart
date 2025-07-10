import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:spotify_app/data/model/auth/create_user_req.dart';

abstract class AuthFirebaseService {

  Future<Either> signup(CreateUserReq CreateUserReq);

  Future <void> signin ();
 }


 class AuthFirebaseServiceImpl extends AuthFirebaseService {
  @override
  Future<void> signin() {
    
    throw UnimplementedError();
  }
 
  @override
  Future<Either> signup(CreateUserReq CreateUserReq) async {
    try {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: CreateUserReq.email, 
      password: CreateUserReq.password);


      return Right('Signup was Successful');
    } on FirebaseAuthException catch(e) {
       String messege = '';
       if(e.code == 'weak-password') {
        messege = 'The password provided is too weak';
       } else if (e.code == 'email-already-in-use') {
        messege = 'An account already exists with that email.';
       }
       return Left(messege);
    }
  
  }


  
 }