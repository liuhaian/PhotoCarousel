//
//  PhotoCarouselViewController.m
//  PhotoCarousel
//
//  Created by Haian Liu on 1/23/15.
//  Copyright (c) 2015 Haian Liu. All rights reserved.
//

#import "PhotoCarouselViewController.h"
#import "PhotoCarouselCell.h"
#import "AppRecord.h"
#import <AssetsLibrary/AssetsLibrary.h>

#define CELL_WIDTH 120
#define CELL_HEIGHT 120
#define CELL_LINE_SPACE 10.0f

@interface PhotoCarouselViewController ()
{
    UIButton *button;
}
//@property(nonatomic, strong) NSArray *assets;

@end

@implementation PhotoCarouselViewController

static NSString * const reuseIdentifier = @"Cell";
+ (ALAssetsLibrary *)defaultAssetsLibrary
{
    static dispatch_once_t pred = 0;
    static ALAssetsLibrary *library = nil;
    dispatch_once(&pred, ^{
        library = [[ALAssetsLibrary alloc] init];
    });
    return library;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc] init];
    [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    layout.minimumInteritemSpacing=1000.0f;
    layout.minimumLineSpacing=CELL_LINE_SPACE;
    [layout setItemSize:CGSizeMake(CELL_WIDTH, CELL_HEIGHT)];
    self.collectionView=[[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:layout];
    [self.collectionView setDataSource:self];
    [self.collectionView setDelegate:self];
    
    //[self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    [self.collectionView registerClass:[PhotoCarouselCell class] forCellWithReuseIdentifier:reuseIdentifier];
    [self.collectionView setBackgroundColor:[UIColor whiteColor]];
    [self.collectionView setUserInteractionEnabled:YES];

    if(self.appRecordEntries==nil){
        self.appRecordEntries=[[NSMutableArray alloc] init];
    }
    
    //To test on a device with a lot of photos
 //   _assets = [@[] mutableCopy];
 //   __block NSMutableArray *tmpAssets = [@[] mutableCopy];
    // 1
    ALAssetsLibrary *assetsLibrary = [PhotoCarouselViewController defaultAssetsLibrary];
    // 2
    [assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
        if(group != nil) {
            [group enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
                if(result)
                {
                    // 3
//                    [tmpAssets addObject:result];
                    AppRecord *appRecord = [[AppRecord alloc] init];
                    appRecord.image=[UIImage imageWithCGImage:[result thumbnail]];
                    [self.appRecordEntries addObject:appRecord];

                }
            }];
        }
        
        // 4
        //NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"date" ascending:NO];
        //self.assets = [tmpAssets sortedArrayUsingDescriptors:@[sort]];
        //self.assets=tmpAssets;
//        for (ALAsset *asset in tmpAssets){
//            AppRecord *appRecord = [[AppRecord alloc] init];
//            appRecord.image=[UIImage imageWithCGImage:[asset thumbnail]];
//            [self.appRecordEntries addObject:appRecord];
//            
//        }
        
        
        // 5
        [self.collectionView reloadData];
    } failureBlock:^(NSError *error) {
        NSLog(@"Error loading images %@", error);
    }];
    

    
    //Add a button over the collectionView
    button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button addTarget:self
               action:@selector(showCount)
     forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"Count" forState:UIControlStateNormal];
    
    UIWindow* window=[UIApplication sharedApplication].delegate.window;
    //   button.frame = CGRectMake(window.center.x-80, window.frame.size.height-40,160.0, 40.0);
    [window addSubview:button];
    
    //Add Autolayout
    [button setTranslatesAutoresizingMaskIntoConstraints:NO];
    NSLayoutConstraint *myConstraint =[NSLayoutConstraint
                                       constraintWithItem:button
                                       attribute:NSLayoutAttributeCenterX
                                       relatedBy:NSLayoutRelationEqual
                                       toItem:window
                                       attribute:NSLayoutAttributeCenterX
                                       multiplier:1.0
                                       constant:0];
    [window addConstraint:myConstraint];
    myConstraint =[NSLayoutConstraint
                   constraintWithItem:button
                   attribute:NSLayoutAttributeBottom
                   relatedBy:NSLayoutRelationEqual
                   toItem:window
                   attribute:NSLayoutAttributeBottom
                   multiplier:1.0
                   constant:-10];
    [window addConstraint:myConstraint];
    
    
}
-(void)showCount{
    NSString *msg=[NSString stringWithFormat:@"You have selected %ld cells", (long)[self getSelectionCount]];
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:nil
                          message:msg
                          delegate:nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil];
    [alert show];
    
}
-(NSInteger)getSelectionCount{
    NSInteger iReturnCount=0;
    if(self.appRecordEntries!=nil){
        for (AppRecord* appRecord in self.appRecordEntries) {
            if(appRecord.isSelected)iReturnCount++;
        }
    }
    return iReturnCount;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    // scroll to the cell
    //NSIndexPath* firstItemPath = [NSIndexPath indexPathForRow:0 inSection:0];
    //PhotoCarouselCell *firstcell = (PhotoCarouselCell *)[self.collectionView cellForItemAtIndexPath:firstItemPath];
    //CGFloat collectionViewWidth = CGRectGetWidth(self.collectionView.frame);
    //CGPoint offset = CGPointMake(firstcell.center.x - collectionViewWidth / 2, 0);
    //[self.collectionView setContentOffset:offset animated:YES];
    [self.collectionView setContentOffset:CGPointMake(1.0,0) animated:YES];
    /*[self.collectionView scrollToItemAtIndexPath:firstItemPath
     atScrollPosition:UICollectionViewScrollPositionBottom
     animated:YES];
     // */
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(CELL_WIDTH, CELL_HEIGHT);
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

/*Comment out the following as it is taken over by Auto Layout
 - (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
 {
 [super didRotateFromInterfaceOrientation:fromInterfaceOrientation];
 //    UIWindow* window=[UIApplication sharedApplication].delegate.window;
 [UIView animateWithDuration:0.1 animations:^{
 button.center = CGPointMake(self.collectionView.frame.size.width/2,self.collectionView.frame.size.height-40);
 }];
 
 }
 // */

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    PhotoCarouselCell *cell = (PhotoCarouselCell *)[collectionView cellForItemAtIndexPath:indexPath];
    //cell.backgroundColor = [UIColor whiteColor];
    NSLog(@"Cell center is %f", cell.center.x);
    
    //    NSArray *visibleItems = [self.collectionView indexPathsForVisibleItems];
    //    NSIndexPath *currentItem = [visibleItems objectAtIndex:0];
    //    NSIndexPath *nextItem = [NSIndexPath indexPathForItem:currentItem.item + 1 inSection:currentItem.section];
    //    NSIndexPath *nextItem = [NSIndexPath indexPathForItem:indexPath.item + 1 inSection:indexPath.section];
    //    [self.collectionView scrollToItemAtIndexPath:nextItem atScrollPosition:UICollectionViewScrollPositionTop animated:YES];
    
    //If the selected cell is in center of the window, toggle Selected or not state of the cell. Else just scroll the seleted view to center.
    CGFloat collectionViewWidth = CGRectGetWidth(self.collectionView.frame);
    // [collectionView setContentInset:UIEdgeInsetsMake(collectionViewWidth / 2, 0, collectionViewWidth / 2, 0)];
    CGPoint offset = CGPointMake(cell.center.x - collectionViewWidth / 2, 0);
    float cellToCenter=self.collectionView.contentOffset.x+self.collectionView.frame.size.width/2-cell.center.x;
    if(abs(cellToCenter)<5){
        AppRecord *appRecord=[self.appRecordEntries objectAtIndex:indexPath.row];
        if(appRecord.isSelected){
            [cell toggleSelected:NO];
            appRecord.isSelected=NO;
        }else{
            [cell toggleSelected:YES];
            appRecord.isSelected=YES;
        }
    }else{
        [collectionView setContentOffset:offset animated:YES];
    }
    
    /* delete the following as we have achieved it in Cell class
     NSIndexPath *nextItem = [NSIndexPath indexPathForItem:indexPath.item + 1 inSection:indexPath.section];
     PhotoCarouselCell *nextCell = (PhotoCarouselCell *)[collectionView cellForItemAtIndexPath:nextItem];
     [UIView animateWithDuration:1.0
     delay:0
     options:(UIViewAnimationOptionAllowUserInteraction)
     animations:^{
     NSLog(@"animation start");
     //[nextCell setBackgroundColor:[UIColor colorWithRed: 180.0/255.0 green: 238.0/255.0 blue:180.0/255.0 alpha: 1.0]];
     //nextCell.selectedIconView.center=CGPointMake(nextCell.selectedIconView.center.x-200,nextCell.selectedIconView.center.y);
     nextCell.selectedIconView.frame =CGRectMake(0, cell.frame.size.height - 45, 45, 45);
     }
     completion:^(BOOL finished){
     NSLog(@"animation end");
     [nextCell setBackgroundColor:[UIColor whiteColor]];
     }
     ];
     // */
    
    
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.appRecordEntries.count;
}
/*
 - (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
 UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
 
 // Configure the cell
 cell.backgroundColor=[UIColor greenColor];
 
 return cell;
 }
 // */

