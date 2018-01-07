//
//  PSMSafariTabStyle.m
//  PSMTabBarControl
//
//  Created by Hejki on 16.07.14.
//
//

#import "PSMSafariTabStyle.h"

#define capWidth            11
#define capHeight           24
#define addTabButtonWidth   22
#define addTabButtonHeight  23

@implementation PSMSafariTabStyle {
    NSImage *closeButton;
    NSImage *closeButtonOver;
    NSImage *closeButtonPressed;
    NSImage *closeButtonInactive;
    NSImage *closeButtonOverInactive;
    NSImage *closeButtonPressedInactive;
    
    NSImage *iwCloseButton;
    NSImage *iwCloseButtonOver;
    NSImage *iwCloseButtonPressed;
    NSImage *iwCloseButtonInactive;
    NSImage *iwCloseButtonOverInactive;
    NSImage *iwCloseButtonPressedInactive;
    
    NSImage *addTabButton;
    NSImage *addTabButtonOver;
    NSImage *addTabButtonPressed;
    NSImage *iwAddTabButton;
    
    NSImage *activeTabFill;
    NSImage *activeTabLeftCap;
    NSImage *activeTabRightCap;
    NSImage *iwActiveTabFill;
    NSImage *iwActiveTabLeftCap;
    NSImage *iwActiveTabRightCap;
    
    NSImage *inactiveTabLeftCap;
    NSImage *inactiveTabRightCap;
    NSImage *iwInactiveTabLeftCap;
    NSImage *iwInactiveTabRightCap;
    
    NSColor *tabBackgroundColor;
    NSColor *iwTabBackgroundColor;
}

+ (NSString *)name {
    return @"Safari";
}

- (NSString *)name {
    return [[self class] name];
}

//+ (CGFloat)desiredTabBarControlHeight;
//
//// cell values
//- (NSAttributedString *)attributedObjectCountStringValueForTabCell:(PSMTabBarCell *)cell;
//- (NSAttributedString *)attributedStringValueForTabCell:(PSMTabBarCell *)cell inTabBarControl:(PSMTabBarControl *)tabBarControl;

#pragma mark -
#pragma mark Creation/Destruction

- (NSImage *)img:(NSString *)name {
    return [[NSImage alloc] initByReferencingFile:[[PSMTabBarControl bundle] pathForImageResource:name]];
}

