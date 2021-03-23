$(call inherit-product, $(SRC_TARGET_DIR)/product/languages_full.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full.mk)

PRODUCT_NAME   := goldfish2
PRODUCT_DEVICE := goldfish2
PRODUCT_BRAND  := goldfish2_brand
PRODUCT_MODEL  := goldfish2_model

# Define u-boot and kernel path and configuration
TARGET_U_BOOT_SOURCE := u-boot
TARGET_U_BOOT_CONFIG := goldfish_config

TARGET_KERNEL_SOURCE := kernel
TARGET_KERNEL_CONFIG := goldfish_armv7_defconfig

PRODUCT_OUT ?= out/target/product/goldfish2

include $(TARGET_KERNEL_SOURCE)/Android.mk
include $(TARGET_U_BOOT_SOURCE)/Android.mk

# Define u-boot images
TARGET_KERNEL_UIMAGE := $(PRODUCT_OUT)/zImage.uimg
TARGET_RAMDISK_UIMAGE := $(PRODUCT_OUT)/ramdisk.uimg

# Define build targets for kernel, U-Boot and U-Boot images
.PHONY: $(TARGET_PREBUILT_KERNEL) $(TARGET_PREBUILT_U-BOOT) $(TARGET_KERNEL_UIMAGE) $(TARGET_RAMDISK_UIMAGE)

$(TARGET_KERNEL_UIMAGE): $(TARGET_PREBUILT_KERNEL)
	mkimage -A arm -C none -O linux -T kernel -d $(TARGET_PREBUILT_INT_KERNEL) -a 0x00010000 -e 0x00010000 $(TARGET_KERNEL_UIMAGE)

$(TARGET_RAMDISK_UIMAGE): $(PRODUCT_OUT)/ramdisk.img
	mkimage -A arm -C none -O linux -T ramdisk -d $(PRODUCT_OUT)/ramdisk.img -a 0x00800000 -e 0x00800000 $(TARGET_RAMDISK_UIMAGE)

LOCAL_U_BOOT := $(TARGET_PREBUILT_U-BOOT)
LOCAL_KERNEL := $(TARGET_PREBUILT_KERNEL)
LOCAL_KERNEL_UIMAGE := $(TARGET_KERNEL_UIMAGE)
LOCAL_RAMDISK_UIMAGE := $(TARGET_RAMDISK_UIMAGE)

PRODUCT_COPY_FILES += \
     $(LOCAL_U_BOOT):u-boot.bin \
     $(LOCAL_KERNEL):kernel \
     $(LOCAL_KERNEL_UIMAGE):system/zImage.uimg \
     $(LOCAL_RAMDISK_UIMAGE):system/ramdisk.uimg
