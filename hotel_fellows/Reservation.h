//
//  Reservation.h
//  hotel_fellows
//
//  Created by drwizzard on 2/9/15.
//  Copyright (c) 2015 nacnud. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Guest, Room;

@interface Reservation : NSManagedObject

@property (nonatomic, retain) NSDate * endDate;
@property (nonatomic, retain) NSDate * startDate;
@property (nonatomic, retain) Guest *guest;
@property (nonatomic, retain) Room *room;

@end