- (instancetype) init {
    self = [super init];
    if (self) {
        closeButton = [self img:@"ActiveWindow_ActiveTabClose"];
        closeButtonOver = [self img:@"ActiveWindow_ActiveTabCloseRollover"];
        closeButtonPressed = [self img:@"ActiveWindow_ActiveTabClosePressed"];
        closeButtonInactive = [self img:@"ActiveWindow_InactiveTabClose"];
        closeButtonOverInactive = [self img:@"ActiveWindow_InactiveTabCloseRollover"];
        closeButtonPressedInactive = [self img:@"ActiveWindow_InactiveTabClosePressed"];
        iwCloseButton = [self img:@"InactiveWindow_ActiveTabClose"];
        iwCloseButtonOver = [self img:@"InactiveWindow_ActiveTabCloseRollover"];
        iwCloseButtonPressed = [self img:@"InactiveWindow_ActiveTabClosePressed"];
        iwCloseButtonInactive = [self img:@"InactiveWindow_InactiveTabClose"];
        iwCloseButtonOverInactive = [self img:@"InactiveWindow_InactiveTabCloseRollover"];
        iwCloseButtonPressedInactive = [self img:@"InactiveWindow_InactiveTabClosePressed"];
        
        addTabButton = [self img:@"ActiveWindow_AddTabButton"];
        addTabButtonOver = [self img:@"ActiveWindow_AddTabButtonRollover"];
        addTabButtonPressed = [self img:@"ActiveWindow_AddTabButtonRollover_Pressed"];
        iwAddTabButton = [self img:@"InactiveWindow_AddTabButton"];
        
        [addTabButtonOver lockFocus];
        [addTabButton drawAtPoint:NSZeroPoint fromRect:NSMakeRect(1, 0, addTabButtonWidth, addTabButtonHeight)
                             operation:NSCompositeSourceOver fraction:1.0];
        [addTabButtonOver unlockFocus];
        
        NSImage *pushedAddTabButton = [self img:@"ActiveWindow_AddTabButtonPushed"];
        [addTabButtonPressed lockFocus];
        [pushedAddTabButton drawAtPoint:NSZeroPoint fromRect:NSMakeRect(1, 0, addTabButtonWidth, addTabButtonHeight)
                              operation:NSCompositeSourceOver fraction:1.0];
        [addTabButtonPressed unlockFocus];
        
        activeTabFill = [self img:@"ActiveWindow_ActiveTabFill"];
        activeTabLeftCap = [self img:@"ActiveWindow_ActiveTabLeftCap"];
        activeTabRightCap = [self img:@"ActiveWindow_ActiveTabRightCap"];
        iwActiveTabFill = [self img:@"InactiveWindow_ActiveTabFill"];
        iwActiveTabLeftCap = [self img:@"InactiveWindow_ActiveTabLeftCap"];
        iwActiveTabRightCap = [self img:@"InactiveWindow_ActiveTabRightCap"];
        
        inactiveTabLeftCap = [self img:@"ActiveWindow_InactiveTabLeftCap"];
        inactiveTabRightCap = [self img:@"ActiveWindow_InactiveTabRightCap"];
        iwInactiveTabLeftCap = [self img:@"InactiveWindow_InactiveTabLeftCap"];
        iwInactiveTabRightCap = [self img:@"InactiveWindow_InactiveTabRightCap"];
        
        NSImage *bgFill = [self img:@"ActiveWindow_InactiveTabBG"];
        tabBackgroundColor = [NSColor colorWithPatternImage:bgFill];
        
        bgFill = [self img:@"InactiveWindow_InactiveTabBG"];
        iwTabBackgroundColor = [NSColor colorWithPatternImage:bgFill];
    }
    return self;
}

#pragma mark -
#pragma mark Control Specific

- (CGFloat)leftMarginForTabBarControl:(PSMTabBarControl *)tabBarControl {
    return 0.0f;
}

- (CGFloat)rightMarginForTabBarControl:(PSMTabBarControl *)tabBarControl {
    return 0.0f;
}

- (CGFloat)topMarginForTabBarControl:(PSMTabBarControl *)tabBarControl {
    return 0.0f;
}

//- (CGFloat)bottomMarginForTabBarControl:(PSMTabBarControl *)tabBarControl;

//- (NSSize)addTabButtonSizeForTabBarControl:(PSMTabBarControl *)tabBarControl {
//    return NSMakeSize(31, 21);
//}

- (NSRect)addTabButtonRectForTabBarControl:(PSMTabBarControl *)tabBarControl {
    NSRect tabFrame = tabBarControl.bounds;
    return NSMakeRect(tabFrame.origin.x + NSWidth(tabFrame) - addTabButtonWidth - 2,
                      tabFrame.origin.y - NSHeight(tabFrame) + addTabButtonHeight + 2,
                      addTabButtonWidth, addTabButtonHeight);
}

//- (NSSize)overflowButtonSizeForTabBarControl:(PSMTabBarControl *)tabBarControl;
//- (NSRect)overflowButtonRectForTabBarControl:(PSMTabBarControl *)tabBarControl;

#pragma mark -
#pragma mark Constraints

- (CGFloat)minimumWidthOfTabCell:(PSMTabBarCell *)cell {
    return 64.0f;
}

//- (CGFloat)desiredWidthOfTabCell:(PSMTabBarCell *)cell;

#pragma mark -
#pragma mark Add Tab Button

- (NSImage *)addTabButtonImage {
    return addTabButton;
}

