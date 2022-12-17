import 'package:flutter/material.dart';
import 'package:uas_mobile/Model/detail.dart';
import 'package:uas_mobile/Services/SpaxesServices.dart';
import 'package:uas_mobile/View/setting.dart';

import 'desc.dart';
import 'detailSpace.dart';
import 'login.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _homeState();
}

class _homeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 196, 196, 196),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 73, 79, 115),
        elevation: 0,
        title: Image(
            image: AssetImage("assets/images/Logo Name.png"), fit: BoxFit.fill),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.search,
                color: Color.fromARGB(255, 245, 246, 248)),
            onPressed: () {},
          ),
        ],
      ),
      body: FutureBuilder<List<Detail>>(
          future: SpaxesService().fetchUser(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else {
              if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              } else {
                return GridView.builder(
                    padding: EdgeInsets.all(5),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 5,
                      childAspectRatio: 0.75,
                    ),
                    itemCount: snapshot.data!.length,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DetailSpace(
                                        detail: snapshot.data![index],
                                        fetchdetail:
                                            SpaxesService().fetchUser(),
                                      )));
                        },
                        child: Container(
                          width: 200,
                          height: 350,
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 245, 246, 248),
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: Color.fromARGB(255, 196, 196, 196)
                                      .withOpacity(0.5),
                                  spreadRadius: 3,
                                  blurRadius: 10,
                                  offset: Offset(0, 3),
                                )
                              ]),
                          child: Column(
                            children: [
                              Container(
                                padding: EdgeInsets.all(10.0),
                                child:
                                    Image.network(snapshot.data![index].image),
                              ),
                              Padding(
                                padding: EdgeInsets.only(bottom: 2),
                                child: Text(
                                  snapshot.data![index].nama,
                                  style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 45, 50, 73)),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(5.0),
                                child: Text(
                                  snapshot.data![index].capt,
                                  style: const TextStyle(
                                    fontSize: 9,
                                    color: Color.fromARGB(255, 45, 50, 73),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    });
              }
            }
          }),
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 73, 79, 115),
              ),
              child: Image(
                  image: AssetImage("assets/images/Logo Name.png"),
                  fit: BoxFit.fill),
              // accountName : Text("Aqza Tri Ananda HAT"),
              // accountEmail: Text("aqzatrianandahat@gmail.com"),
            ),
            ListTile(
                leading: Icon(Icons.home),
                title: const Text('HOME'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Home(),
                      ));
                }),
            ListTile(
              leading: Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Setting(),
                    ));
              },
            ),
            ListTile(
              leading: Icon(Icons.description),
              title: const Text('Description'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Desc(),
                    ));
              },
            ),
            new Divider(),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              trailing: new Icon(Icons.cancel),
              title: const Text('LOGOUT'),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => Login()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
