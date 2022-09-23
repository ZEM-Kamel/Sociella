import 'package:dio/dio.dart';

class DioHelper {
  static late Dio dio;

  static init() {
    print('dioHelper Initialized');
    dio = Dio(
        BaseOptions(
          baseUrl: 'https://student.valuxapps.com/api/',
          receiveDataWhenStatusError: true,
        ));
  }

  static Future<Response> postData({
    Map<String, dynamic> ?data
  }) async
  {
    dio.options.headers =
    {
      'Content-Type': 'application/json',
      'Authorization': 'key = AAAA6b6A9Lw:APA91bFOeJ2XQOO-8LzVu_3LkJaLr5ncXOXPmmsJ-FV8M9CeEmZ6Lp9Zbwl5R21CMsmkO82iWubHylzh-RWaeueZLtzivSgHAoTszzF6fcNfNWd59ABRoSwR2bDYhVdz7zumct16Vrr6'
    };
    return await dio.post(
      'https://fcm.googleapis.com/fcm/send',
      data: data,
    );
  }
}
