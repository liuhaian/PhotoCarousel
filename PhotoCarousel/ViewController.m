//
//  ViewController.m
//  PhotoCarousel
//
//  Created by Haian Liu on 1/23/15.
//  Copyright (c) 2015 Haian Liu. All rights reserved.
//

#import "ViewController.h"
#import "PhotoCarouselViewController.h"
#import "CollectionViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)gotoPhotoCarousel:(id)sender {
    UICollectionViewFlowLayout *fLayout=[[UICollectionViewFlowLayout alloc] init];
    PhotoCarouselViewController *pcvController=[[PhotoCarouselViewController alloc] initWithCollectionViewLayout:fLayout];
    //CollectionViewController *pcvController=[[CollectionViewController alloc] initWithCollectionViewLayout:fLayout];
    //[self presentViewController:pcvController animated:YES completion:nil];
    
    UIViewController *rootViewController = [[[[UIApplication sharedApplication] delegate] window] rootViewController];
    [rootViewController presentViewController:pcvController animated:NO completion:nil];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end