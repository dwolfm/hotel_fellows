//
//  HotelService.h
//  hotel_fellows
//
//  Created by drwizzard on 2/11/15.
//  Copyright (c) 2015 nacnud. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CoreDataStack.h"
#import "Reservation.h"
#import "Room.h"
#import "Guest.h"
#import "Hotel.h"

@interface HotelService : NSObject

@property (strong, nonatomic) CoreDataStack *coreDataStack;

+(id)sharedService;
-(instancetype)initForTesting;
-(instancetype)init;

-(Reservation *)bookReservationForGuest:(Guest *)guest forRoom:(Room *)room startDate:(NSDate *)startDate endDate:(NSDate *)endDate;


@end
