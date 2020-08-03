import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/movies.dart';

class MovieDet extends StatefulWidget{
  static const rout='movie';
  Movie mov;
  void build(BuildContext context){
    mov=ModalRoute.of(context).settings.arguments as Movie;
  }
  @override
  _MovieDetState createState() => _MovieDetState();
}

class _MovieDetState extends State<MovieDet> {
  var iswaiting=true;
  var isused=true;
  @override
    void didChangeDependencies()async{
      if(isused){
        widget.build(context);
        await Provider.of<Movies>(context,listen:false).getMoviedetails(widget.mov);
      }
      
      setState(() {
        iswaiting=false;
        isused=false;
      });
      super.didChangeDependencies();
    }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor:Colors.amber[100],
      appBar:AppBar(
        title:Text(widget.mov.name)
      ),
      body:iswaiting?
      Center(child:CircularProgressIndicator()):
      SingleChildScrollView(
        child:Consumer<Movies>(
          builder:(ctx,m,_)=>
          m.selected==null?Center(child:Text('Details of the movie not found'),):
          Column(
            children: <Widget>[
              Container(
                alignment:Alignment.center,
                padding:EdgeInsets.all(20),
                height:500,
                width:MediaQuery.of(context).size.width,
                child:m.selected.poster!=null?
                Image.network(m.selected.poster):
                Text('Poster not available')
              ),
              Container(
                child:Row(
                  mainAxisAlignment:MainAxisAlignment.spaceAround,
                  children:[
                    Text('Rating',style:TextStyle(fontSize:20,fontWeight:FontWeight.bold),),
                    Text(m.selected.rating!=null?m.selected.rating:'Rating not available',style:TextStyle(fontSize:20,fontWeight:FontWeight.bold)),
                    Icon(Icons.star)
                  ]
                ),
              ),
              SizedBox(height:30),
              Text('Year',style:TextStyle(fontSize:20,fontWeight:FontWeight.bold)),
              Cont(m.selected.year),
              SizedBox(height:30),
              Text('Released Year',style:TextStyle(fontSize:20,fontWeight:FontWeight.bold)),
              Cont(m.selected.released),
              SizedBox(height:30),
              Text('Run Time',style:TextStyle(fontSize:20,fontWeight:FontWeight.bold)),
              Cont(m.selected.runtime),
              SizedBox(height:30),
              Text('Directors',style:TextStyle(fontSize:20,fontWeight:FontWeight.bold)),
              Cont(m.selected.director),
              SizedBox(height:30),
              Text('Genre',style:TextStyle(fontSize:20,fontWeight:FontWeight.bold)),
              Cont(m.selected.genre),
              SizedBox(height:30),
              Text('Actors',style:TextStyle(fontSize:20,fontWeight:FontWeight.bold)),
              Cont(m.selected.actors),
              SizedBox(height:30),
              Text('Plot',style:TextStyle(fontSize:20,fontWeight:FontWeight.bold)),
              Cont(m.selected.plot),
            ],
          )
          )
      )
    );
  }
}

class Cont extends StatelessWidget{
  final String cont;
  Cont(this.cont);
  Widget build(BuildContext context){
    return Container(
      padding:EdgeInsets.all(20),
      child:Text(cont!=null?
        cont:'Not available',style:TextStyle(fontSize:20)
      ),
    );
  }
}