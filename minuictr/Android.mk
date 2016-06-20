LOCAL_PATH := $(call my-dir)
include $(CLEAR_VARS)

LOCAL_CFLAGS += -Wno-unused-parameter
LOCAL_SRC_FILES := graphics_overlay.c events.c resources.c
ifneq ($(BOARD_CUSTOM_GRAPHICS),)
  LOCAL_SRC_FILES += $(BOARD_CUSTOM_GRAPHICS)
else
  LOCAL_SRC_FILES += graphics.c
endif

ifeq ($(TARGET_USES_QCOM_BSP), true)
  LOCAL_CFLAGS += -DMSM_BSP
  ifeq ($(TARGET_PREBUILT_KERNEL),)
    LOCAL_ADDITIONAL_DEPENDENCIES := $(TARGET_OUT_INTERMEDIATES)/KERNEL_OBJ/usr
    LOCAL_C_INCLUDES += $(TARGET_OUT_INTERMEDIATES)/KERNEL_OBJ/usr/include
  else
    ifeq ($(TARGET_CUSTOM_KERNEL_HEADERS),)
      LOCAL_C_INCLUDES += $(commands_recovery_local_path)/minuictr/include
    else
      LOCAL_C_INCLUDES += $(TARGET_CUSTOM_KERNEL_HEADERS)
    endif
  endif
else
	LOCAL_C_INCLUDES += $(commands_recovery_local_path)/minuictr/include
endif

LOCAL_C_INCLUDES += \
	$(commands_recovery_local_path)/minuictr/fonts \
    external/libpng \
    external/zlib \
    system/core/libpixelflinger/include \
    system/core/include/pixelflinger

LOCAL_STATIC_LIBRARIES += libpng
LOCAL_WHOLE_STATIC_LIBRARIES := libpixelflinger_static
LOCAL_MODULE := libminuictr

ifeq ($(subst ",,$(TARGET_RECOVERY_PIXEL_FORMAT)),ABGR_8888)
  LOCAL_CFLAGS += -DRECOVERY_ABGR
endif
ifeq ($(subst ",,$(TARGET_RECOVERY_PIXEL_FORMAT)),RGBA_8888)
  LOCAL_CFLAGS += -DRECOVERY_RGBA
endif
ifeq ($(subst ",,$(TARGET_RECOVERY_PIXEL_FORMAT)),RGBX_8888)
  LOCAL_CFLAGS += -DRECOVERY_RGBX
endif
ifeq ($(subst ",,$(TARGET_RECOVERY_PIXEL_FORMAT)),BGRA_8888)
  LOCAL_CFLAGS += -DRECOVERY_BGRA
endif

ifneq ($(TARGET_RECOVERY_OVERSCAN_PERCENT),)
  LOCAL_CFLAGS += -DOVERSCAN_PERCENT=$(TARGET_RECOVERY_OVERSCAN_PERCENT)
else
  LOCAL_CFLAGS += -DOVERSCAN_PERCENT=0
endif

ifeq ($(BOARD_HAS_FLIPPED_SCREEN), true)
LOCAL_CFLAGS += -DBOARD_HAS_FLIPPED_SCREEN
endif

ifneq ($(BOARD_USE_CUSTOM_RECOVERY_FONT),)
  LOCAL_CFLAGS += -DBOARD_USE_CUSTOM_RECOVERY_FONT=$(BOARD_USE_CUSTOM_RECOVERY_FONT)
endif

ifneq ($(TARGET_RECOVERY_LCD_BACKLIGHT_PATH),)
  LOCAL_CFLAGS += -DRECOVERY_LCD_BACKLIGHT_PATH=\"$(TARGET_RECOVERY_LCD_BACKLIGHT_PATH)\"
endif

include $(BUILD_STATIC_LIBRARY)
