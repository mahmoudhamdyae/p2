class Resource<T> {
  final T? data;
  final Exception? message;

  Resource({this.data, this.message});
}

class Success<T> extends Resource<T> {
  Success(T data) : super(data: data);
}

class Error<T> extends Resource<T> {
  Error(Exception message, {T? data}) : super(data: data, message: message);
}