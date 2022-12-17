import 'package:flutter/material.dart';
import 'package:uas_mobile/Model/detail.dart';

import '../Services/SpaxesServices.dart';
import 'desc.dart';

class DetailSpace extends StatefulWidget {
  final Detail detail;
  Future<List<Detail>> fetchdetail;
  DetailSpace({Key? key, required this.detail, required this.fetchdetail})
      : super(key: key);

  @override
  State<DetailSpace> createState() => _DetailSpaceState();
}

class _DetailSpaceState extends State<DetailSpace> {
  @override
  Widget build(BuildContext context) {
    Widget Details = FutureBuilder<Detail>(
        future: SpaxesService().fetchDataSpace(widget.detail.id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            } else {
              return Text("Nama : " + snapshot.data!.nama);
            }
          }
        });
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 196, 196, 196),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 73, 79, 115),
      ),
      body: FutureBuilder<List<Detail>>(
        future: SpaxesService().fetchUser(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            } else {
              return SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Container(
                      width: 395,
                      height: 470,
                      child: Image.network(
                        widget.detail.image,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                padding: const EdgeInsets.only(bottom: 4),
                                child: Text(widget.detail.nama,
                                    style:
                                        Theme.of(context).textTheme.headline6),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        widget.detail.capt,
                        style: Theme.of(context).textTheme.bodyText1,
                        softWrap: true,
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  ],
                ),
              );
            }
          }
        },
      ),
    );
  }
}
