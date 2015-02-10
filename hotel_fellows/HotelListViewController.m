//
//  HotelListViewController.m
//  hotel_fellows
//
//  Created by drwizzard on 2/9/15.
//  Copyright (c) 2015 nacnud. All rights reserved.
//

#import "HotelListViewController.h"
#import "AppDelegate.h"
#import "Hotel.h"
#import "RoomListViewController.h"


@interface HotelListViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *hotels;
@end

@implementation HotelListViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    NSManagedObjectContext *context = appDelegate.managedObjectContext;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Hotel"];
    NSError *fetchError;
    
    NSArray *results = [context executeFetchRequest:fetchRequest error: &fetchError];
    
    if (!fetchError){
        self.hotels = results;
        [self.tableView reloadData];
    }
    
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.hotels) {
        return self.hotels.count;
    } else {
        return 0;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"hotelCell"];
    Hotel *hotel = self.hotels[indexPath.row];
    cell.textLabel.text = hotel.name;
    return cell;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"ROOM_SEGUE"]){
        RoomListViewController *roomVC = (RoomListViewController *)segue.destinationViewController;
        NSIndexPath *indexPath = self.tableView.indexPathsForSelectedRows.firstObject;
        roomVC.selectedHotel = self.hotels[indexPath.row];
        
    }
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
