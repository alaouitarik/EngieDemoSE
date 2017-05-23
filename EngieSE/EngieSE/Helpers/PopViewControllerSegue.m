//
//  PopViewControllerSegue.m
//  EngieSE
//
//  Created by Tarik ALAOUI on 23/05/2017.
//  Copyright © 2017 Alaoui.me. All rights reserved.
//

#import "PopViewControllerSegue.h"

@implementation PopViewControllerSegue

-(void)perform{
    UIViewController *sourceViewContreoller = [self sourceViewController];
    [sourceViewContreoller.navigationController popViewControllerAnimated:YES];
}

@end
