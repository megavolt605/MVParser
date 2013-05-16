//
// MVlib
//
// MVTools.m
//

#import "MVPTools.h"

@implementation MVTools

static MVTools * sharedInstance;

+ (MVTools *) sharedInstance {
    if (sharedInstance == nil) {
        sharedInstance = [[[self class] alloc] init];
    }
    return sharedInstance;
}

+ (id) allocWithZone: (NSZone *) zone {
    if (sharedInstance == nil) {
        sharedInstance = [super allocWithZone: zone];
        return sharedInstance;
    }
    return nil;
}

- (void) hlogEnter {
    _padding++;
}

- (void) hlogLeave {
    _padding--;
}

- (NSString *) hlogPadding {
    return [@"" stringByPaddingToLength: _padding*2 withString: @" " startingAtIndex: 0];
}


@end
