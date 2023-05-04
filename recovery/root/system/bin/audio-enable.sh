#!/system/bin/sh

ENABLE=$1

#tinymix '     ' $([ "$ENABLE" == 1 ] && echo -n "1" || echo -n "0")

# Enable BE DAI
tinymix 'PRI_MI2S_RX Audio Mixer MultiMedia1' $([ "$ENABLE" == 1 ] && echo -n "1" || echo -n "0")

# Enable device specific mixers
case "$(getprop ro.product.device)" in
	"land")
		tinymix "MI2S_RX Channels" "One"
		tinymix "RX2 MIX1 INP1" $([ "$ENABLE" == 1 ] && echo -n "RX2" || echo -n "ZERO")
		tinymix "RDAC2 MUX" $([ "$ENABLE" == 1 ] && echo -n "RX2" || echo -n "ZERO")
		tinymix "HPHR" $([ "$ENABLE" == 1 ] && echo -n "Switch" || echo -n "ZERO")
		tinymix "SPK PA GPIO Switch" $([ "$ENABLE" == 1 ] && echo -n "1" || echo -n "0")
		;;
	"prada")
		tinymix "RX2 MIX1 INP1" $([ "$ENABLE" == 1 ] && echo -n "RX2" || echo -n "ZERO")
		tinymix "RDAC2 MUX" $([ "$ENABLE" == 1 ] && echo -n "RX2" || echo -n "ZERO")
		tinymix "HPHR" $([ "$ENABLE" == 1 ] && echo -n "Switch" || echo -n "ZERO")
		tinymix "SPK PA GPIO Switch" $([ "$ENABLE" == 1 ] && echo -n "1" || echo -n "0")
		;;
	"riva"|"rolex")
		tinymix "MI2S_RX Channels" "One"
		tinymix "RX2 MIX1 INP1" $([ "$ENABLE" == 1 ] && echo -n "RX2" || echo -n "ZERO")
		tinymix "RDAC2 MUX" $([ "$ENABLE" == 1 ] && echo -n "RX2" || echo -n "ZERO")
#		tinymix "HPHL" $([ "$ENABLE" == 1 ] && echo -n "Switch" || echo -n "ZERO")
		tinymix "HPHR" $([ "$ENABLE" == 1 ] && echo -n "Switch" || echo -n "ZERO")
		tinymix "SPK PA GPIO Switch" $([ "$ENABLE" == 1 ] && echo -n "1" || echo -n "0")
		;;
	"santoni")
		tinymix "MI2S_RX Channels" "One"
		tinymix "RX2 MIX1 INP1" $([ "$ENABLE" == 1 ] && echo -n "RX2" || echo -n "ZERO")
		tinymix "RDAC2 MUX" $([ "$ENABLE" == 1 ] && echo -n "RX2" || echo -n "ZERO")
		tinymix "HPHR" $([ "$ENABLE" == 1 ] && echo -n "Switch" || echo -n "ZERO")
		tinymix "MI8937 AW87319 PA Switch" $([ "$ENABLE" == 1 ] && echo -n "1" || echo -n "0")
		;;
	"ugg"|"ugglite")
		tinymix "SPK PA GPIO Switch" $([ "$ENABLE" == 1 ] && echo -n "1" || echo -n "0")
		tinymix "MI2S_RX Channels" "One"
		tinymix "RX1 MIX1 INP1" $([ "$ENABLE" == 1 ] && echo -n "RX1" || echo -n "ZERO")
		tinymix "RX2 MIX1 INP1" $([ "$ENABLE" == 1 ] && echo -n "RX2" || echo -n "ZERO")
		tinymix "RX HPH Mode" $([ "$ENABLE" == 1 ] && echo -n "HD2" || echo -n "NORMAL")
		tinymix "RDAC2 MUX" $([ "$ENABLE" == 1 ] && echo -n "RX2" || echo -n "ZERO")
		tinymix "HPHL" $([ "$ENABLE" == 1 ] && echo -n "Switch" || echo -n "ZERO")
		tinymix "HPHR" $([ "$ENABLE" == 1 ] && echo -n "Switch" || echo -n "ZERO")
		;;
	*)
		log "Could not enable audio, Device is unsupported!"
		exit 1;
		;;
esac

setprop "audio.ready" "$ENABLE"

exit 0
