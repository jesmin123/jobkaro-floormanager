

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImageUtil{

  static Widget network(String url){
    return CachedNetworkImage(
        imageUrl: url,
        placeholder: (_,str){
          return Icon(Icons.equalizer_rounded);
        },
      errorWidget: (_,err,ex){
       return  Icon(Icons.error);
      }
    );
  }
}