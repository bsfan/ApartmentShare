//
//  User.m
//  apartmentshare
//
//  Created by Tope Abayomi on 22/02/2013.
//  Copyright (c) 2013 App Design Vault. All rights reserved.
//

#import "User.h"

@implementation User

@dynamic username;

- (id)initIntoManagedObjectContext:(NSManagedObjectContext *)context {
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"User" inManagedObjectContext:context];
    self = [super initWithEntity:entity insertIntoManagedObjectContext:context];
    
    if (self) {
        // assign local variables and do other init stuff here
    }
    
    return self;
}

@end

