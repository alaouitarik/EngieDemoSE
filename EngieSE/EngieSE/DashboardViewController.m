//
//  ViewController.m
//  EngieSE
//
//  Created by Tarik ALAOUI on 22/05/2017.
//  Copyright © 2017 Alaoui.me. All rights reserved.
//

#import "DashboardViewController.h"
#import "MenuViewController.h"
#import "AppDelegate.h"

@interface DashboardViewController ()<SlideMenuProtocolDelegate>
@property (weak, nonatomic) IBOutlet UILabel *contentTxt;

@end

@implementation DashboardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    [self addBurgerMenuButton];

    UIImageView* logoImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo_white"]];
    [logoImage setFrame:LOGO_FRAME];
    self.navigationItem.titleView = logoImage;
    
    
    [self initContentRequest];
    
}

// AJOUT DU BOUTON POUR LE DRAWER
-(void) addBurgerMenuButton{
    
    UIButton *btnBurger = [UIButton buttonWithType:UIButtonTypeSystem];
    [btnBurger setImage:[UIImage imageNamed:@"Burger"] forState:UIControlStateNormal];
    [btnBurger setFrame:CGRectMake(0, 0, 30, 21)];
    [btnBurger addTarget:self action:@selector(slideMenuBurgerPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *customBI = [[UIBarButtonItem alloc] initWithCustomView:btnBurger];
    self.navigationItem.leftBarButtonItem = customBI;
    
}

// FORMATAGE DU TEXTE DU RESULTAT DE LA REQUÊTE POST
-(void) initContentRequest{

    NSString *resultat = [[NSUserDefaults standardUserDefaults] stringForKey:kResultSubscription];
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:[resultat dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:NULL];
    
    NSMutableAttributedString *attrResultat = [[NSMutableAttributedString alloc] init];
    for(NSString *key in json){

        NSString *value = ([key isEqualToString:@"id"])? [NSString stringWithFormat:@"%d", [[json objectForKey:key] intValue]] : [json objectForKey:key];
        
        NSMutableAttributedString *entryKey = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@:", key] attributes:@{NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue-Bold" size:14], NSForegroundColorAttributeName: [UIColor blueColor]}];
        NSMutableAttributedString *entryValue = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@" %@\n", value] attributes:@{NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue" size:14], NSForegroundColorAttributeName: [UIColor darkGrayColor]}];
    
        
        [attrResultat appendAttributedString:entryKey];
        [attrResultat appendAttributedString:entryValue];
        
    }
    [_contentTxt setAttributedText:attrResultat];
    [_contentTxt sizeToFit];
}

// SLIDE DU DRAWER POUR L'AFFICHAGE DU MENU (OU LE CACHER)
-(void)slideMenuBurgerPressed:(UIButton *) sender{

    // MENU OUVERT
    if(sender.tag == 10){
        sender.tag = 0;
        UIView *backView = self.view.subviews.lastObject;
        [UIView animateWithDuration:0.4 animations:^{
            CGRect frm = backView.frame;
            frm.origin.x = -1 * [UIScreen mainScreen].bounds.size.width-80;
            backView.frame = frm;
            [backView layoutIfNeeded];
            [backView setBackgroundColor:[UIColor whiteColor]];
            
        } completion:^(BOOL finished) {
            [backView removeFromSuperview];
        }];
    }else{
        // MENU FERMÉ
        sender.tag = 10;

        MenuViewController *menuVC = [self.storyboard instantiateViewControllerWithIdentifier:@"MenuVC"];
        menuVC.burgerBtn = sender;
        menuVC.delegate = self;
        [self.view addSubview:menuVC.view];
        [self addChildViewController:menuVC];
        [menuVC.view layoutIfNeeded];

        
        menuVC.view.frame=CGRectMake(-[UIScreen mainScreen].bounds.size.width, 0, [UIScreen mainScreen].bounds.size.width-80, [UIScreen mainScreen].bounds.size.height);
        
        [UIView animateWithDuration:0.4 animations:^{
            menuVC.view.frame=CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width-80, [UIScreen mainScreen].bounds.size.height);
            
            
        } completion:^(BOOL finished) {
        }];
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
