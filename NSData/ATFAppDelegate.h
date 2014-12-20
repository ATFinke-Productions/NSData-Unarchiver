//
//  ATFAppDelegate.h
//  NSData
//
//  Created by Andrew on 7/5/13.
//  Copyright (c) 2013 ATFinke Productions Incorperated. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface ATFAppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;
@property (assign) IBOutlet NSTextView *textView;
@property (assign) IBOutlet NSTextField *textField;

@property (assign) IBOutlet NSButton * selector;

- (IBAction)selectFile:(id)sender;
- (IBAction)unarchive:(id)sender;

@end