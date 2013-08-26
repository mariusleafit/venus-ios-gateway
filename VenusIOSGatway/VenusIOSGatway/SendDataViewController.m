//
//  SendDataViewController.m
//  VenusIOSGatway
//
//  Created by Marius Gächter on 22.08.13.
//  Copyright (c) 2013 leafit. All rights reserved.
//

#import "SendDataViewController.h"
#import "SendUserDataWCFService.h"
#import "AppDelegate.h"

@interface SendDataViewController ()
@property (nonatomic) SendUserDataWCFService *wcfService;
@property (weak, nonatomic) AppDelegate *appDelegate;
@end

@implementation SendDataViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Send";
        self.tabBarItem.image = [UIImage imageNamed:@"send"];
        
        self.appDelegate = GetAppDelegate();
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    //set textFieldDelegates
    self.txtName.delegate = self;
    self.txtAddress.delegate = self;
    self.txtCity.delegate = self;
    self.txtNPA.delegate = self;
    self.txtPhone.delegate = self;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)sendData:(id)sender {
    
    NSString *urlString = [NSString stringWithFormat:@"https://%@/Services/GAT_ExternalUserAccess/IExternalUserAccessServices/SendUserData",self.appDelegate.serviceHost];
    self.wcfService = [[SendUserDataWCFService alloc] initWithDelegate:self url:[NSURL URLWithString:urlString] name:self.txtName.text address:self.txtAddress.text city:self.txtCity.text npa:self.txtNPA.text phone:self.txtPhone.text];
    [self.wcfService start];
}

#pragma mark UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    
    return YES;
}

#pragma mark WCFServiceDelegate
-(void)wcfService:(WCFService *)wcfService finishedSuccessfully:(NSData *)data {
    NSString *test = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    if(data.length > 0) {
        self.btnSend.titleLabel.textColor = [UIColor redColor];
    } else {
        self.btnSend.titleLabel.textColor = [UIColor greenColor];
    }
}

-(void)wcfService:(WCFService *)wcfService finishedWithError:(NSError *)error {
    self.btnSend.titleLabel.textColor = [UIColor redColor];
}
@end
