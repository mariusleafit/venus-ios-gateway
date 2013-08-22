//
//  ViewController.m
//  VenusIOSGatway
//
//  Created by Marius Gächter on 20.08.13.
//  Copyright (c) 2013 leafit. All rights reserved.
//

#import "ScreenDisplayViewController.h"
#import "GetDDSScreenWCFService.h"
#import "AppDelegate.h"

@interface ScreenDisplayViewController ()
@property (nonatomic) GetDDSScreenWCFService *wcfService;
@property (weak, nonatomic) AppDelegate *appDelegate;
@end

@implementation ScreenDisplayViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Screen";
        self.tabBarItem.image = [UIImage imageNamed:@"display"];
        
        self.appDelegate = GetAppDelegate();
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
}

-(void)viewWillAppear:(BOOL)animated {
    //load image
    [self sendImageRequest];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)send:(id)sender {
    [self sendImageRequest];
}

-(void) sendImageRequest {
    NSString *urlString = [NSString stringWithFormat:@"https://%@/Services/GAT_ExternalUserAccess/IExternalUserAccessServices/GetDDSScreen",self.appDelegate.serviceHost];
    self.wcfService = [[GetDDSScreenWCFService alloc] initWithDelegate:self andUrl:[NSURL URLWithString:urlString]];
    [self.wcfService start];
}

-(void)wcfService:(WCFService *)wcfService finishedSuccessfully:(NSData *)data {
    [self.image setImage:[UIImage imageWithData:data]];
}

-(void)wcfService:(WCFService *)wcfService finishedWithError:(NSError *)error {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Error" message: @"Unable to load image!" delegate: nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}

@end
