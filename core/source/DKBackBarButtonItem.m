//
//  DKBackBarButtonItem.m
//  MyHome
//
//  Created by Дмитрий Калашников on 15/11/13.
//
//

#import "DKBackBarButtonItem.h"
#import "DKBackButton.h"

#define NAVIGATION_BAR_HEIGHT 44.0f
@implementation DKBackBarButtonItem

- (id)init{
    self = [super init];
    if (self) {
        [self startUp];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
    
    }
    return self;
}

- (id)initWithTitle:(NSString *)title{
    self = [super init];
    
    if (self) {
        self.title = title;
        [self startUp];
    }
    return self;
}

-(void)awakeFromNib{
    [self startUp];
    
}

- (void)startUp{
    
    if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_6_1) {
        _btn = [[DKBackButton alloc] init];
    } else {
        _btn = [DKBackButton buttonWithType:UIButtonTypeSystem];
    }
    if (self.title) {
        [_btn setTitle:self.title forState:UIControlStateNormal];
    }
    else{
        [_btn setTitle:NSLocalizedStringFromTable(@"Back", @"DKBackButtonLocalizable", @"There is localization for all strings") forState:UIControlStateNormal];
    }
    
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont systemFontOfSize:15.0f];
    [label setText:_btn.titleLabel.text];
    [label sizeToFit];
    
    if ([[UIImage class] respondsToSelector:@selector(imageWithRenderingMode:)]) {
        [_btn setImage:[[UIImage imageNamed:@"back_indicator_image"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
    } else {
        [_btn setImage:[UIImage imageNamed:@"back_indicator_image_white"] forState:UIControlStateNormal];
    }
    
    [_btn setFrame:CGRectMake(0, 0, label.frame.size.width+22+_btn.imageView.frame.size.width , 44)];
    
    if ([_btn respondsToSelector:@selector(makeOffset)]) {
        [((DKBackButton *)_btn) makeOffset];
    } else {
        [_btn setClipsToBounds:NO];
        [_btn setImageEdgeInsets:UIEdgeInsetsMake(0, - 15, 0, 0)];
        [_btn setTitleEdgeInsets:UIEdgeInsetsMake(0, _btn.imageEdgeInsets.left+15, 0, 0)];
        
        [_btn.titleLabel setFont:[UIFont systemFontOfSize:17.0f]];
    }
    
    [self setCustomView:_btn];
}


#pragma mark UIButton rewritten methods

- (void)setTitle:(NSString *)title{
    
    NSString *_titleCust = nil;
    if (title) {
        _titleCust = title;
    }
    else {
        _titleCust = NSLocalizedStringFromTable(@"Back", @"DKBackButtonLocalizable", @"There is localization for all strings");
    }
    
    _btn = (DKBackButton *)self.customView;
    [_btn setTitle:_titleCust forState:UIControlStateNormal];
    
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont systemFontOfSize:15.0f];
    [label setText:_titleCust];
    [label sizeToFit];
    
    [_btn setFrame:CGRectMake(0, 0, label.frame.size.width+22+_btn.imageView.frame.size.width , 44)];
    if ([_btn respondsToSelector:@selector(setterOffset)]) {
        [_btn setterOffset];
    } else {
        [_btn setClipsToBounds:NO];
        [_btn setImageEdgeInsets:UIEdgeInsetsMake(0, - 25, 0, 0)];
        [_btn setTitleEdgeInsets:UIEdgeInsetsMake(0, _btn.imageEdgeInsets.left+15, 0, 0)];
        
        [_btn.titleLabel setFont:[UIFont systemFontOfSize:17.0f]];
    }
}

- (void)setImage:(UIImage *)image{
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont systemFontOfSize:15.0f];
    [label setText:self.title];
    [label sizeToFit];
    
    _btn = (DKBackButton *)self.customView;
    [_btn setImage:[[UIImage imageNamed:@"back_indicator_image"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
    [_btn setFrame:CGRectMake(0, 0, label.frame.size.width+22+_btn.imageView.frame.size.width, 44)];
    if ([_btn respondsToSelector:@selector(setterOffset)]) {
        [_btn setterOffset];
    } else {
        [_btn setClipsToBounds:NO];
        [_btn setImageEdgeInsets:UIEdgeInsetsMake(0, - 25, 0, 0)];
        [_btn setTitleEdgeInsets:UIEdgeInsetsMake(0, _btn.imageEdgeInsets.left+15, 0, 0)];
        
        [_btn.titleLabel setFont:[UIFont systemFontOfSize:17.0f]];
    }
}


- (void)setTarget:(id)target{
    [super setTarget:target];
    _btn = (DKBackButton *)self.customView;
    [_btn addTarget:self.target action:self.action forControlEvents:UIControlEventTouchUpInside];

}

- (id)target{
    return [super target];
}

- (void)setAction:(SEL)action{
    [super setAction:action];
    _btn = (DKBackButton *)self.customView;
    [_btn addTarget:self.target action:action forControlEvents:UIControlEventTouchUpInside];
}

- (SEL)action{
    return [super action];
}

- (void)setHidden:(BOOL)hidden{
    _btn = (DKBackButton *)self.customView;
    [_btn setHidden:hidden];
}

-(void)setTintColor:(UIColor *)tintColor{
    [super setTintColor:tintColor];
    [self.customView setTintColor:tintColor];
}

@end
