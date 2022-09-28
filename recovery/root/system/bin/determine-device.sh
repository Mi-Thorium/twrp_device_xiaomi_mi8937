#!/system/bin/sh

source /system/bin/mithorium-utils.sh

workaround_gpio_flashlight() {
	echo 1 > /sys/class/leds/flashlight/max_brightness;
	echo 0 > /sys/class/leds/flashlight/brightness;
}

case "$(cat /sys/firmware/devicetree/base/model)" in
	"Qualcomm Technologies, Inc. MSM8917-PMI8937 QRD SKU5")
		if [ -e /sys/class/leds/infrared/transmit ]; then
			set_device_codename "rolex"
			set_device_model "Redmi 4A"
		else
			set_device_codename "riva"
			set_device_model "Redmi 5A (Nougat bootloader)"
		fi
		workaround_gpio_flashlight
		;;
	"Qualcomm Technologies, Inc. MSM8917 QRD SKU5")
		set_device_codename "riva"
		set_device_model "Redmi 5A (Oreo bootloader)"
		workaround_gpio_flashlight
		;;
	"Qualcomm Technologies, Inc. MSM8917-PMI8937 MTP")
		set_device_codename "ugglite"
		set_device_model "Redmi Note 5A / Y1 Lite"
		workaround_gpio_flashlight
		;;
	"Qualcomm Technologies, Inc. MSM8940-PMI8937 MTP")
		set_device_codename "ugg"
		set_device_model "Redmi Note 5A / Y1 Prime"
		workaround_gpio_flashlight
		;;
	"Qualcomm Technologies, Inc. MSM8937-PMI8950 QRD SKU1")
		set_device_codename "land"
		set_device_model "Redmi 3S / 3X"
		start hvdcp_opti
		;;
	"Qualcomm Technologies, Inc. MSM8940-PMI8950 QRD SKU7")
		set_device_codename "santoni"
		set_device_model "Redmi 4X"
		start hvdcp_opti
		;;
	"Qualcomm Technologies, Inc. MSM8937-PMI8950 MTP")
		set_device_codename "prada"
		set_device_model "Redmi 4 Standard"
		start hvdcp_opti
		;;
esac

exit 0