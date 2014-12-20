//
//  ATFAppDelegate.m
//  NSData
//
//  Created by Andrew on 7/5/13.
//  Copyright (c) 2013 ATFinke Productions Incorperated. All rights reserved.
//
#import "ATFAppDelegate.h"
@implementation ATFAppDelegate {
    NSURL * fileURL;
}
- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    self.textView.string = @"";
}

- (BOOL) applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)sender {
    return YES;
}

- (IBAction)unarchive:(id)sender {
    
    self.textView.string = @"";
    
    NSString * string;
    NSString * key = self.textField.stringValue;

    NSData *data = [[NSMutableData alloc] initWithContentsOfURL:fileURL];
    
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];

    BOOL decoded = YES;
    
    id object = [unarchiver decodeObjectForKey:key];
    NSString * class = [NSString stringWithFormat:@"%@",[object class]];

    if ([class isEqualToString:@"__NSDictionaryI"]||[class isEqualToString:@"__NSDictionaryM"]) {
        NSDictionary * dictionary = object;
        
        NSArray * values = [[NSArray alloc]init];
        NSArray * keys = [[NSArray alloc]init];
       
        values = [dictionary allValues];
        keys = [dictionary allKeys];
        
        
        
        for (int i = 0; i < values.count; i++) {
            
            if (i == 0) {
                
                string = [NSString stringWithFormat:@"%@ = %@",keys[i],values[i]];
                
            }
            
            else {
            
                string = [NSString stringWithFormat:@"%@\n%@ = %@",string,keys[i],values[i]];
            }
        }
    }
    
    else if ([class isEqualToString:@"__NSArrayI"] || [class isEqualToString:@"__NSArrayM"]) {
        
        NSArray * array = object;
        NSMutableArray * arrayM = object;
        
        
        BOOL mutable = YES;
        
        if ([class isEqualToString:@"__NSArrayI"]) {
            mutable = NO;
        }
        
        for (int i = 0; i < array.count; i++) {
            
            if (i == 0) {
                if (mutable) {
                    string = [NSString stringWithFormat:@"%@",arrayM[i]];
                }
                else {
                    string = [NSString stringWithFormat:@"%@",array[i]];
                }
                
            }
            
            else {
                if (mutable) {
                    string = [NSString stringWithFormat:@"%@\n%@",string,arrayM[i]];
                }
                else {
                    string = [NSString stringWithFormat:@"%@\n%@",string,array[i]];
                }
            }
        }
}
    
    else if ([class isEqualToString:@"__NSCFConstantString"] || [class isEqualToString:@"__NSCFString"]) {
        
        string = object;
    }
    else if ([class isEqualToString:@"__NSCFNumber"]) {
        NSNumber * number = object;
        string = [NSString stringWithFormat:@"%@",number];
    }
    
    else {
        decoded = NO;
        string = @"Unreadable filetype or wrong data key. Suggestions for filetypes always welcome";
    }

    if (decoded) {
        string = [NSString stringWithFormat:@"%@\n\n\n Finished decoding a %@",string,class];
    }

  [unarchiver finishDecoding];



    [self.textView insertText:string];
    
}
- (IBAction)selectFile:(id)sender {
    
    NSOpenPanel* openDlg = [NSOpenPanel openPanel];
    
    [openDlg setCanChooseFiles:YES];
    
    [openDlg setCanChooseDirectories:NO];



if ( [openDlg runModal] == NSOKButton )
        
    {
        
        for( NSURL* URL in [openDlg URLs] )
            
        {
            
            fileURL = URL;
            
            NSArray * array = [[NSString stringWithFormat:@"%@",fileURL] componentsSeparatedByString:@"/"];
            
            
            
            
            
            self.selector.title = [array lastObject];
            
        }
        
    }
    
}
@end
