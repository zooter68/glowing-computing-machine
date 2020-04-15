LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

LOCAL_MODULE := TrivialQuestNativeActivity
LOCAL_SRC_FILES := TrivialQuestNativeActivity.cpp \
 TrivialQuestNativeActivity_Engine.cpp \
 TeapotRenderer.cpp
  
LOCAL_CFLAGS :=
LOCAL_CPPFLAGS := -std=c++11

LOCAL_LDLIBS := -llog -landroid -lEGL -lGLESv2 -latomic -lz
LOCAL_STATIC_LIBRARIES := cpufeatures android_native_app_glue ndk_helper jui_helper gpg-1

#hard-fp setting
ifneq ($(filter %armeabi-v7a,$(TARGET_ARCH_ABI)),)
#For now, only armeabi-v7a is supported for hard-fp
#adding compiler/liker flags specifying hard float ABI for user code and math library
LOCAL_CFLAGS += -mhard-float -D_NDK_MATH_NO_SOFTFP=1
LOCAL_LDLIBS += -lm_hard
ifeq (,$(filter -fuse-ld=mcld,$(APP_LDFLAGS) $(LOCAL_LDFLAGS)))
#Supressing warn-mismatch warnings
LOCAL_LDFLAGS += -Wl,--no-warn-mismatch
endif
endif

include $(BUILD_SHARED_LIBRARY)

include $(LOCAL_PATH)/../../../../Common/gpg-sdk/gpg-cpp-sdk/android/Android.mk

$(call import-add-path,$(LOCAL_PATH)/../../../../Common)
$(call import-module,ndk_helper)
$(call import-module,jui_helper)
$(call import-module,android/native_app_glue)
$(call import-module,android/cpufeatures)
