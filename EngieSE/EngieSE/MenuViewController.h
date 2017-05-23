//
//  MenuViewController.h
//  EngieSE
//
//  Created by Tarik ALAOUI on 23/05/2017.
//  Copyright © 2017 Alaoui.me. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DashboardViewController.h"

@interface MenuViewController : UIViewController

@property (nonatomic, assign) DashboardViewController* delegate;
@property (nonatomic, assign) UIButton *burgerBtn;

@end


@protocol SlideMenuProtocolDelegate <NSObject>
@end
