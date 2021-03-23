LOCAL_PATH := $(call my-dir)
include $(CLEAR_VARS)

ifneq ($(filter goldfish2,$(TARGET_DEVICE)),)
include $(call all-makefiles-under,$(LOCAL_PATH))
endif
