//
//  BaseTestsUtils.h
//  linphone
//
//  Created by Guillaume BIENKOWSKI on 13/07/2014.
//
//

#import "SLTest.h"

extern NSString* const kTestUsername;
extern NSString* const kTestPassword;
extern NSString* const kTestServer;
extern NSString* const kTestRoute;

@interface BaseTestsUtils : SLTest

- (void)addContactPopupHandler;
- (void)addWizardPopupHandler;

- (void)exitWizardIfNecessary;

- (void)goToSettings;
- (void)goToDialer;

/* Methods to use only in Settings view */
- (void)fillProxyConfigWithTransport:(NSString*)transportType; // make sure you're in settings view

/* Methods to use only in Dialer view */
- (void)checkIsRegisteredWithDelay:(CGFloat)delay;

@end
