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
#include <AssetsLibrary/AssetsLibrary.h>
#include "AppRecord.h"

static NSInteger count=0;

@interface ViewController ()
{
    ALAssetsLibrary *library;
    NSArray *imageArray;
    NSMutableArray *mutableArray;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // The following code will crash the app if there are a lot of photos in the device.
    //[self getAllPictures];
    // So we change it to bundle's image
    mutableArray=[[NSMutableArray alloc] init];
    for(int i=1;i<11;i++){
        [mutableArray addObject:[UIImage imageNamed:[NSString stringWithFormat:@"%d.JPG",i]]];
        //[mutableArray addObject:[UIImage imageNamed:@"1.JPG"]];
    }
    imageArray=[[NSArray alloc] initWithArray:mutableArray];
    [self allPhotosCollected:imageArray];
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)gotoPhotoCarousel:(id)sender {
    UICollectionViewFlowLayout *fLayout=[[UICollectionViewFlowLayout alloc] init];
    PhotoCarouselViewController *pcvController=[[PhotoCarouselViewController alloc] initWithCollectionViewLayout:fLayout];
    pcvController.appRecordEntries=[[NSMutableArray alloc] init];
    for (UIImage* img in imageArray) {
        AppRecord *appRecord=[[AppRecord alloc] init];
        appRecord.image=img;
        appRecord.isSelected=NO;
        [pcvController.appRecordEntries addObject:appRecord];
        
    }
    //CollectionViewController *pcvController=[[CollectionViewController alloc] initWithCollectionViewLayout:fLayout];
    //[self presentViewController:pcvController animated:YES completion:nil];
    
    UIViewController *rootViewController = [[[[UIApplication sharedApplication] delegate] window] rootViewController];
    [rootViewController presentViewController:pcvController animated:NO completion:nil];

}

-(void)getAllPictures
{
    imageArray=[[NSArray alloc] init];
    mutableArray =[[NSMutableArray alloc]init];
    NSMutableArray* assetURLDictionaries = [[NSMutableArray alloc] init];
    
    library = [[ALAssetsLibrary alloc] init];
    
    void (^assetEnumerator)( ALAsset *, NSUInteger, BOOL *) = ^(ALAsset *result, NSUInteger index, BOOL *stop) {
        if(result != nil) {
            if([[result valueForProperty:ALAssetPropertyType] isEqualToString:ALAssetTypePhoto]) {
                [assetURLDictionaries addObject:[result valueForProperty:ALAssetPropertyURLs]];
                
                NSURL *url= (NSURL*) [[result defaultRepresentation]url];
                
                [library assetForURL:url
                         resultBlock:^(ALAsset *asset) {
                             [mutableArray addObject:[UIImage imageWithCGImage:[[asset defaultRepresentation] fullScreenImage]]];
                             
                             if ([mutableArray count]==count)
                             {
                                 imageArray=[[NSArray alloc] initWithArray:mutableArray];
                                 [self allPhotosCollected:imageArray];
                             }
                         }
                        failureBlock:^(NSError *error){ NSLog(@"operation was not successfull!"); } ];
                
            }
        }
    };
    
    NSMutableArray *assetGroups = [[NSMutableArray alloc] init];
    
    void (^ assetGroupEnumerator) ( ALAssetsGroup *, BOOL *)= ^(ALAssetsGroup *group, BOOL *stop) {
        if(group != nil) {
            [group enumerateAssetsUsingBlock:assetEnumerator];
            [assetGroups addObject:group];
            count=[group numberOfAssets];
        }
    };
    
    assetGroups = [[NSMutableArray alloc] init];
    
    [library enumerateGroupsWithTypes:ALAssetsGroupAll
                           usingBlock:assetGroupEnumerator
                         failureBlock:^(NSError *error) {NSLog(@"There is an error");}];
}

-(void)allPhotosCollected:(NSArray*)imgArray
{
    //write your code here after getting all the photos from library...
    NSLog(@"all pictures are %@",imgArray);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
