//
//  NSContainers+DebugPrint.m
//
//  Created by Christopher Miller on 1/30/12.
//  Copyright (c) 2012 Christopher Miller. All rights reserved.
//

#import "NSContainers+DebugPrint.h"

#ifdef DEBUGPRINT_ANY

#ifdef DEBUGPRINT_NO_SUPPRESS_WHITESPACE_ALL
bool __fspp_suppressWhitespaceAll = false;
#else
bool __fspp_suppressWhitespaceAll = true;
#endif

#ifdef DEBUGPRINT_NO_SUPPRESS_WHITESPACE_NSARRAY
bool __fspp_suppressWhitespaceArray = false;
#else
bool __fspp_suppressWhitespaceArray = true;
#endif

#ifdef DEBUGPRINT_NO_SUPPRESS_WHITESPACE_NSDICTIONARY
bool __fspp_suppressWhitespaceDictionary = false;
#else
bool __fspp_suppressWhitespaceDictionary = true;
#endif

#ifdef DEBUGPRINT_NO_SUPPRESS_WHITESPACE_NSSET
bool __fspp_suppressWhitespaceSet = false;
#else
bool __fspp_suppressWhitespaceSet = true;
#endif

#ifdef DEBUGPRINT_NO_SUPPRESS_WHITESPACE_NSORDEREDSET
bool __fspp_suppressWhitespaceOrderedSet = false;
#else
bool __fspp_suppressWhitespaceOrderedSet = true;
#endif

#ifdef DEBUGPRINT_NO_SUPPRESS_WHITESPACE_OBJECT
bool __fspp_suppressWhitespaceObject = false;
#else
bool __fspp_suppressWhitespaceObject = true;
#endif

bool fspp_suppressWhitespace(enum __fspp_type t)
{
    if (__fspp_suppressWhitespaceAll) return true;
    switch (t) {
        case fspp_all:
            return __fspp_suppressWhitespaceAll;
            break;
        case fspp_array:
            return __fspp_suppressWhitespaceArray;
            break;
        case fspp_dictionary:
            return __fspp_suppressWhitespaceDictionary;
            break;
        case fspp_set:
            return __fspp_suppressWhitespaceSet;
            break;
        case fspp_orderedSet:
            return __fspp_suppressWhitespaceOrderedSet;
            break;
        case fspp_object:
            return __fspp_suppressWhitespaceObject;
            break;
            
        default:
            NSCAssert(true==false, @"Not a valid");
            break;
    }
    
    return false;
}

void fspp_setSuppressesWhitespace(enum __fspp_type t, bool shouldSuppress)
{
    switch (t) {
        case fspp_all:
            __fspp_suppressWhitespaceAll = shouldSuppress;
            break;
        case fspp_array:
            __fspp_suppressWhitespaceArray = shouldSuppress;
            break;
        case fspp_dictionary:
            __fspp_suppressWhitespaceDictionary = shouldSuppress;
            break;
        case fspp_set:
            __fspp_suppressWhitespaceSet = shouldSuppress;
            break;
        case fspp_orderedSet:
            __fspp_suppressWhitespaceOrderedSet = shouldSuppress;
            break;
        case fspp_object:
            __fspp_suppressWhitespaceObject = shouldSuppress;
            break;
            
        default:
            NSCAssert(true==false, @"Not a valid");
            break;
    }
}

#endif

