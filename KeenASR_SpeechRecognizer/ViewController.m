//
//  ViewController.m
//  KeenASR_SpeechRecognizer
//
//  Created by Cyril Garcia on 6/26/19.
//  Copyright © 2019 Cyril Garcia. All rights reserved.
//

#import "ViewController.h"
#import "SpeechRecognizerModel.h"
@import MediaPlayer;

@interface ViewController ()
@property (nonatomic, strong) IBOutlet UILabel *responseLabel;
@property (nonatomic, strong) IBOutlet UILabel *confidenceLebel;

@property (nonatomic, weak) KIOSRecognizer *recognizer;
@property (nonatomic, strong) SpeechRecognizerModel *speechRecognizerModel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.speechRecognizerModel = [[SpeechRecognizerModel alloc] init];
    
    self.speechRecognizerModel.delegate = self;
    
    [self.speechRecognizerModel prepMic];
    
    NSArray *phrases = @[@"yes", @"no", @"sure", @"not now", @"go ahead", @"later", @"alright"];
    [self.speechRecognizerModel createDecodingGraph:phrases];
    
}

-(IBAction)startListening:(id)sender {
    [self.speechRecognizerModel startListening];
}

- (void)intent:(int)intent :(NSNumber *)confidenceLevel {
    if (intent == 1) {
        NSLog(@"True");
    } else {
        NSLog(@"False");
    }
}

- (void)recognized:(NSString *)text {
    NSLog(@"Recognized text:%@",text);
}
@end
