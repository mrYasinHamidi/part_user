import 'package:dio/dio.dart';
import 'package:part_user/models/user_data_request.dart';

///Repository of all app's api call
class ApiRepository {
  final Dio _dio = Dio()
    ..options = BaseOptions(
      baseUrl: 'https://reqres.in/',
      connectTimeout: 5000,
      receiveTimeout: 5000,
      sendTimeout: 5000,
    );

  ///Get all Users data
  ///Failed case => return model with  status code  400
  ///Success case => return model with status code 200
  Future<UsersDataResponse> getUsers({int page = 2}) async {
    UsersDataResponse usersDataResponse;
    try {
      String url = 'api/users?page=$page';

      Response response = await _dio.get(url);

      ///return Response with returned data
      usersDataResponse = UsersDataResponse.fromJson(response.data);
      usersDataResponse.statusCode = 200;
    } catch (e) {
      ///return Response with failed status code
      usersDataResponse = UsersDataResponse(statusCode: 400);
    }
    return usersDataResponse;
  }

  ///Delete user api
  ///Failed case => return false
  ///Success case => return true
  Future<bool> deleteUser(int id) async {
    try {
      String url = 'api/users$id';
      Response response = await _dio.delete(url);
      return response.statusCode! >= 200 && response.statusCode! < 300;
    } catch (e) {
      return false;
    }
  }
}
