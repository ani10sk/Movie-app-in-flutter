import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/movies.dart';
import './movie.dart';

class HomeScreen extends StatefulWidget{
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController mv=TextEditingController();
  var isWaiting=false;
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor:Colors.cyan[100],
      appBar:AppBar(
        title:Text('Home'),
      ),
      body:isWaiting?Center(child:CircularProgressIndicator()):
      SingleChildScrollView(
        child:Column(
          children:[
            Container(
              margin:EdgeInsets.all(20),
              padding:EdgeInsets.all(30),
              decoration:BoxDecoration(
                borderRadius:BorderRadius.circular(30),
                color:Colors.black
              ),
              child: TextField(
                controller:mv,
                style:TextStyle(
                  color:Colors.white
                ),
                decoration:InputDecoration(
                  hintText:'Enter the movie',
                  hintStyle:TextStyle(
                    color:Colors.white
                  )
                ),
                onSubmitted:(_)async{
                  setState((){
                    isWaiting=true;
                  });
                  await Provider.of<Movies>(context,listen:false).getMovies(mv.text);
                  setState(() {
                    isWaiting=false;
                  });
                }
              ),
            ),
            SizedBox(
              height:MediaQuery.of(context).size.height,
              child:Consumer<Movies>(
                child:Center(child:Text('No Movies!'),),
                builder:(ctx,m,ch)=>
                m.movies.length==0?ch:
                ListView.builder(
                  itemBuilder:(ctx,i)=>ListTile(
                    onTap:()=>Navigator.of(context).pushNamed(MovieDet.rout,arguments:m.movies[i]),
                    title:Text(m.movies[i].name),
                  ),
                  itemCount:m.movies.length,
                  )
              )
            )
          ]
        )
      )
    );
  }
}