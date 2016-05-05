#### Next

* [#67](https://github.com/neilang/NAMapKit/pull/67) - Added circular pop-up menu sample to Demo project - [@troyz](https://github.com/troyz).
* Your contribution here.

#### [3.2.1](https://github.com/neilang/NAMapKit/tree/v3.2.1) (4/7/2016)

* [#59](https://github.com/neiland/NAMapKit/issues/59), [#52](https://github.com/neiland/NAMapKit/issues/52) - Fix: `NAPinAnnotationView` pin images fail to load - [@joeshi](https://github.com/joeshi).

#### [3.2.0](https://github.com/neilang/NAMapKit/tree/v3.2.0) (12/20/2015)

* [#46](https://github.com/neilang/NAMapKit/pull/46) - Changed to new push pin style - [@neilang](https://github.com/neilang).
* [#44](https://github.com/neiland/NAMapKit/issues/44) - Added `NAMapView#selectAnnotation:animated` implementation - [@frosty](http://github.com/frosty).
* [#43](https://github.com/neilang/NAMapKit/issues/43) - Fix: `NAMapViewDelegate` protocol optional methods were called without checking `respondsToSelector:` - [@frosty](http://github.com/frosty)
* [#39](https://github.com/neilang/NAMapKit/issues/39) - Added `NAMapView#updateContentOffsetToCenterPoint:animated:` to center map on a point without taking into account the map's `zoomScale` - [@ashfurrow](http://github.com/ashfurrow).
* [#37](https://github.com/neilang/NAMapKit/issues/37) - Added assert inside `NAMapView#zoomRelativePoint` when returning `{NaN, NaN}` - [@ashfurrow](http://github.com/ashfurrow).

#### [3.1.1](https://github.com/neilang/NAMapKit/tree/v3.1.1) (5/12/2014)

* [#31](https://github.com/neilang/NAMapKit/issues/31) - Fix: `NAPinAnnotation` and `NAPinAnnotationView` retain cycle - [@dblock](https://github.com/dblock).
* [#34](https://github.com/neilang/NAMapKit/issues/34) - Fix: `NAPinAnnotationCallOutView` uses `imageNamed` which retains memory - [@dblock](https://github.com/dblock).

#### [3.1](https://github.com/neilang/NAMapKit/tree/v3.1) (5/1/2014)

* Replaced tiled map image implementation with [ARTiledImageView](https://github.com/dblock/ARTiledImageView) - [@dblock](https://github.com/dblock).
* Extracted [NADotAnnotation](NAMapKit/NADotAnnotation.h) out of [NAAnnotation](NAMapKit/NAAnnotation.h), which is now a pure virtual class - [@dblock](https://github.com/dblock).
* Fix: `NADotAnnotation` dots resize proportionally when map zoom level changes - [@dblock](https://github.com/dblock).
* Exposed `NAMapView#doubleTapGesture` and `NAMapView#twoFingerTapGesture` - [@orta](https://github.com/orta).

#### [3.0](https://github.com/neilang/NAMapKit/tree/v3.0) (3/15/2014)

* [#16](https://github.com/neilang/NAMapKit/pull/16) - Extracted [NAPinAnnotationMapView](NAMapKit/NAPinAnnotationMapView.h) out of a, now mimimal, `NAMapView` - [@dblock](https://github.com/dblock).
* [#18](https://github.com/neilang/NAMapKit/pull/18) - Added [NAMapViewDelegate](NAMapKit/NAMapViewDelegate.h) for easier handling of taps and zoom events - [@dblock](https://github.com/dblock).
* [#19](https://github.com/neilang/NAMapKit/pull/19) - Added [NATiledImageMapView](NAMapKit/NATiledImageMapView.h) with support for deep-zoom tiled maps - [@dblock](https://github.com/dblock), [@orta](https://github.com/orta).
* [#20](https://github.com/neilang/NAMapKit/pull/20) - Zoom now pans and rests at the point being tapped - [@orta](https://github.com/orta).
* [#14](https://github.com/neilang/NAMapKit/pull/14) - Added tests and [Travis-CI](https://travis-ci.org/neilang/NAMapKit) - [@dblock](https://github.com/dblock).

#### [2.1](https://github.com/neilang/NAMapKit/tree/v2.1)

* [#10](https://github.com/neilang/NAMapKit/pull/10) - Added .podspec - [@donny](https://github.com/donny).
* [#6](https://github.com/neilang/NAMapKit/issues/6) - Added the ability to select annotations on the map - [@neilang](https://github.com/neilang).

#### [2.0](https://github.com/neilang/NAMapKit/tree/v2.0)

* Partial rewrite - [@neilang](https://github.com/neilang).

#### [1.0](https://github.com/neilang/NAMapKit/commits/v1.0)

* Initial public release - [@neilang](https://github.com/neilang).
