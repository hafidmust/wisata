import 'package:flutter/material.dart';
import 'package:wisata/model/tourism_place.dart';

var informationTextStyle = TextStyle(fontFamily: 'Oxygen');
class DetailScreen extends StatelessWidget {
  final TourismPlace place;
  DetailScreen({required this.place});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Image.asset(place.imageAsset),
                SafeArea(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(onPressed: (){
                        Navigator.pop(context);
                      }, icon: Icon(Icons.arrow_back, color: Colors.white,)),
                      FavoriteButton()
                    ],
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Text(
                place.name,
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, fontFamily: 'Staatliches'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Icon(Icons.date_range),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(place.openDays, style: informationTextStyle,),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Icon(Icons.access_time),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(place.openTime, style: informationTextStyle,),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Icon(Icons.monetization_on),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(place.ticketPrice, style: informationTextStyle,),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 32, left: 8, right: 8),
              child: Text(
                place.description,
                textAlign: TextAlign.center,
                style: informationTextStyle,
              ),
            ),
            Container(
                height: 150,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children:
                    place.imageUrls.map((e) {
                      return Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: ClipRRect(
                          child: Image.network(e),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      );
                    }).toList()
                  ,
                ))
          ],
        ),
      ),
    );
  }
}
class FavoriteButton extends StatefulWidget {
  const FavoriteButton({Key? key}) : super(key: key);

  @override
  _FavoriteButtonState createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  bool isFavorite = false;
  @override
  Widget build(BuildContext context) {
    return IconButton(onPressed: (){
      setState(() {
        isFavorite = !isFavorite;
      });
    }, icon: Icon(
      isFavorite ? Icons.favorite : Icons.favorite_border,
      color: Colors.red,
    ));
  }
}

