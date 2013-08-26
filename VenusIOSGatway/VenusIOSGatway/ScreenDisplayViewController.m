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
@property (nonatomic) NSTimer *reloadTimer;

@property int failedScreenLoadingAttempts;
@end

@implementation ScreenDisplayViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Screen";
        self.tabBarItem.image = [UIImage imageNamed:@"display"];
        
        self.failedScreenLoadingAttempts = 0;
        
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
    self.reloadTimer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(reloadScreen:) userInfo:nil repeats:YES];
}

-(void)viewDidDisappear:(BOOL)animated {
    [self.reloadTimer invalidate];
    self.reloadTimer = nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)send:(id)sender {
    [self sendImageRequest];
}

-(void)reloadScreen:(NSTimer *)theTimer {
    if(self.failedScreenLoadingAttempts <= 2) {
        [self sendImageRequest];
    }
}

-(void) sendImageRequest {
    NSString *urlString = [NSString stringWithFormat:@"https://%@/Services/GAT_ExternalUserAccess/IExternalUserAccessServices/GetDDSScreen/%@",self.appDelegate.serviceHost,self.appDelegate.ddsScreenHost];
    self.wcfService = [[GetDDSScreenWCFService alloc] initWithDelegate:self andUrl:[NSURL URLWithString:urlString]];
    [self.wcfService start];
}

-(void)wcfService:(WCFService *)wcfService finishedSuccessfully:(NSData *)data {
    if(data.length > 0) {
        [self.image setImage:[UIImage imageWithData:data]];
        self.failedScreenLoadingAttempts = 0;
    } else {
        self.failedScreenLoadingAttempts++;
    }
}

-(void)wcfService:(WCFService *)wcfService finishedWithError:(NSError *)error {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Error" message: @"Unable to load image!" delegate: nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
    self.failedScreenLoadingAttempts++;
}

@end
