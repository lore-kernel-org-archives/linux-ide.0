From: Tuukka Toivonen <tuukkat@ee.oulu.fi>
Subject: 2.6.0-test3: "bad: scheduling while atomic" when piix as module
Date: Thu, 21 Aug 2003 13:10:53 +0300 (EEST)
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <Pine.GSO.4.55.0308211252040.7262@stekt37>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ee.oulu.fi ([130.231.61.23]:60312 "EHLO ee.oulu.fi")
	by vger.kernel.org with ESMTP id S262565AbTHUKK6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 21 Aug 2003 06:10:58 -0400
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: B.Zolnierkiewicz@elka.pw.edu.pl

[Please forward this mail if there's more appropriate address...and keep me
on the CC]

1) one line summary:
I get error message "bad: schediling while atomic" if starting kernel
2.6.0-test3 with CONFIG_BLK_DEV_PIIX=m at bootup (before loading the
module).

2) full description:
When booting the 2.6.0-test3 kernel with CONFIG_BLK_DEV_PIIX=m,
it gives error message and call trace constantly (I believe at every
interrupt, or at least very frequently for a while, after that at every
keypress. Keypresses echo echoed to the screen, and switching virtual
console appears to work, but otherwise system appears to be non-functional)
Here're the messages (written from paper):

bad: scheduling while atomic
Call Trace:
_stext+0x0/0x80
schedule+0x4C/0x15a0
default_idle+0x0/0x34
_stext+0x0/0x80
default_idle+0x0/0x34
_stext+0x0/0x80
default_idle+0x2c/0x34
cpu_idle+0x43/0x48
_stext+0x7c/0x80
start_kernel+0x15f/0x168

..and this repeats for each keypress. The message comes at the very
beginning of boot process, probably before any modules are loaded yet (or
at least the PIIX module should _not_ be loaded yet).

4) kernel version
Linux version 2.6.0-test3 (tuukkat@powerzone) (gcc version 2.95.4 20011002
(Debian prerelease)) #19 SMP Tue Aug 19 21:08:03 EEST 2003

7.1) software
Linux powerzone 2.6.0-test3 #19 SMP Tue Aug 19 21:08:03 EEST 2003 i686
unknown

Gnu C                  2.95.4
Gnu make               3.79.1
util-linux             2.11n
mount                  2.11n
module-init-tools      2.4.15
e2fsprogs              1.27
reiserfsprogs          3.x.1b
nfs-utils              1.0
Linux C Library        2.2.5
Dynamic linker (ldd)   2.2.5
Procps                 100.
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               2.0.11

(this is Debian 3.0)

7.2) processor
dual Pentium III 933 MHz, 1 GB RIMM memory.
This is Dell Workstation 420 MT

7.5) PCI information

