//
// NATiledImageView
// Created by orta on 2014/01/30.
//

#import "NATiledImageViewDataSource.h"

@interface NATiledImageView : UIView

- (id)initWithDataSource:(NSObject <NATiledImageViewDataSource> *)dataSource;

@property (readonly, nonatomic) NSObject <NATiledImageViewDataSource> *dataSource;
@property (readonly, nonatomic, assign) NSInteger currentZoomLevel;
@property (readwrite, nonatomic, assign) BOOL displayTileBorders;

- (void)cancelConcurrentDownloads;
@end