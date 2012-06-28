//
//  LoginViewController.m
//  MailFlow
//
//  Created by Admin on 6/5/12.
//  Copyright (c) 2012 Bodkin Software Inc. All rights reserved.
//

#import "LoginViewController.h"

@implementation LoginViewController

@synthesize loginButton;
@synthesize statusLbl;
@synthesize emailText, passwordText, UserAccount, PassTo, PassFrom, PassSubject, PassBody;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    EmailUtility *load = [[EmailUtility alloc] init];
    [emailText setText:[load GetEmail]];
    [passwordText setText:[load GetPassword]];
    // Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [self setEmailText:nil];
    [self setPasswordText:nil];
    [self setLoginButton:nil];
    [self setStatusLbl:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if (LoginSuccessful)
    {
        // Make sure your segue name in storyboard is the same as this line
        if ([[segue identifier] isEqualToString:@"showEmailTable"])
        {
            // Get reference to the navigation view controller
            UINavigationController *nav = [segue destinationViewController];
            // Get reference to the destination view controller
            EmailTableController *etc = (EmailTableController *)nav.topViewController;
            // Pass any objects to the view controller here, like...
            [etc setUserAccount:userAccount];
            [etc setStateID:0];
            [etc setStateLbl:@"Inbox"];
        }
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if(textField == emailText){
        [emailText resignFirstResponder];
        [passwordText becomeFirstResponder];
    } else if(textField == passwordText){
        [passwordText resignFirstResponder];
        [self login:self];
    }
    return YES;
}

- (IBAction)login:(id)sender 
{
    LoginSuccessful = NO;
    statusLbl.text = @"Logging In...";
    // Create placeholder alert
    loginAlert =  [[UIAlertView alloc] 
                   initWithTitle:@"Login" 
                   message:@"" 
                   delegate:nil 
                   cancelButtonTitle:@"OK"
                   otherButtonTitles:nil];
    
    // Validate textfields
    if (([[emailText text] length] == 0) || ([[passwordText text] length] == 0))
    {
        statusLbl.text = @"";
        [loginAlert setMessage:@"Please reinput your email and password"];
        [loginAlert show];
    } else {
        //Init account
        userAccount = [[EmailAccount alloc] init];
        //Attempt login with credentials
        @try {
            [userAccount loginToAccount:[emailText text] withPassword:[passwordText text]];
        }
        @catch (NSException *exception) {
        }
    }
    
    if([userAccount isConnected]){
        [userAccount StoreCredentials:[emailText text] Password:[passwordText text]];
        
        //Check to see if folders exist, if not create them
        [userAccount checkFolders:[userAccount allFolders]];
        
        LoginSuccessful = YES;
        
        [self performSegueWithIdentifier:@"showEmailTable" sender:self];
        
    } else {
        statusLbl.text = @"";
        [loginAlert setMessage:@"There was an issue logging in, please check your username and password."];
        [loginAlert show];
    }
    
}

- (IBAction)dismissKeyboards:(id)sender 
{
    [emailText resignFirstResponder];
    [passwordText resignFirstResponder];
}

@end