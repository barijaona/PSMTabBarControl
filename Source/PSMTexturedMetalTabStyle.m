//
//  PSMTexturedMetalTabStyle.m
//  PSMTabBarControl
//
//  Created by Christopher Cahoon on 5/8/2014.
//  Based on PSMMetalTabStyle.h
//  Created by John Pannell on 2/17/06.
//  Copyright 2006 Positive Spin Media. All rights reserved.
//

#import "PSMTexturedMetalTabStyle.h"
#import "PSMTabBarCell.h"
#import "PSMTabBarControl.h"

@interface PSMTabBarCell(SharedPrivates)

- (void)_drawCloseButtonWithFrame:(NSRect)frame inTabBarControl:(PSMTabBarControl *)tabBarControl;

@end

@implementation PSMTexturedMetalTabStyle

+ (NSString *)name {
    return @"TexturedMetal";
}

- (NSString *)name {
	return [[self class] name];
}

#pragma mark -
#pragma mark Creation/Destruction

- (instancetype) init {
	if((self = [super init])) {
		metalCloseButton = [[NSImage alloc] initByReferencingFile:[[PSMTabBarControl bundle] pathForImageResource:@"TabClose_Front_Textured"]];
		metalCloseButtonDown = [[NSImage alloc] initByReferencingFile:[[PSMTabBarControl bundle] pathForImageResource:@"TabClose_Front_Pressed_Textured"]];
		metalCloseButtonOver = [[NSImage alloc] initByReferencingFile:[[PSMTabBarControl bundle] pathForImageResource:@"TabClose_Front_Rollover_Textured"]];

		metalCloseDirtyButton = [[NSImage alloc] initByReferencingFile:[[PSMTabBarControl bundle] pathForImageResource:@"TabClose_Dirty_Textured"]];
		metalCloseDirtyButtonDown = [[NSImage alloc] initByReferencingFile:[[PSMTabBarControl bundle] pathForImageResource:@"TabClose_Dirty_Pressed_Textured"]];
		metalCloseDirtyButtonOver = [[NSImage alloc] initByReferencingFile:[[PSMTabBarControl bundle] pathForImageResource:@"TabClose_Dirty_Rollover_Textured"]];

		_addTabButtonImage = [[NSImage alloc] initByReferencingFile:[[PSMTabBarControl bundle] pathForImageResource:@"TabNewMetal_Textured"]];
		_addTabButtonPressedImage = [[NSImage alloc] initByReferencingFile:[[PSMTabBarControl bundle] pathForImageResource:@"TabNewMetalPressed_Textured"]];
		_addTabButtonRolloverImage = [[NSImage alloc] initByReferencingFile:[[PSMTabBarControl bundle] pathForImageResource:@"TabNewMetalRollover_Textured"]];

		_objectCountStringAttributes = [[NSDictionary alloc] initWithObjectsAndKeys:[[NSFontManager sharedFontManager] convertFont:[NSFont fontWithName:@"Helvetica" size:11.0] toHaveTrait:NSBoldFontMask], NSFontAttributeName,
										[[NSColor whiteColor] colorWithAlphaComponent:0.85], NSForegroundColorAttributeName,
										nil, nil];
	}
	return self;
}


#pragma mark -
#pragma mark Control Specific

- (CGFloat)leftMarginForTabBarControl:(PSMTabBarControl *)tabBarControl {
    return 2.0f;
}

- (CGFloat)rightMarginForTabBarControl:(PSMTabBarControl *)tabBarControl {
    return 24.0f;
}

- (CGFloat)topMarginForTabBarControl:(PSMTabBarControl *)tabBarControl {
	return 10.0f;
}

#pragma mark -
#pragma mark Add Tab Button

- (NSImage *)addTabButtonImage {
	return _addTabButtonImage;
}

- (NSImage *)addTabButtonPressedImage {
	return _addTabButtonPressedImage;
}

