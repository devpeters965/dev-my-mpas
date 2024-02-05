import 'package:dio/dio.dart';
abstract class DataState<T>{
  final T?  data;
  final DioError? error;

  DataState({this.data, this.error});
}


class DataSuccess<T> extends DataState<T>{
 
  DataSuccess(T data) : super(data: data);
}

class DataFaile<T> extends DataState<T>{
  DataFaile(DioError error) : super(error: error);
}