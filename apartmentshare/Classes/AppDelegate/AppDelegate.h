//
//  AppDelegate.h
//  apartmentshare
//
//  Created by Tope on 25/01/2013.
//  Copyright (c) 2013 App Design Vault. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>


@class SMClient;
@class SMCoreDataStore;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (strong, nonatomic) SMCoreDataStore *coreDataStore;
@property (strong, nonatomic) SMClient *client;

@end
