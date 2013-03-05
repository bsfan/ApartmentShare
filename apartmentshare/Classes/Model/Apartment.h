//
//  Apartment.h
//  apartmentshare
//
//  Created by Matt Vaznaian on 3/4/13.
//  Copyright (c) 2013 App Design Vault. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Apartment : NSManagedObject

@property (nonatomic, retain) NSString * apartmentId;
@property (nonatomic, retain) NSString * apartmentType;
@property (nonatomic, retain) NSNumber * createddate;
@property (nonatomic, retain) NSString * location;
@property (nonatomic, retain) NSString * photo;
@property (nonatomic, retain) NSNumber * price;
@property (nonatomic, retain) NSNumber * roomCount;
@property (nonatomic, retain) NSString * sm_owner;

@end
