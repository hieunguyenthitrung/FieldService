import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:field_services/constants/assets_path.dart';
import 'package:field_services/resources/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ImageUtil {
  static Widget loadNetWorkImage({
    required String url,
    bool isUseLoading = true,
    BoxFit fit = BoxFit.cover,
    double? height,
    double? width,
  }) {
    const Widget loadingWidget = Center(
      child: SizedBox(
        width: 24,
        height: 24,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(
            AppColors.primaryColor,
          ),
        ),
      ),
    );

    final Widget placeholder = Image.asset(
      AssetsPath.imgPlaceHolder,
      fit: fit,
      height: height,
      width: width,
    );

    if (url.isEmpty) {
      return placeholder;
    }

    try {
      final base64Img = url.split(',').last;
      final unint8list = base64.decode(base64Img);
      return Image.memory(
        unint8list,
        width: width,
        height: height,
        fit: fit,
      );
    } catch (_) {}

    if (!url.contains('http')) {
      return placeholder;
    }

    // Load network image
    if (url.endsWith('.svg')) {
      return SvgPicture.network(
        url,
        fit: fit,
        height: height,
        placeholderBuilder: (context) {
          if (isUseLoading) {
            return loadingWidget;
          }
          return placeholder;
        },
      );
    }
    return CachedNetworkImage(
      imageUrl: url,
      fit: fit,
      height: height,
      placeholder: (context, url) {
        if (isUseLoading) {
          return loadingWidget;
        }
        return placeholder;
      },
      errorWidget: (ctx, url, error) {
        return placeholder;
      },
    );
  }

  static Widget loadAssetsImage({
    required String assetPath,
    double? width,
    double? height,
    Color? color,
    BoxFit fit = BoxFit.cover,
    Alignment alignment = Alignment.center,
  }) {
    if (assetPath.isEmpty) {
      return Image.asset(
        AssetsPath.imgPlaceHolder,
        fit: fit,
        height: height,
        width: width,
      );
    }

    if (assetPath.endsWith('.svg')) {
      return SvgPicture.asset(
        assetPath,
        width: width,
        height: height,
        fit: fit,
        color: color,
        alignment: alignment,
      );
    }
    return Image.asset(
      assetPath,
      width: width,
      height: height,
      fit: fit,
      color: color,
      alignment: alignment,
    );
  }
}
