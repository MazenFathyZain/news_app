import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/network/local/cache_helper.dart';

import 'layout/news_app/cubit/cubit.dart';
import 'layout/news_app/cubit/states.dart';

class Pagec extends StatefulWidget {

  @override
  State<Pagec> createState() => _PagecState();
}

class _PagecState extends State<Pagec> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => NewsCubit(),
      child: BlocConsumer<NewsCubit, NewsStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(),
              body: GestureDetector(
                onTap: (){
                  NewsCubit.get(context).changeAppMode();
                  print(NewsCubit.get(context).isDark);
                },
                child: Container(
                  child: Center(child: Container(
                    width: 200,
                      height: 200,
                      color: Colors.deepOrange,
                      child: Center(child: Text("${CacheHelper.getBool("isDark")}",))))
                ),
              ),
            );
          }
      ),
    );
  }
}