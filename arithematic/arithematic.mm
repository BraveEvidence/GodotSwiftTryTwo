//
//  arithematic.m
//  arithematic
//
//  Created by Student on 04/05/24.
//


#import <Foundation/Foundation.h>

#import "arithematic-Swift.h"
#ifdef VERSION_4_0
#include "core/object/class_db.h"
#else
#include "core/class_db.h"
#endif

#include "arithematic.h"


ArithemticSwift *arithemticSwift = [[ArithemticSwift alloc] init];

Arithematic *Arithematic::instance = NULL;

Arithematic::Arithematic() {
    instance = this;
    NSLog(@"initialize arithematic");
}

Arithematic::~Arithematic() {
    if (instance == this) {
        instance = NULL;
    }
    NSLog(@"deinitialize arithematic");
}

Arithematic *Arithematic::get_singleton() {
    return instance;
};


void Arithematic::_bind_methods() {
//    ADD_SIGNAL(MethodInfo("multiply_result", PropertyInfo(Variant::STRING, "result")));
    ADD_SIGNAL(MethodInfo("authenticate_result", PropertyInfo(Variant::STRING, "result")));
    ADD_SIGNAL(MethodInfo("error_msg", PropertyInfo(Variant::STRING, "msg")));
    ADD_SIGNAL(MethodInfo("biometric_data", PropertyInfo(Variant::STRING, "data")));
    
//    ClassDB::bind_method("add", &Arithematic::add);
//    ClassDB::bind_method("sub", &Arithematic::sub);
//    ClassDB::bind_method("multiply", &Arithematic::multiply);
    ClassDB::bind_method("getAvaiableBiometrics", &Arithematic::getAvaiableBiometrics);
    ClassDB::bind_method("authenticate", &Arithematic::authenticate);
}

void Arithematic::getAvaiableBiometrics(){
    if (@available(iOS 11.0, *)) {
        LAContext *authContext = [[LAContext alloc] init];
        NSError *error = nil;
        BOOL canEvaluate = [authContext canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error];
        
        if (canEvaluate) {
            switch (authContext.biometryType) {
                case LABiometryTypeNone:
                    emit_signal("biometric_data","NoBiometricFound");
                    break;
                case LABiometryTypeTouchID:
                    emit_signal("biometric_data","FINGERPRINT");
                    break;
                case LABiometryTypeFaceID:
                    emit_signal("biometric_data","FACE");
                    break;
                default:
                    emit_signal("biometric_data","UnKnown Error");
                    break;
            }
        } else {
            emit_signal("biometric_data","BiometricNotAvailable");
        }
    } else {
        emit_signal("biometric_data","Error");
    }
    
    
}

void Arithematic::authenticate(){
    LAContext *context = [[LAContext alloc] init];
    NSError *error = nil;
    if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]) {
        [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics
                localizedReason:@"Are you the device owner?"
                          reply:^(BOOL success, NSError *error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (error) {
                    emit_signal("error_msg","There was a problem verifying your identity");
                }
                
                if (success) {
                    //             resolve(@"true");
                    emit_signal("authenticate_result","Success");
                } else {
                    //             reject(@"Fail",@"You are not the device owner.",nil);
                    emit_signal("error_msg","You are not the device owner");
                }
            });
        }];
        
    } else {
        //       reject(@"Fail",@"Your device cannot authenticate",nil);
        emit_signal("error_msg","Your device cannot authenticate");
    }
}

//int Arithematic::add() {
//    int num1 = 5; // First hardcoded number
//    int num2 = 10; // Second hardcoded number
//    
//    int result = num1 + num2;
//    //    NSLog(@"Result of addition: %d", result);
//    
//    //    int swiftResult = [arithemticSwift add];
//    
//    return result;
//}
//
//int Arithematic::sub(int num1, int num2) {
//    int result = num1 - num2;
//    NSLog(@"Result of subtraction: %d", result);
//    return result;
//    
//    //    int swiftResult = [arithemticSwift subWithNum1:num1 num2:num2];
//    //    return swiftResult;
//}
//
//
//void Arithematic::multiply(){
//    emit_signal("multiply_result", "Hello from Godot");
//}

