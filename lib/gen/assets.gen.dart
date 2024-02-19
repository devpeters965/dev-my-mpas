/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

class $AssetsCartGen {
  const $AssetsCartGen();

  /// File path: assets/cart/custom.json
  String get custom => 'assets/cart/custom.json';

  /// List of all assets
  List<String> get values => [custom];
}

class $AssetsIconsGen {
  const $AssetsIconsGen();

  /// File path: assets/icons/Address-pana.svg
  String get addressPana => 'assets/icons/Address-pana.svg';

  /// File path: assets/icons/Animation.json
  String get animation => 'assets/icons/Animation.json';

  /// File path: assets/icons/Directions-amico.svg
  String get directionsAmico => 'assets/icons/Directions-amico.svg';

  /// File path: assets/icons/Directions-bro.svg
  String get directionsBro => 'assets/icons/Directions-bro.svg';

  /// File path: assets/icons/Directions-pana.svg
  String get directionsPana => 'assets/icons/Directions-pana.svg';

  /// File path: assets/icons/Feeling sorry-pana.svg
  String get feelingSorryPana => 'assets/icons/Feeling sorry-pana.svg';

  /// File path: assets/icons/Group discussion-cuate.svg
  String get groupDiscussionCuate => 'assets/icons/Group discussion-cuate.svg';

  /// File path: assets/icons/Image post-cuate.svg
  String get imagePostCuate => 'assets/icons/Image post-cuate.svg';

  /// File path: assets/icons/Location review-bro.svg
  String get locationReviewBro => 'assets/icons/Location review-bro.svg';

  /// File path: assets/icons/Online world-cuate.svg
  String get onlineWorldCuate => 'assets/icons/Online world-cuate.svg';

  /// File path: assets/icons/Personal settings-pana.svg
  String get personalSettingsPana => 'assets/icons/Personal settings-pana.svg';

  /// File path: assets/icons/Personal site-pana.svg
  String get personalSitePana => 'assets/icons/Personal site-pana.svg';

  /// File path: assets/icons/Social media-cuate.svg
  String get socialMediaCuate => 'assets/icons/Social media-cuate.svg';

  /// File path: assets/icons/Thinking face-cuate.svg
  String get thinkingFaceCuate => 'assets/icons/Thinking face-cuate.svg';

  /// File path: assets/icons/Travelers-pana.svg
  String get travelersPana => 'assets/icons/Travelers-pana.svg';

  /// File path: assets/icons/deleted.json
  String get deleted => 'assets/icons/deleted.json';

  /// File path: assets/icons/empty.json
  String get empty => 'assets/icons/empty.json';

  /// File path: assets/icons/emptyImage.json
  String get emptyImage => 'assets/icons/emptyImage.json';

  /// File path: assets/icons/emtyImage1.json
  String get emtyImage1 => 'assets/icons/emtyImage1.json';

  /// File path: assets/icons/maker.svg
  String get maker => 'assets/icons/maker.svg';

  /// File path: assets/icons/valider.json
  String get valider => 'assets/icons/valider.json';

  /// List of all assets
  List<String> get values => [
        addressPana,
        animation,
        directionsAmico,
        directionsBro,
        directionsPana,
        feelingSorryPana,
        groupDiscussionCuate,
        imagePostCuate,
        locationReviewBro,
        onlineWorldCuate,
        personalSettingsPana,
        personalSitePana,
        socialMediaCuate,
        thinkingFaceCuate,
        travelersPana,
        deleted,
        empty,
        emptyImage,
        emtyImage1,
        maker,
        valider
      ];
}

class Assets {
  Assets._();

  static const $AssetsCartGen cart = $AssetsCartGen();
  static const $AssetsIconsGen icons = $AssetsIconsGen();
}

class AssetGenImage {
  const AssetGenImage(this._assetName);

  final String _assetName;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
