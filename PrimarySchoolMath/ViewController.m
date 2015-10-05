//
//  ViewController.m
//  PrimarySchoolMath
//
//  Created by caoyuxin on 10/4/15.
//  Copyright © 2015 caoyuxin. All rights reserved.
//


#import "ViewController.h"
#import "MainPageViewController.h"
#import "SeeScoreViewController.h"


@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *myIDInputField;
@property (weak, nonatomic) IBOutlet UITextField *myPasswordInputField;
@property (weak, nonatomic) IBOutlet UIButton *mySignUpButton;
@property (weak, nonatomic) IBOutlet UIButton *myLogInButton;

@property (strong, nonatomic) NSMutableDictionary *myPortmanteauDic;

@property UINavigationController *myNav;

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // init a mutable dictionary to store the studentID -> passWord
    self.myPortmanteauDic = [[[NSUserDefaults standardUserDefaults] objectForKey:@"users"] mutableCopy];
    if (self.myPortmanteauDic == nil) {
        self.myPortmanteauDic = [[NSMutableDictionary alloc] init];
    }
    [[[NSUserDefaults standardUserDefaults] objectForKey:@"currentUser"] mutableCopy];
    
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    self.myNav = [storyboard instantiateViewControllerWithIdentifier:@"myNavigationController"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)mySignUpDidPressed:(id)sender {
    // get the string from the text field
    NSString *studentID = self.myIDInputField.text;
    NSString *password = self.myPasswordInputField.text;
    [self.myPortmanteauDic setObject:password forKey:studentID];
    [[NSUserDefaults standardUserDefaults] setObject:self.myPortmanteauDic forKey:@"users"];
    NSLog(@"a new student signed up, see all student: %@", self.myPortmanteauDic);
}
- (IBAction)myLogInDidPressed:(id)sender {
    // get the string from the text field
    NSString *studentID = self.myIDInputField.text;
    NSString *password = self.myPasswordInputField.text;
    
    NSString *correct = [self.myPortmanteauDic objectForKey:studentID];
    
    if ([correct isEqualToString:password]) {
        NSLog(@"student %@ logged in", studentID);
        [[NSUserDefaults standardUserDefaults] setObject:studentID forKey:@"currentUser"];
        [self.myNav setModalPresentationStyle:UIModalPresentationFullScreen];
        [self presentModalViewController:self.myNav animated:YES];
    }
    else {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Section"
                                                            message:@"No such record, please try again or sign up!"
                                                           delegate:nil
                                                  cancelButtonTitle:@"Okay"
                                                  otherButtonTitles:nil];
        
        [alertView show];
    }
    
}

@end
