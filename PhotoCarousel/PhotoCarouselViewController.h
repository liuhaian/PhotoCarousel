//
//  PhotoCarouselViewController.h
//  PhotoCarousel
//
//  Created by Haian Liu on 1/23/15.
//  Copyright (c) 2015 Haian Liu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoCarouselViewController : UICollectionViewController<UICollectionViewDataSource,UICollectionViewDelegate>
@property (nonatomic, strong) NSMutableArray *appRecordEntries;

@end
