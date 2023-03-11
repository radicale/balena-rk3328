PACKAGES =+ " \
	${PN}-ap6256-wifi \
	${PN}-ap6256-bt \
"
FILES:${PN}-ap6256-wifi = " \
        lib/firmware/fw_bcm43456c5_ag.bin \
        lib/firmware/nvram_ap6256.txt \
"
FILES:${PN}-ap6256-bt = " \
        lib/firmware/BCM4345C5.hcd \
"
