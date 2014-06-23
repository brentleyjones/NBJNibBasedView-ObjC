//
//  NBJMergeLayout.m
//  NBJMergeLayout-Objc
//
//  Created by Brentley Jones on 6/22/14.
//  Copyright (c) 2014 Brentley Jones. All rights reserved.
//

#import "NBJMergeLayout.h"

@implementation NBJMergeLayout

#if TARGET_OS_IPHONE

- (void)didMoveToSuperview
{
    if (self.superview) {
        [self moveSubviewsToNewSuperview:self.superview];
        
        // Remove ourselves from our superview
        [self removeFromSuperview];
    }
}

#else

- (void)viewDidMoveToSuperview
{
    if (self.superview) {
        [self moveSubviewsToNewSuperview:self.superview];
        
        // Remove ourselves from our superview
        [self removeFromSuperview];
    }
}

#endif

#pragma mark - Private Methods

- (void)moveSubviewsToNewSuperview:(id)newSuperview
{
    // Add all children to superview
    
    // First start by moving the constraints,
    // because if we move the views first we lose the constraints
    for (NSLayoutConstraint *constraint in self.constraints) {
        NSLayoutConstraint *newConstraint = [self constraintForSuperviewConstraint:constraint withNewSuperview:newSuperview];
        
        [newSuperview addConstraint:newConstraint];
    }
    
    // Secondly we move the views over to our new superview
    // Copy needed or OS X complains about mutating the array
    // (since we are technically removing the views by adding them to the superview)
    NSArray *subviews = [self.subviews copy];
    for (id subview in subviews) {
        [newSuperview addSubview:subview];
    }
}

- (NSLayoutConstraint *)constraintForSuperviewConstraint:(NSLayoutConstraint *)constraint withNewSuperview:(id)newSuperview
{
    id firstItem = constraint.firstItem;
    id secondItem = constraint.secondItem;
    
    // Replace self in constraints with new superview
    if (firstItem == self) {
        firstItem = newSuperview;
    }
    if (secondItem == self) {
        secondItem = newSuperview;
    }
    
    // Construct new constraint
    NSLayoutConstraint *newConstraint = [NSLayoutConstraint constraintWithItem:firstItem attribute:constraint.firstAttribute relatedBy:constraint.relation toItem:secondItem attribute:constraint.secondAttribute multiplier:constraint.multiplier constant:constraint.constant];
    
    return newConstraint;
}

@end
