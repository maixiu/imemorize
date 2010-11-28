//
//  JmemorizeCsvFileParser.h
//  iMemorize
//
//  Created by Matthieu Tabuteau on 20/11/10.
//  Copyright 2010 Matthieu Tabuteau. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface JmemorizeCsvFileParser : NSObject
{

}

+ (NSArray *)parseCardsFromData:(NSString *)data;

@end
