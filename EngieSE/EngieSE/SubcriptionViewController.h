//
//  SubcriptionViewController.h
//  EngieSE
//
//  Created by Tarik ALAOUI on 23/05/2017.
//  Copyright © 2017 Alaoui.me. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomTextFied.h"
typedef void(^ResponseBlock)(NSString *result, NSURLResponse *response, NSError *error);

@interface SubcriptionViewController : UIViewController
@property (weak, nonatomic) IBOutlet CustomTextFied *lastName;
@property (weak, nonatomic) IBOutlet CustomTextFied *firstName;
@property (weak, nonatomic) IBOutlet CustomTextFied *email;
@property (weak, nonatomic) IBOutlet UILabel *errorMsg;
@property (weak, nonatomic) IBOutlet UIButton *validateBtn;

@end
