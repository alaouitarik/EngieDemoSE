//
//  MenuViewController.m
//  EngieSE
//
//  Created by Tarik ALAOUI on 23/05/2017.
//  Copyright © 2017 Alaoui.me. All rights reserved.
//

#import "MenuViewController.h"
#import "AppDelegate.h"

@interface MenuViewController () <UITableViewDelegate, UITableViewDataSource>{
    NSArray *menuLbl;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) UIButton *btnLogout;
@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    menuLbl = @[@"Accueil", @"Consommation par usage", @"Historique de consommation", @"Astuces conso", @"Qualifier mon logement", @"Mon compte"];
}

-(IBAction) logout:(id) sender{
    [[AppDelegate delegate] logout];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"defaultcell"];
    [cell.textLabel setFont:[UIFont fontWithName:@"HelveticaNeue" size:13.f]];
    [cell.textLabel setText:[menuLbl objectAtIndex:indexPath.row]];
    return cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self onCloseMenuClick:_burgerBtn];
}

-(void) onCloseMenuClick:(UIButton *) sender{
    [(DashboardViewController *)_delegate slideMenuBurgerPressed:_burgerBtn];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return menuLbl.count;
}

@end
