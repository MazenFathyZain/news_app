import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/components/components.dart';
import 'package:news_app/layout/news_app/cubit/cubit.dart';
import 'package:news_app/layout/news_app/cubit/states.dart';
import 'package:news_app/models/search/search_screen.dart';
import 'package:news_app/page.dart';

class NewsLayout extends StatefulWidget {

  @override
  State<NewsLayout> createState() => _NewsLayoutState();
}

class _NewsLayoutState extends State<NewsLayout> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = NewsCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text("News App"),
            actions: [
              IconButton(onPressed: () {
                navigateTo(context, SearchScreen());
              }, icon: const Icon(Icons.search)),
              IconButton(
                  onPressed: () {
                    cubit.changeAppMode();
                    // print(cubit.isDark);
                  },
                  icon: const Icon(Icons.brightness_4_outlined))
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            elevation: 20.0,
            selectedItemColor: Colors.deepOrange,
            currentIndex: cubit.currentIndex,
            onTap: (index) {
              cubit.changeBottomNavBar(index);
            },
            items: cubit.bottomItems,
          ),
          body: cubit.screens[cubit.currentIndex],
        );
      },
    );
  }
}
