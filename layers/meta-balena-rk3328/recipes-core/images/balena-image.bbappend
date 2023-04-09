# we need to set aside some space at the beginning for writing u-boot before our partitions
DEVICE_SPECIFIC_SPACE = "16384"
BALENA_IMAGE_ALIGNMENT = "8192"

# add the dtb, extlinux.conf and u-boot binaries to rootfs /boot directory
IMAGE_INSTALL:append = " \
    kernel-devicetree \
    u-boot-extlinux \
    u-boot-blobless \
"

IDBLOCK_NAME = "idblock"
IDBLOCK_START = "32"

UBOOT_NAME = "uboot"
UBOOT_START = "8192"

TRUST_NAME = "trust"
TRUST_START = "12288"


device_specific_configuration() {
    #parted -s ${BALENA_RAW_IMG} unit KiB mkpart ${UBOOT_NAME} ${UBOOT_START} ${TRUST_START}
    #parted -s ${BALENA_RAW_IMG} unit KiB mkpart ${TRUST_NAME} ${TRUST_START} ${DEVICE_SPECIFIC_SPACE}
    dd if=${DEPLOY_DIR_IMAGE}/${IDBLOCK_NAME}.img of=${BALENA_RAW_IMG} conv=notrunc bs=1024 seek=${IDBLOCK_START}
    dd if=${DEPLOY_DIR_IMAGE}/${UBOOT_NAME}.img of=${BALENA_RAW_IMG} conv=notrunc bs=1024 seek=${UBOOT_START}
    dd if=${DEPLOY_DIR_IMAGE}/${TRUST_NAME}.img of=${BALENA_RAW_IMG} conv=notrunc bs=1024 seek=${TRUST_START}
}
IMAGE_CMD:balenaos-img:append() {
    parted -s ${BALENA_RAW_IMG} unit KiB mkpart ${UBOOT_NAME} ${UBOOT_START} ${TRUST_START}
    parted -s ${BALENA_RAW_IMG} unit KiB mkpart ${TRUST_NAME} ${TRUST_START} ${DEVICE_SPECIFIC_SPACE}
}