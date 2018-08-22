//
//  KeyboardViewController.m
//  MyKeyboard
//
//  Created by zonble on 2018/8/22.
//  Copyright © 2018 zonble. All rights reserved.
//

#import "KeyboardViewController.h"

@interface KeyboardViewController ()
@property (nonatomic, strong) UIButton *evilActionButton;
@property (nonatomic, strong) UIButton *nextKeyboardButton;
@end

@implementation KeyboardViewController

- (void)updateViewConstraints {
    [super updateViewConstraints];
    
    // Add custom view sizing constraints here
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
	self.evilActionButton = [UIButton buttonWithType:UIButtonTypeSystem];

	[self.evilActionButton setTitle:NSLocalizedString(@"Go to Evil Keyboard", @"") forState:UIControlStateNormal];
	[self.evilActionButton sizeToFit];
	self.evilActionButton.translatesAutoresizingMaskIntoConstraints = NO;

	[self.evilActionButton addTarget:self action:@selector(evilAction:) forControlEvents:UIControlEventAllTouchEvents];

	[self.view addSubview:self.evilActionButton];

	[self.evilActionButton.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = YES;
	[self.evilActionButton.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor].active = YES;


    self.nextKeyboardButton = [UIButton buttonWithType:UIButtonTypeSystem];
    
    [self.nextKeyboardButton setTitle:NSLocalizedString(@"Next Keyboard", @"Title for 'Next Keyboard' button") forState:UIControlStateNormal];
    [self.nextKeyboardButton sizeToFit];
    self.nextKeyboardButton.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.nextKeyboardButton addTarget:self action:@selector(handleInputModeListFromView:withEvent:) forControlEvents:UIControlEventAllTouchEvents];
    
    [self.view addSubview:self.nextKeyboardButton];
    
    [self.nextKeyboardButton.leftAnchor constraintEqualToAnchor:self.view.leftAnchor].active = YES;
    [self.nextKeyboardButton.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor].active = YES;
}

- (void)openURL:(NSURL *)URL
{
	UIResponder* responder = self;
	while ((responder = [responder nextResponder]) != nil)
	{
		NSLog(@"responder = %@", responder);
		if([responder respondsToSelector:@selector(openURL:)] == YES)
		{
			[responder performSelector:@selector(openURL:) withObject:URL];
		}
	}
}

- (void)evilAction:(id)sender
{
	NSURL *URL = [NSURL URLWithString: @"evilkeyboard://go"];
	[self openURL:URL];
}

- (void)textDidChange:(id<UITextInput>)textInput
{
    // The app has just changed the document's contents, the document context has been updated.
    
    UIColor *textColor = nil;
    if (self.textDocumentProxy.keyboardAppearance == UIKeyboardAppearanceDark) {
        textColor = [UIColor whiteColor];
    } else {
        textColor = [UIColor blackColor];
    }
    [self.evilActionButton setTitleColor:textColor forState:UIControlStateNormal];
	[self.nextKeyboardButton setTitleColor:textColor forState:UIControlStateNormal];
}

@end
