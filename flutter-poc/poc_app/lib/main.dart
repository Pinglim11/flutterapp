import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'imagedetails.dart';
import 'webview.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.grey,
        primaryColor: Colors.white,
        fontFamily: 'Roboto',
      ),
      home: HomePage(title: 'My App'),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {

    var size = MediaQuery.of(context).size;

    final double horizontalPadding = (size.width/4);
    final double gridHeight = (size.height - kToolbarHeight - 24) / 3;
    final double gridWidth = size.width / 2;

    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text(widget.title)
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 500) {
            return Container(
              padding: EdgeInsets.symmetric(horizontal:10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 10),
                  Expanded(
                    child: GridView.builder(
                      itemCount: photos.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: (4/5),
                        crossAxisCount:2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing:15,
                      ),
                      itemBuilder: (BuildContext context, int index){
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => ImageDetailsPage(
                                title: widget.title,
                                photoTitle: photos[index].title,
                                assetName: photos[index].assetName,
                                description: photos[index].description,
                              )),
                            );
                          },
                          child: Stack(
                            children: [
                              AspectRatio(
                                aspectRatio:4/5,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20.0),
                                  child: Image.asset(
                                      photos[index].assetName,
                                      fit: BoxFit.cover
                                  ),
                                ),
                              ),
                              Container(
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                            shape: BoxShape.rectangle,
                                            color:Colors.black.withOpacity(0.3),
                                            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
                                        ),
                                        child: Column(
                                          children: [
                                            SizedBox(height:10),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              children: [
                                                Text(
                                                  photos[index].title,
                                                  style: TextStyle(fontSize: 16,color: Colors.white),
                                                  textAlign: TextAlign.end,
                                                ),
                                                SizedBox(width:20)
                                              ]
                                            ),
                                            SizedBox(height:10)
                                          ],
                                        ),
                                      ),
                                    ]
                                ),
                              )
                            ]
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 60),
                  FloatingActionButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => WebViewPage(title: widget.title)),
                        );
                      },
                      child: Text("Yes")
                  ),
                ],
              ),
            );

          } else {
            return Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(minWidth:300, maxWidth:1000),
                child: Row(
                  children: [
                    SizedBox(width:30),
                    Expanded(
                      child: Column(
                        children: [
                          Expanded(
                            child: GridView.builder(
                              itemCount: photos.length,
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                childAspectRatio: (4/5),
                                crossAxisCount:3,
                                crossAxisSpacing: 60,
                                mainAxisSpacing:40,
                              ),
                              itemBuilder: (BuildContext context, int index){
                                return GestureDetector(
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return ImageDetailsModal(
                                          title: widget.title,
                                          photoTitle: photos[index].title,
                                          assetName: photos[index].assetName,
                                          description: photos[index].description,
                                        );
                                      }
                                    );
                                  },
                                  child: Stack(
                                      children: [
                                        AspectRatio(
                                          aspectRatio:4/5,
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(20.0),
                                            child: Image.asset(
                                                photos[index].assetName,
                                                fit: BoxFit.cover
                                            ),
                                          ),
                                        ),
                                        Container(
                                          child: Column(
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              children: [
                                                Container(
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.rectangle,
                                                    color:Colors.black.withOpacity(0.3),
                                                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
                                                  ),
                                                  child: Column(
                                                    children: [
                                                      SizedBox(height:10),
                                                      Row(
                                                          mainAxisAlignment: MainAxisAlignment.end,
                                                          children: [
                                                            Text(
                                                              photos[index].title,
                                                              style: TextStyle(fontSize: 16,color: Colors.white),
                                                              textAlign: TextAlign.end,
                                                            ),
                                                            SizedBox(width:20)
                                                          ]
                                                      ),
                                                      SizedBox(height:10)
                                                    ],
                                                  ),
                                                ),
                                              ]
                                          ),
                                        )
                                      ]
                                  ),
                                );
                              },
                            ),
                          ),
                          SizedBox(width: 30),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        }
      ),
    );
      /*floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );*/
  }
}

class Photo {
  const Photo({required this.title, required this.assetName, required this.description});
  final String title;
  final String assetName;
  final String description;
}

const List<Photo> photos = const<Photo>[
  const Photo(title:"Child", assetName:"assets/child.jpg", description:"description for child"),
  const Photo(title:"Thirsty", assetName:"assets/thirsty.jpg", description:"description for thirsty"),
  const Photo(title:"Flower Boy", assetName:"assets/flowerboy.jpg", description:"Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco."),
  const Photo(title:"Hands up", assetName:"assets/handsup.jpg", description:"description for handsup"),
  const Photo(title:"Hat Girl", assetName:"assets/hatgirl.jpg", description:"description for hat girl"),
  const Photo(title:"Landscape", assetName:"assets/landscape.jpg", description:"description for landscape"),
  const Photo(title:"Stickers", assetName:"assets/stickers.jpg", description:"description for stickers"),
  const Photo(title:"Tea Time", assetName:"assets/teatime.jpg", description:"description for teatime"),
  const Photo(title:"Sad Kid", assetName:"assets/sadkid.jpg", description:"description sad kid"),
];

