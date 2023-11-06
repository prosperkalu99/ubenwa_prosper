import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class FUImage {

  static Widget image({
    required String assetStringOrUrl,
    File? imageFile,
    bool isNetwork = false,
    bool isFile = false,
    double? width,
    double? height,
    BoxFit? fit,
    Color? color,
    Map<String, String>? httpHeaders,
  }){
    Widget widget;
    if(isNetwork){
      widget = CachedNetworkImage(
        imageUrl: assetStringOrUrl,
        httpHeaders: httpHeaders,
        errorWidget: (context, _, __) => const Icon(Icons.error),
        width: width,
        height: height,
        fit: fit??BoxFit.cover,
        color: color,
      );
    } else if(isFile){
      widget = Image.file(
        imageFile!,
        errorBuilder: (context, __, _) => const Icon(Icons.error),
        height: height,
        width: width,
        fit: fit??BoxFit.cover,
        color: color,
      );
    } else {
      widget = Image.asset(
        assetStringOrUrl,
        errorBuilder: (context, __, _) => const Icon(Icons.error),
        height: height,
        width: width,
        fit: fit??BoxFit.cover,
        color: color,
      );
    }
    return widget;
  }

  static ImageProvider imageProvider({
    required String assetStringOrUrl,
    File? imageFile,
    bool isNetwork = false,
    bool isFile = false,
    int? maxHeight,
    int? maxWidth,
    Map<String, String>? httpHeaders,
  }){
    ImageProvider imageProvider;
    if(isNetwork){
      imageProvider = CachedNetworkImageProvider(
        assetStringOrUrl,
        maxHeight: maxHeight,
        maxWidth: maxWidth,
        headers: httpHeaders,
      );
    } else if(isFile) {
      imageProvider = FileImage(imageFile!);
    } else {
      imageProvider = AssetImage(assetStringOrUrl);
    }
    return imageProvider;
  }

  static Widget svgImage({
    required String assetStringOrUrl,
    bool isNetwork = false,
    double? width,
    double? height,
    BoxFit? fit,
    Color? color,
    String? package,
    Map<String, String>? httpHeaders,
  }){
    Widget widget;
    if(isNetwork){
      widget = SvgPicture.network(
        assetStringOrUrl,
        height: height,
        width: width,
        fit: fit??BoxFit.cover,
        color: color,
        headers: httpHeaders,
      );
    } else {
      widget = SvgPicture.asset(
        assetStringOrUrl,
        height: height,
        width: width,
        fit: fit??BoxFit.cover,
        color: color,
        package: package,
      );
    }
    return widget;
  }

}
