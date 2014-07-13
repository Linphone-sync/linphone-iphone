//
//  BaseTestsUtils.m
//  linphone
//
//  Created by Guillaume BIENKOWSKI on 13/07/2014.
//
//

#import "BaseTestsUtils.h"

@implementation BaseTestsUtils

- (void)addContactPopupHandler {
    SLAlert* popupHandler = [SLAlert alertWithTitle:@"\"Linphone\" Would Like to Access Your Contacts"];
    SLAlertHandler* handler = [popupHandler dismissWithButtonTitled:@"OK"];
    [SLAlertHandler setLoggingEnabled:TRUE];
    [SLAlertHandler addHandler:handler];
}

- (void)addWizardPopupHandler {
    SLAlert* popupHandler = [SLAlert alertWithTitle:@"Warning"];
    SLAlertHandler* handler = [popupHandler dismissWithButtonTitled:@"Launch Wizard"];
    [SLAlertHandler setLoggingEnabled:TRUE];
    [SLAlertHandler addHandler:handler];
}

- (void)exitWizardIfNecessary {
    SLElement* cancelButton = [SLElement elementWithAccessibilityLabel:@"Cancel"];
    if( [cancelButton isValidAndVisible] ){
        [cancelButton tap];
    }
}

- (void)goToSettings {
    SLElement* settingsButton = [SLElement elementWithAccessibilityLabel:@"Settings"];
    SLAssertTrue([settingsButton isValidAndVisible], @"Not in main view");
    [settingsButton tap];
    [self wait:0.5];
}

- (void)checkIsRegisteredWithDelay:(CGFloat)delay {
    SLElement* registrationState = [SLElement elementWithAccessibilityLabel:@"Registration state"];
    
    SLAssertTrueWithTimeout([registrationState isValidAndVisible],
                            delay,@"No registration state in view");
    
    SLAssertTrueWithTimeout( [[registrationState value] isEqualToString:NSLocalizedString(@"Registered", nil)],
                            delay,
                            @"Not registered");
}

@end
