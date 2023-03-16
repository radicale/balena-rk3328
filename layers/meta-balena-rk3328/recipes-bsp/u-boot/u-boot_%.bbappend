FILESEXTRAPATHS:prepend := "${THISDIR}/files:"
UBOOT_KCONFIG_SUPPORT = "1"
inherit resin-u-boot

SRC_URI:append = " \
    file://balenaos_bootcommand.cfg \
"

do_install:append() {
	KERNEL_CMDLINE_ARGS="earlycon=uart8250,mmio32,0xff130000 swiotlb=1 kpti=0 console=ttyFIQ0 rw \${resin_kernel_root} rootfstype=ext4 rootwait"

	# Create extlinux config file for internal image
	mkdir -p ${D}/boot/extlinux || true
	cat >${D}/boot/extlinux/extlinux.conf <<EOF
default BalenaOS

label BalenaOS
    kernel /boot/${KERNEL_IMAGETYPE}

    devicetree /boot/$(echo "${KERNEL_DEVICETREE}" | cut -d '/' -f 2)
    append ${KERNEL_CMDLINE_ARGS}
EOF

	install -m 0644 idblock.img trust.img ${D}/boot
}

# repackage u-boot so that it leaves out the blobless files which we'll package separately
FILES:${PN} = "/boot/uboot*.bin"

PACKAGES += "${PN}-blobless"

# package u-boot with bl31 only (no additional Rockchip blobs)
FILES:${PN}-blobless = " \
    /boot/idblock.img \
    /boot/trust.img \
    /boot/uboot.img \
"

FILES:${PN}-extlinux = "/boot/extlinux/extlinux.conf"
