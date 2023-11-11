import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

import '../../app/constants.dart';
import '../response/responses.dart';

part 'app_api.g.dart';

@RestApi(baseUrl: Constants.baseUrl)
abstract class AppServiceClient {
  factory AppServiceClient(Dio dio, {String baseUrl}) = _AppServiceClient;

  @POST("auth/login")
  Future<LoginResponse> login(
      @Field("phone") String phone,
      @Field("password") String password
      );

  @POST("/auth/register")
  Future<RegisterResponse> register(
      @Field("name") String userName,
      @Field("phone") String mobileNumber,
      @Field("password") String password,
      @Field("password_confirmation") String passwordConfirm);

  @GET("/home")
  Future<HomeResponse> getHomeData();
}