#ifdef DEBUGPRINT_SWIZZLE
#import "JRSwizzle.h"
static bool __fspp_swizzled=false;
bool fspp_swizzleContainerPrinters(NSError ** error)
{
    Class nsarray_class, nsmutablearray_class, nsdictionary_class, nsmutabledictionary_class, nsset_class, nsmutableset_class, nsorderedset_class, nsmutableorderedset_class;
    @autoreleasepool {
        nsarray_class = [[NSArray array] class];
        nsmutablearray_class = [[NSMutableArray array] class];
        nsdictionary_class = [[NSDictionary dictionary] class];
        nsmutabledictionary_class = [[NSMutableDictionary dictionary] class];
        nsset_class = [[NSSet set] class];
        nsmutableset_class = [[NSMutableSet set] class];
        nsorderedset_class = [[NSOrderedSet orderedSet] class];
        nsmutableorderedset_class = [[NSMutableOrderedSet orderedSet] class];
    }
    
    [nsarray_class jr_swizzleMethod:@selector(descriptionWithLocale:indent:) withMethod:@selector(fs_descriptionWithLocale:indent:) error:error];
    if (*error) return false;
    if (nsarray_class != nsmutablearray_class) {
        [nsmutablearray_class jr_swizzleMethod:@selector(descriptionWithLocale:indent:) withMethod:@selector(fs_descriptionWithLocale:indent:) error:error];
        if (*error) return false;
    }
    
    [nsdictionary_class jr_swizzleMethod:@selector(descriptionWithLocale:indent:) withMethod:@selector(fs_descriptionWithLocale:indent:) error:error];
    if (*error) return false;
    if (nsdictionary_class != nsmutabledictionary_class) {
        [nsmutabledictionary_class jr_swizzleMethod:@selector(descriptionWithLocale:indent:) withMethod:@selector(fs_descriptionWithLocale:indent:) error:error];
        if (*error) return false;
    }
    
    [nsset_class jr_swizzleMethod:@selector(descriptionWithLocale:indent:) withMethod:@selector(fs_descriptionWithLocale:indent:) error:error];
    if (*error) return false;
    if (nsset_class != nsmutableset_class) {
        [nsmutableset_class jr_swizzleMethod:@selector(descriptionWithLocale:indent:) withMethod:@selector(fs_descriptionWithLocale:indent:) error:error];
        if (*error) return false;
    }
    
    [nsorderedset_class jr_swizzleMethod:@selector(descriptionWithLocale:indent:) withMethod:@selector(fs_descriptionWithLocale:indent:) error:error];
    if (*error) return false;
    if (nsorderedset_class != nsmutableorderedset_class) {
        [nsmutableorderedset_class jr_swizzleMethod:@selector(descriptionWithLocale:indent:) withMethod:@selector(fs_descriptionWithLocale:indent:) error:error];
        if (*error) return false;
    }
    __fspp_swizzled = !__fspp_swizzled;
    return true;
}
bool fspp_on(void)
{
  return __fspp_swizzled;
}
#endif

#ifdef DEBUGPRINT_ANY
#ifdef DEBUGPRINT_SPACES_PER_INDENT
NSUInteger fspp_spacesPerIndent = DEBUGPRINT_SPACES_PER_INDENT;
#else
NSUInteger fspp_spacesPerIndent = 4;
#endif
#endif

#if defined(DEBUGPRINT_NSARRAY) || defined(DEBUGPRINT_ALL) || defined(DEBUGPRINT_SWIZZLE)
@interface NSArray (__DebugPrint__)
- (NSString *)fs_descriptionWithLocale:(id)locale indent:(NSUInteger)level;
- (NSString *)fs_descriptionWithLocale__impl:(id)locale indent:(NSUInteger)level;
@end
@interface NSMutableArray (__DebugPrint__)
- (NSString *)fs_descriptionWithLocale:(id)locale indent:(NSUInteger)level;
@end
#endif

#if defined(DEBUGPRINT_NSDICTIONARY) || defined(DEBUGPRINT_ALL) || defined(DEBUGPRINT_SWIZZLE)
@interface NSDictionary (__DebugPrint__)
- (NSString *)fs_descriptionWithLocale:(id)locale indent:(NSUInteger)level;
- (NSString *)fs_descriptionWithLocale__impl:(id)locale indent:(NSUInteger)level;
@end
@interface NSMutableDictionary (__DebugPrint__)
#ifndef DEBUGPRINT_SWIZZLE
- (NSString *)descriptionWithLocale:(id)locale indent:(NSUInteger)level;
#endif
- (NSString *)fs_descriptionWithLocale:(id)locale indent:(NSUInteger)level;
@end
#endif

