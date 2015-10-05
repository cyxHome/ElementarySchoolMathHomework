//
//  MainPageViewController.m
//  PrimarySchoolMath
//
//  Created by caoyuxin on 10/4/15.
//  Copyright © 2015 caoyuxin. All rights reserved.
//

#import "MainPageViewController.h"

@interface MainPageViewController ()
@property (weak, nonatomic) IBOutlet UILabel *myMainPageTitle;
@property NSString *currentUser;

@end

@implementation MainPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.myMainPageTitle.numberOfLines=0;
    self.currentUser = [[[NSUserDefaults standardUserDefaults] objectForKey:@"currentUser"] mutableCopy];

    self.myMainPageTitle.text = [NSString stringWithFormat:@"Welcome, Dear %@!",self.currentUser];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void) populateUserID: (NSString *) userID {
    self.currentUser = userID;
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
