//
//  SpeechRecognizerModel.m
//  Hello_SpeechRecognition_OnDevice
//
//  Created by Cyril Garcia on 6/25/19.
//  Copyright © 2019 Cyril Garcia. All rights reserved.
//


#import "SpeechRecognizerModel.h"
@import MediaPlayer;


@interface SpeechRecognizerModel ()
@property (nonatomic, weak) KIOSRecognizer *recognizer;
@end

@implementation SpeechRecognizerModel : NSObject

- (id)init {
    self.recognizer = [KIOSRecognizer sharedInstance];
    self.recognizer.delegate = self;
    
    [KIOSRecognizer setLogLevel:KIOSRecognizerLogLevelInfo];
    self.recognizer.createAudioRecordings = YES;
    
    // if user doesn't say anything for this many seconds we end recognition
    [self.recognizer setVADParameter:KIOSVadTimeoutForNoSpeech toValue:5];
    
    // we never run recognition longer than this many seconds
    [self.recognizer setVADParameter:KIOSVadTimeoutMaxDuration toValue:20];
    // end silence timeouts (somewhat arbitrary); too long and it may be weird
    // if the user finished. Too short and we may cut them off if they pause for a
    // while.
    [self.recognizer setVADParameter:KIOSVadTimeoutEndSilenceForGoodMatch toValue:1];
    // use the same setting here as for the good match, although this could be
    // slightly longer
    [self.recognizer setVADParameter:KIOSVadTimeoutEndSilenceForAnyMatch toValue:1];
    
    return self;
}

-(void)prepMic {
    if ([MPMediaLibrary authorizationStatus] != MPMediaLibraryAuthorizationStatusAuthorized) {
        [MPMediaLibrary requestAuthorization:^(MPMediaLibraryAuthorizationStatus status) {
            if (status == MPMediaLibraryAuthorizationStatusAuthorized) {
                [self prepareForListening];
            } else {
                NSLog(@"NOT WORKING");
            }
        }];
    } else {
        [self prepareForListening];
    }
}

-(void)prepareForListening {
    [self.recognizer prepareForListeningWithCustomDecodingGraphWithName:@"MyDecodingGraph"];
}

-(void)createDecodingGraph:(NSArray*)phrases {
    if (![KIOSDecodingGraph createDecodingGraphFromSentences:phrases forRecognizer:self.recognizer andSaveWithName:@"MyDecodingGraph"]) {
        NSLog(@"Error while creating decoding graph");
        return;
    } else {
        NSLog(@"created");
    }
}

-(void)startListening {
    [self.recognizer startListening];
}

-(void)stopListening {
    [self.recognizer stopListening];
}

- (void)recognizerFinalResult:(KIOSResult *)result forRecognizer:(KIOSRecognizer *)recognizer {
    
    NSDictionary *dict = @{ @"YES" : @1,
                            @"SURE" : @1,
                            @"ALRIGHT" : @1,
                            @"OKAY" : @1,
                            @"LATER" : @0,
                            @"NO" : @0,
                            @"NOT NOW" : @0,
                            @"NOPE" : @0};
    
    int i = [[dict valueForKey:result.cleanText] intValue];
    [self.delegate intent:i :result.confidence];
    [self.delegate recognized:result.cleanText];
}

@end
