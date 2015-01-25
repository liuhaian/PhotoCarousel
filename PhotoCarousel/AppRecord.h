//
//  AppRecord.h
//  PhotoCarousel
//
//  Created by Haian Liu on 1/25/15.
//  Copyright (c) 2015 Haian Liu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppRecord : NSObject
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) NSString *imageURLString;
@property BOOL isSelected;

@end
