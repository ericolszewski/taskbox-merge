//
//  EmailAccount.h
//  MailFlow
//
//  Created by Adam Cianfichi on 6/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CTCoreAccount.h"
#import "CTCoreFolder.h"
#import "KeychainItemWrapper.h"

@interface EmailAccount : CTCoreAccount{
    NSString *Domain, *statesPlist;
    NSArray *ParsedEmail;
    CTCoreFolder *newFolder;
}

@property (nonatomic, strong) NSDictionary *states;

- (void)loginToAccount:(NSString *)email withPassword:(NSString *)password;
- (void)StoreCredentials:(NSString *)email Password:(NSString *)password;
- (void)createFolderWithPath:(NSString *)folderPath;
- (void)checkFolders:(NSSet *)allFolders;

@end