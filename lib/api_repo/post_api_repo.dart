import 'package:rapidellete/api/api.handler.dart';
import 'package:rapidellete/api_rout/post_api_rout.dart';
import 'package:rapidellete/modal/post_data_modal.dart';

class DataList {
  static Future<Datamodal> postapi({
    String? mobile,
  }) async {
    Map<String, dynamic> reqBody = {
      "mobile": "7990112775",
    };

    var response = await API.apiHandler(
      url: APIRoute.datapostapi,
      apiType: ApiType.aPost,
      body: reqBody,
    );

    print('data response ==> $response');
    return datamodalFromJson(response);
  }
}