#if defined(DEBUGPRINT_NSSET) || defined(DEBUGPRINT_ALL) || defined(DEBUGPRINT_SWIZZLE)
@interface NSSet (__DebugPrint__)
- (NSString *)fs_descriptionWithLocale:(id)locale indent:(NSUInteger)level;
- (NSString *)fs_descriptionWithLocale__impl:(id)locale indent:(NSUInteger)level;
@end
@interface NSMutableSet (__DebugPrint__)
- (NSString *)fs_descriptionWithLocale:(id)locale indent:(NSUInteger)level;
@end
#endif

#if defined(DEBUGPRINT_NSORDEREDSET) || defined(DEBUGPRINT_ALL) || defined(DEBUGPRINT_SWIZZLE)
@interface NSOrderedSet (__DebugPrint__)
- (NSString *)fs_descriptionWithLocale:(id)locale indent:(NSUInteger)level;
- (NSString *)fs_descriptionWithLocale__impl:(id)locale indent:(NSUInteger)level;
@end
@interface NSMutableOrderedSet (__DebugPrint__)
- (NSString *)fs_descriptionWithLocale:(id)locale indent:(NSUInteger)level;
@end
#endif

#if defined(DEBUGPRINT_NSARRAY) || defined(DEBUGPRINT_ALL) || defined(DEBUGPRINT_SWIZZLE)
@implementation NSArray (DebugPrint)
#ifndef DEBUGPRINT_SWIZZLE
- (NSString *)descriptionWithLocale:(id)locale indent:(NSUInteger)level
{
    return [self fs_descriptionWithLocale__impl:locale indent:level];
}
#endif
- (NSString *)fs_descriptionWithLocale:(id)locale indent:(NSUInteger)level
{
    return [self fs_descriptionWithLocale__impl:locale indent:level];
}
- (NSString *)fs_descriptionWithLocale__impl:(id)locale indent:(NSUInteger)level
{
    NSMutableString * str = [[NSMutableString alloc] init];
    Class __strClass = [NSString class];
    NSString * indent = [NSString fs_stringByFillingWithCharacter:' ' repeated:fspp_spacesPerIndent*level];
    __block NSString * tmpString;

    [str appendFormat:@"%@(\n", indent];

    NSUInteger lastObjectIndex = [self count]-1;
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([obj isKindOfClass:__strClass])
            tmpString = [obj fs_stringByEscaping];
        else if ([obj respondsToSelector:@selector(descriptionWithLocale:indent:)])
            tmpString = [obj descriptionWithLocale:locale indent:level+1];
        else if ([obj respondsToSelector:@selector(descriptionWithLocale:)])
            tmpString = [[obj descriptionWithLocale:locale] fs_stringByEscaping];
        else if ([obj conformsToProtocol:@protocol(FSDescriptionDict)])
            tmpString = [[obj fs_descriptionDictionary] descriptionWithLocale:locale indent:level+1];
        else
            tmpString = [[obj description] fs_stringByEscaping];
        
        if (fspp_suppressWhitespace(fspp_array))
            tmpString = [tmpString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];

        [str appendFormat:@"%@    %@%@\n", indent, tmpString, (idx==lastObjectIndex)?@"":@","];
    }];

    [str appendFormat:@"%@)", indent];

    return str;
}
@end
@implementation NSMutableArray (DebugPrint)
#ifndef DEBUGPRINT_SWIZZLE
- (NSString *)descriptionWithLocale:(id)locale indent:(NSUInteger)level
{
    return [self fs_descriptionWithLocale__impl:locale indent:level];
}
#endif
- (NSString *)fs_descriptionWithLocale:(id)locale indent:(NSUInteger)level
{
    return [self fs_descriptionWithLocale__impl:locale indent:level];
}
@end
#endif

