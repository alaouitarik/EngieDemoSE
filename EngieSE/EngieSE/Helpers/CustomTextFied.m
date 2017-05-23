//
//  CustomTextFied.m
//  EngieSE
//
//  Created by Tarik ALAOUI on 23/05/2017.
//  Copyright © 2017 Alaoui.me. All rights reserved.
//

#import "CustomTextFied.h"

@interface CustomTextFied(){
    UIImageView *leftIco;
    UIImageView *rightIco;
}

@end

@implementation CustomTextFied

-(void) prepareForInterfaceBuilder{
    [self setupTextField];
}

-(void) setupTextField{
    
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

-(void) awakeFromNib{
    [super awakeFromNib];
    [self setupTextField];
}

-(void) showError:(BOOL) isError{
    self.rightViewMode = (isError) ? UITextFieldViewModeAlways : UITextFieldViewModeNever;
}
@end
