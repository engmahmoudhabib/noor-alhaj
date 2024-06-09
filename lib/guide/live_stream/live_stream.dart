import 'dart:math';

import 'package:flutter/material.dart';
import 'package:zego_uikit_prebuilt_live_streaming/zego_uikit_prebuilt_live_streaming.dart';


class LiveStream extends StatelessWidget {
  const LiveStream({Key? key, this.isHost = false}) : super(key: key);
  final bool isHost; 

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ZegoUIKitPrebuiltLiveStreaming(
        appID: 525046300, // use your appID
        appSign: 'b51e5c96efec494f2c063ddab4990a3ed23ceb397c205a8e0ed627c300a7e39a', // use your appSign
        userID: 'userID'+Random().nextInt(100).toString(),
        userName: 'userNume'+Random().nextInt(100).toString(),
        liveID: "liveID",
        config: isHost
            ? ZegoUIKitPrebuiltLiveStreamingConfig.host()
            : ZegoUIKitPrebuiltLiveStreamingConfig.audience(),
      ),
    );
  }
}