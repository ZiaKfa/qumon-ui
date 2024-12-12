import 'package:http/http.dart' as http;
import 'app_exception.dart';
import 'dart:io';

class Api {
  Future<dynamic> get(String url, String basicAuth) async {
    var responseJson;
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Basic $basicAuth', // Ensure 'Basic ' prefix
        },
      );
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> post(String url, dynamic body, String basicAuth) async {
    var responseJson;
    try {
      final response = await http.post(
        Uri.parse(url),
        body: body,
        headers: {
          'Authorization': 'Basic $basicAuth', // Ensure 'Basic ' prefix
        },
      );
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> put(String url, dynamic body, String basicAuth) async {
    var responseJson;
    try {
      final response = await http.put(
        Uri.parse(url),
        body: body,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Basic $basicAuth', // Ensure 'Basic ' prefix
        },
      );
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> delete(String url, String basicAuth) async {
    var responseJson;
    try {
      final response = await http.delete(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Basic $basicAuth', // Ensure 'Basic ' prefix
        },
      );
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  dynamic _returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        return response;
      case 201:
        return response;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 422:
        throw InvalidInputException(response.body.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occurred while Communication with Server with StatusCode: ${response.statusCode}');
    }
  }
}
