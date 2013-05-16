//
//  MVPToken.h
//  MVParser
//
//  --------------------------------
//  Абстрактный оператор в программе

#import <Foundation/Foundation.h>
#import "MVPTokenProtocols.h"
#import "MVPReader.h"
#import "MVPVariable.h"

@class MVPToken, MVPValue, MVPInterpreter, MVPTokenStatement, MVPLanguage;

@interface MVPToken : NSObject <NSCoding>

#pragma mark -
#pragma mark Интерпретация

+ (MVPToken *) tokenDefWithLanguage: (MVPLanguage *) language;
- (id) initWithLanguage: (MVPLanguage *) language;

- (MVPToken *) interpreter: (MVPInterpreter *) interpreter readFromReader: (MVPReader *) reader;

@property Boolean isOptional;

@property (readonly) MVPLanguage * language;

#pragma mark -
#pragma mark Выполнение

+ (MVPToken *) tokenWithInterpreter: (MVPInterpreter *) interpreter;
- (id) initWithInterpreter: (MVPInterpreter *) interpreter;


- (NSUInteger) startPosition;
- (void) setStartPosition: (NSUInteger) startPosition;
- (NSUInteger) length;
- (void) setLength: (NSUInteger) length;

@property (readonly) MVPInterpreter * interpreter;
@property NSUInteger startPosition;
@property NSUInteger length;

@end
