//
//  GitHubIssueTracker.m
//  Amey_Kelekar_Assignment8
//
//  Created by Amey Kelekar on 4/6/16.
//  Copyright © 2016 Amey Kelekar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GitHubIssueTracker.h"

@implementation GitHubIssueTracker

@synthesize title,body,comments,comments_url,user,login,state,number,created_at;

/*
 Message     :   init
 Input       :   none
 Returns     :   self object -- type id
 Function    :   To initialize the address with Test and dummy values to avoid inconsistent results in case the street name and/or the zipcode isn't passed
 */
-(id)init{
    self = [super init];
    self.title = @"TITLE";
    self.body = @"BODY";
    self.comments = [[NSNumber alloc] initWithInt:0];
    self.comments_url = @"COMMENTS_URL";
    self.user = [[NSNumber alloc] initWithLong:0];
    self.login = @"LOGIN";
    self.state = @"STATE";
    self.number = [[NSNumber alloc] initWithInt:0];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setDay:01];
    [comps setMonth:01];
    [comps setYear:2000];
    self.created_at = [[NSCalendar currentCalendar] dateFromComponents:comps];
    return self;
}
//End Message init

/*
 Message     :   initWithTitle
 Input       :   NSString *hName
 NSMutableArray *dList
 Returns     :   self object -- type id
 Function    :   To initialize the hospital with the name and the department that is passed as the input
 */
-(id)initWithTitle: (NSString *) iTitle andBody: (NSString *) iBody andComments: (NSNumber *) iComments andCommentsURL : (NSString *)iCommentsURL andUser: (NSNumber *) iUser andLogin: (NSString *) iLogin  andState: (NSString *) iState andNumber: (NSNumber *) iNumber andCreatedAt:(NSDate *)iCreatedAt{
    self = [super init];
    self.title = iTitle;
    self.body = iBody;
    self.comments = iComments;
    self.comments_url = iCommentsURL;
    self.user = iUser;
    self.login = iLogin;
    self.state = iState;
    self.number = iNumber;
    self.created_at = iCreatedAt;
    return self;
}
//End Message initWithTitle

@end
