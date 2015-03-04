//
//  RoomListViewController.m
//  hotel_fellows
//
//  Created by drwizzard on 2/9/15.
//  Copyright (c) 2015 nacnud. All rights reserved.
//

#import "RoomListViewController.h"
#import "AppDelegate.h"
#import "Room.h"
#import "ReservationListViewController.h"

@interface RoomListViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *roomsArray;
@end

@implementation RoomListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.roomsArray = (NSArray *)self.selectedHotel.rooms.allObjects;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return
    self.roomsArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ROOM_CELL"];
    Room *room = self.roomsArray[indexPath.row];
    cell.textLabel.text =  [NSString stringWithFormat:@"%@", room.number];
    return cell;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"RESERVAION_LIST"]) {
        ReservationListViewController *destinationVC = segue.destinationViewController;
        NSIndexPath *indexPath = self.tableView.indexPathForSelectedRow;
        Room *room = self.roomsArray[indexPath.row];
        destinationVC.selectedRoom = room;
    }
}


@end
