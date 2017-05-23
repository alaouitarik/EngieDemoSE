//
//  CustomTextFied.m
//  EngieSE
//
//  Created by Tarik ALAOUI on 23/05/2017.
//  Copyright © 2017 Alaoui.me. All rights reserved.
//

#import "CustomTextFied.h"
#import <QuartzCore/QuartzCore.h>

@interface CustomTextFied(){
    UIImageView *leftIco;
    UIImageView *rightIco;
}

@end

@implementation CustomTextFied

-(void) drawRect:(CGRect)rect{
    
    // affichage de l'icon de gauche si elle est renseigné dans le storyboard
    if(!leftIco && _icon)
        leftIco = [[UIImageView alloc] initWithImage:_icon];
    
    if(!rightIco)
        rightIco = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Warning_Ico"]];
    
    self.leftView = leftIco;
    self.leftViewMode = UITextFieldViewModeAlways;

    self.rightView = rightIco;
    self.rightViewMode = UITextFieldViewModeNever;
}


-(void) showError:(BOOL) isError{
    self.rightViewMode = (isError) ? UITextFieldViewModeAlways : UITextFieldViewModeNever;
}
@end
