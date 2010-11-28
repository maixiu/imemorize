//
//  CardsTableViewController.m
//  iMemorize
//
//  Created by Matthieu Tabuteau on 19/11/10.
//  Copyright 2010 Matthieu Tabuteau. All rights reserved.
//

#import "CardsTableViewController.h"
#import "CardDetailViewController.h"
#import "CardSet.h"

@interface CardsTableViewController()
@property (nonatomic, retain) NSDictionary *pagedCardSet;
@property (nonatomic, retain) NSArray *sections;
@property (nonatomic, retain) NSArray *searchCards;

- (void)filterTableForSearchText:(NSString *)searchText inScope:(int)scope;
- (NSString *)formatStringForSearch:(NSString *)searchString;
@end


@implementation CardsTableViewController

@synthesize set;
@synthesize sections, pagedCardSet, searchCards;

- (NSDictionary *)pagedCardSet
{
	if (!pagedCardSet) {
		NSMutableDictionary *sortedCards = [NSMutableDictionary dictionaryWithCapacity:self.set.cards.count];
		for (Card *card in self.set.cards) {
			int charIndex = ([card.flipSide characterAtIndex:0] == '_') ? 1 : 0;
			NSString *firstLetter = [[NSString stringWithFormat:@"%C", [card.flipSide characterAtIndex:charIndex]] lowercaseString];
			NSMutableArray *cardList;
			if (cardList = [sortedCards objectForKey:firstLetter]) {
				[cardList addObject:card];
			}
			else {
				cardList = [NSMutableArray arrayWithObject:card];
				[sortedCards setObject:cardList forKey:firstLetter];
			}
		}
		
		pagedCardSet = sortedCards;
	}
	
	return [pagedCardSet retain];
}

- (NSArray *)sections
{
	if (!sections) {
		NSArray *sortedSections = [[self.pagedCardSet allKeys] sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
		NSMutableArray *sectionIndexes = [NSMutableArray arrayWithArray:sortedSections];
		[sectionIndexes insertObject:UITableViewIndexSearch atIndex:0];
		sections =  [sectionIndexes retain];
	}
	
	return sections;
}


#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	self.title = @"Cards";
	UIBarButtonItem *bbItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
																			target:nil
																			action:nil];
	self.navigationItem.rightBarButtonItem = bbItem;
	[bbItem release];
}


#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	if (tableView == self.tableView) {
		return self.sections.count;
	}
    else {
		return 1;
	}
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	if (tableView == self.tableView) {
		if (section == 0) {
			return 0;
		}
		
		NSArray *cards = [self.pagedCardSet objectForKey:[self.sections objectAtIndex:section]];
		return cards.count;
	}
	else {
		return self.searchCards.count;
	}

}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
	if (tableView == self.tableView) {
		return sections;
	}
	
	return nil;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
	if (tableView == self.tableView) {
		if (section == 0) {
			return nil;
		}
		
		return [self.sections objectAtIndex:section];
	}
	
	return nil;
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
	if (index == 0) {
		[self.tableView setContentOffset:CGPointZero animated:NO];
		return NSNotFound;
	}
	
	return index;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    
	Card *card;
	if (tableView == self.tableView) {
		NSArray *cards = [self.pagedCardSet objectForKey:[self.sections objectAtIndex:indexPath.section]];
		card = [cards objectAtIndex:indexPath.row];
	}
	else {
		card = [self.searchCards objectAtIndex:indexPath.row];
	}
	
    cell.textLabel.text = card.frontSide;
	cell.detailTextLabel.text = card.flipSide;
	
    return cell;
}


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	Card *card;
	if (tableView == self.tableView) {
		NSArray *cards = [self.pagedCardSet objectForKey:[self.sections objectAtIndex:indexPath.section]];
		card = [cards objectAtIndex:indexPath.row];
	}
	else {
		card = [self.searchCards objectAtIndex:indexPath.row];
	}

	CardDetailViewController *detail = [[CardDetailViewController alloc] initWithNibName:@"CardDetail" bundle:nil];
	detail.card = card;
	
	[self.navigationController pushViewController:detail animated:YES];
	[detail release];
}


#pragma mark -
#pragma mark Search

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption
{
	self.searchCards = nil;
	[self filterTableForSearchText:self.searchDisplayController.searchBar.text
						   inScope:[self.searchDisplayController.searchBar selectedScopeButtonIndex]];
	return YES;
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
	[self filterTableForSearchText:searchString
						   inScope:[self.searchDisplayController.searchBar selectedScopeButtonIndex]];
	return YES;
}

#pragma mark -
#pragma mark Private methods

