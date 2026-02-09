package tuna.input;

enum abstract KeyCode(Int) to Int {
    var Digit0 = 48;
    var Digit1 = 49;
    var Digit2 = 50;
    var Digit3 = 51;
    var Digit4 = 52;
    var Digit5 = 53;
    var Digit6 = 54;
    var Digit7 = 55;
    var Digit8 = 56;
    var Digit9 = 57;
    
    var KeyA = 65;
    var KeyB = 66;
    var KeyC = 67;
    var KeyD = 68;
    var KeyE = 69;
    var KeyF = 70;
    var KeyG = 71;
    var KeyH = 72;
    var KeyI = 73;
    var KeyJ = 74;
    var KeyK = 75;
    var KeyL = 76;
    var KeyM = 77;
    var KeyN = 78;
    var KeyO = 79;
    var KeyP = 80;
    var KeyQ = 81;
    var KeyR = 82;
    var KeyS = 83;
    var KeyT = 84;
    var KeyU = 85;
    var KeyV = 86;
    var KeyW = 87;
    var KeyX = 88;
    var KeyY = 89;
    var KeyZ = 90;
    
    var Backspace = 8;
    var Tab = 9;
    var Enter = 13;
    var Shift = 16;
    var Control = 17;
    var Alt = 18;
    var Pause = 19;
    var CapsLock = 20;
    var Escape = 27;
    var Space = 32;
    var PageUp = 33;
    var PageDown = 34;
    var End = 35;
    var Home = 36;
    
    var ArrowLeft = 37;
    var ArrowUp = 38;
    var ArrowRight = 39;
    var ArrowDown = 40;
    
    var Insert = 45;
    var Delete = 46;
    
    var Numpad0 = 96;
    var Numpad1 = 97;
    var Numpad2 = 98;
    var Numpad3 = 99;
    var Numpad4 = 100;
    var Numpad5 = 101;
    var Numpad6 = 102;
    var Numpad7 = 103;
    var Numpad8 = 104;
    var Numpad9 = 105;
    var NumpadMultiply = 106;
    var NumpadAdd = 107;
    var NumpadSubtract = 109;
    var NumpadDecimal = 110;
    var NumpadDivide = 111;
    
    var F1 = 112;
    var F2 = 113;
    var F3 = 114;
    var F4 = 115;
    var F5 = 116;
    var F6 = 117;
    var F7 = 118;
    var F8 = 119;
    var F9 = 120;
    var F10 = 121;
    var F11 = 122;
    var F12 = 123;
    
    var NumLock = 144;
    var ScrollLock = 145;
    
    var Semicolon = 186;
    var Equal = 187;
    var Comma = 188;
    var Minus = 189;
    var Period = 190;
    var Slash = 191;
    var Backquote = 192;
    var BracketLeft = 219;
    var Backslash = 220;
    var BracketRight = 221;
    var Quote = 222;
    
    @:from public static function fromString(code:String):KeyCode {
        return switch(code) {
            case "Digit0": Digit0;
            case "Digit1": Digit1;
            case "Digit2": Digit2;
            case "Digit3": Digit3;
            case "Digit4": Digit4;
            case "Digit5": Digit5;
            case "Digit6": Digit6;
            case "Digit7": Digit7;
            case "Digit8": Digit8;
            case "Digit9": Digit9;
            
            case "KeyA": KeyA;
            case "KeyB": KeyB;
            case "KeyC": KeyC;
            case "KeyD": KeyD;
            case "KeyE": KeyE;
            case "KeyF": KeyF;
            case "KeyG": KeyG;
            case "KeyH": KeyH;
            case "KeyI": KeyI;
            case "KeyJ": KeyJ;
            case "KeyK": KeyK;
            case "KeyL": KeyL;
            case "KeyM": KeyM;
            case "KeyN": KeyN;
            case "KeyO": KeyO;
            case "KeyP": KeyP;
            case "KeyQ": KeyQ;
            case "KeyR": KeyR;
            case "KeyS": KeyS;
            case "KeyT": KeyT;
            case "KeyU": KeyU;
            case "KeyV": KeyV;
            case "KeyW": KeyW;
            case "KeyX": KeyX;
            case "KeyY": KeyY;
            case "KeyZ": KeyZ;
            
            case "Backspace": Backspace;
            case "Tab": Tab;
            case "Enter": Enter;
            case "Shift" | "ShiftLeft" | "ShiftRight": Shift;
            case "Control" | "ControlLeft" | "ControlRight": Control;
            case "Alt" | "AltLeft" | "AltRight": Alt;
            case "Pause": Pause;
            case "CapsLock": CapsLock;
            case "Escape": Escape;
            case "Space": Space;
            case "PageUp": PageUp;
            case "PageDown": PageDown;
            case "End": End;
            case "Home": Home;
            
            case "ArrowLeft": ArrowLeft;
            case "ArrowUp": ArrowUp;
            case "ArrowRight": ArrowRight;
            case "ArrowDown": ArrowDown;
            
            case "Insert": Insert;
            case "Delete": Delete;
            
            case "Numpad0": Numpad0;
            case "Numpad1": Numpad1;
            case "Numpad2": Numpad2;
            case "Numpad3": Numpad3;
            case "Numpad4": Numpad4;
            case "Numpad5": Numpad5;
            case "Numpad6": Numpad6;
            case "Numpad7": Numpad7;
            case "Numpad8": Numpad8;
            case "Numpad9": Numpad9;
            case "NumpadMultiply": NumpadMultiply;
            case "NumpadAdd": NumpadAdd;
            case "NumpadSubtract": NumpadSubtract;
            case "NumpadDecimal": NumpadDecimal;
            case "NumpadDivide": NumpadDivide;
            
            case "F1": F1;
            case "F2": F2;
            case "F3": F3;
            case "F4": F4;
            case "F5": F5;
            case "F6": F6;
            case "F7": F7;
            case "F8": F8;
            case "F9": F9;
            case "F10": F10;
            case "F11": F11;
            case "F12": F12;
            
            case "NumLock": NumLock;
            case "ScrollLock": ScrollLock;
            
            case "Semicolon": Semicolon;
            case "Equal": Equal;
            case "Comma": Comma;
            case "Minus": Minus;
            case "Period": Period;
            case "Slash": Slash;
            case "Backquote": Backquote;
            case "BracketLeft": BracketLeft;
            case "Backslash": Backslash;
            case "BracketRight": BracketRight;
            case "Quote": Quote;
            
            default: cast 0;
        }
    }
    
