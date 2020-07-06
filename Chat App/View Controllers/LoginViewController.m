//
//  LoginViewController.m
//  Chat App
//
//  Created by Ogo-Oluwasobomi Popoola on 7/6/20.
//  Copyright © 2020 Ogo-Oluwasobomi Popoola. All rights reserved.
//

#import "LoginViewController.h"
#import <Parse/Parse.h>

@interface LoginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void) invalidDetailAlert{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle: @"Details Required"
           message: @"Please fill in the appropriate fields"
    preferredStyle:(UIAlertControllerStyleAlert)];
    
    UIAlertAction *okAlert = [UIAlertAction actionWithTitle:@"Ok"
                                                           style: UIAlertActionStyleDefault
                                                           handler:^(UIAlertAction * _Nonnull action) {}];
    
    [alert addAction: okAlert];
    [self presentViewController: alert animated:YES completion:^{}];
}

- (void) signUpError{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle: @"SignUp Error"
           message: @"Unsucessful SignUp"
    preferredStyle:(UIAlertControllerStyleAlert)];
    
    UIAlertAction *okAlert = [UIAlertAction actionWithTitle:@"Ok"
                                                           style: UIAlertActionStyleDefault
                                                           handler:^(UIAlertAction * _Nonnull action) {}];
    
    [alert addAction: okAlert];
    [self presentViewController: alert animated:YES completion:^{}];
}

- (void)registerUser {
    if ([self.usernameField.text isEqual:@""] || [self.passwordField.text isEqual:@""]){
        [self invalidDetailAlert];
    }
    else{
        PFUser *newUser = [PFUser user];

        newUser.username = self.usernameField.text;
        newUser.password = self.passwordField.text;
        
        [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * error) {
            if (error != nil) {
                NSLog(@"Error: %@", error.localizedDescription);
                [self signUpError];
            } else {
                NSLog(@"User registered successfully");
                [self performSegueWithIdentifier: @"loginSegue" sender: nil];
            }
        }];
    }
}

- (IBAction)signUpButton:(id)sender {
    [self registerUser];
}

- (void) wrongUserAlert{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle: @"Invalid Details"
           message:@"Could not find User"
    preferredStyle:(UIAlertControllerStyleAlert)];
    
    UIAlertAction *okAlert = [UIAlertAction actionWithTitle:@"Ok"
                                                           style: UIAlertActionStyleDefault
                                                           handler:^(UIAlertAction * _Nonnull action) {}];
    
    [alert addAction: okAlert];
    [self presentViewController: alert animated:YES completion:^{}];
}

- (void)loginUser {
    if ([self.usernameField.text isEqual:@""] || [self.passwordField.text isEqual:@""]){
        [self invalidDetailAlert];
    }
    else{
        NSString *username = self.usernameField.text;
        NSString *password = self.passwordField.text;
        
        [PFUser logInWithUsernameInBackground:username password:password block:^(PFUser * user, NSError *  error) {
            if (error != nil) {
                NSLog(@"User log in failed: %@", error.localizedDescription);
                [self wrongUserAlert];
            } else {
                NSLog(@"User logged in successfully");
                [self performSegueWithIdentifier: @"loginSegue" sender: nil];
            }
        }];
    }
}

- (IBAction)loginButton:(id)sender {
    [self loginUser];
}

- (IBAction)onTap:(id)sender {
    [self.view endEditing:YES];
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
