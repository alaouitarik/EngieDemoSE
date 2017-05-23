//
//  SubcriptionViewController.m
//  EngieSE
//
//  Created by Tarik ALAOUI on 23/05/2017.
//  Copyright © 2017 Alaoui.me. All rights reserved.
//

#import "SubcriptionViewController.h"
#import "AppDelegate.h"

@interface SubcriptionViewController ()<UITextFieldDelegate>


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

-(BOOL)textFieldShouldReturn:(UITextField*)textField
{
    NSInteger nextTag=textField.tag+1;
    UIResponder* nextResponder=[textField.superview viewWithTag:nextTag];
    if (nextResponder)
        [nextResponder becomeFirstResponder];
    else{
        [textField resignFirstResponder];
        [self validateSubscription:_validateBtn];
    }
    return NO;
}

-(BOOL) isTextFieldEmpty:(CustomTextFied *) textField{
    BOOL haveError = [textField.text isEqualToString:@""];
    [textField showError:haveError];
    return haveError;
}

- (IBAction)validateSubscription:(id)sender {

    BOOL haveError =false;
    [_validateBtn setEnabled:FALSE];
    [_errorMsg setHidden:FALSE];
    
    haveError = [self isTextFieldEmpty:_lastName];
    haveError |= [self isTextFieldEmpty:_firstName];
    haveError |= [self isTextFieldEmpty:_email];
    
    // CACHER LE CLAVIER
    [self.view endEditing:TRUE];
    
    if(haveError){
        [_errorMsg setHidden:FALSE];
        [_validateBtn setEnabled:TRUE];
        [_errorMsg setText:@"Veuillez vérifier les informations que vous avez saisies."];
    }else{
        
        // Envoi de l'inscription si tout est OK
        [_errorMsg setHidden:TRUE];
        [_validateBtn setEnabled:FALSE];
        
        NSString *parameters = [NSString stringWithFormat:@"email=%@&name=%@&surname=%@",_email.text,_lastName.text,_firstName.text];
        [self CurlPost:parameters
                result:^(NSString *result, NSURLResponse *response, NSError *error) {
                    NSLog(@"%@", result);
                    long status_code = (long)[(NSHTTPURLResponse *)response statusCode];
                    if(status_code == 201 && !error){

                        dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
                            // SUCCES : sauvegarde des infos dans les sharedPreferences
                            AppDelegate *app = [AppDelegate delegate];
                            [app.standardUserDefaults setObject:result forKey:kResultSubscription];
                            [app.standardUserDefaults setBool:true forKey:kIsLoggedIn];
                            [app.standardUserDefaults synchronize];

                            dispatch_async(dispatch_get_main_queue(), ^(void){
                                    [app switchToViewController:@"Dashboard"];
                            });
                        });

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
