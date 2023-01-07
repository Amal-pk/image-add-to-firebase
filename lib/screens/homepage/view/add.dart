import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:new_project/screens/homepage/view/textfield.dart';
import 'package:new_project/service/service.dart';

class Edit extends StatelessWidget {
  Edit({super.key, required this.imag});
  List<Offset> _markers = [];
  final String imag;
  @override
  Widget build(BuildContext context) {
    final Storage storage = Storage();
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            FutureBuilder(
                future: storage.downloadUrl(imag),
                builder:
                    (BuildContext context, AsyncSnapshot<String> snapshot) {
                  if (snapshot.connectionState == ConnectionState.done &&
                      snapshot.hasData) {
                    return GestureDetector(
                      onTapDown: (tap) {
                        _markers.add(tap.localPosition);
                        log(tap.localPosition.toString());
                      },
                      child: Stack(
                        children: [
                          // Add your image here
                          Image.network(snapshot.data!),
                          // This is the marker widget
                          ..._markers.map(
                            (marker) => Positioned(
                              left: marker.dx,
                              top: marker.dy,
                              child: Container(
                                width: 20,
                                height: 20,
                                decoration: const BoxDecoration(
                                  color: Colors.red,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  if (snapshot.connectionState == ConnectionState.waiting ||
                      !snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return Container();
                }),
            _markers.isNotEmpty ? const TextPage() : const SizedBox()
          ],
        ),
      ),
    );
  }
}
