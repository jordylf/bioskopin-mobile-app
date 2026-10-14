class NoParams {}

abstract class UseCase<Request, Type> {
  Future<Type> call({Request? request});
}
