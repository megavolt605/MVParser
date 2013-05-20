//
// MVlib
//
// MVTools.h
//

#import <Foundation/Foundation.h>

#ifndef DEBUG
#   define DEBUG
#endif

#define VERBOSE_LOG_

// синглтон для обеспечения работы иерархического протокола
@interface MVTools : NSObject 

+ (MVTools *) sharedInstance;

- (void) hlogEnter;
- (void) hlogLeave;
- (NSString *) hlogPadding;

@property (assign) NSUInteger padding;

@end

// DLog: обертка для NSLog (только при установленной директиве DEBUG)
//		 если установлена директива VERBOSE_LOG, выводится расширенная информация
//		 о названии модуля и номере строки вызова
#ifdef DEBUG
#   ifdef VERBOSE_LOG
#       define DLog(fmt, ...) NSLog((@"%s [Line %5d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#   else
#       define DLog(fmt, ...) NSLog(fmt, ##__VA_ARGS__);
#   endif

#   ifdef VERBOSE_LOG
#       define DHLog(fmt, ...) NSLog((@"%s [Line %5d] %@" fmt), __PRETTY_FUNCTION__, __LINE__, [MVTools sharedInstance].hlogPadding, ##__VA_ARGS__);
#   else
#       define DHLog(fmt, ...) NSLog((@"%@" fmt), [MVTools sharedInstance].hlogPadding, ##__VA_ARGS__);
#   endif
#else
#   define DLog(...)
#   define DHLog(...)
#endif

// ALog: обертка для NSLog
//		 если установлена директива VERBOSE_LOG, выводится расширенная информация
//		 о названии модуля и номере строки вызова
#ifdef VERBOSE_LOG
#   define ALog(fmt, ...) NSLog((@"%s [Line %5d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#   define AHLog(fmt, ...) NSLog((@"%s [Line %5d] %@" fmt), __PRETTY_FUNCTION__, __LINE__, [MVTools sharedInstance].hlogPadding, ##__VA_ARGS__);
#else
#   define ALog(fmt, ...) NSLog(fmt, ##__VA_ARGS__);
#   define AHLog(fmt, ...) NSLog((@"%@" fmt), [MVTools sharedInstance].hlogPadding, ##__VA_ARGS__);
#endif

// макрос для директивы VERBODE_LOG
#ifdef VERBOSE_LOG
#   define VERBOSE(a) a
#else
#   define VERBOSE(a)
#endif

// макрос управления иерархией протокола
#define DLogEnter() [[MVTools sharedInstance] hlogEnter];
#define DLogLeave() [[MVTools sharedInstance] hlogLeave];

// сообщение о вызове абстрактного метода
#ifndef AbstractError
#   define AbstractError DLog(@"ERROR: Abstract method %@.%s [Line %5d] ", [self class], __PRETTY_FUNCTION__, __LINE__);
#endif

#ifndef DAssertClass
#   define DAssertClass(obj, cls, res) NSAssert([obj isKindOfClass: [cls class]], @"Object %@ needs to be kind of %@ class", obj, [cls class]); \
           cls * res = (cls *) obj;
#endif

#ifndef DAssertProtocol
#   define DAssertPrototol(obj, prot) NSAssert([obj conformsToProtocol: @protocol(prot)], @"Object %@ needs to be confirm to %@ protocol", obj, @"prot"); \
        MVPToken <prot> * res = (MVPToken <prot> *) obj;
#endif

