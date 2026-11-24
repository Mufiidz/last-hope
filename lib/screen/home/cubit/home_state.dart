part of 'home_cubit.dart';

@MappableClass()
class HomeState extends BaseState with HomeStateMappable {
  final List<Story> stories;
  new({super.message, super.statusStateScreen, this.stories = const []});
}

sealed class HomeEffect implements BaseEffect {}
