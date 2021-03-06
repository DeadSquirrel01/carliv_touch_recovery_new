/*
 * Copyright (C) 2009 The Android Open Source Project
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#include <linux/input.h>

#include "recovery_ui.h"
#include "common.h"
#include "extendedcommands.h"

char* MENU_HEADERS[] = { NULL };

#ifdef USE_CWM_GRAPHICS
char* MENU_ITEMS[] = { "reboot system now",
                       "install zip",
                       "wipe partitions",
                       "backup and restore",
                       "mounts and storage",
                       "advanced",
                       "power",
                       "enable vibration",
                       NULL };
#else
char* MENU_ITEMS[] = { "Reboot Phone",
                       "Install zip",
                       "Wipe Menu",
                       "Backup/Restore",
                       "Mounts/Storage",
                       "Advanced Menu",
                       "Carliv Menu",
                       "Power Menu",
                       "Vibrate ON/OFF(touch)",
                       NULL };
#endif

void device_ui_init(UIParameters* ui_parameters) {
}

int device_recovery_start() {
    fast_ui_init();
    return 0;
}

// add here any key combo check to reboot device
int device_reboot_now(volatile char* key_pressed, int key_code) {
    return 0;
}

int device_perform_action(int which) {
    return which;
}


int device_wipe_data() {
    return 0;
}

int device_wipe_cache() {
    return 0;
}

int device_wipe_dalvik_cache() {
    return 0;
}

#ifndef USE_CWM_GRAPHICS
int device_wipe_battery_stats() {
    return 0;
}
#endif

int device_wipe_system() {
    return 0;
}
