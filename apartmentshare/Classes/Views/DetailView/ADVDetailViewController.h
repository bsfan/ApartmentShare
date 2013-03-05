//
//  ADVDetailViewController.h
//  apartmentshare
//
//  Created by Tope on 30/01/2013.
//  Copyright (c) 2013 App Design Vault. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Apartment.h"

@interface ADVDetailViewController : UIViewController

@property (nonatomic, weak) IBOutlet UILabel* addressLabel;

@property (nonatomic, weak) IBOutlet UIImageView* apartmentImageView;

@property (nonatomic, strong) IBOutlet UIView* shadowView;

@property (nonatomic, weak) IBOutlet UIButton* contactButton;

@property (nonatomic, weak) IBOutlet UIView* moreDetailsView;

@property (nonatomic, weak) IBOutlet UITextView* moreDetailsTextView;

@property (nonatomic, strong) IBOutlet UIScrollView* scrollView;

@property (nonatomic, weak) IBOutlet UILabel* priceLabel;

@property (nonatomic, weak) IBOutlet UILabel* roomsLabel;

@property (nonatomic, weak) IBOutlet UILabel* apartmentTypeLabel;

@property (nonatomic, strong) Apartment* apartment;

@property (nonatomic, strong) UIImage* apartmentImage;

@end
