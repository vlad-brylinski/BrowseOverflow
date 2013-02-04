//
//  StackOverflowManager.m
//  BrowseOverflow
//
//  Created by Vladislav Brylinskiy on 04.02.13.
//  Copyright (c) 2013 Brylinskiy Vladislav. All rights reserved.
//

#import "StackOverflowManager.h"
#import "Topic.h"

NSString *StackOverflowManagerSearchFailedError = @"StackOverflowManagerSearchFailedError";

@implementation StackOverflowManager

@synthesize delegate;
@synthesize communicator;

- (void)setDelegate:(id<StackOverflowManagerDelegate>)newDelegate
{
    if (newDelegate && ![newDelegate conformsToProtocol:@protocol(StackOverflowManagerDelegate)])
    {
            [[NSException exceptionWithName:NSInvalidArgumentException reason: @"Delegate object does not conform to the delegate protocol" userInfo: nil] raise];
    }
    
    delegate = newDelegate;
}

- (void)fetchQuestionsOnTopic:(Topic *)topic
{
    [communicator searchForQuestionsWithTag:[topic tag]];
}

- (void)searchingForQuestionsFailedWithError:(NSError *)error {
    NSDictionary *errorInfo = [NSDictionary dictionaryWithObject:error forKey: NSUnderlyingErrorKey];
    
    NSError *reportableError = [NSError
                                errorWithDomain:StackOverflowManagerSearchFailedError
                                code: StackOverflowManagerErrorQuestionSearchCode userInfo:errorInfo];
    
    [delegate fetchingQuestionsFailedWithError:reportableError];
}

@end