// ignore_for_file: unused_local_variable

import 'package:http/http.dart' as http;
import 'app_exception.dart';
import 'dart:io';

class Api {
  Future<dynamic> get(dynamic url) async {
    var responseJson;
    try {
      final response = await http.get(
        Uri.parse(url),
      );
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> post(dynamic url, dynamic body) async {
    var responseJson;
    try {
      final response = await http.post(
        Uri.parse(url),
        body: body,
      );
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> put(dynamic url, dynamic body) async {
    var responseJson;
    try {
      final response = await http.put(Uri.parse(url), body: body, headers: {
        'Content-Type': 'application/json',
      });
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> delete(dynamic url) async {
    var responseJson;
    try {
      final response = await http.delete(Uri.parse(url), headers: {
        'Content-Type': 'application/json',
      });
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
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}
