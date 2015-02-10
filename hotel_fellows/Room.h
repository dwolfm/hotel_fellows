//
//  Room.h
//  hotel_fellows
//
//  Created by drwizzard on 2/9/15.
//  Copyright (c) 2015 nacnud. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Room : NSManagedObject

@property (nonatomic, retain) NSNumber * beds;
@property (nonatomic, retain) NSNumber * number;
@property (nonatomic, retain) NSNumber * rate;
@property (nonatomic, retain) NSManagedObject *hotel;
@property (nonatomic, retain) NSSet *reservations;
@end

@interface Room (CoreDataGeneratedAccessors)

- (void)addReservationsObject:(NSManagedObject *)value;
- (void)removeReservationsObject:(NSManagedObject *)value;
- (void)addReservations:(NSSet *)values;
- (void)removeReservations:(NSSet *)values;

@end
