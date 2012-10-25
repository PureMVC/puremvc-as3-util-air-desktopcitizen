## [PureMVC](http://puremvc.github.com/) [ActionScript 3](https://github.com/PureMVC/puremvc-as3-standard-framework/wiki) Utility: Desktop Citizen (AIR)
This utility provides the ability for PureMVC-based AIR applications remember their window size, position, and maximized state each time it is launched. It also provides a facility for requiring confirmation (or executing some shutdown process) before the application window closes.

Standard and MultiCore versions are included.

* [API Docs](http://darkstar.puremvc.org/content_header.html?url=http://puremvc.org/pages/docs/AS3/Utility_AS3_AIR_DesktopCitizen/asdoc/&desc=PureMVC%20Standard%20Docs%20AS3%20Utility:%20Desktop%20Citizen)
* [Discussion](http://forums.puremvc.org/index.php?topic=262)

## Status
Production - [Version 1.3](https://github.com/PureMVC/puremvc-as3-util-air-desktopcitizen/blob/master/VERSION)

## PureMVC Utilities Used
* [XML Database](https://github.com/PureMVC/puremvc-as3-util-air-xmldatabase/wiki)

## Demos Using This Utility
* [CodePeek](https://github.com/PureMVC/puremvc-as3-demo-air-codepeek/wiki)
* [RSS Headlines](https://github.com/PureMVC/puremvc-as3-demo-air-rssheadlines/wiki)

## Platforms / Technologies
* [ActionScript 3](http://en.wikipedia.org/wiki/ActionScript)
* [Flash](http://en.wikipedia.org/wiki/Adobe_flash)
* [Flex](http://en.wikipedia.org/wiki/Adobe_Flex)
* [AIR](http://en.wikipedia.org/wiki/Adobe_AIR)

## Changes in 1.3
* Added support for WindowedApplication (previously only Application was supported). 
* Added ENABLE_CONFIRM/CONFIRM_CLOSING notes that give you a hook into the process of closing a window. Major thanks to Ondina for [the work she did on this](http://forums.puremvc.org/index.php?topic=1107.msg5092).
* Refactored the note naming scheme. Don't worry, it's backward compatible as long as you were using the DesktopCitizenConstants before, I just changed how the note names are composed and added the two new ones.

## Changes in 1.2.1
* Moved constructor actions to onRegister. 

## Changes in 1.2
* Added !MultiCore support. 
* No Standard version functionality changes except renaming source tree, therefore, there is no need to migrate Standard version apps to 1.2 unless you're also migrating to MultiCore.

## Changes in 1.1
* Moved source code into src folder. No functionality changed.

## Features in 1.0 
* Manages an XML Database with the information about the main application window's position, size and state (WindowMetrics)
* Reads the Window Metrics at startup, applies to the main window then sends a notification that the window is ready to be shown.
* Allows the window to be sized and positioned BEFORE being shown so that it doesn't flash up at a default size, then resize, causing visual repaint.  

## License
* PureMVC Utility for AS3 / AIR - Desktop Citizen - Copyright © 2007-2011 Cliff Hall 
* PureMVC - Copyright © 2007-2012 Futurescale, Inc.
* All rights reserved.

* Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:

  * Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
  * Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
  * Neither the name of Futurescale, Inc., PureMVC.org, nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.