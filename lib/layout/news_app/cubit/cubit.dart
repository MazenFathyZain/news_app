import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/news_app/cubit/states.dart';
import 'package:news_app/models/modules/business_screen.dart';
import 'package:news_app/models/modules/science_screen.dart';
import 'package:news_app/models/modules/sports_screen.dart';
import 'package:news_app/network/local/cache_helper.dart';
import 'package:news_app/network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<BottomNavigationBarItem> bottomItems = [
    const BottomNavigationBarItem(
        icon: Icon(
          Icons.business,
        ),
        label: "Business"),
    const BottomNavigationBarItem(
        icon: Icon(
          Icons.sports,
        ),
        label: "Sports"),
    const BottomNavigationBarItem(
        icon: Icon(
          Icons.science,
        ),
        label: "Science"),
  ];

  List<Widget> screens = [
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),
  ];

  void changeBottomNavBar(int index) {
    currentIndex = index;
    if (index == 0) {
      getBusiness();
    }
    if (index == 1) {
      getSports();
    }
    if (index == 2) {
      getScience();
    }
    emit(NewsBottomNavState());
  }

  List<dynamic> business = [];

  void getBusiness() {
    emit(NewsGetBusinessLoadingState());
    DioHelper.getData(url: "v2/top-headlines", query: {
      "country": "eg",
      "category": "business",
      "apiKey": "af6e6144bdbe4935a577b228f1ffe8f7"
    }).then((value) {
      // print(value?.data);
      business = value?.data["articles"];
      // print(business[0]["title"]);
      emit(NewsGetBusinessSuccessState());
    }).catchError((onError) {
      print(onError.toString());
      emit(NewsGetBusinessErrorState(onError.toString()));
    });
  }

  List<dynamic> sports = [];

  void getSports() {
    emit(NewsGetBusinessLoadingState());
    if (sports.length == 0) {
      DioHelper.getData(url: "v2/top-headlines", query: {
        "country": "eg",
        "category": "sports",
        "apiKey": "3a1daaba5d8042ec955a93bb3f59e777"
      }).then((value) {
        // print(value?.data);
        sports = value?.data["articles"];
        // print(sports[0]["title"]);
        emit(NewsGetSportsSuccessState());
      }).catchError((onError) {
        // print(onError.toString());
        emit(NewsGetSportsErrorState(onError.toString()));
      });
    } else {
      emit(NewsGetSportsSuccessState());
    }
  }

  List<dynamic> science = [];

  void getScience() {
    emit(NewsGetScienceLoadingState());
    if (science.length == 0) {
      DioHelper.getData(url: "v2/top-headlines", query: {
        "country": "eg",
        "category": "science",
        "apiKey": "3a1daaba5d8042ec955a93bb3f59e777"
      }).then((value) {
        // print(value?.data);
        science = value?.data["articles"];
        // print(science[0]["title"]);
        emit(NewsGetScienceSuccessState());
      }).catchError((onError) {
        // print(onError.toString());
        emit(NewsGetScienceErrorState(onError.toString()));
      });
    } else {
      emit(NewsGetScienceSuccessState());
    }
  }

  List<dynamic> search = [];

  void getSearch(String value) {
    emit(NewsGetSearchLoadingState());
    DioHelper.getData(
            url: "v2/everything",
            query: {"q": value, "apiKey": "3a1daaba5d8042ec955a93bb3f59e777"})
        .then((value) {
      search = value?.data["articles"];
      // print(search[0]['title']);
      emit(NewsGetSearchSuccessState());
    }).catchError((onError) {
      print(onError.toString());
      emit(NewsGetSearchErrorState(onError.toString()));
    });
  }

  bool isDark = false;

  bool changeAppMode({bool fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
      emit(False());
    } else {
      isDark = !isDark;
      CacheHelper.putBool("isDark", isDark).then((value) {
        emit(True());
      });
    }
  }
}