#if defined(DEBUGPRINT_NSDICTIONARY) || defined(DEBUGPRINT_ALL) || defined(DEBUGPRINT_SWIZZLE)
@implementation NSDictionary (DebugPrint)
#ifndef DEBUGPRINT_SWIZZLE
- (NSString *)descriptionWithLocale:(id)locale indent:(NSUInteger)level
{
    return [self fs_descriptionWithLocale__impl:locale indent:level];
}
#endif
- (NSString *)fs_descriptionWithLocale:(id)locale indent:(NSUInteger)level
{
    return [self fs_descriptionWithLocale__impl:locale indent:level];
}
- (NSString *)fs_descriptionWithLocale__impl:(id)locale indent:(NSUInteger)level
{
    NSMutableString * str = [[NSMutableString alloc] init];
    NSString * indent = [NSString fs_stringByFillingWithCharacter:' ' repeated:fspp_spacesPerIndent*level];

    [str fs_appendDictionaryStartWithIndentString:indent];

    [self enumerateKeysAndObjectsUsingBlock:^(id _key, id _value, BOOL *stop) {
        [str fs_appendDictionaryKey:_key value:_value locale:locale indentString:indent indentLevel:level+1 whitespaceSuppression:fspp_suppressWhitespace(fspp_dictionary)];
    }];

    [str fs_appendDictionaryEndWithIndentString:indent];

    return str;
}
@end
@implementation NSMutableDictionary (DebugPrint)
#ifndef DEBUGPRINT_SWIZZLE
- (NSString *)descriptionWithLocale:(id)locale indent:(NSUInteger)level
{
    return [self fs_descriptionWithLocale__impl:locale indent:level];
}
#endif
- (NSString *)fs_descriptionWithLocale:(id)locale indent:(NSUInteger)level
{
    return [self fs_descriptionWithLocale__impl:locale indent:level];
}
@end
#endif

