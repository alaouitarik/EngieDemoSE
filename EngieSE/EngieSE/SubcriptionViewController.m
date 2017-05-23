//
//  SubcriptionViewController.m
//  EngieSE
//
//  Created by Tarik ALAOUI on 23/05/2017.
//  Copyright © 2017 Alaoui.me. All rights reserved.
//

#import "SubcriptionViewController.h"

@interface SubcriptionViewController ()

@end

@implementation SubcriptionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)validateSubscription:(id)sender {

    BOOL haveError =false;
    [_validateBtn setEnabled:FALSE];
    [_errorMsg setHidden:FALSE];
    
    if([_lastName.text isEqualToString:@""]){
        haveError = true;
        [_lastName showError:TRUE];
    }else{
        [_lastName showError:FALSE];
    }
    if([_firstName.text isEqualToString:@""]){
        haveError = true;
        [_firstName showError:TRUE];
    }else{
        [_firstName showError:FALSE];
    }
    if([_email.text isEqualToString:@""]){
        haveError = true;
        [_email showError:TRUE];
    }else{
        [_email showError:FALSE];
    }
    
    if(haveError){
        [_errorMsg setHidden:FALSE];
        [_validateBtn setEnabled:TRUE];
        [_errorMsg setText:@"Veuillez vérifier les informations que vous avez saisies."];
    }else{
        // Envoi de l'inscription
        [_errorMsg setHidden:TRUE];
        [_validateBtn setEnabled:FALSE];
        
        NSString *parameters = [NSString stringWithFormat:@"email=%@&name=%@&surname=%@",_email.text,_lastName.text,_firstName.text];
        [self CurlPost:parameters
                result:^(NSString *result, NSURLResponse *response, NSError *error) {
                    NSLog(@"%@", result);
                    long status_code = (long)[(NSHTTPURLResponse *)response statusCode];
                    if(status_code == 201 && !error){
                        // SUCCES
                        [[NSUserDefaults standardUserDefaults] setObject:result forKey:@"resultSubscription"];
                        [[NSUserDefaults standardUserDefaults] synchronize];
                    }else{
                        [_errorMsg setHidden:FALSE];
                        [_errorMsg setText:@"Une erreur est survenue.\nVeuillez vérifier les données de votre formulaire ou votre connexion à internet."];
                        [_validateBtn setEnabled:TRUE];

                    }
        }];
        
    }
}


-(void) CurlPost:(NSString *) parameters result:(ResponseBlock) blockResult{
    
    NSData *PostData = [parameters dataUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:@"http://jsonplaceholder.typicode.com/users"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:PostData];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];

    NSURLSession *session = [NSURLSession sharedSession];
    [[session dataTaskWithRequest:request
            completionHandler:^(NSData *data,
                                NSURLResponse *response,
                                NSError *error) {
               
                                if(!error && data){
                                    NSString *resultat = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                                    blockResult(resultat, response, error);
                                }else{
                                    blockResult(nil, response, error);
                                }
            }] resume];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
