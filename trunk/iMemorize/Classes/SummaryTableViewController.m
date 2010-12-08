//
//  SummaryTableViewController.m
//  iMemorize
//
//  Created by Matthieu Tabuteau on 28/11/10.
//  Copyright 2010 Matthieu Tabuteau. All rights reserved.
//

#import "SummaryTableViewController.h"
#import "Card.h"
#import "CardsTableViewController.h"
#import "Constants.h"


@interface SummaryTableViewController()
@property (nonatomic, retain) NSArray *decks;
@property (nonatomic, retain) NSArray *notLearnedCards;
@property (nonatomic, retain) NSArray *decksAreExpired;

- (void)initDecks;
@end

@implementation SummaryTableViewController

@synthesize cards;
@synthesize decks, notLearnedCards, decksAreExpired;

#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	self.title = @"iMemorize";
	[self initDecks];
}


#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.decks.count + 2;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
    }
    
	UIImage *cellImage;
	if (indexPath.row == 0) {
		cell.textLabel.text = @"Summary";
		cell.detailTextLabel.text = [NSString stringWithFormat:@"%d", self.cards.count];
		if ([self.decksAreExpired containsObject:[NSNumber numberWithBool:YES]]) {
			cellImage = [UIImage imageNamed:@"state_forgotten.gif"];
		}
		else {
			cellImage = [UIImage imageNamed:@"state_ok.gif"];
		}
	}
	else if (indexPath.row == 1) {
		cell.textLabel.text = @"Not learned";
		cell.detailTextLabel.text = [NSString stringWithFormat:@"%d", self.notLearnedCards.count];
		if (self.notLearnedCards.count > 0) {
			cellImage = [UIImage imageNamed:@"state_no.gif"];
		}
		else {
			cellImage = [UIImage imageNamed:@"state_ok.gif"];
		}
	}
	else {
		cell.textLabel.text = [NSString stringWithFormat:@"Deck %d", indexPath.row - 1];
		NSArray *deck = [self.decks objectAtIndex:indexPath.row - 2];
		cell.detailTextLabel.text = [NSString  stringWithFormat:@"%d", deck.count]; 
		if ([self.decksAreExpired objectAtIndex:indexPath.row - 2] == [NSNumber numberWithBool:YES]) {
			cellImage = [UIImage imageNamed:@"state_forgotten.gif"];
		}
		else {
			cellImage = [UIImage imageNamed:@"state_ok.gif"];
		}
	}
	
	cell.imageView.image = cellImage;
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	CardsTableViewController *cardsTable = [[CardsTableViewController alloc] initWithNibName:@"CardsTable"
																					 bundle:nil];
	if (indexPath.row == 0) {
		cardsTable.cards = self.cards;
		cardsTable.title = @"Summary";
	}
	else if (indexPath.row == 1) {
		cardsTable.cards = self.notLearnedCards;
		cardsTable.title = @"Not learned";
	}
	else {
		NSArray *deck = [self.decks objectAtIndex:indexPath.row - 2];
		cardsTable.cards = deck;
		cardsTable.title = [NSString stringWithFormat:@"Deck %d", indexPath.row - 1];
	}
	
	[self.navigationController pushViewController:cardsTable animated:true];
	[cardsTable release];
}


#pragma mark -
#pragma mark Private methods

- (void)initDecks
{
	//initialize decksAreExpired
	NSMutableArray *initDecksAreExpired = [[NSMutableArray alloc] initWithCapacity:kMaxDeckCount];
	for (int i = 0; i < kMaxDeckCount; i++) {
		[initDecksAreExpired addObject:[NSNumber numberWithBool:NO]];
	}
	
	NSMutableArray *newDecks = [[NSMutableArray alloc] initWithCapacity:kMaxDeckCount];
	NSMutableArray *newNotLearnedCards = [[NSMutableArray alloc] initWithCapacity:kMaxDeckCount];
	for (Card *card in self.cards) {
		if (card.deck > 0) {
			int deckNum = card.deck <= kMaxDeckCount ? card.deck : kMaxDeckCount;
			if (deckNum > newDecks.count) {
				for (int i = newDecks.count; i < deckNum; i++) {
					[newDecks insertObject:[NSMutableArray arrayWithCapacity:self.cards.count] atIndex:i];
				}
			}
			
			NSMutableArray *cardsInDeck = [newDecks objectAtIndex:deckNum - 1];
			[cardsInDeck addObject:card];
			
			//test expired
			if ([card.expired compare:[NSDate dateWithTimeIntervalSinceNow:0]] == NSOrderedAscending) {
				[initDecksAreExpired replaceObjectAtIndex:deckNum - 1 withObject:[NSNumber numberWithBool:YES]];
			}
		}
		else {
			[newNotLearnedCards addObject:card];
		}
	}
	
	decks = newDecks;
	decksAreExpired = initDecksAreExpired;
	notLearnedCards = newNotLearnedCards;
}


#pragma mark -
#pragma mark Memory management

- (void)dealloc
{
	[cards release];
	[decks release];
	[notLearnedCards release];
    [super dealloc];
}


@end

