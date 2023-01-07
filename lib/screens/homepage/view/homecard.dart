import 'package:flutter/material.dart';
import 'package:new_project/screens/homepage/view/add.dart';
import 'package:new_project/service/service.dart';

class HomeCardsWidgets extends StatelessWidget {
  const HomeCardsWidgets({
    super.key,
    required this.url,
  });
  final String url;

  @override
  Widget build(BuildContext context) {
    final Storage storage = Storage();
    return Scaffold(
      appBar: AppBar(actions: [
        IconButton(
            onPressed: (() {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: ((context) => Edit(
                        imag: url,
                      )),
                ),
              );
            }),
            icon: const Icon(Icons.edit))
      ]),
      body: Container(
        child: FutureBuilder(
            future: storage.downloadUrl(url),
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              if (snapshot.connectionState == ConnectionState.done &&
                  snapshot.hasData) {
                return Container(
                  child: Center(
                    child: Image(
                      image: NetworkImage(snapshot.data!),
                    ),
                  ),
                );
              }
              if (snapshot.connectionState == ConnectionState.waiting ||
                  !snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.red,
                  ),
                );
              }
              return Container();
            }),
      ),
    );
  }
}
