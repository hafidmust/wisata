import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wisata/model/tourism_place.dart';

var informationTextStyle = TextStyle(fontFamily: 'Oxygen');
class DetailScreen extends StatelessWidget {
  final TourismPlace place;
  DetailScreen({required this.place});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints){
        if(constraints.maxWidth > 800){
          return DetailWebPage(place : place);
        }else{
          return DetailPageMobile(place: place);
        }
      },
    );
  }
}

class DetailWebPage extends StatefulWidget {
  final TourismPlace place;
  const DetailWebPage({required this.place});

  @override
  State<DetailWebPage> createState() => _DetailWebPageState();
}

class _DetailWebPageState extends State<DetailWebPage> {
  final _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
        child: Container(
          width: screenWidth <= 1200 ? 800 : 1200,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Wisata Bandung', style: TextStyle(fontSize: 32, fontFamily: 'Staatliches'),),
              SizedBox(height: 32,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(widget.place.imageAsset),
                        ),
                        Scrollbar(
                          controller: _scrollController,
                          child: Container(
                            height: 150,
                            child: ListView(
                              controller: _scrollController,
                              scrollDirection: Axis.horizontal,
                              children:
                                widget.place.imageUrls.map((image){
                                  return Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: ClipRRect(
                                      child: Image.network(image),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  );
                                }
                                ).toList()

                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(width: 32,),
                  Expanded(
                    child: Card(
                      child: Container(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(widget.place.name, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Icon(Icons.date_range),
                                Text(widget.place.openDays),
                                FavoriteButton()
                              ],
                            ),
                            Row(
                              children: [
                                Icon(Icons.access_time),
                                Text(widget.place.openTime),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(Icons.monetization_on),
                                Text(widget.place.ticketPrice)
                              ],
                            ),
                            Container(child: Text(widget.place.description, textAlign: TextAlign.justify,))
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
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
class DetailPageMobile extends StatelessWidget {
  final TourismPlace place;

  const DetailPageMobile({required this.place});


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


