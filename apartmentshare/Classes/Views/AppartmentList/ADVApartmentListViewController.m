//
//  ADVApartmentListViewController.m
//  apartmentshare
//
//  Created by Tope Abayomi on 22/01/2013.
//  Copyright (c) 2013 App Design Vault. All rights reserved.
//


#import "ADVApartmentListViewController.h"
#import "ADVUploadImageViewController.h"
#import "ADVLoginViewController.h"
#import "ADVDetailViewController.h"
#import "ApartmentCell.h"
#import "AppDelegate.h"
#import "Apartment.h"
#import "FTWCache.h"
#import "ADVTheme.h"
#import "NSString+MD5.h"
#import "MBProgressHUD.h"

@interface ADVApartmentListViewController () {

}

@property (nonatomic, retain) NSArray *apartments;
@property (nonatomic, retain) NSMutableDictionary *apartmentImages;
@property (nonatomic, retain) UIActivityIndicatorView *activityIndicator;


-(void)getAllApartments;
-(void)showErrorView:errorString;

@end

@implementation ADVApartmentListViewController


- (AppDelegate *)appDelegate {
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Apartments";

    id <ADVTheme> theme = [ADVThemeManager sharedTheme];
    
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[theme viewBackground]]];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:[self getLogText] style:UIBarButtonItemStylePlain target:self action:@selector(loginLogoutPressed:)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Upload" style:UIBarButtonItemStylePlain target:self action:@selector(uploadPressed:)];
    
    self.managedObjectContext = [[self.appDelegate coreDataStore] contextForCurrentThread];

    [self.apartmentTableView setDelegate:self];
    [self.apartmentTableView setDataSource:self];
    
    self.apartmentImages = [NSMutableDictionary dictionary];
    
    self.client = [SMClient defaultClient];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationItem.leftBarButtonItem.title = [self getLogText];
    
    [self getAllApartments];
        
    NSLog(@"got all apartments");
   
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.apartments count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ApartmentCell* cell = [tableView dequeueReusableCellWithIdentifier:@"ApartmentCell" forIndexPath:indexPath];
    
    Apartment *apartment = [self.apartments objectAtIndex:indexPath.row];
    
    NSNumber* roomCount = [apartment valueForKey:@"roomCount"];
    NSString* roomCountText = [NSString stringWithFormat:@"%d Bed", [roomCount intValue]];
    
    NSNumber* price = [apartment valueForKey:@"price"];
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setNumberStyle: NSNumberFormatterCurrencyStyle];
    NSString *priceString = [numberFormatter stringFromNumber:price];
    
    [cell.locationLabel setText:[apartment valueForKey:@"location"]];
    [cell.priceLabel setText:priceString];
    [cell.roomsLabel setText:roomCountText];
    [cell.apartmentTypeLabel setText:[apartment valueForKey:@"apartmentType"]];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    
    NSURL* imageURL = [NSURL URLWithString:[apartment valueForKey:@"photo"]];
    
    NSString *key = [imageURL.absoluteString MD5Hash];
    NSData *data = [FTWCache objectForKey:key];
    if (data) {
        UIImage *image = [UIImage imageWithData:data];
        cell.apartmentImageView.image = image;
        
        [self.apartmentImages setObject:image forKey:indexPath];
        
    } else {
        //cell.apartmentImageView.image = [UIImage imageNamed:@"icn_default"];
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
        dispatch_async(queue, ^{
            NSData *data = [NSData dataWithContentsOfURL:imageURL];
            [FTWCache setObject:data forKey:key];
            UIImage *image = [UIImage imageWithData:data];
            dispatch_async(dispatch_get_main_queue(), ^{
                
                ApartmentCell* c = (ApartmentCell*)[tableView cellForRowAtIndexPath:indexPath];
                c.apartmentImageView.image =image;
                
                [self.apartmentImages setObject:image forKey:indexPath];
            });
        });
    }

    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 260;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self performSegueWithIdentifier:@"detail" sender:self];
}

#pragma mark Receive Wall Objects


-(void)getAllApartments
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = @"Loading...";
    
    NSFetchRequest *fetch = [[NSFetchRequest alloc] initWithEntityName:@"Apartment"];
    [self.managedObjectContext executeFetchRequest:fetch onSuccess:^(NSArray *results) {
        
        self.apartments = results;
        [self.apartmentTableView reloadData];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    } onFailure:^(NSError *error) {
        
        // ALERT
        NSString *errorString = [error localizedDescription];
        UIAlertView *errorAlertView = [[UIAlertView alloc] initWithTitle:@"Error" message:errorString delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [errorAlertView show];
    }];
}

#pragma mark IB Actions
-(IBAction)uploadPressed:(id)sender
{
    if([[[self appDelegate] client] isLoggedIn]){
        
        [self performSegueWithIdentifier:@"upload" sender:self];
    }
    else{
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Please Log In" message:@"You need to be logged in to upload details" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        [alert show];
    }

}


-(IBAction)loginLogoutPressed:(id)sender
{
    if([[[self appDelegate] client] isLoggedIn]){
    
        [self.client logoutOnSuccess:^(NSDictionary *result) {
            NSLog(@"Success, you are logged out");
            if ([[[self appDelegate] client] isLoggedOut]) {
                NSLog(@"Logged Out");
            }
            
            self.navigationItem.leftBarButtonItem.title = [self getLogText];
            [self.navigationController popViewControllerAnimated:YES];
            
        } onFailure:^(NSError *error) {
            NSLog(@"Logout Fail: %@",error);
        }];
    }
    else{
        
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}

-(NSString*)getLogText{
    
    NSString* logText = [[[self appDelegate] client] isLoggedIn] ? @"Log Out" : @"Log In";
    
    return logText;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if([segue.identifier isEqualToString:@"detail"]){
 
        ADVDetailViewController* detail = (ADVDetailViewController*)segue.destinationViewController;
        
        NSIndexPath* indexPath = [self.apartmentTableView indexPathForSelectedRow];
        Apartment *apartment = [self.apartments objectAtIndex:indexPath.row];
        
        detail.apartment = apartment;
        
        if([self.apartmentImages objectForKey:indexPath]){
            
            detail.apartmentImage = [self.apartmentImages objectForKey:indexPath];
        }

    }
}

#pragma mark Error Alert

-(void)showErrorView:(NSString *)errorMsg{
    
    UIAlertView *errorAlertView = [[UIAlertView alloc] initWithTitle:@"Error" message:errorMsg delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    [errorAlertView show];
}


@end
