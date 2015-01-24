//
//  PhotoCarouselViewController.m
//  PhotoCarousel
//
//  Created by Haian Liu on 1/23/15.
//  Copyright (c) 2015 Haian Liu. All rights reserved.
//

#import "PhotoCarouselViewController.h"
#import "PhotoCarouselCell.h"

@interface PhotoCarouselViewController ()
{
    //UICollectionView *_collectionView;
}

@end

@implementation PhotoCarouselViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {

    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    //Create view programmingly
 //   self.view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc] init];
    [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    layout.minimumInteritemSpacing=1000.0f;
    layout.minimumLineSpacing=20.0f;
    [layout setItemSize:CGSizeMake(240, 240)];
    self.collectionView=[[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:layout];
    [self.collectionView setDataSource:self];
    [self.collectionView setDelegate:self];
    
    //[self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    [self.collectionView registerClass:[PhotoCarouselCell class] forCellWithReuseIdentifier:reuseIdentifier];
    [self.collectionView setBackgroundColor:[UIColor whiteColor]];
    [self.collectionView setUserInteractionEnabled:YES];
    
//    [self.view addSubview:_collectionView];
    
    // Register cell classes
    //[self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    // Do any additional setup after loading the view.
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
    return CGSizeMake(240, 240);
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

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
    
    CGFloat collectionViewWidth = CGRectGetWidth(self.collectionView.frame);
    [collectionView setContentInset:UIEdgeInsetsMake(collectionViewWidth / 2, 0, collectionViewWidth / 2, 0)];
    CGPoint offset = CGPointMake(cell.center.x - collectionViewWidth / 2, 0);
    [collectionView setContentOffset:offset animated:YES];

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


}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 15;
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
    CGRect cellRect = [self.collectionView convertRect:cell.frame toView:self.collectionView.superview];
    CGRect collectionVisualRect=self.collectionView.frame;
    if(cellRect.origin.x+cellRect.size.width>collectionVisualRect.size.width){
        [cell setSelectIconCenter:YES];
    }else{
        [cell setSelectIconCenter:NO];
    }
    // Configure the cell
    //cell.backgroundColor=[UIColor greenColor];
    
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

@end
