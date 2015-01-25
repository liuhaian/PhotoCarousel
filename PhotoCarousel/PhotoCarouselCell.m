//
//  PhotoCarouselCell.m
//  PhotoCarousel
//
//  Created by Haian Liu on 1/24/15.
//  Copyright (c) 2015 Haian Liu. All rights reserved.
//

#import "PhotoCarouselCell.h"

@implementation PhotoCarouselCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.photoView = [[UIImageView alloc] init];
        self.photoView.image = [UIImage imageNamed:@"DSC00592.JPG"];
        //[self.photoView setContentScaleFactor:UIViewContentModeScaleAspectFit];
        
        self.selectedIconView = [[UIImageView alloc] init];
        [self.contentView insertSubview:self.photoView atIndex:4];
        self.ifSelected=NO;
        
        if (self.ifSelected) {
            // /*
            //self.photoView.frame =CGRectMake(0, 0, 140, self.bounds.size.height - self.ifSelected.bounds.size.height);
            self.photoView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
            [self.photoView setContentScaleFactor:UIViewContentModeScaleAspectFit];
            self.selectedIconView.image = [UIImage imageNamed:@"Selected.png"];
            self.selectedIconView.frame =CGRectMake(self.frame.size.width - 45, self.frame.size.height - 45, 45, 45);
            [self.contentView insertSubview:self.selectedIconView atIndex:2];
            // */
            
        }
        else{
            NSLog(@"selected icon not shown.");
            self.photoView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
            self.selectedIconView.image = [UIImage imageNamed:@"notSelected.png"];
            self.selectedIconView.frame =CGRectMake(self.frame.size.width - 45, self.frame.size.height - 45, 45, 45);
            [self.contentView insertSubview:self.selectedIconView atIndex:2];
            
        }

        self.layer.cornerRadius = 6.0;
        
    }
    return self;
}

-(void)layoutSubviews{
    
    [super layoutSubviews];
    
    
}

-(void)setSelectIconCenter:(BOOL)toLeft shouldAlignToRightEdge:(CGFloat)rightEdge
{
//    [self.selectedIconView removeFromSuperview];
//    //self.selectedIconView.center=CGPointMake(23,self.selectedIconView.center.y);
//    self.selectedIconView.frame =CGRectMake(0, self.frame.size.height - 45, 45, 45);
//    [self.contentView insertSubview:self.selectedIconView atIndex:2];
    if(toLeft){
        if(rightEdge<46){
            [UIView animateWithDuration:0.1 animations:^{
                self.selectedIconView.center = CGPointMake(self.selectedIconView.frame.size.width/2,self.selectedIconView.center.y);
            }];
        }else{
            [UIView animateWithDuration:0.1 animations:^{
                self.selectedIconView.center = CGPointMake(rightEdge-self.selectedIconView.frame.size.width/2,self.selectedIconView.center.y);
            }];
            
        }
    }else{
        [UIView animateWithDuration:0.1 animations:^{
            self.selectedIconView.center = CGPointMake(self.frame.size.width - self.selectedIconView.frame.size.width/2,self.selectedIconView.center.y);
        }];
        
    }
}

-(void)toggleSelected
{
    if (self.ifSelected){
        self.selectedIconView.image = [UIImage imageNamed:@"notSelected.png"];
        self.ifSelected=NO;
    }else{
        self.selectedIconView.image = [UIImage imageNamed:@"Selected.png"];
        self.ifSelected=YES;
        
    }
}

@end
