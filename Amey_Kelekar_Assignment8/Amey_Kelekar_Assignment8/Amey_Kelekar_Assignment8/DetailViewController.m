//
//  DetailViewController.m
//  Amey_Kelekar_Assignment8
//
//  Created by Amey Kelekar on 4/9/16.
//  Copyright © 2016 Amey Kelekar. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController
@synthesize titleLabel, bodyLabel, commentsLabel, commentsURLLabel, userLabel, loginLabel, stateLabel, createdAtLabel,titleTextview, bodyTextView, commentsTextField, commentsURLTextView, userTextField, loginTextField, stateTextField, createdAtTextField, currentIssue;

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem {
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
            
        // Update the view.
        [self configureView];
    }
}

- (void)configureView {
    // Update the user interface for the detail item.
    if (self.detailItem) {
        self.detailDescriptionLabel.text = [self.detailItem description];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //[self configureView];
    self.titleTextview.layer.borderWidth = 1.0f;
    self.titleTextview.layer.borderColor = [[UIColor grayColor] CGColor];
    [self.titleTextview setEditable:NO];
    self.titleTextview.scrollEnabled = YES;
    
    self.bodyTextView.layer.borderWidth = 1.0f;
    self.bodyTextView.layer.borderColor = [[UIColor grayColor] CGColor];
    [self.bodyTextView setEditable:NO];
    self.bodyTextView.scrollEnabled = YES;
    
    self.commentsURLTextView.layer.borderWidth = 1.0f;
    self.commentsURLTextView.layer.borderColor = [[UIColor grayColor] CGColor];
    [self.commentsURLTextView setEditable:NO];
    self.commentsURLTextView.scrollEnabled = YES;
    
    self.commentsTextField.userInteractionEnabled = NO;
    self.userTextField.userInteractionEnabled = NO;
    self.loginTextField.userInteractionEnabled = NO;
    self.stateTextField.userInteractionEnabled = NO;
    self.createdAtTextField.userInteractionEnabled = NO;
    
    [self setValues];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) getCurrentIssue:(id)gitHubIssueObject{
    currentIssue = gitHubIssueObject;
}

- (void) setValues{
    self.titleTextview.text = currentIssue.title;
    self.bodyTextView.text = currentIssue.body;
    self.commentsTextField.text = [currentIssue.comments stringValue];
    NSMutableArray *tempArray = [self yourStringArrayWithHTMLSourceString:[self getDataFrom: currentIssue.comments_url] andCount:currentIssue.comments];
    NSString *joinedString = [tempArray componentsJoinedByString:@" "];
    self.commentsURLTextView.text = [self convertHTML:joinedString];
    self.userTextField.text = [currentIssue.user stringValue];
    self.loginTextField.text = currentIssue.login;
    self.stateTextField.text = currentIssue.state;
    NSDateFormatter *nsDateFormatter = [[NSDateFormatter alloc] init];
    [nsDateFormatter setDateFormat:@"yyyy-MM-dd 'at' HH:mm:ss"];
    NSString *stringFromDate = [nsDateFormatter stringFromDate:self.currentIssue.created_at];
    self.createdAtTextField.text = stringFromDate;
}

-(NSString *)convertHTML:(NSString *)html {
    NSScanner *myScanner;
    NSString *text = nil;
    myScanner = [NSScanner scannerWithString:html];
    while ([myScanner isAtEnd] == NO) {
        [myScanner scanUpToString:@"<" intoString:NULL] ;
        [myScanner scanUpToString:@">" intoString:&text] ;
        html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>", text] withString:@""];
    }
    html = [html stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    return html;
}

-(NSMutableArray *)yourStringArrayWithHTMLSourceString:(NSString *)html andCount: (NSNumber *)count{
    NSString *from = @"<div class=\"comment-content\"";
    NSString *to = @"</div>";
    NSMutableArray *array = [[NSMutableArray alloc]init];
    NSScanner* scanner = [NSScanner scannerWithString:html];
    for(int x=0;x<(int)count;x++) {
        NSString *tempString;
        [scanner scanUpToString:from intoString:nil];
        [scanner scanString:from intoString:nil];
        [scanner scanUpToString:to intoString:&tempString];
        NSString *str = [tempString substringFromIndex: [tempString rangeOfString:@"\">"].location+2];
        if(str != nil)
            [array addObject:str];
        else
            break;
    }
    return array;
}

- (NSString *) getDataFrom:(NSString *)url{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setHTTPMethod:@"GET"];
    [request setURL:[NSURL URLWithString:url]];
    NSError *error = [[NSError alloc] init];
    NSHTTPURLResponse *responseCode = nil;
    NSData *oResponseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&responseCode error:&error];
    if([responseCode statusCode] != 200){
        NSLog(@"Error getting %@, HTTP status code %i", url, [responseCode statusCode]);
        return nil;
    }
    return [[NSString alloc] initWithData:oResponseData encoding:NSUTF8StringEncoding];
}

@end
