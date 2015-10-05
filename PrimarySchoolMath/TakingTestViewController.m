//
//  TakingTestViewController.m
//  PrimarySchoolMath
//
//  Created by caoyuxin on 10/4/15.
//  Copyright © 2015 caoyuxin. All rights reserved.
//

#import "TakingTestViewController.h"
#import "MyTableViewController.h"



@interface TakingTestViewController ()
@property (weak, nonatomic) IBOutlet UILabel *myFirstQuestion;
@property (weak, nonatomic) IBOutlet UILabel *mySecondQuestion;
@property (weak, nonatomic) IBOutlet UILabel *myThirdQuestion;
@property (weak, nonatomic) IBOutlet UITextField *myFirstAnswer;
@property (weak, nonatomic) IBOutlet UITextField *mySecondAnswer;
@property (weak, nonatomic) IBOutlet UITextField *myThirdAnswer;
@property int firstCorrectAnswer;
@property int secondCorrectAnswer;
@property int thirdCorrectAnswer;
@property UIViewController *seeScore;
@property (weak, nonatomic) IBOutlet UILabel *myGestureDescription;

@property NSMutableArray *firstItems;
@property NSMutableArray *secondItems;
@property NSMutableArray *thirdItems;
@property MyTableViewController *myTVC;


@end

@implementation TakingTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.myGestureDescription.numberOfLines = 0;
    int max = 30;
    int min = 0;
    // Do any additional setup after loading the view.
    int randNum1 = rand() % (max - min) + min; //create the random number.
    int randNum2 = rand() % (max - min) + min; //create the random number.
    self.firstCorrectAnswer = randNum1 + randNum2;
    self.myFirstQuestion.text = [NSString stringWithFormat:@"%d + %d = ", randNum1, randNum2];
    randNum1 = rand() % (max - min) + min; //create the random number.
    randNum2 = rand() % (max - min) + min; //create the random number.
    self.secondCorrectAnswer = randNum1 - randNum2;
    self.mySecondQuestion.text = [NSString stringWithFormat:@"%d - %d = ", randNum1, randNum2];
    max = 10;
    min = 1;
    randNum1 = rand() % (max - min) + min; //create the random number.
    randNum2 = rand() % (max - min) + min; //create the random number.
    self.thirdCorrectAnswer = randNum1 * randNum2;
    self.myThirdQuestion.text = [NSString stringWithFormat:@"%d * %d = ", randNum1, randNum2];
    NSLog(@"first: %d, second: %d, third: %d",self.firstCorrectAnswer, self.secondCorrectAnswer, self.thirdCorrectAnswer);
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    self.seeScore = [storyboard instantiateViewControllerWithIdentifier:@"seeScore"];
    
    //        let pincher = UIPinchGestureRecognizer(target: self, action: "userDidPinch:")
    //
    //        self.view.addGestureRecognizer(pincher)
    
    UIPinchGestureRecognizer *pincher = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(myGestureRecognized:)];
    
    [self.view addGestureRecognizer:pincher];
    
    self.firstItems = [[NSMutableArray alloc] init];
    
    self.secondItems = [[NSMutableArray alloc] init];
    self.thirdItems = [[NSMutableArray alloc] init];
    self.myTVC = [[MyTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
    
}

- (void)myGestureRecognized:(UIGestureRecognizer*)pincher
{
    if (pincher.state == UIGestureRecognizerStateBegan) {
        //do something
        NSLog(@"PINCH!!");
        self.myFirstAnswer.placeholder = [NSString stringWithFormat:@"%d",self.firstCorrectAnswer];
        self.mySecondAnswer.placeholder = [NSString stringWithFormat:@"%d",self.secondCorrectAnswer];
        self.myThirdAnswer.placeholder = [NSString stringWithFormat:@"%d",self.thirdCorrectAnswer];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)mySubmitButtonPressed:(id)sender {
    int firstAnswer = [self.myFirstAnswer.text intValue];
    int secondAnswer = [self.mySecondAnswer.text intValue];
    int thirdAnswer = [self.myThirdAnswer.text intValue];
    if (firstAnswer == self.firstCorrectAnswer && secondAnswer == self.secondCorrectAnswer && thirdAnswer == self.thirdCorrectAnswer) {
        [self.seeScore setModalPresentationStyle:UIModalPresentationFullScreen];
        [self presentModalViewController:self.seeScore animated:YES];
    }
    else {
        NSArray *item = @[self.myFirstQuestion.text, [NSString stringWithFormat:@"%d",self.firstCorrectAnswer]];
        [self.firstItems addObject:item];
        item = @[self.mySecondQuestion.text, [NSString stringWithFormat:@"%d",self.secondCorrectAnswer]];
        [self.secondItems addObject:item];
        item = @[self.myThirdQuestion.text, [NSString stringWithFormat:@"%d",self.thirdCorrectAnswer]];
        [self.thirdItems addObject:item];
        
        [self.myTVC populateDataWithFirstArray:self.firstItems secondArray:self.secondItems thirdArray:self.thirdItems];
        
        self.myTVC.title = @"Lists";
        
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:self.myTVC];
        
        [self presentViewController:navController animated:YES completion:nil];
    }
    
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
