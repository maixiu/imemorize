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
#import "Deck.h"


@implementation SummaryTableViewController

@synthesize set;


#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	self.title = @"iMemorize";
}


#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.set.decks.count + 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    
	UIImage *cellImage;
	if (indexPath.row == 0) {
		cell.textLabel.text = @"Summary";
		cell.detailTextLabel.text = [NSString stringWithFormat:@"%d", self.set.cards.count];
		if (self.set.isExpired) {
			cellImage = [UIImage imageNamed:@"state_forgotten.gif"];
		}
		else {
			cellImage = [UIImage imageNamed:@"state_ok.gif"];
		}
	}
	else if (indexPath.row == 1) {
		cell.textLabel.text = @"Not learned";
		cell.detailTextLabel.text = [NSString stringWithFormat:@"%d", self.set.cardsNotLearned.count];
		if (self.set.cardsNotLearned.count > 0) {
			cellImage = [UIImage imageNamed:@"state_no.gif"];
		}
		else {
			cellImage = [UIImage imageNamed:@"state_ok.gif"];
		}
	}
	else {
		cell.textLabel.text = [NSString stringWithFormat:@"Deck %d", indexPath.row - 1];
		Deck *deck = [self.set.decks objectAtIndex:indexPath.row - 2];
		cell.detailTextLabel.text = [NSString  stringWithFormat:@"%d", deck.cards.count]; 
		if (deck.isExpired) {
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
		cardsTable.cards = self.set.cards;
		cardsTable.title = @"Summary";
	}
	else if (indexPath.row == 1) {
		cardsTable.cards = self.set.cardsNotLearned;
		cardsTable.title = @"Not learned";
	}
	else {
		Deck *deck = [self.set.decks objectAtIndex:indexPath.row - 2];
		cardsTable.cards = deck.cards;
		cardsTable.title = [NSString stringWithFormat:@"Deck %d", indexPath.row - 1];
	}
	
	[self.navigationController pushViewController:cardsTable animated:true];
	[cardsTable release];
}


#pragma mark -
#pragma mark CardSetDelegate

- (void)cardsUpdated:(id)sender
{
	[self.navigationController popToViewController:self animated:NO];
	[self.tableView reloadData];
}


#pragma mark -
#pragma mark Memory management

- (void)dealloc
{
	[set release];
    [super dealloc];
}


@end

