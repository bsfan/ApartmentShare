//
//  ADVDetailViewController.m
//  apartmentshare
//
//  Created by Tope on 30/01/2013.
//  Copyright (c) 2013 App Design Vault. All rights reserved.
//

#import "ADVDetailViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "ADVTheme.h"

@interface ADVDetailViewController ()

@end

@implementation ADVDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = [self.apartment valueForKey:@"location"];
    
    CAGradientLayer *l = [CAGradientLayer layer];
    l.frame = self.shadowView.bounds;
    UIColor* startColor = [UIColor colorWithWhite:0.0 alpha:0.0];
    UIColor* endColor = [UIColor colorWithWhite:0.0 alpha:0.5];
    l.colors = [NSArray arrayWithObjects:(id)startColor.CGColor, (id)endColor.CGColor, nil];
    [self.shadowView.layer addSublayer:l];
    
    id <ADVTheme> theme = [ADVThemeManager sharedTheme];
    
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[theme viewBackground]]];
    
    [self.contactButton setBackgroundImage:[theme colorButtonBackgroundForState:UIControlStateNormal] forState:UIControlStateNormal];
    [self.contactButton setBackgroundImage:[theme colorButtonBackgroundForState:UIControlStateHighlighted] forState:UIControlStateHighlighted];
    
    CGRect frame = self.moreDetailsTextView.frame;
    frame.size.height = self.moreDetailsTextView.contentSize.height;
    self.moreDetailsTextView.frame = frame;
    
    CGRect moreViewFrame =  self.moreDetailsView.frame;
    moreViewFrame.size.height = frame.size.height + 40;
    self.moreDetailsView.frame = moreViewFrame;
    
    int scrollViewHeight =  moreViewFrame.size.height + 299;
    self.scrollView.contentSize = CGSizeMake(320, scrollViewHeight);
    
    CAGradientLayer *topShadow = [CAGradientLayer layer];
    topShadow.frame = CGRectMake(0, -3, 320, 3);
    UIColor* startColor2 = [UIColor colorWithWhite:0.0 alpha:0.0];
    UIColor* endColor2 = [UIColor colorWithWhite:0.0 alpha:0.3];
    topShadow.colors = [NSArray arrayWithObjects:(id)startColor2.CGColor, (id)endColor2.CGColor, nil];
    [self.moreDetailsView.layer addSublayer:topShadow];
    
    CAGradientLayer *bottomShadow = [CAGradientLayer layer];
    bottomShadow.frame = CGRectMake(0, self.moreDetailsView.frame.origin.y + self.moreDetailsView.frame.size.height, 320, 3);
    bottomShadow.colors = [NSArray arrayWithObjects:(id)startColor2.CGColor, (id)endColor2.CGColor, nil];
    [self.moreDetailsView.layer addSublayer:bottomShadow];
    
    
    NSNumber* roomCount = [self.apartment valueForKey:@"roomCount"];
    NSString* roomCountText = [NSString stringWithFormat:@"%d Bed", [roomCount intValue]];
    
    NSNumber* price = [self.apartment valueForKey:@"price"];
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setNumberStyle: NSNumberFormatterCurrencyStyle];
    NSString *priceString = [numberFormatter stringFromNumber:price];
    
    [self.addressLabel setText:[self.apartment valueForKey:@"location"]];
    [self.priceLabel setText:priceString];
    [self.roomsLabel setText:roomCountText];
    [self.apartmentTypeLabel setText:[self.apartment valueForKey:@"apartmentType"]];
    
    if (self.apartmentImage){
        [self.apartmentImageView setImage:self.apartmentImage];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
