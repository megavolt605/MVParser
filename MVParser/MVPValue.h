//
//  MVPValue.h
//  MVParser
//

#import <Foundation/Foundation.h>

@interface MVPValue : NSObject <NSCopying> 

+ (MVPValue *) valueWithString: (NSString *) string;
- (id) initWithString: (NSString *) string;

@property (readonly) NSString * stringValue;

@end
