From: Brad Campbell <brad@wasp.net.au>
Subject: sata_via issue
Date: Tue, 17 Aug 2004 12:59:38 +0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <4121C8FA.9040408@wasp.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.ccdaust.com.au ([203.29.88.42]:44601 "EHLO
	gateway.ccdaust.com.au") by vger.kernel.org with ESMTP
	id S264538AbUHQI7Q (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 17 Aug 2004 04:59:16 -0400
Received: from [192.168.2.80] (helo=[192.168.2.80])
	by gateway.ccdaust.com.au with esmtp (Exim 3.35 #1 (Debian))
	id 1Bx02e-0006wQ-00
	for <linux-ide@vger.kernel.org>; Tue, 17 Aug 2004 17:14:05 +0800
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


I have a pair of WD2000JB drives with SATA->IDE Converters sitting on the on-board interface of my 
ASUS A7V600 Motherboard
They are set up in an md raid-0 and shared across NFS as a remote root for another driveless box.

I have just lost the 2nd disk (the first went 2 weeks ago in similar circumstances and plugging this 
one into the ATA interface and querying the SMART figures kinda looked like this one was going to 
fail in a similar fashion). It's a RAID-0 so I plan ahead for data loss and rsync the important bits 
to a RAID-5 every night.

When the drive develops a read or write error, it does as the below log shows and then just freezes 
the interface. There are no timeouts (well I waited for 8 hours anyway) and no apparent error 
recovery. I can't read directly from the device with dd either, it just freezes solid.

I can't get much more than this now as the machine is remote and I need to get to it to reset the 
box before I can get at the boot log as it has been up for 1 day longer than my syslog rotation goes 
for.

I guess the bonus is I now have 2 200GB drives that fail in reproducible ways :p)
I know it's an old kernel, I have been waiting for a reboot to upgrade it to 2.6.8.1 (Now I have the 
chance I guess).

I guess what I'm asking is, is there a graceful error recovery method or will it continue to freeze 
solid? Is it a libata issue or drive issue?
When plugged into an ATA interface, the drive errors out on those sectors and continues to work 
"normally"

Regards,
Brad

brad@srv:~$ uname -a
Linux srv 2.6.5 #10 Thu Jun 10 09:36:54 GST 2004 i686 GNU/Linux

brad@srv:~$ lspci
0000:00:00.0 Host bridge: VIA Technologies, Inc. VT8377 [KT400/KT600 AGP] Host Bridge (rev 80)
0000:00:01.0 PCI bridge: VIA Technologies, Inc. VT8237 PCI Bridge
0000:00:09.0 Ethernet controller: 3Com Corporation 3c940 10/100/1000Base-T [Marvell] (rev 12)
0000:00:0b.0 Unknown mass storage controller: Promise Technology, Inc. PDC20318 (SATA150 TX4) (rev 02)
0000:00:0c.0 FireWire (IEEE 1394): VIA Technologies, Inc. IEEE 1394 Host Controller (rev 46)
0000:00:0d.0 Ethernet controller: Marvell Technology Group Ltd. Yukon Gigabit Ethernet 
10/100/1000Base-T Adapter (rev 12)
0000:00:0e.0 Unknown mass storage controller: Promise Technology, Inc. PDC20318 (SATA150 TX4) (rev 02)
0000:00:0f.0 RAID bus controller: VIA Technologies, Inc. VIA VT6420 SATA RAID Controller (rev 80)
0000:00:0f.1 IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus 
Master IDE (rev 06)
0000:00:10.0 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 81)
0000:00:10.1 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 81)
0000:00:10.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 81)
0000:00:10.3 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 81)
0000:00:10.4 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 86)
0000:00:11.0 ISA bridge: VIA Technologies, Inc. VT8237 ISA bridge [K8T800 South]
0000:00:13.0 Unknown mass storage controller: Promise Technology, Inc. PDC20318 (SATA150 TX4) (rev 02)
0000:01:00.0 VGA compatible controller: Silicon Integrated Systems [SiS] 315PRO PCI/AGP VGA Display 
Adapter


Relevant dmesg snip

ata13: DMA timeout, stat 0x1
ATA: abnormal status 0xE0 on port 0x8807
scsi12: ERROR on channel 0, id 0, lun 0, CDB: 0x2a 00 0a b2 00 3f 00 00 08 00
Current sdk: sense = 70  3
ASC= c ASCQ= 2
Raw sense data:0x70 0x00 0x03 0x00 0x00 0x00 0x00 0x06 0x00 0x00 0x00 0x00 0x0c 0x02
end_request: I/O error, dev sdk, sector 179437631
ATA: abnormal status 0xE0 on port 0x8807
ATA: abnormal status 0xE0 on port 0x8807
ATA: abnormal status 0xE0 on port 0x8807

Config

CONFIG_X86=y
CONFIG_MMU=y
CONFIG_UID16=y
CONFIG_GENERIC_ISA_DMA=y

CONFIG_EXPERIMENTAL=y
CONFIG_CLEAN_COMPILE=y
CONFIG_STANDALONE=y
CONFIG_BROKEN_ON_SMP=y

CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_SYSCTL=y
CONFIG_LOG_BUF_SHIFT=17
CONFIG_HOTPLUG=y
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
CONFIG_KALLSYMS=y
CONFIG_FUTEX=y
CONFIG_EPOLL=y
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_AS=y
CONFIG_IOSCHED_DEADLINE=y

CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
CONFIG_MODULE_FORCE_UNLOAD=y
CONFIG_OBSOLETE_MODPARM=y
CONFIG_KMOD=y

CONFIG_X86_PC=y
CONFIG_MK7=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_USE_3DNOW=y
CONFIG_HPET_TIMER=y
CONFIG_HPET_EMULATE_RTC=y
CONFIG_PREEMPT=y
CONFIG_X86_UP_APIC=y
CONFIG_X86_UP_IOAPIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_TSC=y
CONFIG_X86_MCE=y
CONFIG_X86_MCE_NONFATAL=y

CONFIG_NOHIGHMEM=y
CONFIG_MTRR=y
CONFIG_HAVE_DEC_LOCK=y
CONFIG_REGPARM=y

CONFIG_PM=y
CONFIG_SOFTWARE_SUSPEND=y

CONFIG_ACPI=y
CONFIG_ACPI_BOOT=y
CONFIG_ACPI_INTERPRETER=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_SLEEP_PROC_FS=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_BUS=y
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_PCI=y
CONFIG_ACPI_SYSTEM=y

CONFIG_PCI=y
CONFIG_PCI_GOBIOS=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_LEGACY_PROC=y
CONFIG_PCI_NAMES=y

CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_AOUT=m
CONFIG_BINFMT_MISC=m

CONFIG_LBD=y

CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y

CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
CONFIG_IDE_TASKFILE_IO=y

CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_ADMA=y
CONFIG_BLK_DEV_VIA82CXXX=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_IDEDMA_AUTO=y

CONFIG_SCSI=y
CONFIG_SCSI_PROC_FS=y

CONFIG_BLK_DEV_SD=y
CONFIG_BLK_DEV_SR=y
CONFIG_CHR_DEV_SG=y

CONFIG_SCSI_REPORT_LUNS=y

CONFIG_SCSI_SATA=y
CONFIG_SCSI_SATA_PROMISE=y
CONFIG_SCSI_SATA_VIA=y
CONFIG_SCSI_QLA2XXX=y

CONFIG_MD=y
CONFIG_BLK_DEV_MD=y
CONFIG_MD_RAID0=y
CONFIG_MD_RAID5=y
CONFIG_MD_RAID6=y

CONFIG_IEEE1394=m

CONFIG_IEEE1394_OUI_DB=y

CONFIG_IEEE1394_OHCI1394=m

CONFIG_IEEE1394_SBP2=m
CONFIG_IEEE1394_RAWIO=m

CONFIG_NET=y

CONFIG_PACKET=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_BRIDGE=y

CONFIG_NETDEVICES=y

CONFIG_DUMMY=m

CONFIG_SK98LIN=m
CONFIG_TIGON3=m

CONFIG_NET_RADIO=y

CONFIG_HERMES=y
CONFIG_PCI_HERMES=y

CONFIG_NET_WIRELESS=y

CONFIG_INPUT=y

CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768

CONFIG_SOUND_GAMEPORT=y
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y

CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y

CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y

CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_NR_UARTS=4

CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
CONFIG_UNIX98_PTYS=y
CONFIG_LEGACY_PTYS=y
CONFIG_LEGACY_PTY_COUNT=256

CONFIG_HW_RANDOM=y
CONFIG_RTC=y

CONFIG_I2C=y
CONFIG_I2C_CHARDEV=y

CONFIG_I2C_ALGOBIT=y

CONFIG_I2C_ISA=m

CONFIG_I2C_SENSOR=m
CONFIG_SENSORS_IT87=m

CONFIG_VIDEO_SELECT=y

CONFIG_VGA_CONSOLE=y
CONFIG_DUMMY_CONSOLE=y

CONFIG_USB=m
CONFIG_USB_DEBUG=y

CONFIG_USB_DEVICEFS=y

CONFIG_USB_EHCI_HCD=m
CONFIG_USB_UHCI_HCD=m

CONFIG_USB_STORAGE=m

CONFIG_EXT2_FS=y
CONFIG_EXT3_FS=y
CONFIG_EXT3_FS_XATTR=y
CONFIG_JBD=y
CONFIG_FS_MBCACHE=y
CONFIG_AUTOFS4_FS=y

CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
CONFIG_UDF_FS=y

CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
CONFIG_VFAT_FS=y

CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_DEVFS_FS=y
CONFIG_TMPFS=y
CONFIG_RAMFS=y

CONFIG_NFS_FS=y
CONFIG_NFSD=y
CONFIG_NFSD_V3=y
CONFIG_NFSD_V4=y
CONFIG_NFSD_TCP=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_EXPORTFS=y
CONFIG_SUNRPC=y

CONFIG_MSDOS_PARTITION=y

CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_ISO8859_1=y

CONFIG_PROFILING=y
CONFIG_OPROFILE=y

CONFIG_DEBUG_KERNEL=y
CONFIG_EARLY_PRINTK=y
CONFIG_MAGIC_SYSRQ=y
CONFIG_DEBUG_SPINLOCK_SLEEP=y
CONFIG_X86_FIND_SMP_CONFIG=y
CONFIG_X86_MPPARSE=y

CONFIG_CRC32=y
CONFIG_X86_BIOS_REBOOT=y
CONFIG_PC=y
