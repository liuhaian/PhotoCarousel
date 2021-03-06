//
//  PhotoCarouselCell.h
//  PhotoCarousel
//
//  Created by Haian Liu on 1/24/15.
//  Copyright (c) 2015 Haian Liu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoCarouselCell : UICollectionViewCell
@property (strong, nonatomic) UIImageView *photoView;
@property (strong, nonatomic) UIImageView *selectedIconView;
//@property Boolean ifSelected;

-(void)setSelectIconCenter:(BOOL)toLeft shouldAlignToRightEdge:(CGFloat)rightEdge;
-(void)toggleSelected:(BOOL)ifSelected;
-(void)setImage:(UIImage*)img;

@end
