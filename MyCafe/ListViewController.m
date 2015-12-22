//
//  ListViewController.m
//  MyCafe
//
//  Created by User on 12/17/15.
//  Copyright © 2015 Harman. All rights reserved.
//

#import "ListViewController.h"
//#import "MainPageViewController.h"
#import "SharedData.h"
#import "ListViewCell.h"
#import "RecordViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface ListViewController () <CLLocationManagerDelegate>

@property (nonatomic) NSArray *records;
@property (strong, nonatomic) IBOutlet UITableView *listTableView;
@property (nonatomic) RecordViewController *recordViewController;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) CLLocation *currentLocation;

@end

@implementation ListViewController

- (void)awakeFromNib {
    NSLog(@"ListView awaked from nib");
    // Initializing SharedData singleton and array with records
    //self.records = [SharedData sharedData].listOfRecords;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    [self.locationManager requestWhenInUseAuthorization];
    self.currentLocation = self.locationManager.location;
    
    NSLog(@"ListView loaded");
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSLog(@"ListView appeared");

    // Initializing SharedData singleton and array with records
    self.records = [SharedData sharedData].listOfRecords;
    
    NSLog(@"Records array in ListViewController: %@", self.records);
    
    //Updatind table view sending message to the tableView property of UITableViewController superclass
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.records count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // Register custom class in accordance with UITableView class reference (there are some other ways described in apple develop library)
    //[tableView registerClass:[ListViewCell class] forCellReuseIdentifier:@"ListCell"];
    
    ListViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ListCell" forIndexPath:indexPath];
    
    //cell.cellRecord = self.records[indexPath.row];
    //[cell fillData];
    
    Record *currentRecord = self.records[indexPath.row];
    
    cell.nameLabel.text = currentRecord.name;
    cell.typeLabel.text = currentRecord.type;
    cell.addressLabel.text = currentRecord.address;
    
    switch (currentRecord.rating) {
        case 1:
            cell.star1.image = [UIImage imageNamed:@"filledStar"];
            break;
        case 2:
            cell.star1.image = [UIImage imageNamed:@"filledStar"];
            cell.star2.image = [UIImage imageNamed:@"filledStar"];
            break;
        case 3:
            cell.star1.image = [UIImage imageNamed:@"filledStar"];
            cell.star2.image = [UIImage imageNamed:@"filledStar"];
            cell.star3.image = [UIImage imageNamed:@"filledStar"];
            break;
        case 4:
            cell.star1.image = [UIImage imageNamed:@"filledStar"];
            cell.star2.image = [UIImage imageNamed:@"filledStar"];
            cell.star3.image = [UIImage imageNamed:@"filledStar"];
            cell.star4.image = [UIImage imageNamed:@"filledStar"];
            break;
        case 5:
            cell.star1.image = [UIImage imageNamed:@"filledStar"];
            cell.star2.image = [UIImage imageNamed:@"filledStar"];
            cell.star3.image = [UIImage imageNamed:@"filledStar"];
            cell.star4.image = [UIImage imageNamed:@"filledStar"];
            cell.star5.image = [UIImage imageNamed:@"filledStar"];
            break;
        default:
            cell.star1.image = nil;
            cell.star2.image = nil;
            cell.star3.image = nil;
            cell.star4.image = nil;
            cell.star5.image = nil;
            break;
    }
    
    switch (currentRecord.price) {
        case 1:
            cell.coin1.image = [UIImage imageNamed:@"filledCoin"];
            break;
        case 2:
            cell.coin1.image = [UIImage imageNamed:@"filledCoin"];
            cell.coin2.image = [UIImage imageNamed:@"filledCoin"];
            break;
        case 3:
            cell.coin1.image = [UIImage imageNamed:@"filledCoin"];
            cell.coin2.image = [UIImage imageNamed:@"filledCoin"];
            cell.coin3.image = [UIImage imageNamed:@"filledCoin"];
            break;
        case 4:
            cell.coin1.image = [UIImage imageNamed:@"filledCoin"];
            cell.coin2.image = [UIImage imageNamed:@"filledCoin"];
            cell.coin3.image = [UIImage imageNamed:@"filledCoin"];
            cell.coin4.image = [UIImage imageNamed:@"filledCoin"];
            break;
        case 5:
            cell.coin1.image = [UIImage imageNamed:@"filledCoin"];
            cell.coin2.image = [UIImage imageNamed:@"filledCoin"];
            cell.coin3.image = [UIImage imageNamed:@"filledCoin"];
            cell.coin4.image = [UIImage imageNamed:@"filledCoin"];
            cell.coin5.image = [UIImage imageNamed:@"filledCoin"];
            break;
        default:
            cell.coin1.image = nil;
            cell.coin2.image = nil;
            cell.coin3.image = nil;
            cell.coin4.image = nil;
            cell.coin5.image = nil;
            break;
    }

    NSLog(@"Return cell: %@ with rating %ld and price %ld", currentRecord.name, (long) currentRecord.rating, (long) currentRecord.price);
    
    /*
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    __block CLLocation *currentRecordLocation;
    
    [geocoder geocodeAddressString:currentRecord.address
                 completionHandler:^(NSArray<CLPlacemark *> *placemarks, NSError *error) {
                     if ([placemarks count] > 0) {
                         CLPlacemark *currentPlacemark = [placemarks objectAtIndex:0];
                         currentRecordLocation = currentPlacemark.location;
                         NSLog(@"Record Location: %@", currentRecordLocation);
                         CLLocationDistance distance = [currentRecordLocation distanceFromLocation:self.currentLocation];
                         cell.distanceLabel.text = [NSString stringWithFormat:@"%.0f m", distance];
                     }
    }];
    */
    
    CLLocationDistance distance = [currentRecord.location distanceFromLocation:self.currentLocation];
    cell.distanceLabel.text = [NSString stringWithFormat:@"%.0f m", distance];
    
    return cell;
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSLog(@"Prepare for segue in ListViewController");
    self.recordViewController = [segue destinationViewController];
}


#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //[tableView deselectRowAtIndexPath:indexPath animated:NO];
    NSLog(@"Click!");
    self.recordViewController.record = [self.records objectAtIndex:indexPath.row];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

@end