- (PhotoCarouselCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PhotoCarouselCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    /* move the following to scrollViewDidScroll
     CGRect cellRect = [self.collectionView convertRect:cell.frame toView:self.collectionView];
     CGRect collectionVisualRect=self.collectionView.frame;
     if(cellRect.origin.x+cellRect.size.width>collectionVisualRect.size.width){
     [cell setSelectIconCenter:YES];
     }else{
     [cell setSelectIconCenter:NO];
     }
     // */
    // Configure the cell
    AppRecord *appRecord=[self.appRecordEntries objectAtIndex:indexPath.row];
    [cell setImage:appRecord.image];
    [cell toggleSelected:appRecord.isSelected];
    
    return cell;
}


#pragma mark <UICollectionViewDelegate>

/*
 // Uncomment this method to specify if the specified item should be highlighted during tracking
 - (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
 }
 */

//*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
// */

/*
 // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
 - (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
 }
 
 - (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
 }
 
 - (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
 }
 */
# pragma mart <UISCrollViewDelegate>
- (void) scrollViewDidScroll:(UIScrollView *)scrollView {
    // Animation code here.
    NSArray *visibleItems = [self.collectionView indexPathsForVisibleItems];
    /* Comment the following as the order is messed up
     NSIndexPath *firstItem = [visibleItems objectAtIndex:0];
     PhotoCarouselCell *firstCell = (PhotoCarouselCell *)[self.collectionView cellForItemAtIndexPath:firstItem];
     [firstCell setSelectIconCenter:YES];
     NSLog(@"First cell center %f",firstCell.center.x);
     
     
     if(visibleItems.count==3){
     NSIndexPath *middleItem = [visibleItems objectAtIndex:1];
     PhotoCarouselCell *middleCell = (PhotoCarouselCell *)[self.collectionView cellForItemAtIndexPath:middleItem];
     [middleCell setSelectIconCenter:YES];
     NSLog(@"Middle cell center %f",middleCell.center.x);
     
     }
     
     NSIndexPath *lastItem = [visibleItems lastObject];
     PhotoCarouselCell *lastCell = (PhotoCarouselCell *)[self.collectionView cellForItemAtIndexPath:lastItem];
     [lastCell setSelectIconCenter:NO];
     NSLog(@"Last cell center %f",lastCell.center.x);
     // */
    //Adjust the Selected icon position for only right most picture.
    for (NSIndexPath* item in visibleItems) {
        PhotoCarouselCell *cell = (PhotoCarouselCell *)[self.collectionView cellForItemAtIndexPath:item];
        CGFloat rightX=self.collectionView.contentOffset.x+self.collectionView.frame.size.width;
        CGFloat cellRight=cell.center.x+cell.frame.size.width/2;
        CGFloat rigthEdge=rightX+cell.frame.size.width/2-cell.center.x;
        if(rightX<cellRight){
            [cell setSelectIconCenter:YES shouldAlignToRightEdge:rigthEdge];
        }else{
            [cell setSelectIconCenter:NO shouldAlignToRightEdge:rigthEdge];
        }
        
    }
    
    NSLog(@"scrollViewDidScroll");
}

@end
