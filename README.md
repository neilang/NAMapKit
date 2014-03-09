NAMapKit
========

[![Build Status](https://travis-ci.org/neilang/NAMapKit.png)](https://travis-ci.org/neilang/NAMapKit)

Lets you drop MapKit style pins onto a standard UIImage. Also includes callouts, multi-colored pins, animation, zoom and gestures.

![Screenshot 1](screenshot1.png)
![Screenshot 2](screenshot2.png)

Usage
-----

#### Default Annotations

Create a map in a view controller.

``` objc
NAMapView *mapView = [[NAMapView alloc] initWithFrame:self.view.bounds];

mapView.backgroundColor  = [UIColor colorWithRed:0.000f green:0.475f blue:0.761f alpha:1.000f];
mapView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;

mapView.minimumZoomScale = 0.5f;
mapView.maximumZoomScale = 1.5f;

[mapView displayMap:[UIImage imageNamed:@"australia"]];

[self.view addSubview:mapView];
```

Add annotations.

```
NAAnnotation *dot = [NAAnnotation annotationWithPoint:CGPointMake(543.0f, 489.0f)];
[mapView addAnnotation:dot animated:NO];
```

#### Custom Annotations

The default implementation places a red semi-transparent dot on the map. Subclass [NAAnnotation](NAMapKit/NAAnnotation.h) and implement `createViewOnMapView` that returns a custom annotation view. Optionally implement `addToMapView` when the annotation is added, and `updatePosition` to change the location of the view every time the map is zoomed in or zoomed out.

You can find a complete example in [NAPinAnnotation.h](NAMapKit/NAPinAnnotation.h)/[.m](NAMapKit/NAPinAnnotation.m).

Notes
-----

Current version _requires ARC and iOS5_ (untested on iOS4). If you are developing for iOS3/4, checkout the version 1.0 tag of the repository.

If you are using Interface Builder, you can add a UIScrollView to your XIB and change the class to "NAMapView" to use the framework.

Attribution
-----------

When using this code please include the following attribution:

**Includes NAMapKit code developed by [Neil Ang](http://neilang.com/) and [Tony Arnold](http://thecocoabots.com/).**

Have an app on the AppStore that's using NAMapKit? [Add it to the wiki](https://github.com/neilang/NAMapKit/wiki).
