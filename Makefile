.PHONY=clean
QEMU=qemu-system-i386
MOS_IMG_FILE=mos.img
MOS_IMG_SIZE_MB=1
default:
	make run
run: mos.img
	$(QEMU) $(MOS_IMG_FILE)
bootsect.bin:
	@make -C src/boot
kernel.bin:
	@echo "Has not been implemented"
mapps.img:
	@echo "Has not been implemented"
mos.img: bootsect.bin
	@dd if=/dev/zero of=$(MOS_IMG_FILE) bs=1M count=$(MOS_IMG_SIZE_MB)
	@dd if=src/boot/bootsect.bin of=$(MOS_IMG_FILE) seek=0 conv=notrunc
clean:
	@rm -f *.bin *.o $(MOS_IMG_FILE)
	@make clean -C src/boot
	# @make clean -C src/kernel
	# @make clean -C src/mapps