- (NSImage *)addTabButtonRolloverImage {
	return _addTabButtonRolloverImage;
}

#pragma mark -
#pragma mark Drag Support

- (NSRect)dragRectForTabCell:(PSMTabBarCell *)cell ofTabBarControl:(PSMTabBarControl *)tabBarControl {
	NSRect dragRect = [cell frame];
	dragRect.size.width++;

    PSMTabBarOrientation orientation = [tabBarControl orientation];

	if([cell tabState] & PSMTab_SelectedMask) {
		if(orientation == PSMTabBarHorizontalOrientation) {
			dragRect.size.height -= 2.0;
		} else {
			dragRect.size.height += 1.0;
			dragRect.origin.y -= 1.0;
			dragRect.origin.x += 2.0;
			dragRect.size.width -= 3.0;
		}
	} else if(orientation == PSMTabBarVerticalOrientation) {
		dragRect.origin.x--;
	}

	return dragRect;
}

#pragma mark -
#pragma mark Providing Images

- (NSImage *)closeButtonImageOfType:(PSMCloseButtonImageType)type forTabCell:(PSMTabBarCell *)cell
{
    switch (type) {
        case PSMCloseButtonImageTypeStandard:
            return metalCloseButton;
        case PSMCloseButtonImageTypeRollover:
            return metalCloseButtonOver;
        case PSMCloseButtonImageTypePressed:
            return metalCloseButtonDown;
            
        case PSMCloseButtonImageTypeDirty:
            return metalCloseDirtyButton;
        case PSMCloseButtonImageTypeDirtyRollover:
            return metalCloseDirtyButtonOver;
        case PSMCloseButtonImageTypeDirtyPressed:
            return metalCloseDirtyButtonDown;
            
        default:
            break;
    }
    
}

#pragma mark -
#pragma mark Cell Values

- (NSAttributedString *)attributedObjectCountStringValueForTabCell:(PSMTabBarCell *)cell {
	NSString *contents = [NSString stringWithFormat:@"%lu", (unsigned long)[cell count]];
	return [[NSMutableAttributedString alloc] initWithString:contents attributes:_objectCountStringAttributes];
}

- (NSAttributedString *)attributedStringValueForTabCell:(PSMTabBarCell *)cell inTabBarControl:(PSMTabBarControl *)tabBarControl {
	NSMutableAttributedString *attrStr;
	NSString *contents = [cell title];
	attrStr = [[NSMutableAttributedString alloc] initWithString:contents];
	NSRange range = NSMakeRange(0, [contents length]);

	// Add font attribute
	[attrStr addAttribute:NSFontAttributeName value:[NSFont boldSystemFontOfSize:11.0] range:range];
    [attrStr addAttribute:NSForegroundColorAttributeName value:[[NSColor textColor] colorWithAlphaComponent:([[tabBarControl window] isMainWindow] ? 0.75 : 0.5)] range:range];

	// Add shadow attribute
	NSShadow* shadow;
	shadow = [[NSShadow alloc] init];
	CGFloat shadowAlpha;
	if(([cell state] == NSOnState) || [cell isHighlighted]) {
		shadowAlpha = 0.8;
	} else {
		shadowAlpha = 0.5;
	}
	[shadow setShadowColor:[NSColor colorWithCalibratedWhite:1.0 alpha:shadowAlpha]];
	[shadow setShadowOffset:NSMakeSize(0, -1)];
	[shadow setShadowBlurRadius:1.0];
	[attrStr addAttribute:NSShadowAttributeName value:shadow range:range];

	// Paragraph Style for Truncating Long Text
	static NSMutableParagraphStyle *TruncatingTailParagraphStyle = nil;
	if(!TruncatingTailParagraphStyle) {
		TruncatingTailParagraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
		[TruncatingTailParagraphStyle setLineBreakMode:NSLineBreakByTruncatingTail];
		[TruncatingTailParagraphStyle setAlignment:NSCenterTextAlignment];
	}
	[attrStr addAttribute:NSParagraphStyleAttributeName value:TruncatingTailParagraphStyle range:range];

	return attrStr;
}

