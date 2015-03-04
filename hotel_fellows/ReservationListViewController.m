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
    NSManagedObjectContext *context = [[HotelService sharedService] coreDataStack].managedObjectContext;
    
    NSLog(@"viewdl %@", self.selectedRoom.number);
    // Do any additional setup after loading the view.
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Add Reservation" style: UIBarButtonItemStyleDone target:self action: @selector(addReservation:)];

    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Reservation"];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"room == %@",self.selectedRoom];
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"startDate" ascending:true];
    fetchRequest.predicate = predicate;
    fetchRequest.sortDescriptors = @[sortDescriptor];
    self.fetchResutlsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:context sectionNameKeyPath:nil cacheName:nil];
    self.fetchResutlsController.delegate = self;
    self.tableView.dataSource = self;
    NSError *fetchError;
    [self.fetchResutlsController performFetch:&fetchError];
    if (fetchError) {
        NSLog(@" %@",fetchError);
    }
//    NSManagedObjectContext *context = [[HotelService sharedService] coreDataStack].managedObjectContext;
   int reservations = (int) [[[self.fetchResutlsController sections] objectAtIndex:0] numberOfObjects];
    NSLog(@"num reservations %d", reservations);
}

-(void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView beginUpdates];
}

-(void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView endUpdates];
}

-(void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {
    
    switch (type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
        case NSFetchedResultsChangeUpdate:
            [self configureCell:[self.tableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
            break;
        case NSFetchedResultsChangeMove:
            [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [self.tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
        default:
            break;
    }
    
    
}

-(void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath*)indexPath {
    
    Reservation *reservation = [self.fetchResutlsController objectAtIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@" room: %@",reservation.room.number];
}
//
//-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    return [[self.fetchResutlsController sections] count];
//}
//
//-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    
////    NSArray *sections = [self.fetchResutlsController sections];
////    id<NSFetchedResultsSectionInfo> sectionInfo = [sections objectAtIndex:section];
//    return 4 ;
//}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    int reservations = (int) [[[self.fetchResutlsController sections] objectAtIndex:0] numberOfObjects];
    NSLog(@"num reservations %d", reservations);
    return [[self.fetchResutlsController sections] count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RESERVATIONS_CELL" forIndexPath:indexPath];
    UITableViewCell *cell = [[UITableViewCell alloc] init];
//    [self configureCell:cell atIndexPath:indexPath];
    cell.textLabel.text = @"what";
    return cell;
}
-(IBAction)addReservation:(id)sender {
    [self performSegueWithIdentifier:@"MAKE_RESERVATION_SEGUE" sender:self];
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


