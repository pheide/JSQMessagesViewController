//
//  Created by Jesse Squires
//  http://www.jessesquires.com
//
//
//  Documentation
//  http://cocoadocs.org/docsets/JSQMessagesViewController
//
//
//  GitHub
//  https://github.com/jessesquires/JSQMessagesViewController
//
//
//  License
//  Copyright (c) 2014 Jesse Squires
//  Released under an MIT license: http://opensource.org/licenses/MIT
//

#import "JSQMessagesTypingIndicatorFooterView.h"

#import "JSQMessagesBubbleImageFactory.h"

#import "UIImage+JSQMessages.h"

const CGFloat kJSQMessagesTypingIndicatorFooterViewHeight = 46.0f;


@interface JSQMessagesTypingIndicatorFooterView ()

@property (weak, nonatomic) IBOutlet UIImageView *bubbleImageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bubbleImageViewRightHorizontalConstraint;

@property (weak, nonatomic) IBOutlet UIImageView *typingIndicatorImageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *typingIndicatorImageViewRightHorizontalConstraint;

@end



@implementation JSQMessagesTypingIndicatorFooterView

#pragma mark - Class methods

+ (UINib *)nib
{
    return [UINib nibWithNibName:NSStringFromClass([JSQMessagesTypingIndicatorFooterView class])
                          bundle:[NSBundle bundleForClass:[JSQMessagesTypingIndicatorFooterView class]]];
}

+ (NSString *)footerReuseIdentifier
{
    return NSStringFromClass([JSQMessagesTypingIndicatorFooterView class]);
}

#pragma mark - Initialization

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setTranslatesAutoresizingMaskIntoConstraints:NO];
    self.backgroundColor = [UIColor clearColor];
    self.userInteractionEnabled = NO;
    self.typingIndicatorImageView.contentMode = UIViewContentModeScaleAspectFit;
}

#pragma mark - Reusable view

- (void)setBackgroundColor:(UIColor *)backgroundColor
{
    [super setBackgroundColor:backgroundColor];
    self.bubbleImageView.backgroundColor = backgroundColor;
}

#pragma mark - Typing indicator

- (void)configureWithEllipsisColor:(UIColor *)ellipsisColor
                messageBubbleColor:(UIColor *)messageBubbleColor
               shouldDisplayOnLeft:(BOOL)shouldDisplayOnLeft
                 forCollectionView:(UICollectionView *)collectionView
{
    NSParameterAssert(ellipsisColor != nil);
    NSParameterAssert(messageBubbleColor != nil);
    NSParameterAssert(collectionView != nil);
    
    CGFloat bubbleMarginMinimumSpacing = 6.0f;
    CGFloat indicatorMarginMinimumSpacing = 26.0f;
    
    JSQMessagesBubbleImageFactory *bubbleImageFactory = [[JSQMessagesBubbleImageFactory alloc] init];
    
    if (shouldDisplayOnLeft) {
        self.bubbleImageView.image = [bubbleImageFactory incomingMessagesBubbleImageWithColor:messageBubbleColor].messageBubbleImage;
        
        CGFloat collectionViewWidth = CGRectGetWidth(collectionView.frame);
        CGFloat bubbleWidth = CGRectGetWidth(self.bubbleImageView.frame);
        CGFloat indicatorWidth = CGRectGetWidth(self.typingIndicatorImageView.frame);
        
        CGFloat bubbleMarginMaximumSpacing = collectionViewWidth - bubbleWidth - bubbleMarginMinimumSpacing;
        CGFloat indicatorMarginMaximumSpacing = collectionViewWidth - indicatorWidth - indicatorMarginMinimumSpacing;
        
        self.bubbleImageViewRightHorizontalConstraint.constant = bubbleMarginMaximumSpacing;
        self.typingIndicatorImageViewRightHorizontalConstraint.constant = indicatorMarginMaximumSpacing;
    }
    else {
        self.bubbleImageView.image = [bubbleImageFactory outgoingMessagesBubbleImageWithColor:messageBubbleColor].messageBubbleImage;
        
        self.bubbleImageViewRightHorizontalConstraint.constant = bubbleMarginMinimumSpacing;
        self.typingIndicatorImageViewRightHorizontalConstraint.constant = indicatorMarginMinimumSpacing;
    }
    
    [self setNeedsUpdateConstraints];
    
    NSArray *imageNames = @[@"typing0001", @"typing0002", @"typing0003", @"typing0004", @"typing0005", @"typing0006", @"typing0007", @"typing0008", @"typing0009", @"typing0010", @"typing0011", @"typing0012", @"typing0013", @"typing0014", @"typing0015", @"typing0016", @"typing0017", @"typing0018", @"typing0019", @"typing0020", @"typing0021", @"typing0022", @"typing0023", @"typing0024", @"typing0025", @"typing0026", @"typing0027", @"typing0028", @"typing0029", @"typing0030", @"typing0031", @"typing0032", @"typing0033", @"typing0034", @"typing0035", @"typing0036", @"typing0037", @"typing0038", @"typing0039", @"typing0040", @"typing0041", @"typing0042", @"typing0043", @"typing0044", @"typing0045", @"typing0046", @"typing0047", @"typing0048", @"typing0049", @"typing0050", @"typing0051", @"typing0052", @"typing0053", @"typing0054", @"typing0055", @"typing0056", @"typing0057"];
    
    NSMutableArray *images = @[].mutableCopy;
    for (NSString *imageName in imageNames) {
        [images addObject:[UIImage imageNamed:imageName]];
    }
    
    self.typingIndicatorImageView.animationImages = images;
    self.typingIndicatorImageView.animationDuration = images.count / 24.0;
    [self.typingIndicatorImageView startAnimating];
    
//    self.typingIndicatorImageView.image = [[UIImage jsq_defaultTypingIndicatorImage] jsq_imageMaskedWithColor:ellipsisColor];
}

@end