#pragma mark -
#pragma mark Drawing

- (BOOL)_shouldDrawHorizontalTopBorderLineInView:(id)controlView
{
    NSWindow *window = [controlView window];
    NSToolbar *toolbar = [window toolbar];
    if (!toolbar || ![toolbar isVisible] || ([toolbar isVisible] && [toolbar showsBaselineSeparator]))
        return NO;
    
    return YES;
}

- (NSRect)drawingRectForBounds:(NSRect)theRect ofTabCell:(PSMTabBarCell *)cell
{
    NSRect resultRect;

    if ([(PSMTabBarControl *)[cell controlView] orientation] == PSMTabBarHorizontalOrientation && [cell state] == NSOnState) {
        resultRect = NSInsetRect(theRect,MARGIN_X,0.0);
        resultRect.origin.y += 1;
        resultRect.size.height -= MARGIN_Y + 2;
    } else {
        resultRect = NSInsetRect(theRect, MARGIN_X, MARGIN_Y);
        resultRect.size.height -= 1;
    }
    
    return resultRect;
}

- (void)drawBezelOfTabCell:(PSMTabBarCell *)cell withFrame:(NSRect)frame inTabBarControl:(PSMTabBarControl *)tabBarControl {

	NSRect cellFrame = [cell frame];
	NSColor *lineColor = ([[tabBarControl window] isMainWindow]) ?
                                [NSColor darkGrayColor] : [NSColor grayColor];
	NSBezierPath *bezier = [NSBezierPath bezierPath];
	lineColor = [NSColor darkGrayColor];
    
    PSMTabBarOrientation orientation = [(PSMTabBarControl *)[cell controlView] orientation];

	//disable antialiasing of bezier paths
	[NSGraphicsContext saveGraphicsState];
	[[NSGraphicsContext currentContext] setShouldAntialias:NO];

	if([cell state] == NSOnState) {
		// selected tab
		if(orientation == PSMTabBarHorizontalOrientation) {
            // selected tab
            NSRect tabRect = NSOffsetRect(NSInsetRect(cellFrame, 0.5, -10), 0, -10.5);
            bezier = [NSBezierPath bezierPathWithRoundedRect:tabRect xRadius:5 yRadius:5];
            [lineColor set];
            [bezier setLineWidth:1.0];
            
            // special case of hidden control; need line across top of cell
            if ([[cell controlView] frame].size.height < 2)
            {
                NSRectFillUsingOperation(tabRect, NSCompositeSourceOver);
            }
            else
            {
                // background
                [NSGraphicsContext saveGraphicsState];
                [bezier addClip];
                NSDrawWindowBackground(cellFrame);
                [NSGraphicsContext restoreGraphicsState];
                
                [bezier stroke];
            }
		} else {
			NSRect aRect = NSMakeRect(cellFrame.origin.x + 2, cellFrame.origin.y, cellFrame.size.width - 2, cellFrame.size.height);

			// background
			aRect.origin.x++;
			aRect.size.height--;
            
            [[NSColor windowBackgroundColor] set];
            NSRectFill(aRect);
            
			aRect.origin.x--;
			aRect.size.height++;

			// frame
			[lineColor set];
			[bezier setLineWidth:1.0];
			[bezier moveToPoint:NSMakePoint(aRect.origin.x + aRect.size.width, aRect.origin.y)];
			[bezier lineToPoint:NSMakePoint(aRect.origin.x + 2, aRect.origin.y)];
			[bezier lineToPoint:NSMakePoint(aRect.origin.x + 0.5, aRect.origin.y + 2)];
			[bezier lineToPoint:NSMakePoint(aRect.origin.x + 0.5, aRect.origin.y + aRect.size.height - 3)];
			[bezier lineToPoint:NSMakePoint(aRect.origin.x + 3, aRect.origin.y + aRect.size.height)];
			[bezier lineToPoint:NSMakePoint(aRect.origin.x + aRect.size.width, aRect.origin.y + aRect.size.height)];
		}

		[bezier stroke];
	} else {
		// unselected tab
		NSRect aRect = NSMakeRect(cellFrame.origin.x, cellFrame.origin.y, cellFrame.size.width, cellFrame.size.height);
		aRect.origin.y += 0.5;
		aRect.origin.x += 1.5;
		aRect.size.width -= 1;

		[lineColor set];

		if(orientation == PSMTabBarHorizontalOrientation) {
			aRect.origin.x -= 1;
			aRect.size.width += 1;

			// frame
            if ([self _shouldDrawHorizontalTopBorderLineInView:tabBarControl]) {
                [bezier moveToPoint:NSMakePoint(aRect.origin.x, aRect.origin.y)];
                [bezier lineToPoint:NSMakePoint(aRect.origin.x + aRect.size.width, aRect.origin.y)];
            } else {
                [bezier moveToPoint:NSMakePoint(aRect.origin.x + aRect.size.width, aRect.origin.y)];
            }
            
			if(!([cell tabState] & PSMTab_RightIsSelectedMask)) {
				[bezier lineToPoint:NSMakePoint(aRect.origin.x + aRect.size.width, aRect.origin.y + aRect.size.height)];
                
			}
		} else {
			if(!([cell tabState] & PSMTab_LeftIsSelectedMask)) {
				[bezier moveToPoint:NSMakePoint(aRect.origin.x, aRect.origin.y)];
				[bezier lineToPoint:NSMakePoint(aRect.origin.x + aRect.size.width, aRect.origin.y)];
			}

			if(!([cell tabState] & PSMTab_RightIsSelectedMask)) {
				[bezier moveToPoint:NSMakePoint(aRect.origin.x, aRect.origin.y + aRect.size.height)];
				[bezier lineToPoint:NSMakePoint(aRect.origin.x + aRect.size.width, aRect.origin.y + aRect.size.height)];
			}
		}
        
		[bezier stroke];        
	}

	[NSGraphicsContext restoreGraphicsState];
}

