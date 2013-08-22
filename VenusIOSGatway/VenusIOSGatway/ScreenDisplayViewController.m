//
//  ViewController.m
//  VenusIOSGatway
//
//  Created by Marius Gächter on 20.08.13.
//  Copyright (c) 2013 leafit. All rights reserved.
//

#import "ScreenDisplayViewController.h"
#import "WCFService.h"

@interface ScreenDisplayViewController ()
@property (nonatomic) WCFService *wcfService;
@end

@implementation ScreenDisplayViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Screen";
        self.tabBarItem.image = [UIImage imageNamed:@"display"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	//load image
    self.wcfService = [[WCFService alloc] initWithDelegate:self];
    [self.wcfService start];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)send:(id)sender {
    self.wcfService = [[WCFService alloc] initWithDelegate:self];
    [self.wcfService start];
}



-(void)wcfService:(WCFService *)wcfService finishedSuccessfully:(NSData *)data {
    [self.image setImage:[UIImage imageWithData:data]];
}

-(void)wcfService:(WCFService *)wcfService finishedWithError:(NSError *)error {
    NSLog(@"Error");
    
}

@end
