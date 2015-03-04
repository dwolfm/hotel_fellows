//
//  HotelService.m
//  hotel_fellows
//
//  Created by drwizzard on 2/11/15.
//  Copyright (c) 2015 nacnud. All rights reserved.
//


//Singleton for hoasting coreDataStack

#import "HotelService.h"

@implementation HotelService

+(id)sharedService {
    static HotelService *mySharedService = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        mySharedService = [[self alloc] init];
    });
    return mySharedService;
}

-(instancetype)init {
    self = [super init];
    if (self) {
        self.coreDataStack = [[CoreDataStack alloc]init];
    }
    return self;
}

-(instancetype)initForTesting {
    self = [super init];
    if (self) {
        self.coreDataStack = [[CoreDataStack alloc] initForTesting];
    }
    return self;
}

//-(Reservation *)bookReservationForGuest:(Guest *)guest forRoom:(Room *)room startDate:(NSDate *)startDate endDate:(NSDate *)endDate {
//    Reservation *reservation = [NSEntityDescription insertNewObjectForEntityForName:@"Reservation" inManagedObjectContext:self.coreDataStack.managedObjectContext];
//    reservation.startDate = startDate;
//    reservation.endDate = endDate;
//    reservation.room = room;
//    reservation.guest = guest;
//    
//    
//    NSError *saveError;
//    [self.coreDataStack.managedObjectContext save:&saveError];
//    if (!saveError){
//        return reservation;
//    } else {
//        return nil;
//    }
//    
//
//}

-(Reservation *)bookReservationForGuest:(Guest *)guest forRoom:(Room *)room startDate:(NSDate *)startDate endDate:(NSDate *)endDate {
    Reservation *reservation = [NSEntityDescription insertNewObjectForEntityForName:@"Reservation" inManagedObjectContext:self.coreDataStack.managedObjectContext];
    reservation.startDate = startDate;
    reservation.endDate = endDate;
    reservation.room = room;
    reservation.guest = guest;
    
    
    NSError *saveError;
    [self.coreDataStack.managedObjectContext save:&saveError];
    if (!saveError) {
        return reservation;
    } else {
        return nil;
    }
}





@end
