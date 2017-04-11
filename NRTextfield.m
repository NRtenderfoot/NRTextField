//
//  NRTextfield.m
//  ePay
//
//  Created by neetika  on 2/6/17.
//  Copyright © 2017 Neetika Rana. All rights reserved.
//

#import "NRTextfield.h"
#import "Macro.h"

#define YConstant   - 29

@implementation NRTextfield

#pragma mark :- Loading From NIB
-(void)awakeFromNib {
    [super awakeFromNib];
    [self initialization];
    
}

#pragma mark :- Init
-(void)initialization{
    
    self.clipsToBounds = true;
    
    [self layoutIfNeeded];
    
    //Hide default placeholder
    [self makePlaceholderTransparent];
    
    [self addPlaceholderLabel];
    
    self.backgroundColor = [UIColor clearColor];
    self.contentVerticalAlignment = UIControlContentVerticalAlignmentBottom;
    
}

- (void)setText:(NSString *)text{

    [super setText:text];
    
    if(text.length == 0){
        _labelPlaceholder.alpha = 1;
    }else{
        _labelPlaceholder.alpha = 0;
    }
}

#pragma mark - Padding

- (CGRect)textRectForBounds:(CGRect)bounds
{
    return CGRectInset(bounds, 10.0f, 15.0f);
}

- (CGRect)editingRectForBounds:(CGRect)bounds
{
    return [self textRectForBounds:bounds];
}

-(void)addPlaceholderLabel{
    
    if (_labelPlaceholder != nil){
       [_labelPlaceholder removeFromSuperview];
    }
    
    _labelPlaceholder = [[UILabel alloc] initWithFrame:CGRectZero];
    _labelPlaceholder.text = self.placeholder;
    _labelPlaceholder.textAlignment = self.textAlignment;
    _labelPlaceholder.textColor = [UIColor lightGrayColor];
    _labelPlaceholder.font = self.font;
    _labelPlaceholder.restorationIdentifier = self.placeholder?self.placeholder:@"NRTextFieldRestorationIdentifier";
    _labelPlaceholder.backgroundColor = [UIColor clearColor];
    [self addSubview:_labelPlaceholder];

    _textfieldBGImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, self.frame.size.height-50, self.frame.size.width , 50)];
    _textfieldBGImage.image = IMAGE(@"textfield");
    [self addSubview:_textfieldBGImage];
    [self sendSubviewToBack:_textfieldBGImage];

  //  [self setFramesToDefault];
    
    [self addImageViewConstraints];
    [self addLabelConstraints];
    
    
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(NRtextFieldDidChange) name:UITextFieldTextDidChangeNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(NRtextFieldDidBeginEditing) name:UITextFieldTextDidBeginEditingNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(NRtextFieldDidEndEditing) name: UITextFieldTextDidEndEditingNotification object:nil];
}



#pragma mark - Placeholder

- (void)makePlaceholderTransparent{
    
    if(self.placeholder){
        NSAttributedString *str = [[NSAttributedString alloc] initWithString:self.placeholder attributes:@{ NSForegroundColorAttributeName : [UIColor clearColor] }];
        self.attributedPlaceholder = str;
    }
}

#pragma mark - Float & Resign


-(void)addImageViewConstraints{
    _textfieldBGImage.translatesAutoresizingMaskIntoConstraints = NO;
    
    //Trailing
    NSLayoutConstraint *trailing =[NSLayoutConstraint
                                   constraintWithItem:_textfieldBGImage
                                   attribute:NSLayoutAttributeTrailing
                                   relatedBy:NSLayoutRelationEqual
                                   toItem:self
                                   attribute:NSLayoutAttributeTrailing
                                   multiplier:1.0f
                                   constant:0.f];
    
    //Leading
    
    NSLayoutConstraint *leading = [NSLayoutConstraint
                                   constraintWithItem:_textfieldBGImage
                                   attribute:NSLayoutAttributeLeading
                                   relatedBy:NSLayoutRelationEqual
                                   toItem:self
                                   attribute:NSLayoutAttributeLeading
                                   multiplier:1.0f
                                   constant:0.f];
    
    //Bottom
    NSLayoutConstraint *bottom = [NSLayoutConstraint
                               constraintWithItem:_textfieldBGImage
                               attribute:NSLayoutAttributeBottom
                               relatedBy:NSLayoutRelationEqual
                               toItem:self
                               attribute:NSLayoutAttributeBottom
                               multiplier:1.0f
                               constant:0.f];
    
    //Height to be fixed for SubView same as AdHeight
    NSLayoutConstraint *height = [NSLayoutConstraint
                                  constraintWithItem:_textfieldBGImage
                                  attribute:NSLayoutAttributeHeight
                                  relatedBy:NSLayoutRelationEqual
                                  toItem:nil
                                  attribute:NSLayoutAttributeNotAnAttribute
                                  multiplier:0
                                  constant:50];
    
    
    [self addConstraint:trailing];
    [self addConstraint:bottom];
    [self addConstraint:leading];
    [self addConstraint:height];

}

