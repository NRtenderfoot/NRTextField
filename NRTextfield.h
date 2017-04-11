//
//  NRTextfield.h
//  ePay
//
//  Created by neetika  on 2/6/17.
//  Copyright © 2017 Neetika Rana. All rights reserved.
//

#import <UIKit/UIKit.h>

//IB_DESIGNABLE

@interface NRTextfield : UITextField{
    NSLayoutConstraint *labelCenterY;

}

//@property (nonatomic) IBInspectable NSString *FloatingPlaceholder;

@property (nonatomic,strong) UILabel *labelPlaceholder;
@property (nonatomic,strong) UIImageView *textfieldBGImage;
@property BOOL doNotAnimatePlaceholder;

//
//-(void)setTextFieldPlaceholderText:(NSString *)placeholderText;

@end
