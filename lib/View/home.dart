import 'package:flutter/material.dart';
import 'package:uas_mobile/Model/space.dart';
import 'package:uas_mobile/Services/SpaxesServices.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _homeState();
}

class _homeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    List<String> images = [
      "assets/images/Moon HD.png",
      "assets/images/Nebula.png",
      "assets/images/Spacewalk.png",
      "assets/images/Spacewalk 2.png",
    ];
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 196, 196, 196),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 73, 79, 115),
        elevation: 0,
        title: const Text(
          'HOME',
          style: TextStyle(
            color: Color.fromARGB(255, 245, 246, 248),
            fontFamily: 'Poppins SemiBold',
            fontSize: 16,
          ),
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.search,
                color: Color.fromARGB(255, 245, 246, 248)),
            onPressed: () {},
          ),
        ],
      ),
      body: FutureBuilder<List<Space>>(
          future: SpaxesService().fetchUser(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else {
              if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              } else {
                return GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 1,
                      childAspectRatio: 0.75,
                    ),
                    itemCount: snapshot.data!.length,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      return Column(children: [
                        Padding(
                          padding: EdgeInsets.all(20),
                          child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.network(snapshot.data![index].image),
                                Text(
                                  snapshot.data![index].nama,
                                  style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                const SizedBox(height: 15),
                                Text(
                                  snapshot.data![index].capt,
                                  style: const TextStyle(
                                    fontSize: 9,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ]);
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
                // Navigator.pop(context);
                // Navigator.push(context,
                //     MaterialPageRoute(builder: (context) => settingpage(setTheme: setTheme),
                //     ));
              },
            ),
            ListTile(
              leading: Icon(Icons.description),
              title: const Text('Description'),
              onTap: () {
                // Navigator.pop(context);
                // Navigator.push(context,
                //     MaterialPageRoute(builder: (context) => homedetail(),
                //     ));
              },
            ),
            new Divider(),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              trailing: new Icon(Icons.cancel),
              title: const Text('LOGOUT'),
              onTap: () {
                // Navigator.pushReplacement(context,
                //   MaterialPageRoute(builder: (context) => LoginScreen(setTheme: setTheme)),);
              },
            ),
          ],
        ),
      ),
    );
  }
}
