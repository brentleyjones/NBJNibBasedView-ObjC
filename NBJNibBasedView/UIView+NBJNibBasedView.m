//
//  UIView+NBJNibBasedView.m
//  NBJNibBasedView-ObjC
//
//  Created by Brentley Jones on 6/22/14.
//  Copyright (c) 2014 Brentley Jones. All rights reserved.
//

#import "UIView+NBJNibBasedView.h"

#import <objc/runtime.h>
#import "NBJNibBasedView.h"

#if TARGET_OS_IPHONE
#define Rect CGRect
#else
#define Rect NSRect
#endif

@implementation View (NBJNibBasedView)

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        
        void (^swizzleMethod)(SEL, SEL) = ^(SEL originalSelector, SEL swizzledSelector) {
            Method originalMethod = class_getInstanceMethod(class, originalSelector);
            Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
            
            BOOL didAddMethod = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
            
            if (didAddMethod) {
                class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
            } else {
                method_exchangeImplementations(originalMethod, swizzledMethod);
            }
        };
        
        swizzleMethod(@selector(initWithCoder:), @selector(nbj_initWithCoder:));
        swizzleMethod(@selector(initWithFrame:), @selector(nbj_initWithFrame:));
    });
}

#pragma mark - Method Swizzling

- (instancetype)nbj_initWithCoder:(NSCoder *)coder
{
    id retSelf = [self nbj_initWithCoder:coder];
    if (retSelf) {
        [self nbj_nibBasedViewInit];
    }
    return retSelf;
}

- (instancetype)nbj_initWithFrame:(Rect)frame
{
    id retSelf = [self nbj_initWithFrame:frame];
    if (retSelf) {
        [self nbj_nibBasedViewInit];
    }
    return retSelf;
}

#pragma mark - NBJNibBasedView

- (void)nbj_nibBasedViewInit
{
    if ([self conformsToProtocol:@protocol(NBJNibBasedView)]) {
        Class class = [self class];
        
        NSString *nibName;
        if ([class respondsToSelector:@selector(nibBasedViewNibName)]) {
            nibName = [class nibBasedViewNibName];
        } else {
            nibName = NSStringFromClass(class);
        }
        
        BOOL translatesAutoresizingMaskIntoConstraints;
        if ([class respondsToSelector:@selector(nibBasedSubviewTranslatesAutoresizingMaskIntoConstraints)]) {
            translatesAutoresizingMaskIntoConstraints = [class nibBasedSubviewTranslatesAutoresizingMaskIntoConstraints];
        } else {
            translatesAutoresizingMaskIntoConstraints = NO;
        }
        
#if TARGET_OS_IPHONE
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:nibName owner:self options:nil];
#else
        NSArray *topLevelObjects = nil;
        [[NSBundle mainBundle] loadNibNamed:nibName owner:self topLevelObjects:&topLevelObjects];
#endif
        // Find the first view that's a top level object
        View *rootSubview = nil;
        for (id object in topLevelObjects) {
            if ([object isKindOfClass:[View class]]) {
                rootSubview = object;
                break;
            }
        }
        
        // If we found a view, add it as our subview
        if (rootSubview) {
            rootSubview.translatesAutoresizingMaskIntoConstraints = translatesAutoresizingMaskIntoConstraints;
            [self addSubview:rootSubview];
        }
    }
}

@end
