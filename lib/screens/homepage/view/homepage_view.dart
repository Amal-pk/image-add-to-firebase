import 'package:flutter/material.dart';
import 'package:new_project/screens/homepage/controller/home_controller.dart';
import 'package:new_project/screens/homepage/view/homecard.dart';
import 'package:new_project/service/service.dart';
import 'package:provider/provider.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class HomePage extends StatelessWidget {
  const HomePage({super.key, this.email});

  final String? email;

  @override
  Widget build(BuildContext context) {
    final Storage storage = Storage();
    final controller = Provider.of<HomePageController>(context);
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                controller.logout();
                // AuthController.instance.logOut();
                //Implement logout functionality
              }),
        ],
        title: const Text('image'),
        backgroundColor: Colors.red,
      ),
      body: SafeArea(
        child: FutureBuilder(
            future: storage.listFile(),
            builder: (BuildContext context,
                AsyncSnapshot<firebase_storage.ListResult> snapshot) {
              if (snapshot.connectionState == ConnectionState.done &&
                  snapshot.hasData) {
                return Container(
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                    ),
                    itemCount: snapshot.data!.items.length,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => HomeCardsWidgets(
                                  url: snapshot.data!.items[index].name),
                            ),
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.all(10),
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: const [
                              BoxShadow(
                                blurRadius: 2,
                                color: Colors.grey,
                              )
                            ],
                            color: Colors.white,
                          ),
                          child: Center(
                            child: Text(snapshot.data!.items[index].name),
                          ),
                        ),
                      );
                    },
                  ),
                );
              }
              if (snapshot.connectionState == ConnectionState.waiting ||
                  !snapshot.hasData) {
                return Container();
              }
              return Container();
            }),
      ),
    );
  }
}
