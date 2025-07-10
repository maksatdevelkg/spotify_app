import 'package:dartz/dartz.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:spotify_app/data/model/auth/create_user_req.dart';
import 'package:spotify_app/data/sources/auth/auth_firebase_service.dart';
import 'package:spotify_app/domain/repository/auth/auth.dart';
import 'package:spotify_app/service_locator.dart';

class AuthRepositoryImpl extends AuthRepository{
  @override
  Future<void> signin() async {
    
  }

  @override
  Future<Either> signup(CreateUserReq createUserReq) async {
   return await sl<AuthFirebaseService>().signup(createUserReq);
    
  }
}