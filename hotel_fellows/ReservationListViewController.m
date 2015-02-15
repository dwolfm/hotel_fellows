//
//  ReservationListViewController.m
//  hotel_fellows
//
//  Created by drwizzard on 2/11/15.
//  Copyright (c) 2015 nacnud. All rights reserved.
//

#import "ReservationListViewController.h"
#import "HotelService.h"
#import "Room.h"


@interface ReservationListViewController () <NSFetchedResultsControllerDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSFetchedResultsController *fetchResutlsController;

@end

@implementation ReservationListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.dataSource = self;
    // Do any additional setup after loading the view.
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Add Reservation" style: UIBarButtonItemStyleDone target:self action: @selector(addReservation:)];
    
//    NSManagedObjectContext *context = [[HotelService sharedService] coreDataStack].managedObjectContext;
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(IBAction)addReservation:(id)sender {
    NSLog(@"lulwat");
    [self performSegueWithIdentifier:@"MAKE_RESERVATION_SEGUE" sender:self];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc]init];
    cell.textLabel.text = @"lul swag hax";
    cell.backgroundColor = [[UIColor alloc]initWithRed: 0.78 green:0.89 blue:0.77 alpha:1];
    return cell;
    
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
