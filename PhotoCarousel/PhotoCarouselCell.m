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
        
        self.ifSelected = [[UIImageView alloc] init];
        self.ifSelected.image = [UIImage imageNamed:@"notSelected.png"];
        [self.contentView insertSubview:self.photoView atIndex:4];
        
        self.layer.cornerRadius = 6.0;
        
    }
    return self;
}

-(void)layoutSubviews{
    
    [super layoutSubviews];
    
    if (self.ifSelected) {
        // /*
        //self.photoView.frame =CGRectMake(0, 0, 140, self.bounds.size.height - self.ifSelected.bounds.size.height);
        self.photoView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        [self.photoView setContentScaleFactor:UIViewContentModeScaleAspectFit];
        self.ifSelected.frame =CGRectMake(self.frame.size.width - 45, self.frame.size.height - 45, 45, 45);
        [self.contentView insertSubview:self.ifSelected atIndex:2];
        // */
        
    }
    else{
        NSLog(@"selected icon not shown.");
        self.photoView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        
        
    }
    
}

@end