-(void)addLabelConstraints{
    
    _labelPlaceholder.translatesAutoresizingMaskIntoConstraints = NO;
    
    //Trailing
    NSLayoutConstraint *trailing =[NSLayoutConstraint
                                   constraintWithItem:_labelPlaceholder
                                   attribute:NSLayoutAttributeTrailing
                                   relatedBy:NSLayoutRelationEqual
                                   toItem:self
                                   attribute:NSLayoutAttributeTrailing
                                   multiplier:1.0f
                                   constant:10.f];
    
    //Leading
    
    NSLayoutConstraint *leading = [NSLayoutConstraint
                                   constraintWithItem:_labelPlaceholder
                                   attribute:NSLayoutAttributeLeading
                                   relatedBy:NSLayoutRelationEqual
                                   toItem:self
                                   attribute:NSLayoutAttributeLeading
                                   multiplier:1.0f
                                   constant:10.f];
    
    //centerX
    NSLayoutConstraint *centerX = [NSLayoutConstraint
                                  constraintWithItem:_labelPlaceholder
                                  attribute:NSLayoutAttributeCenterX
                                  relatedBy:NSLayoutRelationEqual
                                  toItem:_textfieldBGImage
                                  attribute:NSLayoutAttributeCenterX
                                  multiplier:1.0f
                                   constant:0];
    
    //centerY
    labelCenterY = [NSLayoutConstraint
                                   constraintWithItem:_labelPlaceholder
                                   attribute:NSLayoutAttributeCenterY
                                   relatedBy:NSLayoutRelationEqual
                                   toItem:_textfieldBGImage
                                   attribute:NSLayoutAttributeCenterY
                                   multiplier:1.0f
                                   constant:0];

    
    
    [self addConstraint:trailing];
    [self addConstraint:centerX];
    [self addConstraint:leading];
    [self addConstraint:labelCenterY];
    
}

#pragma mark - Notifications

-(void)NRtextFieldDidChange{
    
    if(self.text.length == 0){
            if(self.text.length == 0){
                _labelPlaceholder.alpha = 1;
            }else{
                _labelPlaceholder.alpha = 0;
            }
    }
    
}

- (void)NRtextFieldDidBeginEditing {
    
    if (self.isFirstResponder){

      //  [_labelPlaceholder setNeedsLayout];
        
     
        [UIView animateWithDuration:0.5 animations:^{
            [self modifyLabelConstraints];
            [self layoutIfNeeded];
        }];
    }
}

- (void)NRtextFieldDidEndEditing{
    
    if(self.text.length == 0){
        [_labelPlaceholder setNeedsLayout];
        
        [UIView animateWithDuration:0.5 animations:^{
            [self setDefaultLabelConstraints];
            [self layoutIfNeeded];
        }];
    }
}
-(void)modifyLabelConstraints{
    
    if(labelCenterY.constant != YConstant)
        labelCenterY.constant = YConstant;

//    if(self.text.length == 0){
//        _labelPlaceholder.alpha = 1;
//    }else{
//        _labelPlaceholder.alpha = 0;
//    }
    
    _labelPlaceholder.font = [UIFont boldSystemFontOfSize:13.0f];
    _labelPlaceholder.textColor = [UIColor darkGrayColor];
}

-(void)setDefaultLabelConstraints{
    
    labelCenterY.constant = 0;
    
    if(self.text.length == 0){
        _labelPlaceholder.alpha = 1;
    }else{
        _labelPlaceholder.alpha = 0;
    }
    
    _labelPlaceholder.font = [UIFont systemFontOfSize:14.0f];
    _labelPlaceholder.textColor = [UIColor lightGrayColor];
}


@end
