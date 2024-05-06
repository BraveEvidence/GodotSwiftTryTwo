//
//  arithematic.h
//  arithematic
//
//  Created by Student on 04/05/24.
//

#ifndef ARITHEMATIC_H
#define ARITHEMATIC_H

#ifdef VERSION_4_0
#include "core/object/object.h"
#endif

#ifdef VERSION_3_X
#include "core/object.h"
#endif

//#include <string>
#import <LocalAuthentication/LocalAuthentication.h>

class Arithematic : public Object {

    GDCLASS(Arithematic, Object);

    static Arithematic *instance;

public:
//    int add();
//    int sub(int num1, int num2);
//    void multiply();
    void getAvaiableBiometrics();
    void authenticate();
    static Arithematic *get_singleton();
   
    
    
    Arithematic();
    ~Arithematic();

protected:
    static void _bind_methods();
};

#endif



