//
//  AppDelegate.m
//  CachedWebView
//
//  Created by Robert Napier on 1/29/12.
//  Copyright (c) 2012 Rob Napier.
//
//  This code is licensed under the MIT License:
//
//  Permission is hereby granted, free of charge, to any person obtaining a
//  copy of this software and associated documentation files (the "Software"),
//  to deal in the Software without restriction, including without limitation
//  the rights to use, copy, modify, merge, publish, distribute, sublicense,
//  and/or sell copies of the Software, and to permit persons to whom the
//  Software is furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
//  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
//  DEALINGS IN THE SOFTWARE.
//

#import "AppDelegate.h"

#import "ViewController.h"
#import "RNCachingURLProtocol.h"

@implementation AppDelegate

@synthesize window = _window;
@synthesize viewController = _viewController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  [NSURLProtocol registerClass:[RNCachingURLProtocol class]];
    
    [RNCachingURLProtocol setEnabled:NO];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(request:)
                                                 name:RNCachingURLProtocolWillStartRequestNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(response:)
                                                 name:RNCachingURLProtocolWillReceiveResponseNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(redirect:)
                                                 name:RNCachingURLProtocolWillRedirectNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(error:)
                                                 name:RNCachingURLProtocolWillFailWithErrorNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(data:)
                                                 name:RNCachingURLProtocolWillReceiveDataNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(finished:)
                                                 name:RNCachingURLProtocolWillFinishNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(stop:)
                                                 name:RNCachingURLProtocolWillStopNotification
                                               object:nil];

  self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
  self.viewController = [[ViewController alloc] initWithNibName:@"ViewController" bundle:nil];
  self.window.rootViewController = self.viewController;
  [self.window makeKeyAndVisible];
  return YES;
}

- (void)request:(NSNotification *)notification {
    [self printNotification:notification];
}

- (void)response:(NSNotification *)notification {
    [self printNotification:notification];
}

- (void)redirect:(NSNotification *)notification {
    [self printNotification:notification];
}

- (void)error:(NSNotification *)notification {
    [self printNotification:notification];
}

- (void)data:(NSNotification *)notification {
    [self printNotification:notification];
}

- (void)finished:(NSNotification *)notification {
    [self printNotification:notification];
}

- (void)stop:(NSNotification *)notification {
    [self printNotification:notification];
}

- (void)printNotification:(NSNotification *)notification {
    NSMutableDictionary *userInfo = [[notification userInfo] mutableCopy];
    if ([userInfo objectForKey:RNCachingURLProtocolDataChunkKey]) {
        [userInfo setObject:[NSData data]
                     forKey:RNCachingURLProtocolDataChunkKey];
    }
    NSLog(@"%@ %@",
           [notification name],
           userInfo);
}

@end