- (NSImage *)addTabButtonPressedImage {
    return addTabButtonPressed;
}

- (NSImage *)addTabButtonRolloverImage {
    return addTabButtonOver;
}

#pragma mark -
#pragma mark Drag Support

- (NSRect)dragRectForTabCell:(PSMTabBarCell *)cell ofTabBarControl:(PSMTabBarControl *)tabBarControl {
    NSRect dragRect = [cell frame];
    
    dragRect.size.width -= capWidth/2 - 2;
    dragRect.origin.x += capWidth/2 + 2;
    return dragRect;
}

#pragma mark -
#pragma mark Providing Images

- (NSImage *)closeButtonImageOfType:(PSMCloseButtonImageType)type forTabCell:(PSMTabBarCell *)cell {
    BOOL selected = ([cell state] == NSOnState);
    BOOL active = [cell controlView].isWindowActive;
    
    switch (type) {
        case PSMCloseButtonImageTypeDirty:
        case PSMCloseButtonImageTypeStandard:
            if (active) {
                return selected ? closeButton : closeButtonInactive;
            } else {
                return selected ? iwCloseButton : iwCloseButtonInactive;
            }
        case PSMCloseButtonImageTypeDirtyRollover:
        case PSMCloseButtonImageTypeRollover:
            if (active) {
                return selected ? closeButtonOver : closeButtonOverInactive;
            } else {
                return selected ? iwCloseButtonOver : iwCloseButtonOverInactive;
            }
        case PSMCloseButtonImageTypeDirtyPressed:
        case PSMCloseButtonImageTypePressed:
            if (active) {
                return selected ? closeButtonPressed : closeButtonPressedInactive;
            } else {
                return selected ? iwCloseButtonPressed : iwCloseButtonPressedInactive;
            }
    }
}

#pragma mark -
#pragma mark Determining Cell Size

//- (CGFloat)heightOfTabCellsForTabBarControl:(PSMTabBarControl *)tabBarControl;

- (NSRect)drawingRectForBounds:(NSRect)rect ofTabCell:(PSMTabBarCell *)cell {
    rect.origin.x += capWidth;
    rect.origin.y += 1;
    rect.size.width -= capWidth;
    return rect;
}

//- (NSRect)titleRectForBounds:(NSRect)theRect ofTabCell:(PSMTabBarCell *)cell;
//- (NSRect)iconRectForBounds:(NSRect)theRect ofTabCell:(PSMTabBarCell *)cell;
//- (NSRect)largeImageRectForBounds:(NSRect)theRect ofTabCell:(PSMTabBarCell *)cell;
//- (NSRect)indicatorRectForBounds:(NSRect)theRect ofTabCell:(PSMTabBarCell *)cell;
//- (NSSize)objectCounterSizeOfTabCell:(PSMTabBarCell *)cell;
//- (NSRect)objectCounterRectForBounds:(NSRect)theRect ofTabCell:(PSMTabBarCell *)cell;

//- (NSRect)closeButtonRectForBounds:(NSRect)rect ofTabCell:(PSMTabBarCell *)cell {
//    return NSMakeRect(rect.origin.x + 12, rect.origin.y + NSHeight(rect)/2 - 5, 12, 13);
//}

#pragma mark -
#pragma mark Drawing

//- (void)drawTabBarControl:(PSMTabBarControl *)tabBarControl inRect:(NSRect)rect;

- (void)drawBezelOfTabBarControl:(PSMTabBarControl *)tabBarControl inRect:(NSRect)rect {
    NSRect frame = tabBarControl.bounds;
    NSRect fill = NSMakeRect(frame.origin.x, frame.origin.y, NSWidth(frame), capHeight);
    
    [NSGraphicsContext saveGraphicsState];
    if (tabBarControl.isWindowActive) {
        [tabBackgroundColor set];
    } else {
        [iwTabBackgroundColor set];
    }
    NSRectFill(fill);
    [NSGraphicsContext restoreGraphicsState];
}

