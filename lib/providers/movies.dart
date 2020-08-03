import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Movie{
  final String id;
  final String name;
  final String year;
  final String released;
  final String runtime;
  final String director;
  final String genre;
  final String actors;
  final String plot;
  final String poster;
  final String rating;
  Movie({
    this.id,
    this.name,
    this.year,
    this.released,
    this.runtime,
    this.director,
    this.genre,
    this.actors,
    this.plot,
    this.poster,
    this.rating
  });

}

class Movies extends ChangeNotifier{
  List<Movie> movies=[];
  Movie selected;
  Future<void> getMovies(String mv)async{
    movies=[];
    if(mv!=''){
      final url='https://imdb8.p.rapidapi.com/title/auto-complete?q=$mv';
      movies=[];
      try{
        final response=await http.get(
          url,headers:{
            'x-rapidapi-host':'imdb8.p.rapidapi.com',
            'x-rapidapi-key':'ee7a81b606mshc9f60b4a30d9313p1d6b68jsn1d2ef1b5d0fc'
          }
        );
        final extractedmsg=json.decode(response.body) as Map<String,dynamic>;
        for(int i=0;i<extractedmsg['d'].length;i++){
          movies.add(Movie(
            id:extractedmsg['d'][i]['id'],
            name:extractedmsg['d'][i]['l'],
            year:'',
            released:'',
            runtime:'',
            director:'',
            genre:'',
            actors:'',
            plot:'',
            poster:''
          ));
          notifyListeners();
        }
      }catch(error){
        print('error');
      }
    }else{
      movies=[];
      notifyListeners();
    }
  }

  Future<void> getMoviedetails(Movie mov)async{
    selected=Movie();
    final url='http://www.omdbapi.com/?i=${mov.id}&apikey=47c1eaee';
    try{
      final response=await http.get(url);
      final extractedmov=json.decode(response.body) as Map<String,dynamic>;
      selected=Movie(
        id:mov.id,
        name:mov.name,
        year:extractedmov['Year'],
        released:extractedmov['Released'],
        runtime:extractedmov['Runtime'],
        director:extractedmov['Director'],
        genre:extractedmov['Genre'],
        actors:extractedmov['Actors'],
        plot:extractedmov['Plot'],
        poster:extractedmov['Poster'],
        rating:extractedmov['Ratings'][1]['Value']
      );
    }catch(error){
      print('error');
    }
  }
}