//
//  EmailTableController.m
//  MailFlow
//
//  Created by Admin on 6/5/12.
//  Copyright (c) 2012 Bodkin Software Inc. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "EmailTableController.h"

#define REFRESH_HEADER_HEIGHT 60.0f

@implementation EmailTableController

@synthesize progInd;
@synthesize emails;
@synthesize swipedCell = _swipedCell;
@synthesize UserAccount;
@synthesize currentEmail;
@synthesize stateID;
@synthesize stateLbl;
@synthesize stateButton;

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Segue to Detail View
    if([segue.identifier isEqualToString:@"showDetail"]){
        DetailViewController *dvc = [segue destinationViewController]; 
        NSIndexPath *path = [self.tableView indexPathForSelectedRow];
        Email *e = [emails objectAtIndex:[path row]]; 
        [dvc setCurrentEmail:e];
    }
    // Segue to Compose View
    if ([[segue identifier] isEqualToString:@"Compose"]){
        ComposeViewController *cvc = [segue destinationViewController]; 
        [cvc setUserAccount:UserAccount];
    }
    // Segue to State View
    if([segue.identifier isEqualToString:@"ToState"]){
        StateViewController *svc = [segue destinationViewController]; 
        [svc setUserAccount:UserAccount];
    }
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setTitle:stateLbl];
    
    SyncRunner *sr = [SyncRunner getRunner];
    [sr registerTableView:self];
    
    [self setupToolbar];
    [self.tableView setSeparatorColor:[UIColor colorWithRed:0.93f green:0.93f blue:0.93f alpha:1.0f]];
    
    [self syncEmails];
    [self populateMessages];
}

- (void)syncEmails
{
    SyncRunner *sr = [SyncRunner getRunner];
    [sr run:UserAccount];
}

- (void)populateMessages
{    
	[NSThread setThreadPriority:1.0];
    
    self.emails = [[NSMutableArray alloc] init];
    DBEmails *db = [[DBEmails alloc] init];
    self.emails = [db getEmailsForState:stateID];
    
    [self.tableView reloadData];
    [self stopLoading];
}

- (void)refresh
{
    SyncRunner *sr = [SyncRunner getRunner];
    if (sr.syncRunning == NO){
        [sr run:UserAccount];
        [self performSelector:@selector(populateMessages) withObject:nil afterDelay:0];
    } else {
        [self populateMessages]; 
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (void)setupToolbar
{
    UIBarButtonItem *feedbackBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_feedback"] style:UIBarButtonItemStylePlain target:self action:@selector(sendFeedback)];
    progInd = [[ProgressIndicator alloc] initWithFrame:CGRectMake(0, 0, 230, 24)];
    UIBarButtonItem *progBtn = [[UIBarButtonItem alloc] initWithCustomView:progInd];
    UIBarButtonItem *composeBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCompose target:self action:@selector(composeMsg)];
    
    self.toolbarItems = [NSArray arrayWithObjects:feedbackBtn, progBtn, composeBtn, nil];
}

- (void)composeMsg
{
    [self performSegueWithIdentifier:@"Compose" sender:self];
}

- (void)sendFeedback
{
    [self presentModalViewController:[[JMC sharedInstance] viewController] animated:YES];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([indexPath row] == 0) {
        return NO;
    }
    return YES;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;    
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{    
    return [self.emails count];  
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Email_Cell";
    
    EmailCell *cell = (EmailCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    Email *cellEmail = [[Email alloc] init];
    cellEmail = [self.emails objectAtIndex:[indexPath row]];
    
    if (cell == nil) {
        cell = [[EmailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.lblSubject.text = cellEmail.subject;
    cell.txtBody.text = cellEmail.body;
    cell.lblFrom.text = cellEmail.fromName;
    cell.lblDate.text = [cellEmail getFormattedDate];
    
    [cell setIndexPath:indexPath];
    [cell setRootTable:tableView];
    [cell setForEmail:cellEmail];
    
    cell.cellDelegate = self;
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 94;    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"showDetail" sender:self];
}

- (void)delegateReloadData{
    self.emails = nil;
    self.emails = [[NSMutableArray alloc] init];
    DBEmails *db = [[DBEmails alloc] init];
    
    self.emails = [db getEmailsForState:stateID];
    
    [self.tableView reloadData];
    [self stopLoading];
}

- (void)delegateCloseCell:(NSIndexPath *)indexPath 
{
    EmailCell *currentlySwipedCell = (EmailCell *)[self.tableView cellForRowAtIndexPath:indexPath];
    if(currentlySwipedCell.swipeState == @"swipedRight"){
        [currentlySwipedCell didSwipeLeftInCell:self];
    } else if (currentlySwipedCell.swipeState == @"swipedLeft"){
        [currentlySwipedCell didSwipeRightInCell:self];
    }
}

- (void)delegateCellSwipe:(NSIndexPath *)indexPath 
{
    if ([_swipedCell compare:indexPath] != NSOrderedSame) {
        // Unswipe the currently swiped cell
        EmailCell *currentlySwipedCell = (EmailCell *)[self.tableView cellForRowAtIndexPath:_swipedCell];
        if(currentlySwipedCell.swipeState == @"swipedRight"){
            [currentlySwipedCell didSwipeLeftInCell:self];
        } else if (currentlySwipedCell.swipeState == @"swipedLeft"){
            [currentlySwipedCell didSwipeRightInCell:self];
        }
    }
    
    if ([_swipedCell compare:indexPath] == NSOrderedSame) {
        _swipedCell = nil;
    }
    // Set the _swipedCell property
    _swipedCell = indexPath;    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView 
{
    if (_swipedCell) {
        EmailCell *currentlySwipedCell = (EmailCell *)[self.tableView cellForRowAtIndexPath:_swipedCell];
        if(currentlySwipedCell.swipeState == @"swipedRight"){
            [currentlySwipedCell didSwipeLeftInCell:self];
        } else if (currentlySwipedCell.swipeState == @"swipedLeft"){
            [currentlySwipedCell didSwipeRightInCell:self];
        }
    }
    if (isLoading) {
        // Update the content inset, good for section headers
        if (scrollView.contentOffset.y > 0)
            self.tableView.contentInset = UIEdgeInsetsZero;
        else if (scrollView.contentOffset.y >= -REFRESH_HEADER_HEIGHT)
            self.tableView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
    } else if (isDragging && scrollView.contentOffset.y < 0) {
        // Update the arrow direction and label
        [UIView beginAnimations:nil context:NULL];
        if (scrollView.contentOffset.y < -REFRESH_HEADER_HEIGHT) {
            // User is scrolling above the header
            refreshLabel.text = self.textRelease;
            [refreshArrow layer].transform = CATransform3DMakeRotation(M_PI, 0, 0, 1);
        } else { // User is scrolling somewhere within the header
            refreshLabel.text = self.textPull;
            [refreshArrow layer].transform = CATransform3DMakeRotation(M_PI * 2, 0, 0, 1);
        }
        [UIView commitAnimations];
    }
}

- (IBAction)stateButton:(id)sender{
    [self performSegueWithIdentifier:@"ToState" sender:self];
}

@end