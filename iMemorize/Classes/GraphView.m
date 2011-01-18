//
//  GraphView.m
//  iMemorize
//
//  Created by Matthieu Tabuteau on 12/01/11.
//  Copyright 2011 Matthieu Tabuteau. All rights reserved.
//

#import "GraphView.h"
#import "GraphBar.h"
#import "GraphSection.h"


@interface GraphView()
@property (nonatomic, retain) NSMutableArray *bars;
@end


@implementation GraphView

@synthesize bars;


- (id)initWithFrame:(CGRect)frame
{
	if (self = [super initWithFrame:frame]) {
		self.backgroundColor = [UIColor whiteColor];
		self.opaque = YES;
		self.bars = [NSMutableArray array];
	}
	
	return self;
}

- (void)reinitData
{
	[self.bars removeAllObjects];
}

- (void)drawRect:(CGRect)rect
{
	int kBarWidth = 10;
	int kAxisArrowSize = 15;
	int kNbLinesYAxis = 10;
	int kLinesYAxisWidth = 10;
	CGPoint kAxisStartPoint = CGPointMake(30, rect.size.height - 30);
	CGPoint kYaxisEndPoint = CGPointMake(kAxisStartPoint.x, 20);
	CGPoint kXaxisEndPoint = CGPointMake(rect.size.width - 20, kAxisStartPoint.y);
	
	CGContextRef context = UIGraphicsGetCurrentContext();
	
	// *** Draw the Y axis ***
	// Draw the line
	[[UIColor blackColor] setStroke];
	CGContextMoveToPoint(context, kAxisStartPoint.x, kAxisStartPoint.y);
	CGContextAddLineToPoint(context, kYaxisEndPoint.x, kYaxisEndPoint.y);
	CGContextStrokePath(context);
	// Draw the arrow at the end
	CGContextMoveToPoint(context, kYaxisEndPoint.x, kYaxisEndPoint.y);
	CGContextAddLineToPoint(context, kYaxisEndPoint.x - kAxisArrowSize / 2, kYaxisEndPoint.y + kAxisArrowSize);
	CGContextMoveToPoint(context, kYaxisEndPoint.x, kYaxisEndPoint.y);
	CGContextAddLineToPoint(context, kYaxisEndPoint.x + kAxisArrowSize / 2, kYaxisEndPoint.y + kAxisArrowSize);
	CGContextStrokePath(context);
	// Draw the marks
	float lineYSize = (kAxisStartPoint.y - kYaxisEndPoint.y) / kNbLinesYAxis;
	for (int i = 1; i < kNbLinesYAxis; i++) {
		CGContextMoveToPoint(context, kAxisStartPoint.x - kLinesYAxisWidth / 2, kAxisStartPoint.y - (i * lineYSize));
		CGContextAddLineToPoint(context, kAxisStartPoint.x + kLinesYAxisWidth / 2, kAxisStartPoint.y - (i * lineYSize));
		CGContextStrokePath(context);
	}
	
	// *** Draw the X axis ***
	// Draw the line
	CGContextMoveToPoint(context, kAxisStartPoint.x, kAxisStartPoint.y);
	CGContextAddLineToPoint(context, kXaxisEndPoint.x, kXaxisEndPoint.y);
	CGContextStrokePath(context);
	// Draw the arrow at the end
	CGContextMoveToPoint(context, kXaxisEndPoint.x, kXaxisEndPoint.y);
	CGContextAddLineToPoint(context, kXaxisEndPoint.x - kAxisArrowSize, kXaxisEndPoint.y - kAxisArrowSize / 2);
	CGContextMoveToPoint(context, kXaxisEndPoint.x, kXaxisEndPoint.y);
	CGContextAddLineToPoint(context, kXaxisEndPoint.x - kAxisArrowSize, kXaxisEndPoint.y + kAxisArrowSize / 2);
	CGContextStrokePath(context);
	// Write text on X axis
	for (int i = 0; i < self.bars.count; i++)
	{
		float x = kAxisStartPoint.x + (i + 1) * (kXaxisEndPoint.x - kAxisStartPoint.x) / (self.bars.count + 1);
		CGContextSelectFont(context, "Helvetica", 14.0, kCGEncodingMacRoman);
		CGContextSetShouldSmoothFonts(context, YES);
		CGContextSetTextMatrix(context, CGAffineTransformMakeScale(1.0, -1.0));
		CGContextSetTextDrawingMode(context, kCGTextFill);
		CGContextShowTextAtPoint(context, x - kBarWidth / 2.5, kAxisStartPoint.y + 20, [[NSString stringWithFormat:@"%d", i + 1] UTF8String], 1);
		CGContextFillPath(context);
	}
	
	
	// *** Draw the deck bars ***
	// Get the biggest size
	int maxSize = 0;
	for (GraphBar *bar in self.bars) {
		int size = [bar totalSize];
		maxSize = size > maxSize ? size : maxSize;
	}

	[[UIColor blackColor] setStroke];
	CGColorRef shadowColor = [UIColor colorWithRed:0.5 green:0.5
											  blue:0.5 alpha:0.7].CGColor;
	CGContextSetShadowWithColor(context, CGSizeMake(3, -2), 3.0, shadowColor);
	for (int i = 0; i < self.bars.count; i++)
	{
		int totalSize = 0;
		GraphBar *bar = [self.bars objectAtIndex:i];
		
		float x = kAxisStartPoint.x + (i + 1) * (kXaxisEndPoint.x - kAxisStartPoint.x) / (self.bars.count + 1);
		for (GraphSection *section in bar.sections)
		{
			[section.color setFill];
			
			float y = kAxisStartPoint.y - (totalSize * (kAxisStartPoint.y - kYaxisEndPoint.y) / maxSize);
			float height = section.size * (kAxisStartPoint.y - kYaxisEndPoint.y) / maxSize;
			CGRect rect = CGRectMake(x - kBarWidth / 2, y, kBarWidth, -height);
			
			CGContextFillRect(context, rect);
			CGContextStrokeRect(context, rect);
			
			totalSize += section.size;
		}
	}
}

- (void)addBarWithIndex:(int)index section:(int)section color:(UIColor *)color size:(int)size
{
	for (int i = self.bars.count; i <= index; i++) {
		GraphBar *bar = [[GraphBar alloc] init];
		[self.bars addObject:bar];
		[bar release];
	}
	
	GraphBar *bar = [self.bars objectAtIndex:index];
	[bar addSectionWithIndex:section color:color size:size];
}

- (void)dealloc
{
	[bars release];
    [super dealloc];
}


@end
