import 'package:rapidellete/api/api.handler.dart';
import 'package:rapidellete/api_rout/post_api_rout.dart';
import 'package:rapidellete/modal/post_data_modal.dart';

class DeleteDataList {
  static Future deleteapi({String? id}) async {
    Map<String, dynamic> reqBody = {"mobile": "7990112775", "id": id};

    var response = await API.apiHandler(
      url: APIRoute.datadelete,
      apiType: ApiType.aPost,
      body: reqBody,
    );

    print('delete response ==> $response');
    return response;
  }
}
