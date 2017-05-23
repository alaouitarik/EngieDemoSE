//
//  AppDelegate.h
//  EngieSE
//
//  Created by Tarik ALAOUI on 22/05/2017.
//  Copyright © 2017 Alaoui.me. All rights reserved.
//

#define kResultSubscription @"resultSubscription"
#define kIsLoggedIn @"isLoggedIn"
#define LOGO_FRAME CGRectMake(0, 0, 82, 30)

#import <UIKit/UIKit.h>
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) NSUserDefaults *standardUserDefaults;
@property (strong, nonatomic) UIStoryboard *storyboard;
+(AppDelegate*) delegate;

-(void) logout;
-(void) switchToViewController:(NSString *) VCName;

@end

