//
//  MainViewController.m
//  Space_Coding_Challenge
//
//  Created by Frans Kurniawan on 4/23/14.
//  Copyright (c) 2014 Frans Kurniawan. All rights reserved.
//
#define urlPrefix [NSURL URLWithString:@"http://mydeatree.appspot.com/api/v1/public_ideas/"]
#import "MainViewController.h"

@interface MainViewController ()
{
    NSMutableData *webData;
    NSURLConnection *connection;
}

@end

@implementation MainViewController
@synthesize colView,index,colCell,titleArray,textArray,createdDateArray,combinedDict;

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
    // Do any additional setup after loading the view from its nib.
    NSLog(@"%@",urlPrefix);
    //Load Content
    webData = [NSMutableData data];
    NSURLRequest *request = [NSURLRequest requestWithURL:urlPrefix];
    [[NSURLConnection alloc]initWithRequest:request delegate:self];
    
    colView.delegate = self;
    colView.dataSource = self;
    //Initialize CollectionView
    [self prepareCollectionView];
}

#pragma mark NSURL Delegate
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [webData setLength:0];
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [webData appendData:data];
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"Fail Getting Data");
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSDictionary *allDict = [NSJSONSerialization JSONObjectWithData:webData options:0 error:nil];
    NSArray *allObject = [allDict valueForKey:@"objects"];
    createdDateArray = [[NSMutableArray alloc]init];
    textArray = [[NSMutableArray alloc]init];
    titleArray = [[NSMutableArray alloc]init];
    
    for (NSDictionary *dict in allObject)
    {
        combinedDict = [dict allValues];
        NSString *created_date_string = [dict objectForKey:@"created_date"];
        NSString *text_string = [dict objectForKey:@"text"];
        NSString *title_string = [dict objectForKey:@"title"];
        
        [createdDateArray addObject:created_date_string];
        [textArray addObject:text_string];
        [titleArray addObject:title_string];
    }
    
    [self.colView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark prepateCollectionView
-(void)prepareCollectionView
{
    [colView registerClass:[CollectionCell class] forCellWithReuseIdentifier:@"cellIdentifier"];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    [colView setCollectionViewLayout:flowLayout];
}


#pragma mark CollectionView Delegate Methods
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return titleArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    CollectionCell *cell = (CollectionCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifier" forIndexPath:indexPath];

    [cell.titleLabel setText:titleArray[indexPath.row]];
    [cell.textLabel setText:textArray[indexPath.row]];
    [cell.createdDateLabel setText:createdDateArray[indexPath.row]];
    
    return cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGSize size = CGSizeMake(320, 320);
    return size;
}

#pragma sort button clicked
- (IBAction)sortByTitleClicked:(id)sender
{
    NSArray *titleTemp = [[NSArray alloc]initWithArray:titleArray];
    NSArray *sortedArray = [titleTemp sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    titleTemp =[[NSMutableArray alloc]initWithArray: sortedArray];
    
    NSMutableArray *textTemp = [[NSMutableArray alloc]init];
    NSMutableArray *dateTemp = [[NSMutableArray alloc]init];
    
    int total = titleArray.count;

    for (int i = 0; i < total; i++) {
        int idx = 0;
        idx = [titleArray indexOfObject:titleTemp[i]];
        [textTemp addObject:textArray[idx]];
        [dateTemp addObject:createdDateArray[idx]];
    }
    
    textArray = [[NSMutableArray alloc]initWithArray:textTemp];
    titleArray = [[NSMutableArray alloc]initWithArray:titleTemp];
    createdDateArray = [[NSMutableArray alloc]initWithArray:dateTemp];
    
    [colView reloadData];
}

- (IBAction)sortByDateClicked:(id)sender
{
    NSArray *dateTemp = [[NSArray alloc]initWithArray:createdDateArray];
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:nil ascending:NO selector:@selector(localizedCompare:)];
    NSArray *sortedArray = [dateTemp sortedArrayUsingDescriptors:[NSArray arrayWithObject:sortDescriptor]];
    dateTemp =[[NSMutableArray alloc]initWithArray: sortedArray];
    
    NSMutableArray *textTemp = [[NSMutableArray alloc]init];
    NSMutableArray *titleTemp = [[NSMutableArray alloc]init];
    
    int total = createdDateArray.count;
    
    for (int i = 0; i < total; i++) {
        int idx = 0;
        idx = [createdDateArray indexOfObject:dateTemp[i]];
        [textTemp addObject:textArray[idx]];
        [titleTemp addObject:titleArray[idx]];
    }
    
    textArray = [[NSMutableArray alloc]initWithArray:textTemp];
    titleArray = [[NSMutableArray alloc]initWithArray:titleTemp];
    createdDateArray = [[NSMutableArray alloc]initWithArray:dateTemp];
    
    [colView reloadData];
}
@end
