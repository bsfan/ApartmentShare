//
//  ADVLoginViewController.m
//  apartmentshare
//
//  Created by Tope Abayomi on 22/01/2013.
//  Copyright (c) 2013 App Design Vault. All rights reserved.
//

#import "ADVLoginViewController.h"
#import "ADVRegisterViewController.h"
#import "ADVApartmentListViewController.h"
#import "ADVTheme.h"
#import "AppDelegate.h"
#import "StackMob.h"
#import "User.h"

@implementation ADVLoginViewController

@synthesize userTextField = _userTextField, passwordTextField = _passwordTextField;
@synthesize managedObjectContext = _managedObjectContext;
@synthesize client = _client;

- (AppDelegate *)appDelegate {
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Log In";
    }
    return self;
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    id <ADVTheme> theme = [ADVThemeManager sharedTheme];
    
    
    self.title = @"Login";
    
    self.loginTableView = [[UITableView alloc] initWithFrame:CGRectMake(16, 50, 294, 110) style:UITableViewStyleGrouped];
    
    [self.loginTableView setScrollEnabled:NO];
    [self.loginTableView setBackgroundView:nil];
    [self.view addSubview:self.loginTableView];
    
    [self.loginTableView setDataSource:self];
    [self.loginTableView setDelegate:self];
    
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[theme viewBackground]]];
    
    
    [self.loginButton setBackgroundImage:[theme colorButtonBackgroundForState:UIControlStateNormal] forState:UIControlStateNormal];
    [self.loginButton setBackgroundImage:[theme colorButtonBackgroundForState:UIControlStateHighlighted] forState:UIControlStateHighlighted];
    
    
    
    self.userTextField = [[UITextField alloc] initWithFrame:CGRectMake(20, 10, 260, 50)];
    [self.userTextField setPlaceholder:@"Username"];
    [self.userTextField setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    
    
    self.passwordTextField = [[UITextField alloc] initWithFrame:CGRectMake(20, 10, 260, 50)];
    [self.passwordTextField setPlaceholder:@"Password"];
    [self.passwordTextField setSecureTextEntry:YES];
    [self.passwordTextField setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    
    self.managedObjectContext = [[self.appDelegate coreDataStore] contextForCurrentThread];
    
    self.client = [SMClient defaultClient];
    
    self.userTextField.delegate = self;
    self.passwordTextField.delegate = self;
}

-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    
    self.title = @"Log In";
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    self.userTextField = nil;
    self.passwordTextField = nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell* cell = nil;
    
    if(indexPath.row == 0){
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UsernameCell"];
        
        [cell addSubview:self.userTextField];
        
    }else {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"PasswordCell"];
        
        [cell addSubview:self.passwordTextField];
    }
    
    return cell;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark IB Actions

//Show the hidden register view
-(IBAction)signUpPressed:(id)sender
{
    [self performSegueWithIdentifier:@"signup" sender:self];
}

//Login button pressed
-(IBAction)logInPressed:(id)sender
{
    [self.client loginWithUsername:self.userTextField.text password:self.passwordTextField.text onSuccess:^(NSDictionary *results) {
        
        if ([[[self appDelegate] client] isLoggedIn]) {
            NSLog(@"Logged in");
        }
        
        [self performSegueWithIdentifier:@"list" sender:self];
        
    } onFailure:^(NSError *error) {
        //Something bad has ocurred
        NSString *errorString = [error localizedDescription];
        UIAlertView *errorAlertView = [[UIAlertView alloc] initWithTitle:@"Error" message:errorString delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [errorAlertView show];
    }];
}

@end
