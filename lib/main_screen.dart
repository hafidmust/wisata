import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wisata/detail_screen.dart';
import 'package:wisata/model/tourism_place.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wisata Bandung'),
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints){
          if(constraints.maxWidth <=600){
            return TourismPlaceList();
          }else if(constraints.maxWidth <= 1200){
            return TourismPlaceGrid(gridCount : 4);
          }else{
            return TourismPlaceGrid(gridCount : 6);
          }
        },
      ) ,
    );
  }
}

class TourismPlaceList extends StatelessWidget {
  const TourismPlaceList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        final TourismPlace place = tourismPlaceList[index];
        return InkWell(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> DetailScreen(place: place,)));
          },
          child: Card(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: Image.asset(place.imageAsset),
                  flex: 1,
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(place.name),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(place.location),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
      itemCount: tourismPlaceList.length,
    );
  }
}
class TourismPlaceGrid extends StatelessWidget {
  final int gridCount;
  TourismPlaceGrid({required this.gridCount});

  @override
  Widget build(BuildContext context) {

    return GridView.count(
      crossAxisCount: gridCount,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      children:
        tourismPlaceList.map((place) {
          return InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => DetailScreen(place: place)));
            },
            child: Card(
              child: Column(
                children: [
                  Expanded(
                      child: Image.asset(place.imageAsset, fit: BoxFit.cover,)
                  ),
                  Text(place.name, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                  SizedBox(height: 8,),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(place.location),
                  )

                ],
              ),
            ),
          );
        }).toList()

    );
  }
}


