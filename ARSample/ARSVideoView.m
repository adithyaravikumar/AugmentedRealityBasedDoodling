//
//  ARSVideoView.m
//  ARSample
//
//  Created by Adithya Ravikumar on 12/8/13.
//  Copyright (c) 2013 Nothing. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
#import "ARSVideoView.h"

@interface ARSVideoView()<AVCaptureVideoDataOutputSampleBufferDelegate>
@property (nonatomic, strong) AVCaptureSession *captureSession;
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *captureVideoPreviewLayer;
@end

@implementation ARSVideoView

- (instancetype) initWithFrame: (CGRect) frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupVideo];
    }
    return self;
}

- (void) setupVideo
{
    AVCaptureDevice *inputDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    AVCaptureDeviceInput *captureInput = [AVCaptureDeviceInput deviceInputWithDevice:inputDevice error:nil];
    if (!captureInput) {
        return;
    }
    AVCaptureVideoDataOutput *captureOutput = [[AVCaptureVideoDataOutput alloc] init];
    /* captureOutput:didOutputSampleBuffer:fromConnection delegate method !*/
    [captureOutput setSampleBufferDelegate:self queue:dispatch_get_main_queue()];
    NSString* key = (NSString*)kCVPixelBufferPixelFormatTypeKey;
    NSNumber* value = [NSNumber numberWithUnsignedInt:kCVPixelFormatType_32BGRA];
    NSDictionary* videoSettings = [NSDictionary dictionaryWithObject:value forKey:key];
    [captureOutput setVideoSettings:videoSettings];
    self.captureSession = [[AVCaptureSession alloc] init];
    NSString* preset = 0;
    if (!preset) {
        preset = AVCaptureSessionPresetMedium;
    }
    self.captureSession.sessionPreset = preset;
    if ([self.captureSession canAddInput:captureInput]) {
        [self.captureSession addInput:captureInput];
    }
    if ([self.captureSession canAddOutput:captureOutput]) {
        [self.captureSession addOutput:captureOutput];
    }
    
    //handle prevLayer
    if (!self.captureVideoPreviewLayer) {
        self.captureVideoPreviewLayer = [AVCaptureVideoPreviewLayer layerWithSession:self.captureSession];
    }
    
    //if you want to adjust the previewlayer frame, here!
    self.captureVideoPreviewLayer.frame = self.bounds;
    self.captureVideoPreviewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    [self.layer addSublayer: self.captureVideoPreviewLayer];
    [self.captureSession startRunning];
}

@end