#if defined(DEBUGPRINT_NSSET) || defined(DEBUGPRINT_ALL) || defined (DEBUGPRINT_SWIZZLE)
@implementation NSSet (DebugPrint)
#ifndef DEBUGPRINT_SWIZZLE
- (NSString *)descriptionWithLocale:(id)locale indent:(NSUInteger)level
{
    return [self fs_descriptionWithLocale__impl:locale indent:level];
}
#endif
- (NSString *)fs_descriptionWithLocale:(id)locale indent:(NSUInteger)level
{
    return [self fs_descriptionWithLocale__impl:locale indent:level];
}
- (NSString *)fs_descriptionWithLocale__impl:(id)locale indent:(NSUInteger)level
{
    NSMutableString * str = [[NSMutableString alloc] init];
    NSString * indent = [NSString fs_stringByFillingWithCharacter:' ' repeated:fspp_spacesPerIndent*level];
    
    Class __strClass = [NSString class];
    __block NSString * tmpString;
    NSUInteger count = [self count];
    __block NSUInteger idx = 0;
    
    [str appendFormat:@"%@{(\n", indent];
    
    [self enumerateObjectsUsingBlock:^(id obj, BOOL *stop) {
        if ([obj isKindOfClass:__strClass])
            tmpString = [obj fs_stringByEscaping];
        else if ([obj respondsToSelector:@selector(descriptionWithLocale:indent:)])
            tmpString = [obj descriptionWithLocale:locale indent:level+1];
        else if ([obj respondsToSelector:@selector(descriptionWithLocale:)])
            tmpString = [[obj descriptionWithLocale:locale] fs_stringByEscaping];
        else if ([obj conformsToProtocol:@protocol(FSDescriptionDict)])
            tmpString = [[obj fs_descriptionDictionary] descriptionWithLocale:locale indent:level+1];
        else
            tmpString = [[obj description] fs_stringByEscaping];
        
        if (fspp_suppressWhitespace(fspp_set))
            tmpString = [tmpString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        
        [str appendFormat:@"%@    %@", indent, tmpString];
        if (idx+1 == count)
            [str appendString:@"\n"];
        else
            [str appendString:@",\n"];
        
        idx++;
    }];
    
    [str appendFormat:@"%@)}", indent];
    
    return str;
}
@end
@implementation NSMutableSet (DebugPrint)
#ifndef DEBUGPRINT_SWIZZLE
- (NSString *)descriptionWithLocale:(id)locale indent:(NSUInteger)level
{
    return [self fs_descriptionWithLocale__impl:locale indent:level];
}
#endif
- (NSString *)fs_descriptionWithLocale:(id)locale indent:(NSUInteger)level
{
    return [self fs_descriptionWithLocale__impl:locale indent:level];
}
@end
#endif

#if defined(DEBUGPRINT_NSORDEREDSET) || defined(DEBUGPRINT_ALL) || defined(DEBUGPRINT_SWIZZLE)
@implementation NSOrderedSet (DebugPrint)
#ifndef DEBUGPRINT_SWIZZLE
- (NSString *)descriptionWithLocale:(id)locale indent:(NSUInteger)level
{
    return [self fs_descriptionWithLocale__impl:locale indent:level];
}
#endif
- (NSString *)fs_descriptionWithLocale:(id)locale indent:(NSUInteger)level
{
    return [self fs_descriptionWithLocale__impl:locale indent:level];
}
- (NSString *)fs_descriptionWithLocale__impl:(id)locale indent:(NSUInteger)level
{
    NSMutableString * str = [[NSMutableString alloc] init];
    NSString * indent = [NSString fs_stringByFillingWithCharacter:' ' repeated:fspp_spacesPerIndent*level];
    
    Class __strClass = [NSString class];
    __block NSString * tmpString;
    NSUInteger count = [self count];
    
    [str appendFormat:@"%@{(\n", indent];
    
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([obj isKindOfClass:__strClass])
            tmpString = [obj fs_stringByEscaping];
        else if ([obj respondsToSelector:@selector(descriptionWithLocale:indent:)])
            tmpString = [obj descriptionWithLocale:locale indent:level+1];
        else if ([obj respondsToSelector:@selector(descriptionWithLocale:)])
            tmpString = [[obj descriptionWithLocale:locale] fs_stringByEscaping];
        else if ([obj conformsToProtocol:@protocol(FSDescriptionDict)])
            tmpString = [[obj fs_descriptionDictionary] descriptionWithLocale:locale indent:level+1];
        else
            tmpString = [[obj description] fs_stringByEscaping];
        
        if (fspp_suppressWhitespace(fspp_orderedSet))
            tmpString = [tmpString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        
        [str appendFormat:@"%@    %@", indent, tmpString];
        if (idx+1 == count)
            [str appendString:@"\n"];
        else
            [str appendString:@",\n"];
    }];
    
    [str appendFormat:@"%@)}", indent];
    
    return str;
}
@end
@implementation NSMutableOrderedSet (DebugPrint)
#ifndef DEBUGPRINT_SWIZZLE
- (NSString *)descriptionWithLocale:(id)locale indent:(NSUInteger)level
{
    return [self fs_descriptionWithLocale__impl:locale indent:level];
}
#endif
- (NSString *)fs_descriptionWithLocale:(id)locale indent:(NSUInteger)level
{
    return [self fs_descriptionWithLocale__impl:locale indent:level];
}
@end
#endif

