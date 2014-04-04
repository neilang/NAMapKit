#### Next

* Replaced tiled map image implementation with [ARTiledImageView](https://github.com/dblock/ARTiledImageView) - [@dblock](github.com/dblock).
* Extracted [NADotAnnotation](NAMapKit/NADotAnnotation.h) out of [NAAnnotation](NAMapKit/NAAnnotation.h), which is now a pure virtual class - [@dblock](github.com/dblock).
* Fix: `NADotAnnotation` dots resize proportionally when map zoom level changes - [@dblock](github.com/dblock).
* Exposed `NAMapView#doubleTapGesture` and `NAMapView#twoFingerTapGesture` - [@orta](github.com/orta).
 
#### [3.0](https://github.com/neilang/NAMapKit/tree/v3.0) (3/15/2014)

* [#16](https://github.com/neilang/NAMapKit/pull/16) - Extracted [NAPinAnnotationMapView](NAMapKit/NAPinAnnotationMapView.h) out of a, now mimimal, `NAMapView` - [@dblock](github.com/dblock).
* [#18](https://github.com/neilang/NAMapKit/pull/18) - Added [NAMapViewDelegate](NAMapKit/NAMapViewDelegate.h) for easier handling of taps and zoom events - [@dblock](github.com/dblock).
* [#19](https://github.com/neilang/NAMapKit/pull/19) - Added [NATiledImageMapView](NAMapKit/NATiledImageMapView.h) with support for deep-zoom tiled maps - [@dblock](github.com/dblock), [@orta](github.com/orta).
* [#20](https://github.com/neilang/NAMapKit/pull/20) - Zoom now pans and rests at the point being tapped - [@orta](github.com/orta).
* [#14](https://github.com/neilang/NAMapKit/pull/14) - Added tests and [Travis-CI](https://travis-ci.org/neilang/NAMapKit) - [@dblock](github.com/dblock).

#### [2.1](https://github.com/neilang/NAMapKit/tree/v2.1)

* [#10](https://github.com/neilang/NAMapKit/pull/10) - Added .podspec - [@donny](https://github.com/donny).
* [#6](https://github.com/neilang/NAMapKit/issues/6) - Added the ability to select annotations on the map - [@neilang](https://github.com/neilang).

#### [2.0](https://github.com/neilang/NAMapKit/tree/v2.0)

* Partial rewrite - [@neilang](https://github.com/neilang).

#### [1.0](https://github.com/neilang/NAMapKit/commits/v1.0)

* Initial public release - [@neilang](https://github.com/neilang).

