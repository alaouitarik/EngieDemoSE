//
//  AppDelegate.h
//  EngieSE
//
//  Created by Tarik ALAOUI on 22/05/2017.
//  Copyright © 2017 Alaoui.me. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

+(AppDelegate*) delegate;

-(void) logout;
-(void) switchToViewController:(NSString *) VCName;

@end

