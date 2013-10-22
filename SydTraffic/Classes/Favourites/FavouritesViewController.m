//
//  FavouritesViewController.m
//  SydTraffic
//
//  Created by Nicolas Triantafillou on 26/09/13.
//  Copyright (c) 2013 Nicolas Triantafillou. All rights reserved.
//

#import "FavouritesViewController.h"
#import "SharedData.h"
#import "FavouriteCell.h"
#import "UIImageView+AFNetworking.h"
#import "CameraViewController.h"


@interface FavouritesViewController ()

@end

@implementation FavouritesViewController

@synthesize toolBar, background, collection, faveList, ip, label, image, smallview;

- (IBAction)back:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(UIStatusBarStyle) preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    LXReorderableCollectionViewFlowLayout *layout = [[LXReorderableCollectionViewFlowLayout alloc] init];
    [self.collection setCollectionViewLayout:layout];
    
    // put a transparent image under the status bar to make it translucent but tinted
    UIImageView *coverStatus = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    coverStatus.image = [UIImage imageNamed:@"trans50.png"];
    [self.view addSubview:coverStatus];
    [self.view sendSubviewToBack:coverStatus];
    
    // set the background
    self.background = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0,
                                                              [UIScreen mainScreen].bounds.size.width,
                                                              [UIScreen mainScreen].bounds.size.height)];
    
    // fill the image from the top, to suit 3.5 inch devices
    [self.background setContentMode:UIViewContentModeScaleAspectFill];
    self.background.image = [UIImage imageNamed:[NSString stringWithFormat:@"bg%@.jpg",[SharedData sharedInstance].bg]];
    [self.view addSubview:background];
    [self.view sendSubviewToBack:background];
    
    [self.toolBar setBackgroundColor:[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.8]];
    [self.collection setBackgroundColor:[UIColor clearColor]];

    // gets rid of the top 1px white border above the toolbar
    self.toolBar.clipsToBounds = YES;
    
    //[collection registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"faveCell"];


}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UICollectionView Datasource
// 1
- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section {
    //NSString *searchTerm = self.searches[section];
    //return [self.searchResults[searchTerm] count];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:@"F.plist"];
    self.faveList = [NSMutableDictionary dictionaryWithContentsOfFile:filePath];
    
    // if it's nil, there was no file, and no favourites
    if ([self.faveList count] == 0)
    {
        self.smallview.hidden = FALSE;
        return 0;
    }

    // this far means we have at least one favourite
    self.smallview.hidden = TRUE;
    
    return [self.faveList count];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    

    FavouriteCell *cell = [cv dequeueReusableCellWithReuseIdentifier:@"faveCell" forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor whiteColor];
    
    // fave keys
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *favkeyspath = [documentsDirectory stringByAppendingPathComponent:@"FK.plist"];
    NSMutableArray *favKeys = [[NSMutableArray alloc] initWithContentsOfFile:favkeyspath];
    NSDictionary *tmpcamera = [faveList objectForKey:[favKeys objectAtIndex:indexPath.row]];

    //NSLog(@"camera processing: %@", [keyArray objectAtIndex:indexPath.row]);
    
    [cell.imageView setImageWithURL:[NSURL URLWithString:[tmpcamera objectForKey:@"url"]] placeholderImage:[UIImage imageNamed:@"trans50.png"]];

    return cell;
}

/*
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"faveCell";
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    UIImageView *recipeImageView = (UIImageView *)[cell viewWithTag:100];
    recipeImageView.image = [UIImage imageNamed:@"bg1.png"];
    
    return cell;
}*/

// 4
/*- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
 return [[UICollectionReusableView alloc] init];
}*/

- (void)collectionView:(UICollectionView *)collectionView itemAtIndexPath:(NSIndexPath *)fromIndexPath willMoveToIndexPath:(NSIndexPath *)toIndexPath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *favkeyspath = [documentsDirectory stringByAppendingPathComponent:@"FK.plist"];
    NSMutableArray *favKeys = [[NSMutableArray alloc] initWithContentsOfFile:favkeyspath];
    
    
    id object = [favKeys objectAtIndex:fromIndexPath.item];
    [favKeys removeObjectAtIndex:fromIndexPath.item];
    [favKeys insertObject:object atIndex:toIndexPath.item];
    [favKeys writeToFile:favkeyspath atomically:YES];
}


#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    self.ip = indexPath;
    [self performSegueWithIdentifier:@"camview" sender:self];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"camview"])
    {
        CameraViewController *destViewController = [segue destinationViewController];
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *favkeyspath = [documentsDirectory stringByAppendingPathComponent:@"FK.plist"];
        NSMutableArray *favKeys = [[NSMutableArray alloc] initWithContentsOfFile:favkeyspath];
        NSDictionary *tmpcamera = [faveList objectForKey:[favKeys objectAtIndex:ip.row]];

        destViewController.thetitle = [tmpcamera objectForKey:@"name"];
        destViewController.theurl = [tmpcamera objectForKey:@"url"];
        destViewController.thedesc = [tmpcamera objectForKey:@"desc"];
   
    }
}





- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    // TODO: Deselect item
}

#pragma mark – UICollectionViewDelegateFlowLayout

// 1
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    //NSString *searchTerm = self.searches[indexPath.section]; FlickrPhoto *photo = self.searchResults[searchTerm][indexPath.row];
    
    CGSize retval =  CGSizeMake(107, 80);
    retval.height += 25; retval.width += 25;
    return retval;
}

// 3
- (UIEdgeInsets)collectionView:
(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(5, 20, 5, 20);
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    //[self.collection reloadData];
  
}



@end
