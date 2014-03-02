//
//  Created by Jesse Squires
//  http://www.hexedbits.com
//
//
//  Documentation
//  http://cocoadocs.org/docsets/JSMessagesViewController
//
//
//  The MIT License
//  Copyright (c) 2014 Jesse Squires
//  http://opensource.org/licenses/MIT
//

#import "JSQMessagesInputToolbar.h"

#import "JSQMessagesToolbarContentView.h"

#import "UIView+JSQMessages.h"

const CGFloat kJSQMessagesInputToolbarHeightDefault = 44.0f;


@interface JSQMessagesInputToolbar ()

@end



@implementation JSQMessagesInputToolbar

#pragma mark - Initialization

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    NSArray *nibViews = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([JSQMessagesToolbarContentView class]) owner:nil options:nil];
    JSQMessagesToolbarContentView *toolbarContentView = [nibViews firstObject];
    toolbarContentView.frame = self.frame;
    [self addSubview:toolbarContentView];
    [self jsq_pinAllEdgesOfSubview:toolbarContentView];
    _contentView = toolbarContentView;
    
    UIImage *cameraImage = [UIImage imageNamed:@"button-photo"];
    UIButton *cameraButton = [[UIButton alloc] initWithFrame:CGRectZero];
    [cameraButton setImage:cameraImage forState:UIControlStateNormal];
    [cameraButton setImage:cameraImage forState:UIControlStateHighlighted];
    cameraButton.contentMode = UIViewContentModeScaleAspectFit;
    cameraButton.backgroundColor = [UIColor clearColor];
    cameraButton.tintColor = [UIColor lightGrayColor];
    self.contentView.leftBarButtonItem = cameraButton;
    
    NSString *sendTitle = NSLocalizedString(@"Send", @"Text for the send button on the messages view toolbar");
    UIButton *sendButton = [[UIButton alloc] initWithFrame:CGRectZero];
    [sendButton setTitle:sendTitle forState:UIControlStateNormal];
    [sendButton setTitle:sendTitle forState:UIControlStateHighlighted];
    [sendButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [sendButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
    sendButton.titleLabel.font = [UIFont boldSystemFontOfSize:17.0f];
    sendButton.contentMode = UIViewContentModeCenter;
    sendButton.backgroundColor = [UIColor clearColor];
    sendButton.tintColor = [UIColor blueColor];
    self.contentView.rightBarButtonItem = sendButton;
}

@end