//
//  MVPAppDelegate.m
//  MVParser
//

#import "MVPAppDelegate.h"
#import "MVPTools.h"

#import "MVPReader.h"
#import "MVPInterpreter.h"
#import "MVPLanguageLogo.h"

@implementation MVPAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    MVPReader * s = [MVPReader readerWithString: @"  print   12.2, \" abc \"  ;   print 23.3; \t print \t 33.4; "];
    
    MVPInterpreter * i = [MVPInterpreter interpreterWithLanguage: [MVPLanguageLogo new]];
    
    if ([i parseFromReader: s]) {
        DLog(@"Program: \n%@", i.program);
        [i.program run];
    }
}

- (IBAction)qqq:(id)sender {
}
@end