//- (void)drawInteriorOfTabBarControl:(PSMTabBarControl *)tabBarControl inRect:(NSRect)rect {}

- (void)drawBezelOfTabCell:(PSMTabBarCell *)cell withFrame:(NSRect)frame inTabBarControl:(PSMTabBarControl *)tabBarControl {
    NSUInteger cellIndex = [tabBarControl.cells indexOfObject:cell];
    __block NSUInteger selCellIndex = 0;
    [tabBarControl.cells enumerateObjectsUsingBlock:^(id obj, NSUInteger index, BOOL *stop) {
        if ([obj state] == NSOnState) {
            selCellIndex = index;
            *stop = YES;
        }
    }];
    
    NSRect fill = NSMakeRect(frame.origin.x, frame.origin.y, NSWidth(frame), capHeight);
    NSRect leftCap = NSMakeRect(frame.origin.x, frame.origin.y, capWidth, capHeight);
    NSRect rightCap = NSMakeRect(frame.origin.x + NSWidth(frame), frame.origin.y, capWidth, capHeight);
    
//    NSLog(@"draw: %ld, sel=%d, lsel=%d, rsel=%d, l=%d, m=%d, r=%d, s=%d", cellIndex,
//          (cell.tabState & PSMTab_SelectedMask) == PSMTab_SelectedMask,
//          (cell.tabState & PSMTab_LeftIsSelectedMask) == PSMTab_LeftIsSelectedMask,
//          (cell.tabState & PSMTab_RightIsSelectedMask) == PSMTab_RightIsSelectedMask,
//          (cell.tabState & PSMTab_PositionLeftMask) == PSMTab_PositionLeftMask,
//          (cell.tabState & PSMTab_PositionMiddleMask) == PSMTab_PositionMiddleMask,
//          (cell.tabState & PSMTab_PositionRightMask) == PSMTab_PositionRightMask,
//          (cell.tabState & PSMTab_PositionSingleMask) == PSMTab_PositionSingleMask);
    
    if([cell state] == NSOnState) { // Selected Tab
        fill.origin.x += capWidth;
        fill.size.width -= capWidth;
        
        NSImage *fillImage = activeTabFill;
        NSImage *leftCapImage = activeTabLeftCap;
        NSImage *rightCapImage = activeTabRightCap;
        if (!tabBarControl.isWindowActive) {
            fillImage = iwActiveTabFill;
            leftCapImage = iwActiveTabLeftCap;
            rightCapImage = iwActiveTabRightCap;
        }
        
        [fillImage drawInRect:fill fromRect:NSMakeRect(0, 0, 64.0, capHeight) operation:NSCompositeSourceOver fraction:1.0 respectFlipped:YES hints:nil];
        [leftCapImage drawInRect:leftCap fromRect:NSMakeRect(0, 0, capWidth, capHeight) operation:NSCompositeSourceOver fraction:1.0 respectFlipped:YES hints:nil];
        [rightCapImage drawInRect:rightCap fromRect:NSMakeRect(0, 0, capWidth, capHeight) operation:NSCompositeSourceOver fraction:1.0 respectFlipped:YES hints:nil];
    } else { // Unselected Tab
        if (cellIndex > 0 && cellIndex < selCellIndex) {
            NSImage *img = tabBarControl.isWindowActive ? inactiveTabLeftCap : iwInactiveTabLeftCap;
            [img drawInRect:leftCap fromRect:NSMakeRect(0, 0, capWidth, capHeight) operation:NSCompositeSourceOver fraction:1.0 respectFlipped:YES hints:nil];
        }
        
        if (cellIndex > selCellIndex) {
            NSImage *img = tabBarControl.isWindowActive ? inactiveTabRightCap : iwInactiveTabRightCap;
            [img drawInRect:rightCap fromRect:NSMakeRect(0, 0, capWidth, capHeight) operation:NSCompositeSourceOver fraction:1.0 respectFlipped:YES hints:nil];
        }
    }
}