- (void)filterTableForSearchText:(NSString *)searchText inScope:(int)scopeIndex
{
	if ([searchText length] > 0) {
		if (scopeIndex == 0) {
			//Search cards which frontside (hanzi) match the searched text
			NSMutableArray *tempSearch = [NSMutableArray arrayWithCapacity:self.set.cards.count];
			for (Card *card in self.set.cards) {
				if ([card.frontSide compare:searchText options:NSLiteralSearch range:NSMakeRange(0, searchText.length)] == NSOrderedSame) {
					[tempSearch addObject:card];
				}
			}
			
			self.searchCards = tempSearch;
		}
		else {
			//Search cards which flipside (pinyin) match the searched text
			NSMutableArray *firstCharSearchValues = nil;
			NSMutableArray *searchValues = nil;
			NSString *firstChar = [searchText substringToIndex:1];
			
			// On récupère la liste des mots dont le 1er charactère recherché fait partit du dictionnaire
			if ([searchText compare:@"a" options:NSLiteralSearch range:NSMakeRange(0, 1)] == NSOrderedSame) {
				NSArray *values = [self.pagedCardSet objectsForKeys:[NSArray arrayWithObjects:@"à", @"ā", @"ǎ", nil]
													 notFoundMarker:[NSNull null]];
				firstCharSearchValues = [NSMutableArray arrayWithCapacity:[self.set.cards count]];
				for (id value in values) {
					if (value != [NSNull null]) {
						[firstCharSearchValues addObjectsFromArray:value];
					}
				}
			}
			else if ([searchText compare:@"e" options:NSLiteralSearch range:NSMakeRange(0, 1)] == NSOrderedSame) {
				NSArray *values = [self.pagedCardSet objectsForKeys:[NSArray arrayWithObjects:@"è", @"é", @"ě", nil]
													 notFoundMarker:[NSNull null]];
				firstCharSearchValues = [NSMutableArray arrayWithCapacity:[self.set.cards count]];
				for (id value in values) {
					if (value != [NSNull null]) {
						[firstCharSearchValues addObjectsFromArray:value];
					}
				}
			}
			else if ([self.pagedCardSet objectForKey:firstChar]) {
				firstCharSearchValues = [NSMutableArray arrayWithArray:[self.pagedCardSet objectForKey:firstChar]];
			}
			
			// Si la taille du texte recherché > 1, on filtre plus finement
			if (searchText.length > 1 && firstCharSearchValues) {
				searchValues = [NSMutableArray arrayWithCapacity:firstCharSearchValues.count];
				for (Card *c in firstCharSearchValues) {
					NSString *flipWithNoTone = [self formatStringForSearch:c.flipSide];
					
					if ([flipWithNoTone compare:searchText options:NSLiteralSearch range:NSMakeRange(0, searchText.length)] == NSOrderedSame) {
						[searchValues addObject:c];
					}
				}
			}
			else {
				searchValues = firstCharSearchValues;
			}
			
			self.searchCards = searchValues;
		}
	}
}

- (NSString *)formatStringForSearch:(NSString *)searchString
{
	//Replacing the 'a'
	NSString *formattedString = [searchString stringByReplacingOccurrencesOfString:@"ā" withString:@"a"];
	formattedString = [formattedString stringByReplacingOccurrencesOfString:@"á" withString:@"a"];
	formattedString = [formattedString stringByReplacingOccurrencesOfString:@"ǎ" withString:@"a"];
	formattedString = [formattedString stringByReplacingOccurrencesOfString:@"à" withString:@"a"];
	
	//Replacing the 'e'
	formattedString = [formattedString stringByReplacingOccurrencesOfString:@"ē" withString:@"e"];
	formattedString = [formattedString stringByReplacingOccurrencesOfString:@"é" withString:@"e"];
	formattedString = [formattedString stringByReplacingOccurrencesOfString:@"ě" withString:@"e"];
	formattedString = [formattedString stringByReplacingOccurrencesOfString:@"è" withString:@"e"];

	//Replacing the 'u'
	formattedString = [formattedString stringByReplacingOccurrencesOfString:@"ū" withString:@"u"];
	formattedString = [formattedString stringByReplacingOccurrencesOfString:@"ú" withString:@"u"];
	formattedString = [formattedString stringByReplacingOccurrencesOfString:@"ǔ" withString:@"u"];
	formattedString = [formattedString stringByReplacingOccurrencesOfString:@"ù" withString:@"u"];
	
	//Replacing the 'i'
	formattedString = [formattedString stringByReplacingOccurrencesOfString:@"ī" withString:@"i"];
	formattedString = [formattedString stringByReplacingOccurrencesOfString:@"í" withString:@"i"];
	formattedString = [formattedString stringByReplacingOccurrencesOfString:@"ǐ" withString:@"i"];
	formattedString = [formattedString stringByReplacingOccurrencesOfString:@"ì" withString:@"i"];
	
	//Replacing the 'o'
	formattedString = [formattedString stringByReplacingOccurrencesOfString:@"ō" withString:@"o"];
	formattedString = [formattedString stringByReplacingOccurrencesOfString:@"ó" withString:@"o"];
	formattedString = [formattedString stringByReplacingOccurrencesOfString:@"ǒ" withString:@"o"];
	formattedString = [formattedString stringByReplacingOccurrencesOfString:@"ò" withString:@"o"];
	
	//Removing spaces
	formattedString = [formattedString stringByReplacingOccurrencesOfString:@" " withString:@""];
	
	return formattedString;
}


#pragma mark -
#pragma mark Memory management

- (void)dealloc
{
	[set release];
	[sections release];
	[pagedCardSet release];
    [super dealloc];
}


@end

