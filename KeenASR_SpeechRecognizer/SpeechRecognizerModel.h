//
//  SpeechRecognizerModel.h
//  Hello_SpeechRecognition_OnDevice
//
//  Created by Cyril Garcia on 6/25/19.
//  Copyright © 2019 Cyril Garcia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KeenASR/KeenASR.h"

@protocol SpeechRecognizerModelDelegate <NSObject>
-(void)intent:(int)intent :(NSNumber*)confidenceLevel;
-(void)recognized:(NSString*)text;
@end


@interface SpeechRecognizerModel : NSObject <KIOSRecognizerDelegate>

@property (nonatomic, strong) id <SpeechRecognizerModelDelegate> delegate;

-(void)prepMic;
-(void)createDecodingGraph:(NSArray*)phrases;
-(void)startListening;
-(void)stopListening;
@end
