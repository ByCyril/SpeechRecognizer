//
//  ViewController.h
//  KeenASR_SpeechRecognizer
//
//  Created by Cyril Garcia on 6/26/19.
//  Copyright © 2019 Cyril Garcia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KeenASR/KeenASR.h"
#import "SpeechRecognizerModel.h"

@interface ViewController : UIViewController <KIOSRecognizerDelegate, SpeechRecognizerModelDelegate>


@end