    @:from public static function fromSDL2(sdlKey:Int):KeyCode {
        return switch(sdlKey) {
            case 48: Digit0;
            case 49: Digit1;
            case 50: Digit2;
            case 51: Digit3;
            case 52: Digit4;
            case 53: Digit5;
            case 54: Digit6;
            case 55: Digit7;
            case 56: Digit8;
            case 57: Digit9;
            
            case 97: KeyA;
            case 98: KeyB;
            case 99: KeyC;
            case 100: KeyD;
            case 101: KeyE;
            case 102: KeyF;
            case 103: KeyG;
            case 104: KeyH;
            case 105: KeyI;
            case 106: KeyJ;
            case 107: KeyK;
            case 108: KeyL;
            case 109: KeyM;
            case 110: KeyN;
            case 111: KeyO;
            case 112: KeyP;
            case 113: KeyQ;
            case 114: KeyR;
            case 115: KeyS;
            case 116: KeyT;
            case 117: KeyU;
            case 118: KeyV;
            case 119: KeyW;
            case 120: KeyX;
            case 121: KeyY;
            case 122: KeyZ;
            
            case 8: Backspace;
            case 9: Tab;
            case 13: Enter;
            case 27: Escape;
            case 32: Space;
            
            case 0x4000004A: Home;
            case 0x4000004D: End;
            case 0x4000004B: PageUp;
            case 0x4000004E: PageDown;
            
            case 0x40000050: ArrowLeft;
            case 0x40000052: ArrowUp;
            case 0x4000004F: ArrowRight;
            case 0x40000051: ArrowDown;
            
            case 0x40000049: Insert;
            case 0x4000004C: Delete;
            
            case 0x4000003A: F1;
            case 0x4000003B: F2;
            case 0x4000003C: F3;
            case 0x4000003D: F4;
            case 0x4000003E: F5;
            case 0x4000003F: F6;
            case 0x40000040: F7;
            case 0x40000041: F8;
            case 0x40000042: F9;
            case 0x40000043: F10;
            case 0x40000044: F11;
            case 0x40000045: F12;
            
            case 0x400000E1: Shift;
            case 0x400000E5: Shift;
            case 0x400000E0: Control;
            case 0x400000E4: Control;
            case 0x400000E2: Alt;
            case 0x400000E6: Alt;
            
            case 0x40000039: CapsLock;
            case 0x40000053: NumLock;
            case 0x40000047: ScrollLock;
            case 0x40000048: Pause;
            
            case 0x40000062: Numpad0;
            case 0x40000059: Numpad1;
            case 0x4000005A: Numpad2;
            case 0x4000005B: Numpad3;
            case 0x4000005C: Numpad4;
            case 0x4000005D: Numpad5;
            case 0x4000005E: Numpad6;
            case 0x4000005F: Numpad7;
            case 0x40000060: Numpad8;
            case 0x40000061: Numpad9;
            
            case 0x40000055: NumpadMultiply;
            case 0x40000057: NumpadAdd;
            case 0x40000056: NumpadSubtract;
            case 0x40000063: NumpadDecimal;
            case 0x40000054: NumpadDivide;
            
            case 59: Semicolon;
            case 61: Equal;
            case 44: Comma;
            case 45: Minus;
            case 46: Period;
            case 47: Slash;
            case 96: Backquote;
            case 91: BracketLeft;
            case 92: Backslash;
            case 93: BracketRight;
            case 39: Quote;
            
            default: cast 0;
        }
    }
}