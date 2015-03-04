//
//  MakeReservationViewController.m
//  hotel_fellows
//
//  Created by drwizzard on 2/11/15.
//  Copyright (c) 2015 nacnud. All rights reserved.
//

#import "MakeReservationViewController.h"
#import "Reservation.h"
#import "Guest.h"
#import "HotelService.h"

@interface MakeReservationViewController ()
@property (weak, nonatomic) IBOutlet UIDatePicker *startDatePicker;
@property (weak, nonatomic) IBOutlet UIDatePicker *endDatePicker;

@end

@implementation MakeReservationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)bookPressed:(id)sender {
    Guest *guest = [NSEntityDescription insertNewObjectForEntityForName:@"Guest" inManagedObjectContext:[[HotelService sharedService] coreDataStack].managedObjectContext];
    guest.firstName = @"dunk";
    guest.lastName = @"slug";
    
    NSLog(@"made reservation for adate %@", self.startDatePicker.date);
    [[HotelService sharedService]bookReservationForGuest:guest forRoom:self.selectedRoom startDate:self.startDatePicker.date endDate:self.endDatePicker.date];

    
    [[self navigationController] popViewControllerAnimated:true];

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
