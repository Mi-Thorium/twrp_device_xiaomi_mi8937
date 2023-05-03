#!/system/bin/sh

source /system/bin/mithorium-utils.sh

workaround_gpio_flashlight() {
	echo 1 > /sys/class/leds/flashlight/max_brightness;
	echo 0 > /sys/class/leds/flashlight/brightness;
}

set_device_codename "$(cat /sys/xiaomi-msm8937-mach/codename)"
set_device_model "$(cat /sys/xiaomi-msm8937-mach/product_name)"

if [ "$(cat /sys/class/leds/flashlight/device/of_node/compatible)" == "qcom,leds-gpio-flash" ]; then
	workaround_gpio_flashlight
fi

exit 0
