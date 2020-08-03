import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './providers/movies.dart';
import './screens/home.dart';
import './screens/movie.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value:Movies() ,
      child: MaterialApp(
        debugShowCheckedModeBanner:false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.red,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home:HomeScreen(),
        routes:{
          MovieDet.rout:(ctx)=>MovieDet()
        },
      ),
    );
  }
}