@implementation NSString (EscapeArtist)
- (NSString *)fs_stringByEscaping
{ @autoreleasepool {
    NSMutableString * s = [self mutableCopy];
    NSDictionary * replacementDict = [NSDictionary dictionaryWithObjectsAndKeys:
                                      // REPLACEMENT, PATTERN
                                      @"\\n", @"\n",
                                      @"\\r", @"\r",
                                      @"\"",  @"\\\"",
                                      nil];    // TODO: many many more kinds of escapes
    BOOL replacedSomething = NO;
    for (NSString * pattern in [replacementDict allKeys]) {
        if (NSNotFound!=[s rangeOfString:pattern].location) {
            replacedSomething = YES;
            [s replaceOccurrencesOfString:pattern withString:[replacementDict objectForKey:pattern] options:NSLiteralSearch range:NSMakeRange(0, [s length])];
        }
    }

    if (NSNotFound!=[s rangeOfCharacterFromSet:[NSCharacterSet characterSetWithCharactersInString:@";,. "]].location)
        replacedSomething = YES;
    
    if (YES==replacedSomething) {
        [s insertString:@"\"" atIndex:0];
        [s appendString:@"\""];
    }
    
    return [s copy];
} }
@end

@implementation NSString (FilledString)
+ (NSString *)fs_stringByFillingWithCharacter:(char)character repeated:(NSUInteger)times
{
    char* f = malloc(sizeof(char)*times);
    
    f = memset(f, character, times); // memset may be implemented in assembler, which has some really spiffy bits to make filling memory blocks super-fast.
    // It's fair to expect OS X to have an optimized memset; ObjC zero-fills new objects, so using memset for that AND having that super-optimized makes sense.
    // So, by using memset we get to piggy-back on their work, for free.
    return [[NSString alloc] initWithBytesNoCopy:f length:times encoding:NSASCIIStringEncoding freeWhenDone:YES];
}
+ (NSString *)fs_stringByFillingWithString:(NSString *)string repeated:(NSUInteger)times
{
    NSMutableString * s = [NSMutableString stringWithCapacity:[string length]*times];
    for (NSUInteger i=0;
         i<times;
         ++i) [s appendString:string];
    return s;
}
@end

@implementation NSMutableString (PrettyDict)
- (void)fs_appendDictionaryStartWithIndentString:(NSString *)indentString
{
  [self appendFormat:@"%@{\n", indentString];
}
- (void)fs_appendDictionaryStartWithIndentString:(NSString *)indentString caller:(id)caller
{
    [self appendFormat:@"%@{\n", indentString];
    [self fs_appendDictionaryKey:@"_class" value:NSStringFromClass([caller class]) locale:nil indentString:indentString indentLevel:1];
    [self fs_appendDictionaryKey:@"_ptr" value:[NSString stringWithFormat:@"%p", caller] locale:nil indentString:indentString indentLevel:1];
}
- (void)fs_appendDictionaryKey:(NSString *)key value:(id)value locale:(id)locale indentString:(NSString *)indentString indentLevel:(NSUInteger)level
{
    [self fs_appendDictionaryKey:key value:value locale:locale indentString:indentString indentLevel:level whitespaceSuppression:false];
}
- (void)fs_appendDictionaryKey:(NSString *)key value:(id)value locale:(id)locale indentString:(NSString *)indentString indentLevel:(NSUInteger)level whitespaceSuppression:(bool)suppress
{
    NSString * _value = nil;
    if ([value respondsToSelector:@selector(fs_descriptionDictionary)]) _value = [[value fs_descriptionDictionary] descriptionWithLocale:locale indent:level];
    else if ([value respondsToSelector:@selector(descriptionWithLocale:indent:)]) _value = [value descriptionWithLocale:locale indent:level];
    else if ([value respondsToSelector:@selector(descriptionWithLocale:)]) _value = [[value descriptionWithLocale:locale] fs_stringByEscaping];
    else _value = [[value description] fs_stringByEscaping];
    
    if (suppress)
        _value = [_value stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];

    NSString * indent = [NSString fs_stringByFillingWithCharacter:' ' repeated:fspp_spacesPerIndent*level-[indentString length]];
    
    [self appendFormat:@"%@%@%@ = %@;\n", indentString, indent, [key fs_stringByEscaping], _value];
}
- (void)fs_appendDictionaryEndWithIndentString:(NSString *)indentString
{
  [self appendFormat:@"%@}", indentString];
}
@end
