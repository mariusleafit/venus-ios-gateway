//
//  SendDataViewController.h
//  VenusIOSGatway
//
//  Created by Marius Gächter on 22.08.13.
//  Copyright (c) 2013 leafit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WCFServiceDelegate.h"  

@interface SendDataViewController : UIViewController <WCFServiceDelegate, UITextFieldDelegate>
- (IBAction)sendData:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *txtName;
@property (weak, nonatomic) IBOutlet UITextField *txtAddress;
@property (weak, nonatomic) IBOutlet UITextField *txtCity;
@property (weak, nonatomic) IBOutlet UITextField *txtNPA;
@property (weak, nonatomic) IBOutlet UITextField *txtPhone;
@property (weak, nonatomic) IBOutlet UIButton *btnSend;

@end
