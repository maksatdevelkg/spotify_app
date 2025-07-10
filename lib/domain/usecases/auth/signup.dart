import 'package:dartz/dartz.dart';
import 'package:spotify_app/core/usecases/usecase.dart';
import 'package:spotify_app/data/model/auth/create_user_req.dart';
import 'package:spotify_app/domain/repository/auth/auth.dart';
import 'package:spotify_app/service_locator.dart';

class SignupUseCase implements UseCase<Either , CreateUserReq> {
  @override
  Future<Either> call({CreateUserReq ? params}) async{
    
  return sl<AuthRepository>().signup(params!);
  }
  

}