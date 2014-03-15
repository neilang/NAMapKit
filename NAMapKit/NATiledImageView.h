//
//  NATiledImageView.h
//  NAMapKit
//
//  Created by orta on 2014/01/30.
//  Copyright (c) 2010-14 neilang.com. All rights reserved.
//

#import "NATiledImageViewDataSource.h"

/**
 *  A tiled image view.
 */
@interface NATiledImageView : UIView

// Initialize with a data source.
- (id)initWithDataSource:(NSObject <NATiledImageViewDataSource> *)dataSource;
// Cancel any pending tile downloads.
- (void)cancelConcurrentDownloads;

// Tiled images data source.
@property (readonly, nonatomic) NSObject <NATiledImageViewDataSource> *dataSource;
// Display tiled borders for debugging.
@property (readwrite, nonatomic, assign) BOOL displayTileBorders;
// Current image zoom level.
@property (readonly, nonatomic) NSInteger currentZoomLevel;

@end