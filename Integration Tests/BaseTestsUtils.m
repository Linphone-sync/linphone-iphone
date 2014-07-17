//
//  BaseTestsUtils.m
//  linphone
//
//  Created by Guillaume BIENKOWSKI on 13/07/2014.
//
//

#import "BaseTestsUtils.h"

// keep the \n at the end for keyboard dismiss
NSString* const kTestRoute    = @"sip.linphone.org\n";
NSString* const kTestServer   = @"sip.linphone.org\n";
NSString* const kTestUsername = @"testios\n";
NSString* const kTestPassword = @"testtest\n";


@implementation BaseTestsUtils


#pragma mark - Static constants 

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
    SLButton* cancelButton = [SLButton elementWithAccessibilityLabel:@"Cancel"];
    if( [cancelButton isValidAndVisible] ){
        [cancelButton tap];
    } else {
        SLLog(@"No Cancel button found, skip");
    }
}

- (void)goToSettings {
    [self goToViewWithButton:@"Settings"];
}

- (void)goToDialer {
    [self goToViewWithButton:@"Dialer"];
}

- (void)goToViewWithButton:(NSString*)buttonLabel {

    BOOL (^predicate)(NSObject*) = ^BOOL(NSObject* obj){
        BOOL found = FALSE;
        if( [obj.accessibilityLabel isEqualToString:buttonLabel] ){
            found = [obj.accessibilityHint hasPrefix:@"switch"];
        }
        return found;
    };
    
    SLButton* button = [SLButton elementMatching:predicate withDescription:buttonLabel];
    SLAssertTrue([button isValidAndVisible], @"Not in main view");
    [button tap];
    [self wait:0.5];
}

- (void)fillProxyConfigWithTransport:(NSString*)transportType {
    SLElement* username  = [SLElement elementWithAccessibilityLabel:@"User name"];
    SLElement* password  = [SLElement elementWithAccessibilityLabel:@"Password"];
    SLElement* domain    = [SLElement elementWithAccessibilityLabel:@"Domain"];
    SLElement* proxy     = [SLElement elementWithAccessibilityLabel:@"Proxy"];
    SLElement* transport = [SLElement elementMatching:^BOOL(NSObject *obj) {
        if([[obj accessibilityLabel] hasPrefix:@"Transport"]) return TRUE;
        else return FALSE;
    }
                                      withDescription:@"Transport"];

    [username tap];
    [[SLKeyboard keyboard] typeString:kTestUsername];

    [password tap];
    [[SLKeyboard keyboard] typeString:kTestPassword];

    [domain tap];
    [[SLKeyboard keyboard] typeString:kTestServer];

    [proxy tap];
    [[SLKeyboard keyboard] typeString:kTestRoute];

    // select transport and come back
    [transport tap];
    SLElement* type = [SLElement elementWithAccessibilityLabel:transportType];
    [type tap];

    SLElement* backToSettings = [SLElement elementMatching:^BOOL(NSObject *obj) {
        if( [obj.accessibilityLabel isEqualToString:@"Settings"] &&
           (obj.accessibilityTraits & UIAccessibilityTraitSelected) == 0 ){
            return TRUE;
        } else return FALSE;
    } withDescription:@"Back to settings"];
    [backToSettings tap];
}

- (void)registerForTestAccountIfNecessary {
    [self goToDialer];

    SLElement* registrationState = [SLElement elementWithAccessibilityLabel:@"Registration state"];
    if([registrationState isValidAndVisible] &&
       [[registrationState value] isEqualToString:NSLocalizedString(@"Registered", nil)] ){
        // nothing to do
        SLLog(@"Already registered, skip");
    } else {
        [self goToSettings];
        [self fillProxyConfigWithTransport:@"TCP"];
        [self goToDialer];
        [self checkIsRegisteredWithDelay:10];
    }
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
