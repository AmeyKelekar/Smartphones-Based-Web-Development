//
//  GitHubIssueTracker.h
//  Amey_Kelekar_Assignment8
//
//  Created by Amey Kelekar on 4/6/16.
//  Copyright © 2016 Amey Kelekar. All rights reserved.
//

#ifndef GitHubIssueTracker_h
#define GitHubIssueTracker_h
@interface GitHubIssueTracker : NSObject

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *body;
@property (strong, nonatomic) NSNumber *comments;
@property (strong, nonatomic) NSString *comments_url;
@property (strong, nonatomic) NSNumber *user;
@property (strong, nonatomic) NSString *login;
@property (strong, nonatomic) NSString *state;
@property (strong, nonatomic) NSNumber *number;
@property (strong, nonatomic) NSDate *created_at;

//Message declarations
-(id)init;

-(id)initWithTitle: (NSString *) iTitle andBody: (NSString *) iBody andComments: (NSNumber *) iComments andCommentsURL : (NSString *)iCommentsURL andUser: (NSNumber *) iUser andLogin: (NSString *) iLogin andState: (NSString *) iState andNumber: (NSNumber *) iNumber andCreatedAt: (NSDate *)iCreatedAt;

@end

#endif /* GitHubIssueTracker_h */
