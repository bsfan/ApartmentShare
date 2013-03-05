//
//  ADVApartmentListViewController.h
//  apartmentshare
//
//  Created by Tope Abayomi on 22/01/2013.
//  Copyright (c) 2013 App Design Vault. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StackMob.h"

@interface ADVApartmentListViewController : UIViewController <NSFetchedResultsControllerDelegate, UITableViewDataSource, UITableViewDelegate>


@property (nonatomic, weak) IBOutlet UITableView *apartmentTableView;

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;

@property (strong, nonatomic) SMClient *client;

-(IBAction)uploadPressed:(id)sender;
-(IBAction)loginLogoutPressed:(id)sender;

@end
