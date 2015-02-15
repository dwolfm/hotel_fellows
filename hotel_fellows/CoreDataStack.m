//
//  CoreDataStack.m
//  hotel_fellows
//
//  Created by drwizzard on 2/11/15.
//  Copyright (c) 2015 nacnud. All rights reserved.
//

#import "CoreDataStack.h"
#import "Hotel.h"
#include "Room.h"


@interface CoreDataStack()
@property (nonatomic) BOOL isTesting;

@end


@implementation CoreDataStack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

-(instancetype)initForTesting {
    self = [super init];
    if (self) {
        self.isTesting = true;
    }
    return self;
}

-(instancetype)init {
    self = [super init];
    [self seedDataBaseIfNeeded];
    return self;
}

-(void)seedDataBaseIfNeeded {
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Hotel"];
    NSError *fetchError;
    
    NSInteger results = [self.managedObjectContext countForFetchRequest:fetchRequest error:&fetchError];
    if (results == 0) {
        NSURL *seedUrl = [[NSBundle mainBundle] URLForResource:@"seed" withExtension:@"json"];
        NSData *seedData = [[NSData alloc] initWithContentsOfURL:seedUrl];
        NSError *jsonError;
        NSDictionary *rootDictionary = [NSJSONSerialization JSONObjectWithData:seedData options:0 error:&jsonError];
        if (!jsonError) {
            NSArray *jsonArray = rootDictionary[@"Hotels"];
            for (NSDictionary *hotelDictionary in jsonArray) {
                Hotel *hotel = [NSEntityDescription insertNewObjectForEntityForName:@"Hotel" inManagedObjectContext:self.managedObjectContext];
                hotel.name = hotelDictionary[@"name"];
                hotel.rating = hotelDictionary[@"stars"];
                hotel.location = hotelDictionary[@"location"];
                
                NSArray *roomsArray = hotelDictionary[@"rooms"];
                for (NSDictionary *roomDictionary in roomsArray) {
                    Room *room = [NSEntityDescription insertNewObjectForEntityForName:@"Room" inManagedObjectContext:self.managedObjectContext];
                    room.number = roomDictionary[@"number"];
                    room.rate = roomDictionary[@"rate"];
                    room.beds = roomDictionary[@"beds"];
                    room.hotel = hotel;
                }
                
                NSError *saveError;
                [self.managedObjectContext save:&saveError];
                
                if(saveError){
                    NSLog(@"%@",saveError.localizedDescription);
                }
            }
        }
    }
}


// the directory the app uses to store the core data store file.
-(NSURL *)applicationDocumentsDirectory{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}


// if the app doesnt no where the managed object model is its guna barf a fatal error :(
// called to init persistant store coordinator
-(NSManagedObjectModel *)managedObjectModel {
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"hotel_fellows" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    NSLog(@"this is the model url: %@", modelURL);
    return _managedObjectModel;
}



// setup the persistnant store cordinator
-(NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel: self.managedObjectModel ];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"hotel_fellows.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"there wasn an erer creatin or loadin the apps saved data";
    NSString  *storeType;
    if (self.isTesting) {
        storeType = NSInMemoryStoreType;
    } else {
        storeType = NSSQLiteStoreType;
    }
    if (![ _persistentStoreCoordinator addPersistentStoreWithType:storeType configuration:nil URL:storeURL options:nil error:&error]) {
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"failed to init the apps saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"your error domain" code:666 userInfo:dict];
        NSLog(@"Unresolved error %@: %@)", error, [error userInfo]);
        abort();
    }
    return _persistentStoreCoordinator;
}


// set up managed object context
- (NSManagedObjectContext *)managedObjectContext {
    if (_managedObjectContext != nil){
        return _managedObjectContext;
    }
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] init];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}


-(void)saveContext {
    NSManagedObjectContext *manObjContext = self.managedObjectContext;
    if (manObjContext != nil ){
        NSError *error = nil;
        if ([manObjContext hasChanges] && ![manObjContext save:&error]){
            NSLog(@"unresolved error %@: %@", error, [error userInfo]);
            abort();
        }
    }
}

@end
