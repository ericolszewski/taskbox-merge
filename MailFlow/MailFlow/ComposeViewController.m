//
//  ComposeViewController.m
//  MailFlow
//
//  Created by Adam Cianfichi on 6/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ComposeViewController.h"

@interface ComposeViewController ()

@end

@implementation ComposeViewController

@synthesize txtTo;
@synthesize txtSubject;
@synthesize addContact;
@synthesize btnCal;
@synthesize btnAssign;
@synthesize btnPriority;
@synthesize btnTag;
@synthesize txtBody;
@synthesize UserAccount;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) { 
        [self setTitle:@"Compose"];
        [self.navigationController setToolbarHidden:NO animated:YES];
    }
    return self;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"FromCompose"]){
        UINavigationController *nav = [segue destinationViewController];
        EmailTableController *etc = (EmailTableController *)nav.topViewController;
        [etc setTitle:@"Inbox"];
        [etc setUserAccount:UserAccount];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [self setAddContact:nil];
    [self setBtnCal:nil];
    [self setBtnAssign:nil];
    [self setBtnPriority:nil];
    [self setBtnTag:nil];
    [self setTxtBody:nil];
    [self setTxtTo:nil];
    [self setTxtSubject:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView{
    [textView resignFirstResponder];
    return YES;
}

- (IBAction)dismissKeyboards:(id)sender {
    [txtTo resignFirstResponder];
    [txtSubject resignFirstResponder];
    [txtBody resignFirstResponder];
}

- (IBAction)sendMsg:(id)sender {
    EmailUtility *login = [[EmailUtility alloc] init];

    NSString *emailkey = [login GetEmail];
    NSString *passwordkey = [login GetPassword];
    
    [login sendMessage:txtTo.text:txtSubject.text:txtBody.text:passwordkey:emailkey];

    [self performSegueWithIdentifier:@"FromCompose" sender:self];

}

- (IBAction)cancelCompose:(id)sender {
    
}
@end
