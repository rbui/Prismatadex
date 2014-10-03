//
//  UnitCollectionViewController.m
//  Prismatadex
//
//  Created by Ritchie Bui on 2014-10-03.
//  Copyright (c) 2014 Ritchie Bui. All rights reserved.
//

#import "UnitCollectionViewController.h"
#import "Unit.h"
#import "UnitListCollectionViewCell.h"
#import "UnitGridCollectionViewCell.h"

@interface UnitCollectionViewController ()

@property NSMutableArray *units;
@property BOOL isGridView;

@end


@implementation UnitCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    // Do any additional setup after loading the view.
    self.isGridView = YES;
    _units = [[NSMutableArray alloc] init];
    [self.collectionView registerNib: [UINib nibWithNibName: @"UnitGridCollectionViewCell" bundle: nil]
          forCellWithReuseIdentifier: @"unitGridCell"];
    [self.collectionView registerNib: [UINib nibWithNibName: @"UnitListCollectionViewCell" bundle: nil]
          forCellWithReuseIdentifier: @"unitListCell"];
    [self loadDataUnitDataFromFile];


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


#pragma mark - Helper methods

- (void) loadDataUnitDataFromFile
{
    NSString *plistPath = [[NSBundle mainBundle] pathForResource: @"Units" ofType: @"plist"];
    NSData *data = [NSData dataWithContentsOfFile:plistPath];
    NSError *error;
    NSPropertyListFormat format;
    
    NSArray *units = [NSPropertyListSerialization
                      propertyListWithData: data
                      options: NSPropertyListImmutable
                      format: &format
                      error: &error];
    
    for (NSDictionary *unitDict in units)
    {
        Unit *unit = [[Unit alloc] init];
        [unit setValuesForKeysWithDictionary: unitDict];
        [self.units addObject: unit];
    }

}

- (IBAction)toggleLayout
{
    self.isGridView = !self.isGridView;
    [self.collectionView reloadData];
    
    if (self.isGridView)
    {
        [self setGridFlowLayout];
    }
    else
    {
        [self setListFlowLayout];
    }

}

- (void) setGridFlowLayout
{
    UICollectionViewFlowLayout *gridFLow = [[UICollectionViewFlowLayout alloc] init];
    [gridFLow setItemSize: CGSizeMake(120.f, 120.f)];
    
    [self.collectionView setCollectionViewLayout: gridFLow animated: YES];
}

- (void) setListFlowLayout
{
    UICollectionViewFlowLayout *listFLow = [[UICollectionViewFlowLayout alloc] init];
    [listFLow setItemSize: CGSizeMake(350.f, 100.f)];
    
    [self.collectionView setCollectionViewLayout: listFLow animated: YES];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.units count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell;
    NSString *name = ((Unit *)self.units[indexPath.item]).name;
    
    if (self.isGridView)
    {
        cell = [collectionView dequeueReusableCellWithReuseIdentifier: @"unitGridCell" forIndexPath: indexPath];
        ((UnitGridCollectionViewCell *)cell).nameLabel.text = name;
        NSLog(@"grid cell width: %f", cell.frame.size.width);
    }
    else
    {
        cell = [collectionView dequeueReusableCellWithReuseIdentifier: @"unitListCell" forIndexPath: indexPath];
        ((UnitListCollectionViewCell *)cell).nameLabel.text = name;
        NSLog(@"list cell width: %f", cell.frame.size.width);
    }
    

    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

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
