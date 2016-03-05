//
//  ViewController.m
//  SearchAcronym
//
//  Created by Chaitanya Kumar on 3/4/16.
//  Copyright © 2016 Chaitanya Kumar. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) Acronym *acronym;
@property (nonatomic, strong) NSCharacterSet *disallowedCharacters;;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.acronymTableView.delegate = self;
    self.acronymTableView.dataSource = self;
    self.acronymTF.delegate = self;
    self.searchBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [_searchBtn addRoundedCorners:UIRectCornerTopRight | UIRectCornerBottomRight
                                                    withRadii:CGSizeMake(10.0f, 10.0f)];
    self.acronymBgView.layer.cornerRadius = 10;
    [self.acronymTF becomeFirstResponder];
}

- (IBAction) searchAcronym:(id)sender {
    if (![_acronymTF.text isEqualToString:@""]) {
        [self.acronymTF resignFirstResponder];
        [self searchForAcronym:_acronymTF.text];
     }
}

 -(void) searchForAcronym: (NSString*) str {
     NSDictionary *parameters = @{@"sf": str};
     
     [[NetworkClient sharedInstance] getResponseForURLString:URL Parameters:parameters
                            success:^(NSURLSessionDataTask *task, Acronym *acronym) {
                                
                                [MBProgressHUD hideHUDForView:self.view animated:YES];
                                self.acronym = acronym;
                                if (self.acronym && self.acronym.meanings.count > 0) {
                                    [self.acronymTableView setHidden:NO];
                                    [self.acronymTableView setContentOffset:CGPointZero animated:NO];
                                    [self.acronymTableView reloadData];
                                }
                                else{
                                    [self.acronymTableView setHidden:YES];
                                    if (![self.acronymTF.text isEqualToString:@""]) {
                                        self.noResultsLbl.text = [NSString stringWithFormat:@"No results found for the acronym %@", self.acronymTF.text];
                                    } else {
                                        self.noResultsLbl.text = @"";
                                    }
                                }
                                
                            }
                            failure:^(NSURLSessionDataTask *task, NSError *error) {
                                [MBProgressHUD hideHUDForView:self.view animated:YES];
                                [self.acronymTableView setHidden:YES];
                                self.noResultsLbl.text = [NSString stringWithFormat:@"There's is an error in searching for the acronym. \nError: %@", error.localizedDescription];
                                
                            }];
 }

#pragma mark- UITableView Datasource methods
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.acronym.meanings.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *reuseIdentifier = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    Meaning *meaning = [self.acronym.meanings objectAtIndex:indexPath.row];
    cell.textLabel.text = meaning.meaning;
    
    return cell;
}

#pragma mark - UITextField Delegate methods

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        dispatch_async(dispatch_get_main_queue(), ^(){
            if (self.acronymTF.text.length != 0) {
                NSString * searchStr = [textField.text stringByReplacingCharactersInRange:range withString:string];
                [self searchForAcronym:searchStr];
            }
                
            [self.acronymTableView reloadData];
        });
    });
    return YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    [self searchForAcronym:self.acronymTF.text];
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
