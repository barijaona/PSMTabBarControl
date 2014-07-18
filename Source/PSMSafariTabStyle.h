//
//  PSMSafariTabStyle.h
//  PSMTabBarControl
//
//  Created by Hejki on 16.07.14.
//
//

#import <Cocoa/Cocoa.h>
#import "PSMTabStyle.h"

@interface PSMSafariTabStyle : NSObject <PSMTabStyle>

- (void)encodeWithCoder:(NSCoder *)aCoder;
- (instancetype)initWithCoder:(NSCoder *)aDecoder;

@end
