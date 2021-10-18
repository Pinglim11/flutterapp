import 'package:flutter/material.dart';

class ImageDetailsPage extends StatefulWidget {
  ImageDetailsPage({Key? key,
    required this.title,
    required this.photoTitle,
    required this.assetName,
    required this.description
  }) : super(key: key);

  final String title, photoTitle, assetName, description;

  @override
  _ImageDetailsPageState createState() => _ImageDetailsPageState();
}

class _ImageDetailsPageState extends State<ImageDetailsPage> {
  @override
  Widget build(BuildContext context) {

    var size = MediaQuery.of(context).size;

    final double imageHeight = (size.height - kToolbarHeight - 24) *(2/3);
    final double descHeight =  (size.height - kToolbarHeight - 24) *(1/3);

    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text(widget.title)
        ),
      ),
      body: Center(
        child: Column(

          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AspectRatio(
              aspectRatio: 4/5,
              child: ConstrainedBox(
                constraints: BoxConstraints(maxHeight: imageHeight, maxWidth:370),
                child: ClipRRect(
                  child: Image.asset(widget.assetName, fit: BoxFit.cover),
                ),
              ),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal:30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:[
                      Text(
                        widget.photoTitle,
                        style: TextStyle(fontFamily: 'Roboto', fontSize: 37),
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.start,
                      ),
                      SizedBox(height: 10),
                      ConstrainedBox(
                        constraints: BoxConstraints(maxHeight: descHeight, maxWidth: 330),
                        child: Text(
                          widget.description,
                          maxLines: 9,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ]
                  ),
                )
              ],
            ),


      ],
        ),
      ),
    );
  }
}

class ImageDetailsModal extends StatefulWidget {
  ImageDetailsModal({Key? key,
    required this.title,
    required this.photoTitle,
    required this.assetName,
    required this.description
  }) : super(key: key);

  final String title, photoTitle, assetName, description;

  @override
  _ImageDetailsModalState createState() => _ImageDetailsModalState();
}

class _ImageDetailsModalState extends State<ImageDetailsModal> {
  @override
  Widget build(BuildContext context) {

    var size = MediaQuery.of(context).size;
    final double imageWidth = (size.width/5);
    final double descWidth = (size.width/7);
    final double padding = (size.width/4);
    final double imageHeight = (size.height - kToolbarHeight - 24) *(2/3);
    final double descHeight =  (size.height - kToolbarHeight - 24) *(1/3);

    return ConstrainedBox(
      constraints: BoxConstraints(minHeight:300, minWidth:300, maxHeight:650, maxWidth:900),
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 0,
        backgroundColor: Colors.red,
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight:300, minWidth:300, maxHeight:650, maxWidth:900),
          child: AspectRatio(
            aspectRatio:7/5,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 40),
              decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(color: Colors.black,offset: Offset(0,10),
                        blurRadius: 10
                    ),
                  ]
              ),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:[
                        ConstrainedBox(
                          constraints: BoxConstraints(maxHeight: imageHeight, maxWidth: imageWidth),
                          child: AspectRatio(
                            aspectRatio: 4/5,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20.0),
                              child: Image.asset(widget.assetName, fit: BoxFit.cover),
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal:30),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children:[
                                SizedBox(height: 40),
                                Text(
                                  widget.photoTitle,
                                  style: TextStyle(fontFamily: 'Roboto', fontSize: 37),
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.start,
                                ),
                                SizedBox(height: 10),
                                ConstrainedBox(
                                  constraints: BoxConstraints(maxHeight: descHeight, maxWidth: descWidth),
                                  child: Text(
                                    widget.description,
                                    maxLines: 9,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                              ]
                          ),
                        ),
                      ]
                    )
                  ],
                ),
              ),
            ),
          ),
        )
      ),
    );
  }
}