PCI devices found:
  Bus  0, device   0, function  0:
    Host bridge: Intel Corp. 82840 840 (Carmel) C (rev 2).
      Prefetchable 32 bit memory at 0xf0000000 [0xf3ffffff].
  Bus  0, device   1, function  0:
    PCI bridge: Intel Corp. 82840 840 (Carmel) C (rev 2).
      Master Capable.  Latency=64.  Min Gnt=14.
  Bus  0, device  30, function  0:
    PCI bridge: Intel Corp. 82801AA PCI Bridge (rev 2).
      Master Capable.  No bursts.  Min Gnt=6.
  Bus  0, device  31, function  0:
    ISA bridge: Intel Corp. 82801AA ISA Bridge ( (rev 2).
  Bus  0, device  31, function  1:
    IDE interface: Intel Corp. 82801AA IDE (rev 2).
      I/O at 0xffa0 [0xffaf].
  Bus  0, device  31, function  2:
    USB Controller: Intel Corp. 82801AA USB (rev 2).
      IRQ 19.
      I/O at 0xff80 [0xff9f].
  Bus  0, device  31, function  3:
    SMBus: Intel Corp. 82801AA SMBus (rev 2).
      IRQ 17.
      I/O at 0xccd0 [0xccdf].
  Bus  1, device   0, function  0:
    VGA compatible controller: Matrox Graphics, Inc MGA G400 AGP (rev 130).
      IRQ 16.
      Master Capable.  Latency=64.  Min Gnt=16.Max Lat=32.
      Prefetchable 32 bit memory at 0xf4000000 [0xf5ffffff].
      Non-prefetchable 32 bit memory at 0xfcffc000 [0xfcffffff].
      Non-prefetchable 32 bit memory at 0xfc000000 [0xfc7fffff].
  Bus  2, device   4, function  0:
    Ethernet controller: 3Com Corporation 3c905C-TX/TX-M [Torn (rev 120).
      IRQ 16.
      Master Capable.  Latency=64.  Min Gnt=10.Max Lat=10.
      I/O at 0xdc80 [0xdcff].
      Non-prefetchable 32 bit memory at 0xf8fffc00 [0xf8fffc7f].
  Bus  2, device   6, function  0:
    Multimedia audio controller: Cirrus Logic CS 4614/22/24 [Cryst (rev 1).
      IRQ 18.
      Master Capable.  Latency=64.  Min Gnt=4.Max Lat=24.
      Non-prefetchable 32 bit memory at 0xf8ffe000 [0xf8ffefff].
      Non-prefetchable 32 bit memory at 0xf8e00000 [0xf8efffff].
  Bus  2, device   9, function  0:
    Multimedia video controller: Brooktree Corporatio Bt878 Video Capture (rev 2).
      IRQ 17.
      Master Capable.  Latency=64.  Min Gnt=16.Max Lat=40.
      Prefetchable 32 bit memory at 0xf6001000 [0xf6001fff].
  Bus  2, device   9, function  1:
    Multimedia controller: Brooktree Corporatio Bt878 Audio Capture (rev 2).
      IRQ 17.
      Master Capable.  Latency=64.  Min Gnt=4.Max Lat=255.
      Prefetchable 32 bit memory at 0xf6000000 [0xf6000fff].
  Bus  2, device  14, function  0:
    PCI bridge: Digital Equipment Co DECchip 21152 (rev 3).
      Master Capable.  Latency=64.  Min Gnt=6.
  Bus  3, device   5, function  0:
    Ethernet controller: Realtek Semiconducto RTL-8139/8139C/8139C (rev 16).
      IRQ 17.
      Master Capable.  Latency=64.  Min Gnt=32.Max Lat=64.
      I/O at 0xec00 [0xecff].
      Non-prefetchable 32 bit memory at 0xfafffc00 [0xfafffcff].
  Bus  3, device  10, function  0:
    SCSI storage controller: Adaptec AIC-7899P U160/m (rev 1).
      IRQ 18.
      Master Capable.  Latency=64.  Min Gnt=40.Max Lat=25.
      I/O at 0xe800 [0xe8ff].
      Non-prefetchable 64 bit memory at 0xfaffe000 [0xfaffefff].
  Bus  3, device  10, function  1:
    SCSI storage controller: Adaptec AIC-7899P U160/m (#2) (rev 1).
      IRQ 19.
      Master Capable.  Latency=64.  Min Gnt=40.Max Lat=25.
      I/O at 0xe400 [0xe4ff].
      Non-prefetchable 64 bit memory at 0xfaffd000 [0xfaffdfff].

X) workaround
Compiling PIIX statically into kernel works fine.

Y) Here's .config for the failing kernel:

CONFIG_X86=y
CONFIG_MMU=y
CONFIG_UID16=y
CONFIG_GENERIC_ISA_DMA=y

CONFIG_EXPERIMENTAL=y

CONFIG_SYSVIPC=y
CONFIG_SYSCTL=y
CONFIG_LOG_BUF_SHIFT=17
CONFIG_KALLSYMS=y
CONFIG_FUTEX=y
CONFIG_EPOLL=y
CONFIG_IOSCHED_AS=y
CONFIG_IOSCHED_DEADLINE=y

CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
CONFIG_MODULE_FORCE_UNLOAD=y
CONFIG_OBSOLETE_MODPARM=y
CONFIG_KMOD=y

CONFIG_X86_PC=y
CONFIG_MPENTIUMIII=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_L1_CACHE_SHIFT=5
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_SMP=y
CONFIG_NR_CPUS=2
CONFIG_PREEMPT=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_TSC=y
CONFIG_X86_MCE=y
CONFIG_MICROCODE=m
CONFIG_X86_MSR=m
CONFIG_X86_CPUID=m
CONFIG_HIGHMEM4G=y
CONFIG_HIGHMEM=y
CONFIG_MTRR=y
CONFIG_HAVE_DEC_LOCK=y

CONFIG_PM=y

CONFIG_APM=y
CONFIG_APM_DO_ENABLE=y
CONFIG_APM_DISPLAY_BLANK=y
CONFIG_APM_RTC_IS_GMT=y

CONFIG_PCI=y
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_LEGACY_PROC=y
CONFIG_PCI_NAMES=y

CONFIG_KCORE_ELF=y
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_AOUT=m
CONFIG_BINFMT_MISC=m

CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
CONFIG_PARPORT_PC_CML1=m
CONFIG_PARPORT_PC_FIFO=y
CONFIG_PARPORT_1284=y

CONFIG_BLK_DEV_FD=m
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_CRYPTOLOOP=m
CONFIG_BLK_DEV_NBD=m
CONFIG_BLK_DEV_RAM=m
CONFIG_BLK_DEV_RAM_SIZE=4096

CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y

CONFIG_BLK_DEV_IDEDISK=y
CONFIG_BLK_DEV_IDECD=m
CONFIG_BLK_DEV_IDESCSI=m
CONFIG_IDE_TASKFILE_IO=y

CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_GENERIC=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_IDEDMA_ONLYDISK=y
CONFIG_BLK_DEV_ADMA=y
CONFIG_BLK_DEV_PIIX=m
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_IDEDMA_AUTO=y

CONFIG_SCSI=y

CONFIG_BLK_DEV_SD=y
CONFIG_BLK_DEV_SR=m
CONFIG_CHR_DEV_SG=m

CONFIG_SCSI_REPORT_LUNS=y
CONFIG_SCSI_CONSTANTS=y

CONFIG_SCSI_AIC7XXX=y
CONFIG_AIC7XXX_CMDS_PER_DEVICE=253
CONFIG_AIC7XXX_RESET_DELAY_MS=1500
CONFIG_AIC7XXX_DEBUG_MASK=0
CONFIG_AIC7XXX_REG_PRETTY_PRINT=y

CONFIG_NET=y

CONFIG_PACKET=m
CONFIG_PACKET_MMAP=y
CONFIG_NETLINK_DEV=m
CONFIG_UNIX=m
CONFIG_INET=y

CONFIG_NETFILTER=y

CONFIG_IP_NF_CONNTRACK=m
CONFIG_IP_NF_QUEUE=m
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_IP_NF_COMPAT_IPCHAINS=m

CONFIG_IPV6_SCTP__=y

CONFIG_NETDEVICES=y

CONFIG_DUMMY=m

CONFIG_NET_ETHERNET=y
CONFIG_NET_VENDOR_3COM=y
CONFIG_VORTEX=m

CONFIG_NET_PCI=y
CONFIG_NE2K_PCI=m
CONFIG_8139TOO=m

CONFIG_PLIP=m
CONFIG_PPP=m
CONFIG_PPP_ASYNC=m
CONFIG_PPP_DEFLATE=m
CONFIG_PPP_BSDCOMP=m

CONFIG_INPUT=y

CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_EVDEV=m

CONFIG_SOUND_GAMEPORT=y
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=m

CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
CONFIG_KEYBOARD_SUNKBD=m
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=m
CONFIG_MOUSE_SERIAL=m
CONFIG_INPUT_MISC=y
CONFIG_INPUT_PCSPKR=m
CONFIG_INPUT_UINPUT=m

CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y

CONFIG_SERIAL_8250=m

CONFIG_SERIAL_CORE=m
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256
CONFIG_PRINTER=m
CONFIG_PPDEV=m

CONFIG_I2C=m
CONFIG_I2C_ALGOBIT=m
CONFIG_SCx200_ACB=m
CONFIG_I2C_ALGOPCF=m
CONFIG_I2C_CHARDEV=m

CONFIG_I2C_PIIX4=m

CONFIG_SENSORS_ADM1021=m
CONFIG_SENSORS_IT87=m
CONFIG_SENSORS_LM75=m
CONFIG_SENSORS_LM85=m
CONFIG_SENSORS_LM78=m
CONFIG_SENSORS_VIA686A=m
CONFIG_SENSORS_W83781D=m
CONFIG_I2C_SENSOR=m

CONFIG_BUSMOUSE=m

CONFIG_IPMI_HANDLER=m
CONFIG_IPMI_PANIC_EVENT=y
CONFIG_IPMI_DEVICE_INTERFACE=m
CONFIG_IPMI_KCS=m
CONFIG_IPMI_WATCHDOG=m

CONFIG_NVRAM=m
CONFIG_RTC=m
CONFIG_GEN_RTC=m
CONFIG_GEN_RTC_X=y

CONFIG_AGP=y
CONFIG_AGP_INTEL=y
CONFIG_DRM=y
CONFIG_DRM_MGA=m
CONFIG_RAW_DRIVER=m
CONFIG_HANGCHECK_TIMER=m

CONFIG_VIDEO_DEV=m

CONFIG_VIDEO_PROC_FS=y

CONFIG_VIDEO_BT848=m

CONFIG_VIDEO_VIDEOBUF=m
CONFIG_VIDEO_TUNER=m
CONFIG_VIDEO_BUF=m
CONFIG_VIDEO_BTCX=m

CONFIG_EXT2_FS=y
CONFIG_EXT3_FS=m
CONFIG_JBD=m
CONFIG_REISERFS_FS=y
CONFIG_JFS_FS=m
CONFIG_XFS_FS=m
CONFIG_MINIX_FS=m
CONFIG_ROMFS_FS=m
CONFIG_AUTOFS4_FS=m

CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
CONFIG_UDF_FS=m

CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_VFAT_FS=m
CONFIG_NTFS_FS=m
CONFIG_NTFS_RW=y

CONFIG_PROC_FS=y
CONFIG_DEVFS_FS=y
CONFIG_DEVFS_MOUNT=y
CONFIG_DEVPTS_FS=y
CONFIG_TMPFS=y
CONFIG_RAMFS=y

CONFIG_AFFS_FS=m
CONFIG_CRAMFS=m

CONFIG_NFS_FS=m
CONFIG_NFS_V3=y
CONFIG_NFSD=m
CONFIG_NFSD_V3=y
CONFIG_LOCKD=m
CONFIG_LOCKD_V4=y
CONFIG_EXPORTFS=m
CONFIG_SUNRPC=m
CONFIG_SMB_FS=m
CONFIG_CODA_FS=m
CONFIG_INTERMEZZO_FS=m

CONFIG_PARTITION_ADVANCED=y
CONFIG_MSDOS_PARTITION=y
CONFIG_SMB_NLS=y
CONFIG_NLS=y

CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=m
CONFIG_NLS_CODEPAGE_850=m
CONFIG_NLS_ISO8859_1=m
CONFIG_NLS_ISO8859_15=m
CONFIG_NLS_UTF8=m

CONFIG_VGA_CONSOLE=y
CONFIG_DUMMY_CONSOLE=y

CONFIG_SOUND=m

CONFIG_SND=m
CONFIG_SND_SEQUENCER=m
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=m
CONFIG_SND_PCM_OSS=m
CONFIG_SND_SEQUENCER_OSS=y
CONFIG_SND_RTCTIMER=m
CONFIG_SND_VERBOSE_PRINTK=y

CONFIG_SND_DUMMY=m

CONFIG_SND_CS46XX=m

CONFIG_SND_USB_AUDIO=m

CONFIG_USB=m
CONFIG_USB_DEBUG=y

CONFIG_USB_DEVICEFS=y

CONFIG_USB_UHCI_HCD=m

CONFIG_USB_AUDIO=m

CONFIG_USB_PWC=m

CONFIG_DEBUG_KERNEL=y
CONFIG_DEBUG_STACKOVERFLOW=y
CONFIG_DEBUG_SLAB=y
CONFIG_DEBUG_IOVIRT=y
CONFIG_MAGIC_SYSRQ=y
CONFIG_DEBUG_SPINLOCK=y
CONFIG_DEBUG_SPINLOCK_SLEEP=y
CONFIG_X86_EXTRA_IRQS=y
CONFIG_X86_FIND_SMP_CONFIG=y
CONFIG_X86_MPPARSE=y

CONFIG_CRYPTO=y
CONFIG_CRYPTO_NULL=m
CONFIG_CRYPTO_DES=m
CONFIG_CRYPTO_BLOWFISH=m
CONFIG_CRYPTO_AES=m
CONFIG_CRYPTO_DEFLATE=m

CONFIG_ZLIB_INFLATE=m
CONFIG_ZLIB_DEFLATE=m
CONFIG_X86_SMP=y
CONFIG_X86_HT=y
CONFIG_X86_BIOS_REBOOT=y
CONFIG_X86_TRAMPOLINE=y
