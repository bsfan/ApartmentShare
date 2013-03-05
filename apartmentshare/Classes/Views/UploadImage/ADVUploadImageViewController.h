//
//  ADVUploadImageViewController.h
//  apartmentshare
//
//  Created by Tope Abayomi on 22/01/2013.
//  Copyright (c) 2013 App Design Vault. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface ADVUploadImageViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@property (nonatomic, weak) IBOutlet UIImageView *uploadImageView;

@property (nonatomic, weak) IBOutlet UIView *imageContainer;

@property (nonatomic, weak) IBOutlet UIButton *imageButton;

@property (nonatomic, weak) IBOutlet UITableView *dataTableView;

@property (nonatomic, strong) IBOutlet UITextField *locationTextField;

@property (nonatomic, strong) IBOutlet UITextField *priceTextField;

@property (nonatomic, strong) IBOutlet UISlider *roomsSlider;

@property (nonatomic, strong) IBOutlet UILabel *roomsLabel;

@property (nonatomic, strong) IBOutlet UISegmentedControl *apartmentTypeControl;

@property (nonatomic, strong) NSError* uploadError;

-(IBAction)selectPicturePressed:(id)sender;



@end
