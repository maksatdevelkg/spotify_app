import 'package:dartz/dartz.dart';
import 'package:spotify_app/core/usecases/usecase.dart';
import 'package:spotify_app/data/model/auth/create_user_req.dart';
import 'package:spotify_app/data/model/auth/signin_user_req.dart';
import 'package:spotify_app/domain/repository/auth/auth.dart';
import 'package:spotify_app/service_locator.dart';

class SigninUseCase implements UseCase<Either , SigninUserReq> {
  @override
  Future<Either> call({SigninUserReq ? params}) async{
    
  return sl<AuthRepository>().signin(params!);
  }
  

}