//- (void)drawBezelOfTabCell:(PSMTabBarCell *)cell withFrame:(NSRect)frame inTabBarControl:(PSMTabBarControl *)tabBarControl {}
//- (void)drawInteriorOfTabCell:(PSMTabBarCell *)cell withFrame:(NSRect)frame inTabBarControl:(PSMTabBarControl *)tabBarControl {}
//- (void)drawTitleOfTabCell:(PSMTabBarCell *)cell withFrame:(NSRect)frame inTabBarControl:(PSMTabBarControl *)tabBarControl;
//- (void)drawIconOfTabCell:(PSMTabBarCell *)cell withFrame:(NSRect)frame inTabBarControl:(PSMTabBarControl *)tabBarControl;
//- (void)drawLargeImageOfTabCell:(PSMTabBarCell *)cell withFrame:(NSRect)frame inTabBarControl:(PSMTabBarControl *)tabBarControl;
//- (void)drawIndicatorOfTabCell:(PSMTabBarCell *)cell withFrame:(NSRect)frame inTabBarControl:(PSMTabBarControl *)tabBarControl;
//- (void)drawObjectCounterOfTabCell:(PSMTabBarCell *)cell withFrame:(NSRect)frame inTabBarControl:(PSMTabBarControl *)tabBarControl;
//- (void)drawCloseButtonOfTabCell:(PSMTabBarCell *)cell withFrame:(NSRect)frame inTabBarControl:(PSMTabBarControl *)tabBarControl;

#pragma mark -
#pragma mark Archiving

- (void)encodeWithCoder:(NSCoder *)coder {
    if([coder allowsKeyedCoding]) {
        [coder encodeObject:closeButton forKey:@"safariCloseButton"];
        [coder encodeObject:closeButtonOver forKey:@"safariCloseButtonOver"];
        [coder encodeObject:closeButtonPressed forKey:@"safariCloseButtonPressed"];
        [coder encodeObject:closeButtonInactive forKey:@"safariCloseButtonInactive"];
        [coder encodeObject:closeButtonOverInactive forKey:@"safariCloseButtonOverInactive"];
        [coder encodeObject:closeButtonPressedInactive forKey:@"safariCloseButtonPressedInactive"];
        [coder encodeObject:iwCloseButton forKey:@"safariiwCloseButton"];
        [coder encodeObject:iwCloseButtonOver forKey:@"safariiwCloseButtonOver"];
        [coder encodeObject:iwCloseButtonPressed forKey:@"safariiwCloseButtonPressed"];
        [coder encodeObject:iwCloseButtonInactive forKey:@"safariiwCloseButtonInactive"];
        [coder encodeObject:iwCloseButtonOverInactive forKey:@"safariiwCloseButtonOverInactive"];
        [coder encodeObject:iwCloseButtonPressedInactive forKey:@"safariiwCloseButtonPressedInactive"];
        [coder encodeObject:addTabButton forKey:@"safariAddTabButtonImage"];
        [coder encodeObject:addTabButtonPressed forKey:@"safariAddTabButtonPressedImage"];
        [coder encodeObject:addTabButtonOver forKey:@"safariAddTabButtonOverImage"];
        [coder encodeObject:iwAddTabButton forKey:@"safariiwAddTabButtonImage"];
        [coder encodeObject:activeTabFill forKey:@"safariActiveTabFill"];
        [coder encodeObject:activeTabLeftCap forKey:@"safariActiveTabLeftCap"];
        [coder encodeObject:activeTabRightCap forKey:@"safariActiveTabRightCap"];
        [coder encodeObject:iwActiveTabFill forKey:@"safariiwActiveTabFill"];
        [coder encodeObject:iwActiveTabLeftCap forKey:@"safariiwActiveTabLeftCap"];
        [coder encodeObject:iwActiveTabRightCap forKey:@"safariiwActiveTabRightCap"];
        [coder encodeObject:inactiveTabLeftCap forKey:@"safariInactiveTabLeftCap"];
        [coder encodeObject:inactiveTabRightCap forKey:@"safariInactiveTabRightCap"];
        [coder encodeObject:iwInactiveTabLeftCap forKey:@"safariiwInactiveTabLeftCap"];
        [coder encodeObject:iwInactiveTabRightCap forKey:@"safariiwInactiveTabRightCap"];
        [coder encodeObject:tabBackgroundColor forKey:@"safariTabBackgroundColor"];
        [coder encodeObject:iwTabBackgroundColor forKey:@"safariiwTabBackgroundColor"];
    }
}