- (void)drawBezelOfTabBarControl:(PSMTabBarControl *)tabBarControl inRect:(NSRect)rect {

	//Draw for our whole bounds; it'll be automatically clipped to fit the appropriate drawing area
	rect = [tabBarControl bounds];
    
    PSMTabBarOrientation orientation = [tabBarControl orientation];

	if(orientation == PSMTabBarVerticalOrientation && [tabBarControl frame].size.width < 2) {
		return;
	}

	[NSGraphicsContext saveGraphicsState];
	[[NSGraphicsContext currentContext] setShouldAntialias:NO];

    [[NSColor colorWithCalibratedWhite:0.0 alpha:([[tabBarControl window] isMainWindow] ? 0.1 : 0.05)] set];
    NSRectFillUsingOperation(rect, NSCompositeSourceAtop);
    
    NSGradient *shadow = [[NSGradient alloc ] initWithStartingColor:[NSColor colorWithDeviceWhite:0 alpha:([[tabBarControl window] isMainWindow] ? 0.15 : 0.1)] endingColor:[NSColor clearColor]];
    NSRect shadowRect = NSMakeRect(rect.origin.x, rect.origin.y, rect.size.width, 7);
    [shadow drawInRect:shadowRect angle:90];
    
    if ([[tabBarControl window] isMainWindow]) {
        [[NSColor darkGrayColor] set];
    } else {
        [[NSColor grayColor] set];
    }

	if(orientation == PSMTabBarHorizontalOrientation) {

        if ([self _shouldDrawHorizontalTopBorderLineInView:tabBarControl]) {
            [NSBezierPath strokeLineFromPoint:NSMakePoint(rect.origin.x, rect.origin.y + 0.5) toPoint:NSMakePoint(rect.origin.x + rect.size.width, rect.origin.y + 0.5)];
        }
        
		[NSBezierPath strokeLineFromPoint:NSMakePoint(rect.origin.x, rect.origin.y + rect.size.height - 0.5) toPoint:NSMakePoint(rect.origin.x + rect.size.width, rect.origin.y + rect.size.height - 0.5)];
	} else {
		[NSBezierPath strokeLineFromPoint:NSMakePoint(rect.origin.x, rect.origin.y + 0.5) toPoint:NSMakePoint(rect.origin.x, rect.origin.y + rect.size.height + 0.5)];
		[NSBezierPath strokeLineFromPoint:NSMakePoint(rect.origin.x + rect.size.width, rect.origin.y + 0.5) toPoint:NSMakePoint(rect.origin.x + rect.size.width, rect.origin.y + rect.size.height + 0.5)];
	}

	[NSGraphicsContext restoreGraphicsState];
}

