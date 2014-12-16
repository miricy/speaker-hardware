intermediates := $(local-intermediates-dir)

ifeq ($(SW_BOARD_HAVE_BLUETOOTH_NAME), ap6210)
SRC := $(call my-dir)/include/$(addprefix vnd_, $(addsuffix -ap6210.txt,$(basename $(TARGET_DEVICE))))
endif

ifeq ($(SW_BOARD_HAVE_BLUETOOTH_NAME), ap6330)
SRC := $(call my-dir)/include/$(addprefix vnd_, $(addsuffix -ap6330.txt,$(basename $(TARGET_DEVICE))))
endif

ifeq (,$(wildcard $(SRC)))
# configuration file does not exist. Use default one
SRC := $(call my-dir)/include/vnd_generic.txt
endif
GEN := $(intermediates)/vnd_buildcfg.h
TOOL := $(TOP_DIR)external/bluetooth/bluedroid/tools/gen-buildcfg.sh

$(GEN): PRIVATE_PATH := $(call my-dir)
$(GEN): PRIVATE_CUSTOM_TOOL = $(TOOL) $< $@
$(GEN): $(SRC)  $(TOOL)
	$(transform-generated-source)

LOCAL_GENERATED_SOURCES += $(GEN)