- (instancetype)initWithCoder:(NSCoder *)decoder {
    if([decoder allowsKeyedCoding]) {
        closeButton = [decoder decodeObjectForKey:@"safariCloseButton"];
        closeButtonOver = [decoder decodeObjectForKey:@"safariCloseButtonOver"];
        closeButtonPressed = [decoder decodeObjectForKey:@"safariCloseButtonPressed"];
        closeButtonInactive = [decoder decodeObjectForKey:@"safariCloseButtonInactive"];
        closeButtonOverInactive = [decoder decodeObjectForKey:@"safariCloseButtonOverInactive"];
        closeButtonPressedInactive = [decoder decodeObjectForKey:@"safariCloseButtonPressedInactive"];
        iwCloseButton = [decoder decodeObjectForKey:@"safariiwCloseButton"];
        iwCloseButtonOver = [decoder decodeObjectForKey:@"safariiwCloseButtonOver"];
        iwCloseButtonPressed = [decoder decodeObjectForKey:@"safariiwCloseButtonPressed"];
        iwCloseButtonInactive = [decoder decodeObjectForKey:@"safariiwCloseButtonInactive"];
        iwCloseButtonOverInactive = [decoder decodeObjectForKey:@"safariiwCloseButtonOverInactive"];
        iwCloseButtonPressedInactive = [decoder decodeObjectForKey:@"safariiwCloseButtonPressedInactive"];
        addTabButton = [decoder decodeObjectForKey:@"safariAddTabButtonImage"];
        addTabButtonPressed = [decoder decodeObjectForKey:@"safariAddTabButtonPressedImage"];
        addTabButtonOver = [decoder decodeObjectForKey:@"safariAddTabButtonOverImage"];
        iwAddTabButton = [decoder decodeObjectForKey:@"safariiwAddTabButtonImage"];
        activeTabFill = [decoder decodeObjectForKey:@"safariActiveTabFill"];
        activeTabLeftCap = [decoder decodeObjectForKey:@"safariActiveTabLeftCap"];
        activeTabRightCap = [decoder decodeObjectForKey:@"safariActiveTabRightCap"];
        iwActiveTabFill = [decoder decodeObjectForKey:@"safariiwActiveTabFill"];
        iwActiveTabLeftCap = [decoder decodeObjectForKey:@"safariiwActiveTabLeftCap"];
        iwActiveTabRightCap = [decoder decodeObjectForKey:@"safariiwActiveTabRightCap"];
        inactiveTabLeftCap = [decoder decodeObjectForKey:@"safariInactiveTabLeftCap"];
        inactiveTabRightCap = [decoder decodeObjectForKey:@"safariInactiveTabRightCap"];
        iwInactiveTabLeftCap = [decoder decodeObjectForKey:@"safariiwInactiveTabLeftCap"];
        iwInactiveTabRightCap = [decoder decodeObjectForKey:@"safariiwInactiveTabRightCap"];
        tabBackgroundColor = [decoder decodeObjectForKey:@"safariTabBackgroundColor"];
        iwTabBackgroundColor = [decoder decodeObjectForKey:@"safariiwTabBackgroundColor"];
    }
    return self;
}

@end