- (void)drawCloseButtonOfTabCell:(PSMTabBarCell *)cell withFrame:(NSRect)frame inTabBarControl:(PSMTabBarControl *)tabBarControl {
    NSRect offsetFrame = frame;
    if([cell isHighlighted]) {
        if([cell state] == NSOnState) {
            offsetFrame.origin.y += 1.5;
        } else {
            offsetFrame.origin.y += 1;
        }
        [cell _drawCloseButtonWithFrame:offsetFrame inTabBarControl:tabBarControl];
    }
}

#pragma mark -
#pragma mark Archiving

- (void)encodeWithCoder:(NSCoder *)aCoder {
	//[super encodeWithCoder:aCoder];
	if([aCoder allowsKeyedCoding]) {
		[aCoder encodeObject:metalCloseButton forKey:@"metalCloseButton"];
		[aCoder encodeObject:metalCloseButtonDown forKey:@"metalCloseButtonDown"];
		[aCoder encodeObject:metalCloseButtonOver forKey:@"metalCloseButtonOver"];
		[aCoder encodeObject:metalCloseDirtyButton forKey:@"metalCloseDirtyButton"];
		[aCoder encodeObject:metalCloseDirtyButtonDown forKey:@"metalCloseDirtyButtonDown"];
		[aCoder encodeObject:metalCloseDirtyButtonOver forKey:@"metalCloseDirtyButtonOver"];
		[aCoder encodeObject:_addTabButtonImage forKey:@"addTabButtonImage"];
		[aCoder encodeObject:_addTabButtonPressedImage forKey:@"addTabButtonPressedImage"];
		[aCoder encodeObject:_addTabButtonRolloverImage forKey:@"addTabButtonRolloverImage"];
	}
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
	// self = [super initWithCoder:aDecoder];
	//if (self) {
	if([aDecoder allowsKeyedCoding]) {
		metalCloseButton = [aDecoder decodeObjectForKey:@"metalCloseButton"];
		metalCloseButtonDown = [aDecoder decodeObjectForKey:@"metalCloseButtonDown"];
		metalCloseButtonOver = [aDecoder decodeObjectForKey:@"metalCloseButtonOver"];
		metalCloseDirtyButton = [aDecoder decodeObjectForKey:@"metalCloseDirtyButton"];
		metalCloseDirtyButtonDown = [aDecoder decodeObjectForKey:@"metalCloseDirtyButtonDown"];
		metalCloseDirtyButtonOver = [aDecoder decodeObjectForKey:@"metalCloseDirtyButtonOver"];
		_addTabButtonImage = [aDecoder decodeObjectForKey:@"addTabButtonImage"];
		_addTabButtonPressedImage = [aDecoder decodeObjectForKey:@"addTabButtonPressedImage"];
		_addTabButtonRolloverImage = [aDecoder decodeObjectForKey:@"addTabButtonRolloverImage"];
	}
	//}
	return self;
}

@end
