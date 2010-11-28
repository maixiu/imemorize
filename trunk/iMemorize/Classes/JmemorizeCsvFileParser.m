//
//  JmemorizeCsvFileParser.m
//  iMemorize
//
//  Created by Matthieu Tabuteau on 20/11/10.
//  Copyright 2010 Matthieu Tabuteau. All rights reserved.
//

#import "JmemorizeCsvFileParser.h"
#import "Card.h"


@implementation JmemorizeCsvFileParser

+ (NSArray *)parseCardsFromData:(NSString *)data
{
	NSMutableArray *cards = [NSMutableArray array];
	
    NSMutableCharacterSet *scanUpToCharacterSet = (id)[NSMutableCharacterSet characterSetWithCharactersInString:@",\""];
    [scanUpToCharacterSet formUnionWithCharacterSet:[NSCharacterSet newlineCharacterSet]];
	
    // Create scanner, and scan string
	NSScanner *scanner = [[NSScanner alloc] initWithString:data];
    [scanner setCharactersToBeSkipped:nil];
    while (![scanner isAtEnd]) {
        BOOL insideQuotes = NO;
        BOOL finishedRow = NO;
		NSMutableArray *columns = [[NSMutableArray alloc] initWithCapacity:4];
		NSMutableString *currentColumn = [[NSMutableString alloc] init];
        while (!finishedRow) {
            NSString *scanned;
            if ([scanner scanUpToCharactersFromSet:scanUpToCharacterSet intoString:&scanned]) {
                [currentColumn appendString:scanned];
            }
			
            if ([scanner isAtEnd]) {
                if (![currentColumn isEqualToString:@""]) [columns addObject:currentColumn];
                finishedRow = YES;
            }
            else if ([scanner scanCharactersFromSet:[NSCharacterSet newlineCharacterSet] intoString:&scanned]) {
                if (insideQuotes) {
                    // Add line break to column text
                    [currentColumn appendString:scanned];
                }
                else {
                    // End of row
                    [columns addObject:currentColumn];
                    finishedRow = YES;
                }
            }
            else if ([scanner scanString:@"\"" intoString:NULL]) {
                if (insideQuotes && [scanner scanString:@"\"" intoString:NULL]) {
                    // Replace double quotes with a single quote in the column string.
                    [currentColumn appendString:@"\""]; 
                }
                else {
                    // Start or end of a quoted string.
                    insideQuotes = !insideQuotes;
                }
            }
            else if ([scanner scanString:@"," intoString:NULL]) {  
                if (insideQuotes) {
                    [currentColumn appendString:@","];
                }
                else {
                    // This is a column separating comma
                    [columns addObject:currentColumn];
					[currentColumn release];
					currentColumn = [[NSMutableString alloc] init];
                    [scanner scanCharactersFromSet:[NSCharacterSet whitespaceCharacterSet] intoString:NULL];
                }
            }
        }
        if (columns.count == 4) {
			Card *card = [Card cardWithFrontSide:[columns objectAtIndex:0] flipSide:[columns objectAtIndex:1]];
			[cards addObject:card];
		}
		
		[columns release];
		[currentColumn release];
    }
	
	[scanner release];
    return cards;
}

@end
