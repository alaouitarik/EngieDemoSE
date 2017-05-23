//
//  CustomTextFied.h
//  EngieSE
//
//  Created by Tarik ALAOUI on 23/05/2017.
//  Copyright © 2017 Alaoui.me. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE
@interface CustomTextFied : UITextField

@property (nonatomic) IBInspectable UIImage *icon;

-(void) showError:(BOOL) isError;

@end
