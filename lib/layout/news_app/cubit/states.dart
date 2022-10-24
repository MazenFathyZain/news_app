abstract class NewsStates{}
class NewsInitialState extends NewsStates {}
class  NewsBottomNavState extends NewsStates{}
class NewsGetBusinessLoadingState extends NewsStates{}
class NewsGetBusinessSuccessState extends NewsStates{}
class NewsGetBusinessErrorState extends NewsStates{
  final String error;
  NewsGetBusinessErrorState(this.error);
}

class NewsGetSportsLoadingState extends NewsStates{}
class NewsGetSportsSuccessState extends NewsStates{}
class NewsGetSportsErrorState extends NewsStates{
  final String error;
  NewsGetSportsErrorState(this.error);
}

class NewsGetScienceLoadingState extends NewsStates{}
class NewsGetScienceSuccessState extends NewsStates{}
class NewsGetScienceErrorState extends NewsStates{
  final String error;
  NewsGetScienceErrorState(this.error);
}

class NewsGetSettingsLoadingState extends NewsStates{}
class NewsGetSettingsSuccessState extends NewsStates{}
class NewsGetSettingsErrorState extends NewsStates{
  final String error;
  NewsGetSettingsErrorState(this.error);
}

class NewsGetSearchLoadingState extends NewsStates{}
class NewsGetSearchSuccessState extends NewsStates{}
class NewsGetSearchErrorState extends NewsStates{
  final String error;
  NewsGetSearchErrorState(this.error);
}
class True extends NewsStates{}
class False extends NewsStates{}