//
//  IACResizingLabel.m
//  Accessibility 101
//
//  Created by Chris McMeeking on 3/31/15.
//  Copyright (c) 2015 Deque Systems. All rights reserved.
//

#import "DQLabel.h"
#import "DQTextView.h"
#import "DQFontUtilities.h"
#import "DQLog.h"

#define LOG_FLAG YES

@implementation DQLabel {
    NSString* _contentSizeCategory;
}

-(id)init {
    self = [super init];
    
    if (self) {
        [self initialize];
    }
    
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    
    if (self)
        [self initialize];
    
    return self;
}

-(id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self)
        [self initialize];
    
    return self;
}

-(void)initialize {
    
    [self setContentSizeCategory:[DQFontUtilities contentSizeCategory:self.font]];
    
    [self didChangePreferredContentSize];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didChangePreferredContentSize)
                                                 name:UIContentSizeCategoryDidChangeNotification
                                               object:nil];
    
    //Warns programmer if the number of lines is not set to 0.
    if (self.numberOfLines != 0) DQLog(@"Warning: number of lines not set to 0.  Content will not be allowed to wrap on larger text sizes!");
}

-(void)didChangePreferredContentSize {
    self.font = [UIFont preferredFontForTextStyle:_contentSizeCategory];
}

-(void)setContentSizeCategory:(NSString *)contentSizeCategory {
    
    if ([DQTextView isValidContentSizeCategory:contentSizeCategory]) {
        
        _contentSizeCategory = contentSizeCategory;
    } else {
        DQLog(@"WARNING: Content Size Category not valid, setting to \"UIFontTextStyleBody\" by default for element: %@", self);
        _contentSizeCategory = UIFontTextStyleBody;
    }
    
    if (_contentSizeCategory == UIFontTextStyleHeadline) {
        self.accessibilityTraits |= UIAccessibilityTraitHeader;
    }
    
    [self didChangePreferredContentSize];
}

//TODO: What if user wants to change font? Change color?

-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
