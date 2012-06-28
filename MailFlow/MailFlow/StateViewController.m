//
//  StateViewController.m
//  MailFlow
//
//  Created by Admin on 6/7/12.
//  Copyright (c) 2012 Bodkin Software Inc. All rights reserved.
//

#import "StateViewController.h"

@interface StateViewController ()

@end

@implementation StateViewController

@synthesize states;
@synthesize stateID;
@synthesize UserAccount;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        
    }
    return self;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSIndexPath *path = [self.tableView indexPathForSelectedRow];
    State *s = [states objectAtIndex:[path row]]; 
    
    if ([[segue identifier] isEqualToString:@"FromState"])
    {
        UINavigationController *nav = [segue destinationViewController];
        EmailTableController *etc = (EmailTableController *)nav.topViewController;
        [etc setUserAccount:UserAccount];
        [etc setStateID:s.state_id];
        [etc setStateLbl:s.label];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    State *inbox = [[State alloc] init];
    inbox.label = @"Inbox";
    
    DBStates *sdb = [[DBStates alloc] init];
    states = [sdb getAllStates];
    [states insertObject:inbox atIndex:0];
}

- (void)viewDidUnload
{
    
    [super viewDidUnload];
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [states count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"StateCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    State *state = [states objectAtIndex:[indexPath row]];
    [[cell textLabel] setText:[state label]];
    
    cell.accessoryType = UITableViewCellAccessoryNone;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"FromState" sender:self];
}

@end
