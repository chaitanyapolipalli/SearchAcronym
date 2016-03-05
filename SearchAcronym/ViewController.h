//
//  ViewController.h
//  SearchAcronym
//
//  Created by Chaitanya Kumar on 3/4/16.
//  Copyright © 2016 Chaitanya Kumar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AFNetworking/AFNetworking.h>
#import "AFHTTPSessionManager.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import "UIView+RoundCorners.h"
#import "NetworkClient.h"
#import "Meaning.h"
#import "Acronym.h"

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *acronymTF;
@property (weak, nonatomic) IBOutlet UIButton *searchBtn;
@property (weak, nonatomic) IBOutlet UITableView *acronymTableView;
@property (weak, nonatomic) IBOutlet UIView *noResultsBgView;
@property (weak, nonatomic) IBOutlet UILabel *noResultsLbl;

@property (weak, nonatomic) IBOutlet UIView *acronymBgView;

- (IBAction)searchAcronym:(id)sender;

@end

