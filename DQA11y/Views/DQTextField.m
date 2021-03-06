//
//  DQTextField.m
//  DQA11y
//
//  Created by Chris McMeeking on 4/10/15.
//  Copyright (c) 2015 Deque Developer. All rights reserved.
//

#import "DQTextField.h"
#import "DQFontUtilities.h"

@implementation DQTextField {
    NSString* _contentSizeCategory;
}

- (id)init {
    self = [super init];
    
    if (self) {
        [self initialize];
    }
    
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        [self initialize];
    }
    
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        [self initialize];
    }
    
    return self;
}

-(void)initialize {
    
    _contentSizeCategory = [DQFontUtilities contentSizeCategory:self.font];
    announcePlaceholderText = YES;
    
    [self didChangePreferredContentSize];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didChangePreferredContentSize)
                                                 name:UIContentSizeCategoryDidChangeNotification
                                               object:nil];
}

-(void)didChangePreferredContentSize {
    self.font = [UIFont preferredFontForTextStyle:_contentSizeCategory];
}

-(NSString*)accessibilityLabel {
    NSString* label = [super accessibilityLabel];
    NSString* placeholder = self.placeholder;
    
    if(self.text.length > 0 && announcePlaceholderText) {
        if(label.length > 0 && placeholder.length > 0) {
            return [NSString stringWithFormat:@"%@, %@", label, placeholder];
        } else if(placeholder.length > 0) {
            return placeholder;
        }
    }
    return label;
}


//TODO: What if user wants to change font? Change color? Why is there nothing in the .h file for this?

-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
