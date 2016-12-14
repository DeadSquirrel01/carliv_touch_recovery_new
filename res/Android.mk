LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

LOCAL_MODULE := carliv
LOCAL_MODULE_TAGS := eng
LOCAL_MODULE_CLASS := RECOVERY_EXECUTABLES
LOCAL_MODULE_PATH := $(TARGET_RECOVERY_ROOT_OUT)/ctres
CARLIV_RES_LOC := $(commands_recovery_local_path)/res/images/

CARLIV_RES_GEN := $(intermediates)/carliv
$(CARLIV_RES_GEN):
	mkdir -p $(TARGET_RECOVERY_ROOT_OUT)/ctres/gui/
	cp -fr $(CARLIV_RES_LOC)/* $(TARGET_RECOVERY_ROOT_OUT)/ctres/gui

LOCAL_GENERATED_SOURCES := $(CARLIV_RES_GEN)
LOCAL_SRC_FILES := carliv $(CARLIV_RES_GEN)

include $(BUILD_PREBUILT)
