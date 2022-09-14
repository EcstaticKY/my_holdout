import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CachedImages extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CachedImagesState();
  }
}

class CachedImagesState extends State<CachedImages> {
  int _avatarKey;

  @override
  void initState() {
    super.initState();
    _avatarKey = Random().nextInt(999);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cached Images'),
        actions: <Widget>[
          ElevatedButton(
            onPressed: () {
              // _avatarKey = Random().nextInt(999);
              setState(() {});
            },
            child: Text('Refresh'),
          )
        ],
      ),
      body: Center(
        child: CachedNetworkImage(
          placeholder: (context, url) => const CircularProgressIndicator(),
          imageUrl: 'https://picsum.photos/250?image=$_avatarKey',
        ),
      ),
    );
  }
}
