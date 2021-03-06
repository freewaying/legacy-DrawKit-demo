///**********************************************************************************************************************************
///  GCSpecialColorWell.m
///  GCDrawKit
///
///  Created by graham on 01/05/2007.
///  Released under the Creative Commons license 2007 Apptree.net.
///
/// 
///  This work is licensed under the Creative Commons Attribution-ShareAlike 2.5 License.
///  To view a copy of this license, visit http://creativecommons.org/licenses/by-sa/2.5/ or send a letter to
///  Creative Commons, 543 Howard Street, 5th Floor, San Francisco, California, 94105, USA.
///
///**********************************************************************************************************************************

#import "GCSpecialColorWell.h"

#import <DKDrawKit/LogEvent.h>


#pragma mark Contants (Non-localized)
NSString*	kDKColorWellWillActivate	= @"kDKColorWellWillActivate";
NSString*	kDKColorWellDidActivate		= @"kDKColorWellDidActivate";
NSString*	kDKColorWellWillDeactivate	= @"kDKColorWellWillDeactivate";
NSString*	kDKColorWellDidDeactivate	= @"kDKColorWellDidDeactivate";


#pragma mark Static Vars
static	GCSpecialColorWell* sCurrentActiveWell = nil;


@implementation GCSpecialColorWell
#pragma mark As a GCSpecialColorWell

+ (void)		deactivateCurrentWell
{
	[sCurrentActiveWell deactivate];
	sCurrentActiveWell = nil;
}


#pragma mark -
#pragma mark As an NSColorWell
- (void)		activate:(BOOL) exclusive
{
	if(! [self isActive])
	{
		[[NSNotificationCenter defaultCenter] postNotificationName:kDKColorWellWillActivate object:self];
		[super activate:exclusive];
		sCurrentActiveWell = self;
	//	LogEvent_(kReactiveEvent, @"activating well: %@", self);
		
		[[NSNotificationCenter defaultCenter] postNotificationName:kDKColorWellDidActivate object:self];
	}
}


- (void)		deactivate
{
	if([self isActive])
	{
		[[NSNotificationCenter defaultCenter] postNotificationName:kDKColorWellWillDeactivate object:self];

	//	LogEvent_(kReactiveEvent, @"deactivating well: %@", self);
		sCurrentActiveWell = nil;
		[super deactivate];
		[[NSNotificationCenter defaultCenter] postNotificationName:kDKColorWellDidDeactivate object:self];
	}
}


#pragma mark -
#pragma mark As an NSObject
+ (void)		load
{
//    [GCSpecialColorWell poseAsClass:[NSColorWell class]];
}


@end
