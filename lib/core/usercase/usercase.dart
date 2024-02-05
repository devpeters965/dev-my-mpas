abstract class UserCase<T, Param>{
  Future<T> call({Param param});
}
