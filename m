From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [git patches] IDE updates part #2
Date: Sat, 26 Jan 2008 20:43:17 +0100
Message-ID: <200801262043.17739.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.155]:46303 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752841AbYAZTf6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 26 Jan 2008 14:35:58 -0500
Received: by fg-out-1718.google.com with SMTP id e21so1096580fga.17
        for <linux-ide@vger.kernel.org>; Sat, 26 Jan 2008 11:35:55 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org


IDE updates continued:

* make remaining built-in only IDE host drivers modular and cleanup ide=
=2Ec
  #ifdef hell (me)

* "resurrected" fixes for HDIO_DRIVE_TASKFILE ioctl (Tejun Heo)

* unify handling of REQ_TYPE_ATA_CMD and REQ_TYPE_ATA_TASKFILE requests
=A0 (me, heavily based on the earlier patches from Tejun Heo)

* host driver specific fixes: sl82c105, cs5520, cy82c693, atiixp and ot=
hers

* the usual cleanups/fixups all over the place

All patches included in this update have been in IDE tree since at leas=
t 12th
December, got testing in -mm and (almost all) have been reviewed by Ser=
gei
(IOW it is just another "boring" IDE update ;).


Linus, please pull from:

master.kernel.org:/pub/scm/linux/kernel/git/bart/ide-2.6.git/

to receive the following updates:

 Documentation/ide.txt             |   13 +--
 drivers/ide/Kconfig               |   50 +++++-----
 drivers/ide/Makefile              |   58 +++++++-----
 drivers/ide/arm/Makefile          |    4 +
 drivers/ide/arm/bast-ide.c        |    2 +-
 drivers/ide/arm/icside.c          |   23 +----
 drivers/ide/arm/ide_arm.c         |   17 +++-
 drivers/ide/arm/rapide.c          |   33 +++---
 drivers/ide/cris/Makefile         |    2 +-
 drivers/ide/cris/ide-cris.c       |   29 +++---
 drivers/ide/h8300/Makefile        |    2 +
 drivers/ide/h8300/ide-h8300.c     |   27 ++++--
 drivers/ide/ide-acpi.c            |    2 +-
 drivers/ide/ide-disk.c            |   57 +++++------
 drivers/ide/ide-dma.c             |   98 +++++++-----------
 drivers/ide/ide-generic.c         |    8 ++-
 drivers/ide/ide-io.c              |  116 +++-------------------
 drivers/ide/ide-iops.c            |   31 +++---
 drivers/ide/ide-lib.c             |   25 ++----
 drivers/ide/ide-pnp.c             |   24 +++--
 drivers/ide/ide-probe.c           |  175 +++++++++++++++--------------=
----
 drivers/ide/ide-proc.c            |   12 ++-
 drivers/ide/ide-scan-pci.c        |  121 +++++++++++++++++++++++
 drivers/ide/ide-tape.c            |    5 +
 drivers/ide/ide-taskfile.c        |  155 +++++++++++++----------------
 drivers/ide/ide.c                 |  197 +++++++----------------------=
--------
 drivers/ide/legacy/Makefile       |   19 +++-
 drivers/ide/legacy/ali14xx.c      |    5 +-
 drivers/ide/legacy/buddha.c       |   44 +++++----
 drivers/ide/legacy/dtc2278.c      |    5 +-
 drivers/ide/legacy/falconide.c    |   22 +++-
 drivers/ide/legacy/gayle.c        |   43 +++++---
 drivers/ide/legacy/ht6560b.c      |    5 +-
 drivers/ide/legacy/ide-cs.c       |    2 +-
 drivers/ide/legacy/ide_platform.c |   55 +++++-----
 drivers/ide/legacy/macide.c       |   52 +++++-----
 drivers/ide/legacy/q40ide.c       |   24 ++++-
 drivers/ide/legacy/qd65xx.c       |    5 +-
 drivers/ide/legacy/umc8672.c      |    5 +-
 drivers/ide/mips/au1xxx-ide.c     |   36 ++-----
 drivers/ide/mips/swarm.c          |    1 +
 drivers/ide/pci/Makefile          |    4 +
 drivers/ide/pci/atiixp.c          |   71 ++++----------
 drivers/ide/pci/cmd640.c          |   16 +++-
 drivers/ide/pci/cmd64x.c          |  114 +---------------------
 drivers/ide/pci/cs5520.c          |   19 ++---
 drivers/ide/pci/cy82c693.c        |   64 ++----------
 drivers/ide/pci/delkin_cb.c       |    2 +-
 drivers/ide/pci/hpt366.c          |   11 ++-
 drivers/ide/pci/it821x.c          |   37 +++-----
 drivers/ide/pci/pdc202xx_new.c    |   11 ++-
 drivers/ide/pci/pdc202xx_old.c    |   11 ++-
 drivers/ide/pci/sc1200.c          |    6 +-
 drivers/ide/pci/serverworks.c     |   25 +----
 drivers/ide/pci/sgiioc4.c         |   49 +++-------
 drivers/ide/pci/siimage.c         |   15 ++--
 drivers/ide/pci/sl82c105.c        |   89 ++++-------------
 drivers/ide/pci/trm290.c          |    9 +--
 drivers/ide/ppc/Makefile          |    3 +
 drivers/ide/ppc/mpc8xx.c          |   18 ++++
 drivers/ide/ppc/pmac.c            |   46 +++++----
 drivers/ide/setup-pci.c           |  151 +++++------------------------
 drivers/macintosh/mediabay.c      |    3 +-
 include/linux/blkdev.h            |    1 -
 include/linux/ide.h               |   61 +++++++-----
 65 files changed, 999 insertions(+), 1446 deletions(-)
 create mode 100644 drivers/ide/h8300/Makefile
 create mode 100644 drivers/ide/ide-scan-pci.c
 create mode 100644 drivers/ide/ppc/Makefile


Bartlomiej Zolnierkiewicz (60):
      sl82c105: program DMA/PIO timings in ->dma_start/->ide_dma_end
      sl82c105: remove no longer needed ->selectproc method
      serverworks: cleanup ->set_dma_mode method
      ide-disk: add idedisk_set_doorlock() helper
      ide: (hopefully) fix VDMA for CS5520
      cy82c693: correct DMA modes clipping
      cy82c693: add ->set_dma_mode method
      sgiioc4: add ide_toggle_bounce() calls
      icside: add ide_toggle_bounce() calls
      au1xxx-ide: add ide_toggle_bounce() calls
      ide: remove ->ide_dma_on and ->dma_off_quietly methods from ide_h=
wif_t
      ide-cris: fix DMA methods
      atiixp: remove ->dma_host_on and ->dma_host_off methods
      ide: move drive->using_dma check to callers of ->dma_host_on meth=
od
      ide: merge ->dma_host_{on,off} methods into ->dma_host_set method
      ide: dump taskfile HOB registers in ide_tf_load() (if DEBUG is de=
fined)
      ide: merge ->fixup and ->quirkproc methods
      ide: don't try to unregister interfaces if 'initializing' in ide_=
register_hw()
      ide: kill probe_hwif_init()
      ide: fix probing for hosts with serialized or IRQ sharing interfa=
ces
      rapide: set hwif->chipset
      swarm: set hwif->chipset
      ide: add hwif->chipset fixup to ide_device_add()
      ide: remove ideprobe_init()
      sgiioc4: always init hwif->io_ports
      ide: add ide_init_port_hw() helper
      ide: drop 'initializing' argument from ide_register_hw()
      ide: move ide_arm_init() call from init_ide_data() to ide_init()
      cmd640: fix dependency on IDE_GENERIC
      ide: fix host drivers depending on ide_generic to probe for inter=
faces (take 2)
      ide: make remaining built-in only IDE host drivers modular (take =
2)
      au1xxx-ide: au_ide_probe() fixes
      au1xxx-ide: use ide_init_port_hw()
      ide: always use ide_std_init_ports() in setup-pci.c
      ide: use ide_init_port_hw() in setup-pci.c
      rapide: remove write-only hwif->hwif_data
      ide-pmac: use custom hwif->sg_max_nents only if DMA support is en=
abled
      ide: add ide_set_irq() inline helper
      ide: print banner message once per controller in m68k host driver=
s
      ide: move CONFIG_IDEPCI_PCIBUS_ORDER code to ide-scan-pci.c
      ide: make CONFIG_IDEPCI_PCIBUS_ORDER visible and deprecate it
      ide: add ide_busy_sleep() helper
      ide: remove broken disk byte-swapping support
      cmd64x: remove /proc/ide/cmd64x
      ide: clear HOB bit for REQ_TYPE_ATA_CMD requests in ide_end_drive=
_cmd()
      ide: fix final status check in task_in_intr()
      ide-tape: fix handling of non-special requests in ->end_request m=
ethod
      ide: set IDE_TFLAG_IN_* flags before queuing/executing command
      ide: remove needless ->cursg clearing from task_end_request()
      ide: use rq->nr_sectors in task_end_request()
      ide: kill DATA_READY define
      ide: use wait_drive_not_busy() in drive_cmd_intr() (take 2)
      ide: initialize rq->cmd_type in ide_init_drive_cmd() callers
      ide: convert "empty" REQ_TYPE_ATA_CMD requests to use REQ_TYPE_AT=
A_TASKFILE
      ide: don't enable local IRQs for PIO-in in driver_cmd_intr() (tak=
e 2)
      ide: check BUSY and ERROR status bits before reading data in driv=
e_cmd_intr()
      ide: fix final status check in drive_cmd_intr()
      ide: switch set_xfer_rate() to use REQ_TYPE_ATA_TASKFILE requests
      ide: switch ide_cmd_ioctl() to use REQ_TYPE_ATA_TASKFILE requests
      ide: remove REQ_TYPE_ATA_CMD

Olof Johansson (1):
      ide: Fix build break caused by "ide: remove ideprobe_init()"

Tejun Heo (2):
      ide: fix ->io_32bit race in ide_taskfile_ioctl()
      ide: task_end_request() fix


diff --git a/Documentation/ide.txt b/Documentation/ide.txt
index 1d50f23..94e2e3b 100644
--- a/Documentation/ide.txt
+++ b/Documentation/ide.txt
@@ -30,7 +30,7 @@
 ***
 ***  The CMD640 is also used on some Vesa Local Bus (VLB) cards, and i=
s *NOT*
 ***  automatically detected by Linux.  For safe, reliable operation wi=
th such
-***  interfaces, one *MUST* use the "ide0=3Dcmd640_vlb" kernel option.
+***  interfaces, one *MUST* use the "cmd640.probe_vlb" kernel option.
 ***
 ***  Use of the "serialize" option is no longer necessary.
=20
@@ -244,10 +244,6 @@ Summary of ide driver parameters for kernel comman=
d line
=20
  "hdx=3Dnodma"		: disallow DMA
=20
- "hdx=3Dswapdata"		: when the drive is a disk, byte swap all data
-
- "hdx=3Dbswap"		: same as above..........
-
  "hdx=3Dscsi"		: the return of the ide-scsi flag, this is useful for
  			  allowing ide-floppy, ide-tape, and ide-cdrom|writers
  			  to use ide-scsi emulation on a device specific option.
@@ -292,9 +288,6 @@ The following are valid ONLY on ide0, which usually=
 corresponds
 to the first ATA interface found on the particular host, and the defau=
lts for
 the base,ctl ports must not be altered.
=20
- "ide0=3Dcmd640_vlb"	: *REQUIRED* for VLB cards with the CMD640 chip
-			  (not for PCI -- automatically detected)
-
  "ide=3Ddoubler"		: probe/support IDE doublers on Amiga
=20
 There may be more options than shown -- use the source, Luke!
@@ -310,6 +303,10 @@ i.e. to enable probing for ALI M14xx chipsets (ali=
14xx host driver) use:
 * "probe" module parameter when ali14xx driver is compiled as module
   ("modprobe ali14xx probe")
=20
+Also for legacy CMD640 host driver (cmd640) you need to use "probe_vlb=
"
+kernel paremeter to enable probing for VLB version of the chipset (PCI=
 ones
+are detected automatically).
+
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
=20
 IDE ATAPI streaming tape driver
diff --git a/drivers/ide/Kconfig b/drivers/ide/Kconfig
index ee01e27..64df55e 100644
--- a/drivers/ide/Kconfig
+++ b/drivers/ide/Kconfig
@@ -325,7 +325,7 @@ config BLK_DEV_PLATFORM
 	  If unsure, say N.
=20
 config BLK_DEV_CMD640
-	bool "CMD640 chipset bugfix/support"
+	tristate "CMD640 chipset bugfix/support"
 	depends on X86
 	---help---
 	  The CMD-Technologies CMD640 IDE chip is used on many common 486 and
@@ -359,9 +359,8 @@ config BLK_DEV_CMD640_ENHANCED
 	  Otherwise say N.
=20
 config BLK_DEV_IDEPNP
-	bool "PNP EIDE support"
+	tristate "PNP EIDE support"
 	depends on PNP
-	select IDE_GENERIC
 	help
 	  If you have a PnP (Plug and Play) compatible EIDE card and
 	  would like the kernel to automatically detect and activate
@@ -375,7 +374,19 @@ config BLK_DEV_IDEPCI
 	bool
=20
 config IDEPCI_PCIBUS_ORDER
-	def_bool BLK_DEV_IDE=3Dy && BLK_DEV_IDEPCI
+	bool "Probe IDE PCI devices in the PCI bus order (DEPRECATED)"
+	depends on BLK_DEV_IDE=3Dy && BLK_DEV_IDEPCI
+	default y
+	help
+	  Probe IDE PCI devices in the order in which they appear on the
+	  PCI bus (i.e. 00:1f.1 PCI device before 02:01.0 PCI device)
+	  instead of the order in which IDE PCI host drivers are loaded.
+
+	  Please note that this method of assuring stable naming of
+	  IDE devices is unreliable and use other means for achieving
+	  it (i.e. udev).
+
+	  If in doubt, say N.
=20
 # TODO: split it on per host driver config options (or module paramete=
rs)
 config BLK_DEV_OFFBOARD
@@ -789,7 +800,7 @@ config BLK_DEV_CELLEB
 endif
=20
 config BLK_DEV_IDE_PMAC
-	bool "Builtin PowerMac IDE support"
+	tristate "Builtin PowerMac IDE support"
 	depends on PPC_PMAC && IDE=3Dy && BLK_DEV_IDE=3Dy
 	help
 	  This driver provides support for the built-in IDE controller on
@@ -843,8 +854,9 @@ config BLK_DEV_IDE_AU1XXX_SEQTS_PER_RQ
        depends on BLK_DEV_IDE_AU1XXX
=20
 config IDE_ARM
-	def_bool ARM && (ARCH_CLPS7500 || ARCH_RPC || ARCH_SHARK)
-	select IDE_GENERIC
+	tristate "ARM IDE support"
+	depends on ARM && (ARCH_CLPS7500 || ARCH_RPC || ARCH_SHARK)
+	default y
=20
 config BLK_DEV_IDE_ICSIDE
 	tristate "ICS IDE interface support"
@@ -876,10 +888,9 @@ config BLK_DEV_IDE_BAST
 	  Simtec BAST or the Thorcom VR1000
=20
 config ETRAX_IDE
-	bool "ETRAX IDE support"
+	tristate "ETRAX IDE support"
 	depends on CRIS && BROKEN
 	select BLK_DEV_IDEDMA
-	select IDE_GENERIC
 	help
 	  Enables the ETRAX IDE driver.
=20
@@ -911,17 +922,15 @@ config ETRAX_IDE_G27_RESET
 endchoice
=20
 config IDE_H8300
-	bool "H8300 IDE support"
+	tristate "H8300 IDE support"
 	depends on H8300
-	select IDE_GENERIC
 	default y
 	help
 	  Enables the H8300 IDE driver.
=20
 config BLK_DEV_GAYLE
-	bool "Amiga Gayle IDE interface support"
+	tristate "Amiga Gayle IDE interface support"
 	depends on AMIGA
-	select IDE_GENERIC
 	help
 	  This is the IDE driver for the Amiga Gayle IDE interface. It suppor=
ts
 	  both the `A1200 style' and `A4000 style' of the Gayle IDE interface=
,
@@ -951,9 +960,8 @@ config BLK_DEV_IDEDOUBLER
 	  runtime using the "ide=3Ddoubler" kernel boot parameter.
=20
 config BLK_DEV_BUDDHA
-	bool "Buddha/Catweasel/X-Surf IDE interface support (EXPERIMENTAL)"
+	tristate "Buddha/Catweasel/X-Surf IDE interface support (EXPERIMENTAL=
)"
 	depends on ZORRO && EXPERIMENTAL
-	select IDE_GENERIC
 	help
 	  This is the IDE driver for the IDE interfaces on the Buddha,=20
 	  Catweasel and X-Surf expansion boards.  It supports up to two inter=
faces=20
@@ -964,9 +972,8 @@ config BLK_DEV_BUDDHA
 	  to one of its IDE interfaces.
=20
 config BLK_DEV_FALCON_IDE
-	bool "Falcon IDE interface support"
+	tristate "Falcon IDE interface support"
 	depends on ATARI
-	select IDE_GENERIC
 	help
 	  This is the IDE driver for the builtin IDE interface on the Atari
 	  Falcon. Say Y if you have a Falcon and want to use IDE devices (har=
d
@@ -974,9 +981,8 @@ config BLK_DEV_FALCON_IDE
 	  interface.
=20
 config BLK_DEV_MAC_IDE
-	bool "Macintosh Quadra/Powerbook IDE interface support"
+	tristate "Macintosh Quadra/Powerbook IDE interface support"
 	depends on MAC
-	select IDE_GENERIC
 	help
 	  This is the IDE driver for the builtin IDE interface on some m68k
 	  Macintosh models. It supports both the `Quadra style' (used in
@@ -988,18 +994,16 @@ config BLK_DEV_MAC_IDE
 	  builtin IDE interface.
=20
 config BLK_DEV_Q40IDE
-	bool "Q40/Q60 IDE interface support"
+	tristate "Q40/Q60 IDE interface support"
 	depends on Q40
-	select IDE_GENERIC
 	help
 	  Enable the on-board IDE controller in the Q40/Q60.  This should
 	  normally be on; disable it only if you are running a custom hard
 	  drive subsystem through an expansion card.
=20
 config BLK_DEV_MPC8xx_IDE
-	bool "MPC8xx IDE support"
+	tristate "MPC8xx IDE support"
 	depends on 8xx && (LWMON || IVMS8 || IVML24 || TQM8xxL) && IDE=3Dy &&=
 BLK_DEV_IDE=3Dy && !PPC_MERGE
-	select IDE_GENERIC
 	help
 	  This option provides support for IDE on Motorola MPC8xx Systems.
 	  Please see 'Type of MPC8xx IDE interface' for details.
diff --git a/drivers/ide/Makefile b/drivers/ide/Makefile
index b181fc6..0d2da89 100644
--- a/drivers/ide/Makefile
+++ b/drivers/ide/Makefile
@@ -7,41 +7,37 @@
 # Note : at this point, these files are compiled on all systems.
 # In the future, some of these should be built conditionally.
 #
-# First come modules that register themselves with the core
+# link order is important here
=20
 EXTRA_CFLAGS				+=3D -Idrivers/ide
=20
-obj-$(CONFIG_BLK_DEV_IDE)		+=3D pci/
-
 ide-core-y +=3D ide.o ide-io.o ide-iops.o ide-lib.o ide-probe.o ide-ta=
skfile.o
=20
-ide-core-$(CONFIG_BLK_DEV_CMD640)	+=3D pci/cmd640.o
-
-# Core IDE code - must come before legacy
+# core IDE code
 ide-core-$(CONFIG_BLK_DEV_IDEPCI)	+=3D setup-pci.o
 ide-core-$(CONFIG_BLK_DEV_IDEDMA)	+=3D ide-dma.o
 ide-core-$(CONFIG_IDE_PROC_FS)		+=3D ide-proc.o
-ide-core-$(CONFIG_BLK_DEV_IDEPNP)	+=3D ide-pnp.o
 ide-core-$(CONFIG_BLK_DEV_IDEACPI)	+=3D ide-acpi.o
=20
-# built-in only drivers from arm/
-ide-core-$(CONFIG_IDE_ARM)		+=3D arm/ide_arm.o
+obj-$(CONFIG_BLK_DEV_IDE)		+=3D ide-core.o
=20
-# built-in only drivers from legacy/
-ide-core-$(CONFIG_BLK_DEV_BUDDHA)	+=3D legacy/buddha.o
-ide-core-$(CONFIG_BLK_DEV_FALCON_IDE)	+=3D legacy/falconide.o
-ide-core-$(CONFIG_BLK_DEV_GAYLE)	+=3D legacy/gayle.o
-ide-core-$(CONFIG_BLK_DEV_MAC_IDE)	+=3D legacy/macide.o
-ide-core-$(CONFIG_BLK_DEV_Q40IDE)	+=3D legacy/q40ide.o
+ifeq ($(CONFIG_IDE_ARM), y)
+	ide-arm-core-y +=3D arm/ide_arm.o
+	obj-y +=3D ide-arm-core.o
+endif
=20
-# built-in only drivers from ppc/
-ide-core-$(CONFIG_BLK_DEV_MPC8xx_IDE)	+=3D ppc/mpc8xx.o
-ide-core-$(CONFIG_BLK_DEV_IDE_PMAC)	+=3D ppc/pmac.o
+obj-$(CONFIG_BLK_DEV_IDE)		+=3D legacy/ pci/
=20
-# built-in only drivers from h8300/
-ide-core-$(CONFIG_IDE_H8300)		+=3D h8300/ide-h8300.o
+obj-$(CONFIG_IDEPCI_PCIBUS_ORDER)	+=3D ide-scan-pci.o
=20
-obj-$(CONFIG_BLK_DEV_IDE)		+=3D ide-core.o
+ifeq ($(CONFIG_BLK_DEV_CMD640), y)
+	cmd640-core-y +=3D pci/cmd640.o
+	obj-y +=3D cmd640-core.o
+endif
+
+obj-$(CONFIG_BLK_DEV_IDE)		+=3D cris/ ppc/
+obj-$(CONFIG_BLK_DEV_IDEPNP)		+=3D ide-pnp.o
+obj-$(CONFIG_IDE_H8300)			+=3D h8300/
 obj-$(CONFIG_IDE_GENERIC)		+=3D ide-generic.o
=20
 obj-$(CONFIG_BLK_DEV_IDEDISK)		+=3D ide-disk.o
@@ -49,6 +45,20 @@ obj-$(CONFIG_BLK_DEV_IDECD)		+=3D ide-cd.o
 obj-$(CONFIG_BLK_DEV_IDETAPE)		+=3D ide-tape.o
 obj-$(CONFIG_BLK_DEV_IDEFLOPPY)		+=3D ide-floppy.o
=20
-obj-$(CONFIG_BLK_DEV_IDE)		+=3D legacy/ arm/ mips/
-obj-$(CONFIG_BLK_DEV_HD)		+=3D legacy/
-obj-$(CONFIG_ETRAX_IDE)		+=3D cris/
+ifeq ($(CONFIG_BLK_DEV_IDECS), y)
+	ide-cs-core-y +=3D legacy/ide-cs.o
+	obj-y +=3D ide-cs-core.o
+endif
+
+ifeq ($(CONFIG_BLK_DEV_PLATFORM), y)
+	ide-platform-core-y +=3D legacy/ide_platform.o
+	obj-y +=3D ide-platform-core.o
+endif
+
+obj-$(CONFIG_BLK_DEV_IDE)		+=3D arm/ mips/
+
+# old hd driver must be last
+ifeq ($(CONFIG_BLK_DEV_HD), y)
+	hd-core-y +=3D legacy/hd.o
+	obj-y +=3D hd-core.o
+endif
diff --git a/drivers/ide/arm/Makefile b/drivers/ide/arm/Makefile
index 6a78f07..5f63ad2 100644
--- a/drivers/ide/arm/Makefile
+++ b/drivers/ide/arm/Makefile
@@ -3,4 +3,8 @@ obj-$(CONFIG_BLK_DEV_IDE_ICSIDE)	+=3D icside.o
 obj-$(CONFIG_BLK_DEV_IDE_RAPIDE)	+=3D rapide.o
 obj-$(CONFIG_BLK_DEV_IDE_BAST)		+=3D bast-ide.o
=20
+ifeq ($(CONFIG_IDE_ARM), m)
+	obj-m +=3D ide_arm.o
+endif
+
 EXTRA_CFLAGS	:=3D -Idrivers/ide
diff --git a/drivers/ide/arm/bast-ide.c b/drivers/ide/arm/bast-ide.c
index 48db616..45bf9c8 100644
--- a/drivers/ide/arm/bast-ide.c
+++ b/drivers/ide/arm/bast-ide.c
@@ -45,7 +45,7 @@ bastide_register(unsigned int base, unsigned int aux,=
 int irq,
 	hw.io_ports[IDE_CONTROL_OFFSET] =3D aux + (6 * 0x20);
 	hw.irq =3D irq;
=20
-	ide_register_hw(&hw, NULL, 0, hwif);
+	ide_register_hw(&hw, NULL, hwif);
=20
 	return 0;
 }
diff --git a/drivers/ide/arm/icside.c b/drivers/ide/arm/icside.c
index 673402f..8a5c720 100644
--- a/drivers/ide/arm/icside.c
+++ b/drivers/ide/arm/icside.c
@@ -287,26 +287,10 @@ static void icside_set_dma_mode(ide_drive_t *driv=
e, const u8 xfer_mode)
 		ide_xfer_verbose(xfer_mode), 2000 / drive->drive_data);
 }
=20
-static void icside_dma_host_off(ide_drive_t *drive)
+static void icside_dma_host_set(ide_drive_t *drive, int on)
 {
 }
=20
-static void icside_dma_off_quietly(ide_drive_t *drive)
-{
-	drive->using_dma =3D 0;
-}
-
-static void icside_dma_host_on(ide_drive_t *drive)
-{
-}
-
-static int icside_dma_on(ide_drive_t *drive)
-{
-	drive->using_dma =3D 1;
-
-	return 0;
-}
-
 static int icside_dma_end(ide_drive_t *drive)
 {
 	ide_hwif_t *hwif =3D HWIF(drive);
@@ -422,10 +406,7 @@ static void icside_dma_init(ide_hwif_t *hwif)
 	hwif->dmatable_dma	=3D 0;
 	hwif->set_dma_mode	=3D icside_set_dma_mode;
=20
-	hwif->dma_host_off	=3D icside_dma_host_off;
-	hwif->dma_off_quietly	=3D icside_dma_off_quietly;
-	hwif->dma_host_on	=3D icside_dma_host_on;
-	hwif->ide_dma_on	=3D icside_dma_on;
+	hwif->dma_host_set	=3D icside_dma_host_set;
 	hwif->dma_setup		=3D icside_dma_setup;
 	hwif->dma_exec_cmd	=3D icside_dma_exec_cmd;
 	hwif->dma_start		=3D icside_dma_start;
diff --git a/drivers/ide/arm/ide_arm.c b/drivers/ide/arm/ide_arm.c
index 8957cba..60f2497 100644
--- a/drivers/ide/arm/ide_arm.c
+++ b/drivers/ide/arm/ide_arm.c
@@ -24,12 +24,25 @@
 # define IDE_ARM_IRQ	IRQ_HARDDISK
 #endif
=20
-void __init ide_arm_init(void)
+static int __init ide_arm_init(void)
 {
+	ide_hwif_t *hwif;
 	hw_regs_t hw;
+	u8 idx[4] =3D { 0xff, 0xff, 0xff, 0xff };
=20
 	memset(&hw, 0, sizeof(hw));
 	ide_std_init_ports(&hw, IDE_ARM_IO, IDE_ARM_IO + 0x206);
 	hw.irq =3D IDE_ARM_IRQ;
-	ide_register_hw(&hw, NULL, 1, NULL);
+
+	hwif =3D ide_find_port(hw.io_ports[IDE_DATA_OFFSET]);
+	if (hwif) {
+		ide_init_port_hw(hwif, &hw);
+		idx[0] =3D hwif->index;
+
+		ide_device_add(idx);
+	}
+
+	return 0;
 }
+
+module_init(ide_arm_init);
diff --git a/drivers/ide/arm/rapide.c b/drivers/ide/arm/rapide.c
index 0775a3a..e6b56d1 100644
--- a/drivers/ide/arm/rapide.c
+++ b/drivers/ide/arm/rapide.c
@@ -13,26 +13,18 @@
=20
 #include <asm/ecard.h>
=20
-static ide_hwif_t *
-rapide_locate_hwif(void __iomem *base, void __iomem *ctrl, unsigned in=
t sz, int irq)
+static void rapide_setup_ports(hw_regs_t *hw, void __iomem *base,
+			       void __iomem *ctrl, unsigned int sz, int irq)
 {
 	unsigned long port =3D (unsigned long)base;
-	ide_hwif_t *hwif =3D ide_find_port(port);
 	int i;
=20
-	if (hwif =3D=3D NULL)
-		goto out;
-
 	for (i =3D IDE_DATA_OFFSET; i <=3D IDE_STATUS_OFFSET; i++) {
-		hwif->io_ports[i] =3D port;
+		hw->io_ports[i] =3D port;
 		port +=3D sz;
 	}
-	hwif->io_ports[IDE_CONTROL_OFFSET] =3D (unsigned long)ctrl;
-	hwif->irq =3D irq;
-	hwif->mmio =3D 1;
-	default_hwif_mmiops(hwif);
-out:
-	return hwif;
+	hw->io_ports[IDE_CONTROL_OFFSET] =3D (unsigned long)ctrl;
+	hw->irq =3D irq;
 }
=20
 static int __devinit
@@ -42,6 +34,7 @@ rapide_probe(struct expansion_card *ec, const struct =
ecard_id *id)
 	void __iomem *base;
 	int ret;
 	u8 idx[4] =3D { 0xff, 0xff, 0xff, 0xff };
+	hw_regs_t hw;
=20
 	ret =3D ecard_request_resources(ec);
 	if (ret)
@@ -53,11 +46,17 @@ rapide_probe(struct expansion_card *ec, const struc=
t ecard_id *id)
 		goto release;
 	}
=20
-	hwif =3D rapide_locate_hwif(base, base + 0x818, 1 << 6, ec->irq);
+	hwif =3D ide_find_port((unsigned long)base);
 	if (hwif) {
-		hwif->hwif_data =3D base;
-		hwif->gendev.parent =3D &ec->dev;
-		hwif->noprobe =3D 0;
+		memset(&hw, 0, sizeof(hw));
+		rapide_setup_ports(&hw, base, base + 0x818, 1 << 6, ec->irq);
+		hw.chipset =3D ide_generic;
+		hw.dev =3D &ec->dev;
+
+		ide_init_port_hw(hwif, &hw);
+
+		hwif->mmio =3D 1;
+		default_hwif_mmiops(hwif);
=20
 		idx[0] =3D hwif->index;
=20
diff --git a/drivers/ide/cris/Makefile b/drivers/ide/cris/Makefile
index 6176e8d..20b9596 100644
--- a/drivers/ide/cris/Makefile
+++ b/drivers/ide/cris/Makefile
@@ -1,3 +1,3 @@
 EXTRA_CFLAGS				+=3D -Idrivers/ide
=20
-obj-y					+=3D ide-cris.o
+obj-$(CONFIG_IDE_ETRAX)			+=3D ide-cris.o
diff --git a/drivers/ide/cris/ide-cris.c b/drivers/ide/cris/ide-cris.c
index 325e608..8c3294c 100644
--- a/drivers/ide/cris/ide-cris.c
+++ b/drivers/ide/cris/ide-cris.c
@@ -673,9 +673,8 @@ static void cris_ide_input_data (ide_drive_t *drive=
, void *, unsigned int);
 static void cris_ide_output_data (ide_drive_t *drive, void *, unsigned=
 int);
 static void cris_atapi_input_bytes(ide_drive_t *drive, void *, unsigne=
d int);
 static void cris_atapi_output_bytes(ide_drive_t *drive, void *, unsign=
ed int);
-static int cris_dma_on (ide_drive_t *drive);
=20
-static void cris_dma_off(ide_drive_t *drive)
+static void cris_dma_host_set(ide_drive_t *drive, int on)
 {
 }
=20
@@ -755,13 +754,11 @@ static void cris_set_dma_mode(ide_drive_t *drive,=
 const u8 speed)
 		cris_ide_set_speed(TYPE_DMA, 0, strobe, hold);
 }
=20
-void __init
-init_e100_ide (void)
+static int __init init_e100_ide(void)
 {
 	hw_regs_t hw;
-	int ide_offsets[IDE_NR_PORTS];
-	int h;
-	int i;
+	int ide_offsets[IDE_NR_PORTS], h, i;
+	u8 idx[4] =3D { 0xff, 0xff, 0xff, 0xff };
=20
 	printk("ide: ETRAX FS built-in ATA DMA controller\n");
=20
@@ -778,9 +775,11 @@ init_e100_ide (void)
 		                ide_offsets,
 		                0, 0, cris_ide_ack_intr,
 		                ide_default_irq(0));
-		ide_register_hw(&hw, NULL, 1, &hwif);
+		hwif =3D ide_find_port(hw.io_ports[IDE_DATA_OFFSET]);
 		if (hwif =3D=3D NULL)
 			continue;
+		ide_init_port_data(hwif, hwif->index);
+		ide_init_port_hw(hwif, &hw);
 		hwif->mmio =3D 1;
 		hwif->chipset =3D ide_etrax100;
 		hwif->set_pio_mode =3D &cris_set_pio_mode;
@@ -789,6 +788,7 @@ init_e100_ide (void)
 		hwif->ata_output_data =3D &cris_ide_output_data;
 		hwif->atapi_input_bytes =3D &cris_atapi_input_bytes;
 		hwif->atapi_output_bytes =3D &cris_atapi_output_bytes;
+		hwif->dma_host_set =3D &cris_dma_host_set;
 		hwif->ide_dma_end =3D &cris_dma_end;
 		hwif->dma_setup =3D &cris_dma_setup;
 		hwif->dma_exec_cmd =3D &cris_dma_exec_cmd;
@@ -799,9 +799,6 @@ init_e100_ide (void)
 		hwif->OUTBSYNC =3D &cris_ide_outbsync;
 		hwif->INB =3D &cris_ide_inb;
 		hwif->INW =3D &cris_ide_inw;
-		hwif->dma_host_off =3D &cris_dma_off;
-		hwif->dma_host_on =3D &cris_dma_on;
-		hwif->dma_off_quietly =3D &cris_dma_off;
 		hwif->cbl =3D ATA_CBL_PATA40;
 		hwif->host_flags |=3D IDE_HFLAG_NO_ATAPI_DMA;
 		hwif->pio_mask =3D ATA_PIO4,
@@ -809,6 +806,8 @@ init_e100_ide (void)
 		hwif->drives[1].autotune =3D 1;
 		hwif->ultra_mask =3D cris_ultra_mask;
 		hwif->mwdma_mask =3D 0x07; /* Multiword DMA 0-2 */
+
+		idx[h] =3D hwif->index;
 	}
=20
 	/* Reset pulse */
@@ -821,14 +820,12 @@ init_e100_ide (void)
 	cris_ide_set_speed(TYPE_PIO, ATA_PIO4_SETUP, ATA_PIO4_STROBE, ATA_PIO=
4_HOLD);
 	cris_ide_set_speed(TYPE_DMA, 0, ATA_DMA2_STROBE, ATA_DMA2_HOLD);
 	cris_ide_set_speed(TYPE_UDMA, ATA_UDMA2_CYC, ATA_UDMA2_DVS, 0);
-}
=20
-static int cris_dma_on (ide_drive_t *drive)
-{
+	ide_device_add(idx);
+
 	return 0;
 }
=20
-
 static cris_dma_descr_type mydescr __attribute__ ((__aligned__(16)));
=20
 /*
@@ -1060,3 +1057,5 @@ static void cris_dma_start(ide_drive_t *drive)
 		LED_DISK_READ(1);
 	}
 }
+
+module_init(init_e100_ide);
diff --git a/drivers/ide/h8300/Makefile b/drivers/ide/h8300/Makefile
new file mode 100644
index 0000000..5eba16f
--- /dev/null
+++ b/drivers/ide/h8300/Makefile
@@ -0,0 +1,2 @@
+
+obj-$(CONFIG_IDE_H8300)			+=3D ide-h8300.o
diff --git a/drivers/ide/h8300/ide-h8300.c b/drivers/ide/h8300/ide-h830=
0.c
index 4a49b5c..4f6d019 100644
--- a/drivers/ide/h8300/ide-h8300.c
+++ b/drivers/ide/h8300/ide-h8300.c
@@ -84,11 +84,12 @@ static inline void hwif_setup(ide_hwif_t *hwif)
 	hwif->INSL  =3D NULL;
 }
=20
-void __init h8300_ide_init(void)
+static int __init h8300_ide_init(void)
 {
 	hw_regs_t hw;
 	ide_hwif_t *hwif;
-	int idx;
+	int index;
+	u8 idx[4] =3D { 0xff, 0xff, 0xff, 0xff };
=20
 	if (!request_region(CONFIG_H8300_IDE_BASE, H8300_IDE_GAP*8, "ide-h830=
0"))
 		goto out_busy;
@@ -100,16 +101,28 @@ void __init h8300_ide_init(void)
 	hw_setup(&hw);
=20
 	/* register if */
-	idx =3D ide_register_hw(&hw, NULL, 1, &hwif);
-	if (idx =3D=3D -1) {
+	hwif =3D ide_find_port(hw.io_ports[IDE_DATA_OFFSET]);
+	if (hwif =3D=3D NULL) {
 		printk(KERN_ERR "ide-h8300: IDE I/F register failed\n");
-		return;
+		return -ENOENT;
 	}
=20
+	index =3D hwif->index;
+	ide_init_port_data(hwif, index);
+	ide_init_port_hw(hwif, &hw);
 	hwif_setup(hwif);
-	printk(KERN_INFO "ide%d: H8/300 generic IDE interface\n", idx);
-	return;
+	printk(KERN_INFO "ide%d: H8/300 generic IDE interface\n", index);
+
+	idx[0] =3D index;
+
+	ide_device_add(idx);
+
+	return 0;
=20
 out_busy:
 	printk(KERN_ERR "ide-h8300: IDE I/F resource already used.\n");
+
+	return -EBUSY;
 }
+
+module_init(h8300_ide_init);
diff --git a/drivers/ide/ide-acpi.c b/drivers/ide/ide-acpi.c
index e0bb0cf..e888fc3 100644
--- a/drivers/ide/ide-acpi.c
+++ b/drivers/ide/ide-acpi.c
@@ -386,7 +386,7 @@ static int taskfile_load_raw(ide_drive_t *drive,
=20
 	/* convert gtf to IDE Taskfile */
 	memcpy(&args.tf_array[7], &gtf->tfa, 7);
-	args.tf_flags =3D IDE_TFLAG_OUT_TF | IDE_TFLAG_OUT_DEVICE;
+	args.tf_flags =3D IDE_TFLAG_TF | IDE_TFLAG_DEVICE;
=20
 	if (ide_noacpitfs) {
 		DEBPRINT("_GTF execution disabled\n");
diff --git a/drivers/ide/ide-disk.c b/drivers/ide/ide-disk.c
index d8fdd86..717e114 100644
--- a/drivers/ide/ide-disk.c
+++ b/drivers/ide/ide-disk.c
@@ -201,7 +201,7 @@ static ide_startstop_t __ide_do_rw_disk(ide_drive_t=
 *drive, struct request *rq,
=20
 	memset(&task, 0, sizeof(task));
 	task.tf_flags =3D IDE_TFLAG_NO_SELECT_MASK;  /* FIXME? */
-	task.tf_flags |=3D (IDE_TFLAG_OUT_TF | IDE_TFLAG_OUT_DEVICE);
+	task.tf_flags |=3D (IDE_TFLAG_TF | IDE_TFLAG_DEVICE);
=20
 	if (drive->select.b.lba) {
 		if (lba48) {
@@ -219,13 +219,8 @@ static ide_startstop_t __ide_do_rw_disk(ide_drive_=
t *drive, struct request *rq,
 			tf->lbal   =3D (u8) block;
 			tf->lbam   =3D (u8)(block >>  8);
 			tf->lbah   =3D (u8)(block >> 16);
-#ifdef DEBUG
-			printk("%s: 0x%02x%02x 0x%02x%02x%02x%02x%02x%02x\n",
-				drive->name, tf->hob_nsect, tf->nsect,
-				tf->hob_lbah, tf->hob_lbam, tf->hob_lbal,
-				tf->lbah, tf->lbam, tf->lbal);
-#endif
-			task.tf_flags |=3D (IDE_TFLAG_LBA48 | IDE_TFLAG_OUT_HOB);
+
+			task.tf_flags |=3D (IDE_TFLAG_LBA48 | IDE_TFLAG_HOB);
 		} else {
 			tf->nsect  =3D nsectors & 0xff;
 			tf->lbal   =3D block;
@@ -319,9 +314,9 @@ static u64 idedisk_read_native_max_address(ide_driv=
e_t *drive, int lba48)
 	else
 		tf->command =3D WIN_READ_NATIVE_MAX;
 	tf->device  =3D ATA_LBA;
-	args.tf_flags =3D IDE_TFLAG_OUT_TF | IDE_TFLAG_OUT_DEVICE;
+	args.tf_flags =3D IDE_TFLAG_TF | IDE_TFLAG_DEVICE;
 	if (lba48)
-		args.tf_flags |=3D (IDE_TFLAG_LBA48 | IDE_TFLAG_OUT_HOB);
+		args.tf_flags |=3D (IDE_TFLAG_LBA48 | IDE_TFLAG_HOB);
 	/* submit command request */
 	ide_no_data_taskfile(drive, &args);
=20
@@ -358,9 +353,9 @@ static u64 idedisk_set_max_address(ide_drive_t *dri=
ve, u64 addr_req, int lba48)
 		tf->command  =3D WIN_SET_MAX;
 	}
 	tf->device |=3D ATA_LBA;
-	args.tf_flags =3D IDE_TFLAG_OUT_TF | IDE_TFLAG_OUT_DEVICE;
+	args.tf_flags =3D IDE_TFLAG_TF | IDE_TFLAG_DEVICE;
 	if (lba48)
-		args.tf_flags |=3D (IDE_TFLAG_LBA48 | IDE_TFLAG_OUT_HOB);
+		args.tf_flags |=3D (IDE_TFLAG_LBA48 | IDE_TFLAG_HOB);
 	/* submit command request */
 	ide_no_data_taskfile(drive, &args);
 	/* if OK, compute maximum address value */
@@ -500,7 +495,7 @@ static int smart_enable(ide_drive_t *drive)
 	tf->lbam    =3D SMART_LCYL_PASS;
 	tf->lbah    =3D SMART_HCYL_PASS;
 	tf->command =3D WIN_SMART;
-	args.tf_flags =3D IDE_TFLAG_OUT_TF | IDE_TFLAG_OUT_DEVICE;
+	args.tf_flags =3D IDE_TFLAG_TF | IDE_TFLAG_DEVICE;
 	return ide_no_data_taskfile(drive, &args);
 }
=20
@@ -515,7 +510,7 @@ static int get_smart_data(ide_drive_t *drive, u8 *b=
uf, u8 sub_cmd)
 	tf->lbam    =3D SMART_LCYL_PASS;
 	tf->lbah    =3D SMART_HCYL_PASS;
 	tf->command =3D WIN_SMART;
-	args.tf_flags	=3D IDE_TFLAG_OUT_TF | IDE_TFLAG_OUT_DEVICE;
+	args.tf_flags	=3D IDE_TFLAG_TF | IDE_TFLAG_DEVICE;
 	args.data_phase	=3D TASKFILE_IN;
 	(void) smart_enable(drive);
 	return ide_raw_taskfile(drive, &args, buf, 1);
@@ -625,8 +620,10 @@ static int set_multcount(ide_drive_t *drive, int a=
rg)
=20
 	if (drive->special.b.set_multmode)
 		return -EBUSY;
+
 	ide_init_drive_cmd (&rq);
-	rq.cmd_type =3D REQ_TYPE_ATA_CMD;
+	rq.cmd_type =3D REQ_TYPE_ATA_TASKFILE;
+
 	drive->mult_req =3D arg;
 	drive->special.b.set_multmode =3D 1;
 	(void) ide_do_drive_cmd (drive, &rq, ide_wait);
@@ -694,7 +691,7 @@ static int write_cache(ide_drive_t *drive, int arg)
 		args.tf.feature =3D arg ?
 			SETFEATURES_EN_WCACHE : SETFEATURES_DIS_WCACHE;
 		args.tf.command =3D WIN_SETFEATURES;
-		args.tf_flags =3D IDE_TFLAG_OUT_TF | IDE_TFLAG_OUT_DEVICE;
+		args.tf_flags =3D IDE_TFLAG_TF | IDE_TFLAG_DEVICE;
 		err =3D ide_no_data_taskfile(drive, &args);
 		if (err =3D=3D 0)
 			drive->wcache =3D arg;
@@ -714,7 +711,7 @@ static int do_idedisk_flushcache (ide_drive_t *driv=
e)
 		args.tf.command =3D WIN_FLUSH_CACHE_EXT;
 	else
 		args.tf.command =3D WIN_FLUSH_CACHE;
-	args.tf_flags =3D IDE_TFLAG_OUT_TF | IDE_TFLAG_OUT_DEVICE;
+	args.tf_flags =3D IDE_TFLAG_TF | IDE_TFLAG_DEVICE;
 	return ide_no_data_taskfile(drive, &args);
 }
=20
@@ -729,7 +726,7 @@ static int set_acoustic (ide_drive_t *drive, int ar=
g)
 	args.tf.feature =3D arg ? SETFEATURES_EN_AAM : SETFEATURES_DIS_AAM;
 	args.tf.nsect   =3D arg;
 	args.tf.command =3D WIN_SETFEATURES;
-	args.tf_flags =3D IDE_TFLAG_OUT_TF | IDE_TFLAG_OUT_DEVICE;
+	args.tf_flags =3D IDE_TFLAG_TF | IDE_TFLAG_DEVICE;
 	ide_no_data_taskfile(drive, &args);
 	drive->acoustic =3D arg;
 	return 0;
@@ -766,7 +763,6 @@ static void idedisk_add_settings(ide_drive_t *drive=
)
 	ide_add_setting(drive,	"bios_head",	SETTING_RW,	TYPE_BYTE,	0,	255,			=
1,	1,	&drive->bios_head,	NULL);
 	ide_add_setting(drive,	"bios_sect",	SETTING_RW,	TYPE_BYTE,	0,	63,			1=
,	1,	&drive->bios_sect,	NULL);
 	ide_add_setting(drive,	"address",	SETTING_RW,	TYPE_BYTE,	0,	2,			1,	1=
,	&drive->addressing,	set_lba_addressing);
-	ide_add_setting(drive,	"bswap",	SETTING_READ,	TYPE_BYTE,	0,	1,			1,	1=
,	&drive->bswap,		NULL);
 	ide_add_setting(drive,	"multcount",	SETTING_RW,	TYPE_BYTE,	0,	id->max=
_multsect,	1,	1,	&drive->mult_count,	set_multcount);
 	ide_add_setting(drive,	"nowerr",	SETTING_RW,	TYPE_BYTE,	0,	1,			1,	1,=
	&drive->nowerr,		set_nowerr);
 	ide_add_setting(drive,	"lun",		SETTING_RW,	TYPE_INT,	0,	7,			1,	1,	&d=
rive->lun,		NULL);
@@ -975,6 +971,17 @@ static ide_driver_t idedisk_driver =3D {
 #endif
 };
=20
+static int idedisk_set_doorlock(ide_drive_t *drive, int on)
+{
+	ide_task_t task;
+
+	memset(&task, 0, sizeof(task));
+	task.tf.command =3D on ? WIN_DOORLOCK : WIN_DOORUNLOCK;
+	task.tf_flags =3D IDE_TFLAG_TF | IDE_TFLAG_DEVICE;
+
+	return ide_no_data_taskfile(drive, &task);
+}
+
 static int idedisk_open(struct inode *inode, struct file *filp)
 {
 	struct gendisk *disk =3D inode->i_bdev->bd_disk;
@@ -989,17 +996,13 @@ static int idedisk_open(struct inode *inode, stru=
ct file *filp)
 	idkp->openers++;
=20
 	if (drive->removable && idkp->openers =3D=3D 1) {
-		ide_task_t args;
-		memset(&args, 0, sizeof(ide_task_t));
-		args.tf.command =3D WIN_DOORLOCK;
-		args.tf_flags =3D IDE_TFLAG_OUT_TF | IDE_TFLAG_OUT_DEVICE;
 		check_disk_change(inode->i_bdev);
 		/*
 		 * Ignore the return code from door_lock,
 		 * since the open() has already succeeded,
 		 * and the door_lock is irrelevant at this point.
 		 */
-		if (drive->doorlocking && ide_no_data_taskfile(drive, &args))
+		if (drive->doorlocking && idedisk_set_doorlock(drive, 1))
 			drive->doorlocking =3D 0;
 	}
 	return 0;
@@ -1015,11 +1018,7 @@ static int idedisk_release(struct inode *inode, =
struct file *filp)
 		ide_cacheflush_p(drive);
=20
 	if (drive->removable && idkp->openers =3D=3D 1) {
-		ide_task_t args;
-		memset(&args, 0, sizeof(ide_task_t));
-		args.tf.command =3D WIN_DOORUNLOCK;
-		args.tf_flags =3D IDE_TFLAG_OUT_TF | IDE_TFLAG_OUT_DEVICE;
-		if (drive->doorlocking && ide_no_data_taskfile(drive, &args))
+		if (drive->doorlocking && idedisk_set_doorlock(drive, 0))
 			drive->doorlocking =3D 0;
 	}
=20
diff --git a/drivers/ide/ide-dma.c b/drivers/ide/ide-dma.c
index 18c78ad..5bf3203 100644
--- a/drivers/ide/ide-dma.c
+++ b/drivers/ide/ide-dma.c
@@ -153,13 +153,7 @@ ide_startstop_t ide_dma_intr (ide_drive_t *drive)
 		if (!dma_stat) {
 			struct request *rq =3D HWGROUP(drive)->rq;
=20
-			if (rq->rq_disk) {
-				ide_driver_t *drv;
-
-				drv =3D *(ide_driver_t **)rq->rq_disk->private_data;
-				drv->end_request(drive, 1, rq->nr_sectors);
-			} else
-				ide_end_request(drive, 1, rq->nr_sectors);
+			task_end_request(drive, rq, stat);
 			return ide_stopped;
 		}
 		printk(KERN_ERR "%s: dma_intr: bad DMA status (dma_stat=3D%x)\n",=20
@@ -408,23 +402,29 @@ static int dma_timer_expiry (ide_drive_t *drive)
 }
=20
 /**
- *	ide_dma_host_off	-	Generic DMA kill
+ *	ide_dma_host_set	-	Enable/disable DMA on a host
  *	@drive: drive to control
  *
- *	Perform the generic IDE controller DMA off operation. This
- *	works for most IDE bus mastering controllers
+ *	Enable/disable DMA on an IDE controller following generic
+ *	bus-mastering IDE controller behaviour.
  */
=20
-void ide_dma_host_off(ide_drive_t *drive)
+void ide_dma_host_set(ide_drive_t *drive, int on)
 {
 	ide_hwif_t *hwif	=3D HWIF(drive);
 	u8 unit			=3D (drive->select.b.unit & 0x01);
 	u8 dma_stat		=3D hwif->INB(hwif->dma_status);
=20
-	hwif->OUTB((dma_stat & ~(1<<(5+unit))), hwif->dma_status);
+	if (on)
+		dma_stat |=3D (1 << (5 + unit));
+	else
+		dma_stat &=3D ~(1 << (5 + unit));
+
+	hwif->OUTB(dma_stat, hwif->dma_status);
 }
=20
-EXPORT_SYMBOL(ide_dma_host_off);
+EXPORT_SYMBOL_GPL(ide_dma_host_set);
+#endif /* CONFIG_BLK_DEV_IDEDMA_PCI */
=20
 /**
  *	ide_dma_off_quietly	-	Generic DMA kill
@@ -438,11 +438,10 @@ void ide_dma_off_quietly(ide_drive_t *drive)
 	drive->using_dma =3D 0;
 	ide_toggle_bounce(drive, 0);
=20
-	drive->hwif->dma_host_off(drive);
+	drive->hwif->dma_host_set(drive, 0);
 }
=20
 EXPORT_SYMBOL(ide_dma_off_quietly);
-#endif /* CONFIG_BLK_DEV_IDEDMA_PCI */
=20
 /**
  *	ide_dma_off	-	disable DMA on a device
@@ -455,52 +454,29 @@ EXPORT_SYMBOL(ide_dma_off_quietly);
 void ide_dma_off(ide_drive_t *drive)
 {
 	printk(KERN_INFO "%s: DMA disabled\n", drive->name);
-	drive->hwif->dma_off_quietly(drive);
+	ide_dma_off_quietly(drive);
 }
=20
 EXPORT_SYMBOL(ide_dma_off);
=20
-#ifdef CONFIG_BLK_DEV_IDEDMA_PCI
-/**
- *	ide_dma_host_on	-	Enable DMA on a host
- *	@drive: drive to enable for DMA
- *
- *	Enable DMA on an IDE controller following generic bus mastering
- *	IDE controller behaviour
- */
-
-void ide_dma_host_on(ide_drive_t *drive)
-{
-	if (drive->using_dma) {
-		ide_hwif_t *hwif	=3D HWIF(drive);
-		u8 unit			=3D (drive->select.b.unit & 0x01);
-		u8 dma_stat		=3D hwif->INB(hwif->dma_status);
-
-		hwif->OUTB((dma_stat|(1<<(5+unit))), hwif->dma_status);
-	}
-}
-
-EXPORT_SYMBOL(ide_dma_host_on);
-
 /**
- *	__ide_dma_on		-	Enable DMA on a device
+ *	ide_dma_on		-	Enable DMA on a device
  *	@drive: drive to enable DMA on
  *
  *	Enable IDE DMA for a device on this IDE controller.
  */
-=20
-int __ide_dma_on (ide_drive_t *drive)
+
+void ide_dma_on(ide_drive_t *drive)
 {
 	drive->using_dma =3D 1;
 	ide_toggle_bounce(drive, 1);
=20
-	drive->hwif->dma_host_on(drive);
-
-	return 0;
+	drive->hwif->dma_host_set(drive, 1);
 }
=20
-EXPORT_SYMBOL(__ide_dma_on);
+EXPORT_SYMBOL(ide_dma_on);
=20
+#ifdef CONFIG_BLK_DEV_IDEDMA_PCI
 /**
  *	ide_dma_setup	-	begin a DMA phase
  *	@drive: target device
@@ -755,6 +731,7 @@ EXPORT_SYMBOL_GPL(ide_find_dma_mode);
=20
 static int ide_tune_dma(ide_drive_t *drive)
 {
+	ide_hwif_t *hwif =3D drive->hwif;
 	u8 speed;
=20
 	if (noautodma || drive->nodma || (drive->id->capability & 1) =3D=3D 0=
)
@@ -767,15 +744,21 @@ static int ide_tune_dma(ide_drive_t *drive)
 	if (ide_id_dma_bug(drive))
 		return 0;
=20
-	if (drive->hwif->host_flags & IDE_HFLAG_TRUST_BIOS_FOR_DMA)
+	if (hwif->host_flags & IDE_HFLAG_TRUST_BIOS_FOR_DMA)
 		return config_drive_for_dma(drive);
=20
 	speed =3D ide_max_dma_mode(drive);
=20
-	if (!speed)
-		return 0;
+	if (!speed) {
+		 /* is this really correct/needed? */
+		if ((hwif->host_flags & IDE_HFLAG_CY82C693) &&
+		    ide_dma_good_drive(drive))
+			return 1;
+		else
+			return 0;
+	}
=20
-	if (drive->hwif->host_flags & IDE_HFLAG_NO_SET_MODE)
+	if (hwif->host_flags & IDE_HFLAG_NO_SET_MODE)
 		return 0;
=20
 	if (ide_set_dma_mode(drive, speed))
@@ -820,7 +803,6 @@ err_out:
=20
 int ide_set_dma(ide_drive_t *drive)
 {
-	ide_hwif_t *hwif =3D drive->hwif;
 	int rc;
=20
 	/*
@@ -829,13 +811,15 @@ int ide_set_dma(ide_drive_t *drive)
 	 * things, if not checked and cleared.
 	 *   PARANOIA!!!
 	 */
-	hwif->dma_off_quietly(drive);
+	ide_dma_off_quietly(drive);
=20
 	rc =3D ide_dma_check(drive);
 	if (rc)
 		return rc;
=20
-	return hwif->ide_dma_on(drive);
+	ide_dma_on(drive);
+
+	return 0;
 }
=20
 #ifdef CONFIG_BLK_DEV_IDEDMA_PCI
@@ -972,14 +956,8 @@ void ide_setup_dma(ide_hwif_t *hwif, unsigned long=
 base, unsigned num_ports)
 	if (!(hwif->dma_prdtable))
 		hwif->dma_prdtable	=3D (hwif->dma_base + 4);
=20
-	if (!hwif->dma_off_quietly)
-		hwif->dma_off_quietly =3D &ide_dma_off_quietly;
-	if (!hwif->dma_host_off)
-		hwif->dma_host_off =3D &ide_dma_host_off;
-	if (!hwif->ide_dma_on)
-		hwif->ide_dma_on =3D &__ide_dma_on;
-	if (!hwif->dma_host_on)
-		hwif->dma_host_on =3D &ide_dma_host_on;
+	if (!hwif->dma_host_set)
+		hwif->dma_host_set =3D &ide_dma_host_set;
 	if (!hwif->dma_setup)
 		hwif->dma_setup =3D &ide_dma_setup;
 	if (!hwif->dma_exec_cmd)
diff --git a/drivers/ide/ide-generic.c b/drivers/ide/ide-generic.c
index 0f72b98..bb30c29 100644
--- a/drivers/ide/ide-generic.c
+++ b/drivers/ide/ide-generic.c
@@ -14,10 +14,16 @@
=20
 static int __init ide_generic_init(void)
 {
+	u8 idx[MAX_HWIFS];
+	int i;
+
 	if (ide_hwifs[0].io_ports[IDE_DATA_OFFSET])
 		ide_get_lock(NULL, NULL); /* for atari only */
=20
-	(void)ideprobe_init();
+	for (i =3D 0; i < MAX_HWIFS; i++)
+		idx[i] =3D ide_hwifs[i].present ? 0xff : i;
+
+	ide_device_add_all(idx);
=20
 	if (ide_hwifs[0].io_ports[IDE_DATA_OFFSET])
 		ide_release_lock();	/* for atari only */
diff --git a/drivers/ide/ide-io.c b/drivers/ide/ide-io.c
index 2711b5a..6f8f544 100644
--- a/drivers/ide/ide-io.c
+++ b/drivers/ide/ide-io.c
@@ -75,7 +75,7 @@ static int __ide_end_request(ide_drive_t *drive, stru=
ct request *rq,
 	 */
 	if (drive->state =3D=3D DMA_PIO_RETRY && drive->retry_pio <=3D 3) {
 		drive->state =3D 0;
-		HWGROUP(drive)->hwif->ide_dma_on(drive);
+		ide_dma_on(drive);
 	}
=20
 	if (!end_that_request_chunk(rq, uptodate, nr_bytes)) {
@@ -219,7 +219,7 @@ static ide_startstop_t ide_start_power_step(ide_dri=
ve_t *drive, struct request *
 		 * we could be smarter and check for current xfer_speed
 		 * in struct drive etc...
 		 */
-		if (drive->hwif->ide_dma_on =3D=3D NULL)
+		if (drive->hwif->dma_host_set =3D=3D NULL)
 			break;
 		/*
 		 * TODO: respect ->using_dma setting
@@ -231,7 +231,7 @@ static ide_startstop_t ide_start_power_step(ide_dri=
ve_t *drive, struct request *
 	return ide_stopped;
=20
 out_do_tf:
-	args->tf_flags	 =3D IDE_TFLAG_OUT_TF | IDE_TFLAG_OUT_DEVICE;
+	args->tf_flags	 =3D IDE_TFLAG_TF | IDE_TFLAG_DEVICE;
 	args->data_phase =3D TASKFILE_NO_DATA;
 	return do_rw_taskfile(drive, args);
 }
@@ -354,7 +354,6 @@ void ide_tf_read(ide_drive_t *drive, ide_task_t *ta=
sk)
 =20
 void ide_end_drive_cmd (ide_drive_t *drive, u8 stat, u8 err)
 {
-	ide_hwif_t *hwif =3D HWIF(drive);
 	unsigned long flags;
 	struct request *rq;
=20
@@ -362,17 +361,7 @@ void ide_end_drive_cmd (ide_drive_t *drive, u8 sta=
t, u8 err)
 	rq =3D HWGROUP(drive)->rq;
 	spin_unlock_irqrestore(&ide_lock, flags);
=20
-	if (rq->cmd_type =3D=3D REQ_TYPE_ATA_CMD) {
-		u8 *args =3D (u8 *) rq->buffer;
-		if (rq->errors =3D=3D 0)
-			rq->errors =3D !OK_STAT(stat,READY_STAT,BAD_STAT);
-
-		if (args) {
-			args[0] =3D stat;
-			args[1] =3D err;
-			args[2] =3D hwif->INB(IDE_NSECTOR_REG);
-		}
-	} else if (rq->cmd_type =3D=3D REQ_TYPE_ATA_TASKFILE) {
+	if (rq->cmd_type =3D=3D REQ_TYPE_ATA_TASKFILE) {
 		ide_task_t *args =3D (ide_task_t *) rq->special;
 		if (rq->errors =3D=3D 0)
 			rq->errors =3D !OK_STAT(stat,READY_STAT,BAD_STAT);
@@ -383,10 +372,6 @@ void ide_end_drive_cmd (ide_drive_t *drive, u8 sta=
t, u8 err)
 			tf->error =3D err;
 			tf->status =3D stat;
=20
-			args->tf_flags |=3D (IDE_TFLAG_IN_TF|IDE_TFLAG_IN_DEVICE);
-			if (args->tf_flags & IDE_TFLAG_LBA48)
-				args->tf_flags |=3D IDE_TFLAG_IN_HOB;
-
 			ide_tf_read(drive, args);
 		}
 	} else if (blk_pm_request(rq)) {
@@ -626,42 +611,6 @@ ide_startstop_t ide_abort(ide_drive_t *drive, cons=
t char *msg)
 		return __ide_abort(drive, rq);
 }
=20
-/**
- *	drive_cmd_intr		- 	drive command completion interrupt
- *	@drive: drive the completion interrupt occurred on
- *
- *	drive_cmd_intr() is invoked on completion of a special DRIVE_CMD.
- *	We do any necessary data reading and then wait for the drive to
- *	go non busy. At that point we may read the error data and complete
- *	the request
- */
-=20
-static ide_startstop_t drive_cmd_intr (ide_drive_t *drive)
-{
-	struct request *rq =3D HWGROUP(drive)->rq;
-	ide_hwif_t *hwif =3D HWIF(drive);
-	u8 *args =3D (u8 *) rq->buffer;
-	u8 stat =3D hwif->INB(IDE_STATUS_REG);
-	int retries =3D 10;
-
-	local_irq_enable_in_hardirq();
-	if (rq->cmd_type =3D=3D REQ_TYPE_ATA_CMD &&
-	    (stat & DRQ_STAT) && args && args[3]) {
-		u8 io_32bit =3D drive->io_32bit;
-		drive->io_32bit =3D 0;
-		hwif->ata_input_data(drive, &args[4], args[3] * SECTOR_WORDS);
-		drive->io_32bit =3D io_32bit;
-		while (((stat =3D hwif->INB(IDE_STATUS_REG)) & BUSY_STAT) && retries=
--)
-			udelay(100);
-	}
-
-	if (!OK_STAT(stat, READY_STAT, BAD_STAT))
-		return ide_error(drive, "drive_cmd", stat);
-		/* calls ide_end_drive_cmd */
-	ide_end_drive_cmd(drive, stat, hwif->INB(IDE_ERROR_REG));
-	return ide_stopped;
-}
-
 static void ide_tf_set_specify_cmd(ide_drive_t *drive, struct ide_task=
file *tf)
 {
 	tf->nsect   =3D drive->sect;
@@ -710,7 +659,7 @@ static ide_startstop_t ide_disk_special(ide_drive_t=
 *drive)
 		return ide_stopped;
 	}
=20
-	args.tf_flags =3D IDE_TFLAG_OUT_TF | IDE_TFLAG_OUT_DEVICE |
+	args.tf_flags =3D IDE_TFLAG_TF | IDE_TFLAG_DEVICE |
 			IDE_TFLAG_CUSTOM_HANDLER;
=20
 	do_rw_taskfile(drive, &args);
@@ -787,7 +736,7 @@ static ide_startstop_t do_special (ide_drive_t *dri=
ve)
=20
 			if (hwif->host_flags & IDE_HFLAG_SET_PIO_MODE_KEEP_DMA) {
 				if (keep_dma)
-					hwif->ide_dma_on(drive);
+					ide_dma_on(drive);
 			}
 		}
=20
@@ -847,16 +796,9 @@ static ide_startstop_t execute_drive_cmd (ide_driv=
e_t *drive,
 		struct request *rq)
 {
 	ide_hwif_t *hwif =3D HWIF(drive);
-	u8 *args =3D rq->buffer;
-	ide_task_t ltask;
-	struct ide_taskfile *tf =3D &ltask.tf;
-
-	if (rq->cmd_type =3D=3D REQ_TYPE_ATA_TASKFILE) {
-		ide_task_t *task =3D rq->special;
-=20
-		if (task =3D=3D NULL)
-			goto done;
+	ide_task_t *task =3D rq->special;
=20
+	if (task) {
 		hwif->data_phase =3D task->data_phase;
=20
 		switch (hwif->data_phase) {
@@ -873,33 +815,6 @@ static ide_startstop_t execute_drive_cmd (ide_driv=
e_t *drive,
 		return do_rw_taskfile(drive, task);
 	}
=20
-	if (args =3D=3D NULL)
-		goto done;
-
-	memset(&ltask, 0, sizeof(ltask));
-	if (rq->cmd_type =3D=3D REQ_TYPE_ATA_CMD) {
-#ifdef DEBUG
-		printk("%s: DRIVE_CMD\n", drive->name);
-#endif
-		tf->feature =3D args[2];
-		if (args[0] =3D=3D WIN_SMART) {
-			tf->nsect =3D args[3];
-			tf->lbal  =3D args[1];
-			tf->lbam  =3D 0x4f;
-			tf->lbah  =3D 0xc2;
-			ltask.tf_flags =3D IDE_TFLAG_OUT_TF;
-		} else {
-			tf->nsect =3D args[1];
-			ltask.tf_flags =3D IDE_TFLAG_OUT_FEATURE |
-					 IDE_TFLAG_OUT_NSECT;
-		}
- 	}
-	tf->command =3D args[0];
-	ide_tf_load(drive, &ltask);
-	ide_execute_command(drive, args[0], &drive_cmd_intr, WAIT_WORSTCASE, =
NULL);
-	return ide_started;
-
-done:
  	/*
  	 * NULL is actually a valid way of waiting for
  	 * all current requests to be flushed from the queue.
@@ -939,8 +854,7 @@ static void ide_check_pm_state(ide_drive_t *drive, =
struct request *rq)
 		if (rc)
 			printk(KERN_WARNING "%s: bus not ready on wakeup\n", drive->name);
 		SELECT_DRIVE(drive);
-		if (IDE_CONTROL_REG)
-			HWIF(drive)->OUTB(drive->ctl, IDE_CONTROL_REG);
+		ide_set_irq(drive, 1);
 		rc =3D ide_wait_not_busy(HWIF(drive), 100000);
 		if (rc)
 			printk(KERN_WARNING "%s: drive not ready on wakeup\n", drive->name)=
;
@@ -1004,8 +918,7 @@ static ide_startstop_t start_request (ide_drive_t =
*drive, struct request *rq)
 		if (drive->current_speed =3D=3D 0xff)
 			ide_config_drive_speed(drive, drive->desired_speed);
=20
-		if (rq->cmd_type =3D=3D REQ_TYPE_ATA_CMD ||
-		    rq->cmd_type =3D=3D REQ_TYPE_ATA_TASKFILE)
+		if (rq->cmd_type =3D=3D REQ_TYPE_ATA_TASKFILE)
 			return execute_drive_cmd(drive, rq);
 		else if (blk_pm_request(rq)) {
 			struct request_pm_state *pm =3D rq->data;
@@ -1213,15 +1126,13 @@ static void ide_do_request (ide_hwgroup_t *hwgr=
oup, int masked_irq)
 		}
 	again:
 		hwif =3D HWIF(drive);
-		if (hwgroup->hwif->sharing_irq &&
-		    hwif !=3D hwgroup->hwif &&
-		    hwif->io_ports[IDE_CONTROL_OFFSET]) {
+		if (hwgroup->hwif->sharing_irq && hwif !=3D hwgroup->hwif) {
 			/*
 			 * set nIEN for previous hwif, drives in the
 			 * quirk_list may not like intr setups/cleanups
 			 */
 			if (drive->quirk_list !=3D 1)
-				hwif->OUTB(drive->ctl | 2, IDE_CONTROL_REG);
+				ide_set_irq(drive, 0);
 		}
 		hwgroup->hwif =3D hwif;
 		hwgroup->drive =3D drive;
@@ -1334,7 +1245,7 @@ static ide_startstop_t ide_dma_timeout_retry(ide_=
drive_t *drive, int error)
 	 */
 	drive->retry_pio++;
 	drive->state =3D DMA_PIO_RETRY;
-	hwif->dma_off_quietly(drive);
+	ide_dma_off_quietly(drive);
=20
 	/*
 	 * un-busy drive etc (hwgroup->busy is cleared on return) and
@@ -1679,7 +1590,6 @@ irqreturn_t ide_intr (int irq, void *dev_id)
 void ide_init_drive_cmd (struct request *rq)
 {
 	memset(rq, 0, sizeof(*rq));
-	rq->cmd_type =3D REQ_TYPE_ATA_CMD;
 	rq->ref_count =3D 1;
 }
=20
diff --git a/drivers/ide/ide-iops.c b/drivers/ide/ide-iops.c
index c97c071..e2a7e95 100644
--- a/drivers/ide/ide-iops.c
+++ b/drivers/ide/ide-iops.c
@@ -619,7 +619,7 @@ no_80w:
 int ide_ata66_check (ide_drive_t *drive, ide_task_t *args)
 {
 	if (args->tf.command =3D=3D WIN_SETFEATURES &&
-	    args->tf.lbal > XFER_UDMA_2 &&
+	    args->tf.nsect > XFER_UDMA_2 &&
 	    args->tf.feature =3D=3D SETFEATURES_XFER) {
 		if (eighty_ninty_three(drive) =3D=3D 0) {
 			printk(KERN_WARNING "%s: UDMA speeds >UDMA33 cannot "
@@ -639,7 +639,7 @@ int ide_ata66_check (ide_drive_t *drive, ide_task_t=
 *args)
 int set_transfer (ide_drive_t *drive, ide_task_t *args)
 {
 	if (args->tf.command =3D=3D WIN_SETFEATURES &&
-	    args->tf.lbal >=3D XFER_SW_DMA_0 &&
+	    args->tf.nsect >=3D XFER_SW_DMA_0 &&
 	    args->tf.feature =3D=3D SETFEATURES_XFER &&
 	    (drive->id->dma_ultra ||
 	     drive->id->dma_mword ||
@@ -688,8 +688,7 @@ int ide_driveid_update(ide_drive_t *drive)
 	 */
=20
 	SELECT_MASK(drive, 1);
-	if (IDE_CONTROL_REG)
-		hwif->OUTB(drive->ctl,IDE_CONTROL_REG);
+	ide_set_irq(drive, 1);
 	msleep(50);
 	hwif->OUTB(WIN_IDENTIFY, IDE_COMMAND_REG);
 	timeout =3D jiffies + WAIT_WORSTCASE;
@@ -742,8 +741,8 @@ int ide_config_drive_speed(ide_drive_t *drive, u8 s=
peed)
 //		msleep(50);
=20
 #ifdef CONFIG_BLK_DEV_IDEDMA
-	if (hwif->ide_dma_on)	/* check if host supports DMA */
-		hwif->dma_host_off(drive);
+	if (hwif->dma_host_set)	/* check if host supports DMA */
+		hwif->dma_host_set(drive, 0);
 #endif
=20
 	/* Skip setting PIO flow-control modes on pre-EIDE drives */
@@ -772,13 +771,12 @@ int ide_config_drive_speed(ide_drive_t *drive, u8=
 speed)
 	SELECT_DRIVE(drive);
 	SELECT_MASK(drive, 0);
 	udelay(1);
-	if (IDE_CONTROL_REG)
-		hwif->OUTB(drive->ctl | 2, IDE_CONTROL_REG);
+	ide_set_irq(drive, 0);
 	hwif->OUTB(speed, IDE_NSECTOR_REG);
 	hwif->OUTB(SETFEATURES_XFER, IDE_FEATURE_REG);
 	hwif->OUTBSYNC(drive, WIN_SETFEATURES, IDE_COMMAND_REG);
-	if ((IDE_CONTROL_REG) && (drive->quirk_list =3D=3D 2))
-		hwif->OUTB(drive->ctl, IDE_CONTROL_REG);
+	if (drive->quirk_list =3D=3D 2)
+		ide_set_irq(drive, 1);
=20
 	error =3D __ide_wait_stat(drive, drive->ready_stat,
 				BUSY_STAT|DRQ_STAT|ERR_STAT,
@@ -799,10 +797,11 @@ int ide_config_drive_speed(ide_drive_t *drive, u8=
 speed)
=20
  skip:
 #ifdef CONFIG_BLK_DEV_IDEDMA
-	if (speed >=3D XFER_SW_DMA_0)
-		hwif->dma_host_on(drive);
-	else if (hwif->ide_dma_on)	/* check if host supports DMA */
-		hwif->dma_off_quietly(drive);
+	if ((speed >=3D XFER_SW_DMA_0 || (hwif->host_flags & IDE_HFLAG_VDMA))=
 &&
+	    drive->using_dma)
+		hwif->dma_host_set(drive, 1);
+	else if (hwif->dma_host_set)	/* check if host supports DMA */
+		ide_dma_off_quietly(drive);
 #endif
=20
 	switch(speed) {
@@ -1012,10 +1011,10 @@ static void check_dma_crc(ide_drive_t *drive)
 {
 #ifdef CONFIG_BLK_DEV_IDEDMA
 	if (drive->crc_count) {
-		drive->hwif->dma_off_quietly(drive);
+		ide_dma_off_quietly(drive);
 		ide_set_xfer_rate(drive, ide_auto_reduce_xfer(drive));
 		if (drive->current_speed >=3D XFER_SW_DMA_0)
-			(void) HWIF(drive)->ide_dma_on(drive);
+			ide_dma_on(drive);
 	} else
 		ide_dma_off(drive);
 #endif
diff --git a/drivers/ide/ide-lib.c b/drivers/ide/ide-lib.c
index a3bd8e8..9b44fbd 100644
--- a/drivers/ide/ide-lib.c
+++ b/drivers/ide/ide-lib.c
@@ -454,8 +454,7 @@ int ide_set_xfer_rate(ide_drive_t *drive, u8 rate)
 static void ide_dump_opcode(ide_drive_t *drive)
 {
 	struct request *rq;
-	u8 opcode =3D 0;
-	int found =3D 0;
+	ide_task_t *task =3D NULL;
=20
 	spin_lock(&ide_lock);
 	rq =3D NULL;
@@ -464,25 +463,15 @@ static void ide_dump_opcode(ide_drive_t *drive)
 	spin_unlock(&ide_lock);
 	if (!rq)
 		return;
-	if (rq->cmd_type =3D=3D REQ_TYPE_ATA_CMD) {
-		char *args =3D rq->buffer;
-		if (args) {
-			opcode =3D args[0];
-			found =3D 1;
-		}
-	} else if (rq->cmd_type =3D=3D REQ_TYPE_ATA_TASKFILE) {
-		ide_task_t *args =3D rq->special;
-		if (args) {
-			opcode =3D args->tf.command;
-			found =3D 1;
-		}
-	}
+
+	if (rq->cmd_type =3D=3D REQ_TYPE_ATA_TASKFILE)
+		task =3D rq->special;
=20
 	printk("ide: failed opcode was: ");
-	if (!found)
-		printk("unknown\n");
+	if (task =3D=3D NULL)
+		printk(KERN_CONT "unknown\n");
 	else
-		printk("0x%02x\n", opcode);
+		printk(KERN_CONT "0x%02x\n", task->tf.command);
 }
=20
 u64 ide_get_lba_addr(struct ide_taskfile *tf, int lba48)
diff --git a/drivers/ide/ide-pnp.c b/drivers/ide/ide-pnp.c
index e245521..cbbb0f7 100644
--- a/drivers/ide/ide-pnp.c
+++ b/drivers/ide/ide-pnp.c
@@ -31,7 +31,6 @@ static int idepnp_probe(struct pnp_dev * dev, const s=
truct pnp_device_id *dev_id
 {
 	hw_regs_t hw;
 	ide_hwif_t *hwif;
-	int index;
=20
 	if (!(pnp_port_valid(dev, 0) && pnp_port_valid(dev, 1) && pnp_irq_val=
id(dev, 0)))
 		return -1;
@@ -41,11 +40,19 @@ static int idepnp_probe(struct pnp_dev * dev, const=
 struct pnp_device_id *dev_id
 				pnp_port_start(dev, 1));
 	hw.irq =3D pnp_irq(dev, 0);
=20
-	index =3D ide_register_hw(&hw, NULL, 1, &hwif);
+	hwif =3D ide_find_port(hw.io_ports[IDE_DATA_OFFSET]);
+	if (hwif) {
+		u8 index =3D hwif->index;
+		u8 idx[4] =3D { index, 0xff, 0xff, 0xff };
+
+		ide_init_port_data(hwif, index);
+		ide_init_port_hw(hwif, &hw);
=20
-	if (index !=3D -1) {
-	    	printk(KERN_INFO "ide%d: generic PnP IDE interface\n", index);
+		printk(KERN_INFO "ide%d: generic PnP IDE interface\n", index);
 		pnp_set_drvdata(dev,hwif);
+
+		ide_device_add(idx);
+
 		return 0;
 	}
=20
@@ -68,12 +75,15 @@ static struct pnp_driver idepnp_driver =3D {
 	.remove		=3D idepnp_remove,
 };
=20
-void __init pnpide_init(void)
+static int __init pnpide_init(void)
 {
-	pnp_register_driver(&idepnp_driver);
+	return pnp_register_driver(&idepnp_driver);
 }
=20
-void __exit pnpide_exit(void)
+static void __exit pnpide_exit(void)
 {
 	pnp_unregister_driver(&idepnp_driver);
 }
+
+module_init(pnpide_init);
+module_exit(pnpide_exit);
diff --git a/drivers/ide/ide-probe.c b/drivers/ide/ide-probe.c
index 0379d1f..edf650b 100644
--- a/drivers/ide/ide-probe.c
+++ b/drivers/ide/ide-probe.c
@@ -235,9 +235,6 @@ static inline void do_identify (ide_drive_t *drive,=
 u8 cmd)
 	drive->media =3D ide_disk;
 	printk("%s DISK drive\n", (id->config =3D=3D 0x848a) ? "CFA" : "ATA" =
);
=20
-	if (hwif->quirkproc)
-		drive->quirk_list =3D hwif->quirkproc(drive);
-
 	return;
=20
 err_misc:
@@ -353,22 +350,19 @@ static int try_to_identify (ide_drive_t *drive, u=
8 cmd)
 	 * the irq handler isn't expecting.
 	 */
 	if (IDE_CONTROL_REG) {
-		u8 ctl =3D drive->ctl | 2;
 		if (!hwif->irq) {
 			autoprobe =3D 1;
 			cookie =3D probe_irq_on();
-			/* enable device irq */
-			ctl &=3D ~2;
 		}
-		hwif->OUTB(ctl, IDE_CONTROL_REG);
+		ide_set_irq(drive, autoprobe);
 	}
=20
 	retval =3D actual_try_to_identify(drive, cmd);
=20
 	if (autoprobe) {
 		int irq;
-		/* mask device irq */
-		hwif->OUTB(drive->ctl|2, IDE_CONTROL_REG);
+
+		ide_set_irq(drive, 0);
 		/* clear drive IRQ */
 		(void) hwif->INB(IDE_STATUS_REG);
 		udelay(5);
@@ -388,6 +382,20 @@ static int try_to_identify (ide_drive_t *drive, u8=
 cmd)
 	return retval;
 }
=20
+static int ide_busy_sleep(ide_hwif_t *hwif)
+{
+	unsigned long timeout =3D jiffies + WAIT_WORSTCASE;
+	u8 stat;
+
+	do {
+		msleep(50);
+		stat =3D hwif->INB(hwif->io_ports[IDE_STATUS_OFFSET]);
+		if ((stat & BUSY_STAT) =3D=3D 0)
+			return 0;
+	} while (time_before(jiffies, timeout));
+
+	return 1;
+}
=20
 /**
  *	do_probe		-	probe an IDE device
@@ -456,7 +464,6 @@ static int do_probe (ide_drive_t *drive, u8 cmd)
 		if ((rc =3D=3D 1 && cmd =3D=3D WIN_PIDENTIFY) &&
 			((drive->autotune =3D=3D IDE_TUNE_DEFAULT) ||
 			(drive->autotune =3D=3D IDE_TUNE_AUTO))) {
-			unsigned long timeout;
 			printk("%s: no response (status =3D 0x%02x), "
 				"resetting drive\n", drive->name,
 				hwif->INB(IDE_STATUS_REG));
@@ -464,10 +471,7 @@ static int do_probe (ide_drive_t *drive, u8 cmd)
 			hwif->OUTB(drive->select.all, IDE_SELECT_REG);
 			msleep(50);
 			hwif->OUTB(WIN_SRST, IDE_COMMAND_REG);
-			timeout =3D jiffies;
-			while (((hwif->INB(IDE_STATUS_REG)) & BUSY_STAT) &&
-			       time_before(jiffies, timeout + WAIT_WORSTCASE))
-				msleep(50);
+			(void)ide_busy_sleep(hwif);
 			rc =3D try_to_identify(drive, cmd);
 		}
 		if (rc =3D=3D 1)
@@ -495,20 +499,16 @@ static int do_probe (ide_drive_t *drive, u8 cmd)
 static void enable_nest (ide_drive_t *drive)
 {
 	ide_hwif_t *hwif =3D HWIF(drive);
-	unsigned long timeout;
=20
 	printk("%s: enabling %s -- ", hwif->name, drive->id->model);
 	SELECT_DRIVE(drive);
 	msleep(50);
 	hwif->OUTB(EXABYTE_ENABLE_NEST, IDE_COMMAND_REG);
-	timeout =3D jiffies + WAIT_WORSTCASE;
-	do {
-		if (time_after(jiffies, timeout)) {
-			printk("failed (timeout)\n");
-			return;
-		}
-		msleep(50);
-	} while ((hwif->INB(IDE_STATUS_REG)) & BUSY_STAT);
+
+	if (ide_busy_sleep(hwif)) {
+		printk(KERN_CONT "failed (timeout)\n");
+		return;
+	}
=20
 	msleep(50);
=20
@@ -656,8 +656,7 @@ static int wait_hwif_ready(ide_hwif_t *hwif)
 		/* Ignore disks that we will not probe for later. */
 		if (!drive->noprobe || drive->present) {
 			SELECT_DRIVE(drive);
-			if (IDE_CONTROL_REG)
-				hwif->OUTB(drive->ctl, IDE_CONTROL_REG);
+			ide_set_irq(drive, 1);
 			mdelay(2);
 			rc =3D ide_wait_not_busy(hwif, 35000);
 			if (rc)
@@ -676,19 +675,18 @@ out:
=20
 /**
  *	ide_undecoded_slave	-	look for bad CF adapters
- *	@hwif: interface
+ *	@drive1: drive
  *
  *	Analyse the drives on the interface and attempt to decide if we
  *	have the same drive viewed twice. This occurs with crap CF adapters
  *	and PCMCIA sometimes.
  */
=20
-void ide_undecoded_slave(ide_hwif_t *hwif)
+void ide_undecoded_slave(ide_drive_t *drive1)
 {
-	ide_drive_t *drive0 =3D &hwif->drives[0];
-	ide_drive_t *drive1 =3D &hwif->drives[1];
+	ide_drive_t *drive0 =3D &drive1->hwif->drives[0];
=20
-	if (drive0->present =3D=3D 0 || drive1->present =3D=3D 0)
+	if ((drive1->dn & 1) =3D=3D 0 || drive0->present =3D=3D 0)
 		return;
=20
 	/* If the models don't match they are not the same product */
@@ -791,18 +789,11 @@ static void probe_hwif(ide_hwif_t *hwif)
 		}
 	}
 	if (hwif->io_ports[IDE_CONTROL_OFFSET] && hwif->reset) {
-		unsigned long timeout =3D jiffies + WAIT_WORSTCASE;
-		u8 stat;
-
 		printk(KERN_WARNING "%s: reset\n", hwif->name);
 		hwif->OUTB(12, hwif->io_ports[IDE_CONTROL_OFFSET]);
 		udelay(10);
 		hwif->OUTB(8, hwif->io_ports[IDE_CONTROL_OFFSET]);
-		do {
-			msleep(50);
-			stat =3D hwif->INB(hwif->io_ports[IDE_STATUS_OFFSET]);
-		} while ((stat & BUSY_STAT) && time_after(timeout, jiffies));
-
+		(void)ide_busy_sleep(hwif);
 	}
 	local_irq_restore(flags);
 	/*
@@ -817,8 +808,12 @@ static void probe_hwif(ide_hwif_t *hwif)
 		return;
 	}
=20
-	if (hwif->fixup)
-		hwif->fixup(hwif);
+	for (unit =3D 0; unit < MAX_DRIVES; unit++) {
+		ide_drive_t *drive =3D &hwif->drives[unit];
+
+		if (drive->present && hwif->quirkproc)
+			hwif->quirkproc(drive);
+	}
=20
 	for (unit =3D 0; unit < MAX_DRIVES; ++unit) {
 		ide_drive_t *drive =3D &hwif->drives[unit];
@@ -833,7 +828,7 @@ static void probe_hwif(ide_hwif_t *hwif)
=20
 			drive->nice1 =3D 1;
=20
-			if (hwif->ide_dma_on)
+			if (hwif->dma_host_set)
 				ide_set_dma(drive);
 		}
 	}
@@ -848,25 +843,6 @@ static void probe_hwif(ide_hwif_t *hwif)
 	}
 }
=20
-static int hwif_init(ide_hwif_t *hwif);
-static void hwif_register_devices(ide_hwif_t *hwif);
-
-static int probe_hwif_init(ide_hwif_t *hwif)
-{
-	probe_hwif(hwif);
-
-	if (!hwif_init(hwif)) {
-		printk(KERN_INFO "%s: failed to initialize IDE interface\n",
-				 hwif->name);
-		return -1;
-	}
-
-	if (hwif->present)
-		hwif_register_devices(hwif);
-
-	return 0;
-}
-
 #if MAX_HWIFS > 1
 /*
  * save_match() is used to simplify logic in init_irq() below.
@@ -1359,54 +1335,63 @@ static void hwif_register_devices(ide_hwif_t *h=
wif)
 	}
 }
=20
-int ideprobe_init (void)
+int ide_device_add_all(u8 *idx)
 {
-	unsigned int index;
-	int probe[MAX_HWIFS];
-
-	memset(probe, 0, MAX_HWIFS * sizeof(int));
-	for (index =3D 0; index < MAX_HWIFS; ++index)
-		probe[index] =3D !ide_hwifs[index].present;
-
-	for (index =3D 0; index < MAX_HWIFS; ++index)
-		if (probe[index])
-			probe_hwif(&ide_hwifs[index]);
-	for (index =3D 0; index < MAX_HWIFS; ++index)
-		if (probe[index])
-			hwif_init(&ide_hwifs[index]);
-	for (index =3D 0; index < MAX_HWIFS; ++index) {
-		if (probe[index]) {
-			ide_hwif_t *hwif =3D &ide_hwifs[index];
-			if (!hwif->present)
-				continue;
-			if (hwif->chipset =3D=3D ide_unknown || hwif->chipset =3D=3D ide_fo=
rced)
-				hwif->chipset =3D ide_generic;
-			hwif_register_devices(hwif);
+	ide_hwif_t *hwif;
+	int i, rc =3D 0;
+
+	for (i =3D 0; i < MAX_HWIFS; i++) {
+		if (idx[i] =3D=3D 0xff)
+			continue;
+
+		probe_hwif(&ide_hwifs[idx[i]]);
+	}
+
+	for (i =3D 0; i < MAX_HWIFS; i++) {
+		if (idx[i] =3D=3D 0xff)
+			continue;
+
+		hwif =3D &ide_hwifs[idx[i]];
+
+		if (hwif_init(hwif) =3D=3D 0) {
+			printk(KERN_INFO "%s: failed to initialize IDE "
+					 "interface\n", hwif->name);
+			rc =3D -1;
+			continue;
 		}
 	}
-	for (index =3D 0; index < MAX_HWIFS; ++index)
-		if (probe[index])
-			ide_proc_register_port(&ide_hwifs[index]);
-	return 0;
-}
=20
-EXPORT_SYMBOL_GPL(ideprobe_init);
+	for (i =3D 0; i < MAX_HWIFS; i++) {
+		if (idx[i] =3D=3D 0xff)
+			continue;
=20
-int ide_device_add(u8 idx[4])
-{
-	int i, rc =3D 0;
+		hwif =3D &ide_hwifs[idx[i]];
=20
-	for (i =3D 0; i < 4; i++) {
-		if (idx[i] !=3D 0xff)
-			rc |=3D probe_hwif_init(&ide_hwifs[idx[i]]);
+		if (hwif->present) {
+			if (hwif->chipset =3D=3D ide_unknown ||
+			    hwif->chipset =3D=3D ide_forced)
+				hwif->chipset =3D ide_generic;
+			hwif_register_devices(hwif);
+		}
 	}
=20
-	for (i =3D 0; i < 4; i++) {
+	for (i =3D 0; i < MAX_HWIFS; i++) {
 		if (idx[i] !=3D 0xff)
 			ide_proc_register_port(&ide_hwifs[idx[i]]);
 	}
=20
 	return rc;
 }
+EXPORT_SYMBOL_GPL(ide_device_add_all);
+
+int ide_device_add(u8 idx[4])
+{
+	u8 idx_all[MAX_HWIFS];
+	int i;
=20
+	for (i =3D 0; i < MAX_HWIFS; i++)
+		idx_all[i] =3D (i < 4) ? idx[i] : 0xff;
+
+	return ide_device_add_all(idx_all);
+}
 EXPORT_SYMBOL_GPL(ide_device_add);
diff --git a/drivers/ide/ide-proc.c b/drivers/ide/ide-proc.c
index a4007d3..aa663e7 100644
--- a/drivers/ide/ide-proc.c
+++ b/drivers/ide/ide-proc.c
@@ -346,14 +346,20 @@ static int ide_write_setting(ide_drive_t *drive, =
ide_settings_t *setting, int va
=20
 static int set_xfer_rate (ide_drive_t *drive, int arg)
 {
+	ide_task_t task;
 	int err;
=20
 	if (arg < 0 || arg > 70)
 		return -EINVAL;
=20
-	err =3D ide_wait_cmd(drive,
-			WIN_SETFEATURES, (u8) arg,
-			SETFEATURES_XFER, 0, NULL);
+	memset(&task, 0, sizeof(task));
+	task.tf.command =3D WIN_SETFEATURES;
+	task.tf.feature =3D SETFEATURES_XFER;
+	task.tf.nsect   =3D (u8)arg;
+	task.tf_flags =3D IDE_TFLAG_OUT_FEATURE | IDE_TFLAG_OUT_NSECT |
+			IDE_TFLAG_IN_NSECT;
+
+	err =3D ide_no_data_taskfile(drive, &task);
=20
 	if (!err && arg) {
 		ide_set_xfer_rate(drive, (u8) arg);
diff --git a/drivers/ide/ide-scan-pci.c b/drivers/ide/ide-scan-pci.c
new file mode 100644
index 0000000..7ffa332
--- /dev/null
+++ b/drivers/ide/ide-scan-pci.c
@@ -0,0 +1,121 @@
+/*
+ * support for probing IDE PCI devices in the PCI bus order
+ *
+ * Copyright (c) 1998-2000  Andre Hedrick <andre@linux-ide.org>
+ * Copyright (c) 1995-1998  Mark Lord
+ *
+ * May be copied or modified under the terms of the GNU General Public=
 License
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/ide.h>
+
+/*
+ *	Module interfaces
+ */
+
+static int pre_init =3D 1;		/* Before first ordered IDE scan */
+static LIST_HEAD(ide_pci_drivers);
+
+/*
+ *	__ide_pci_register_driver	-	attach IDE driver
+ *	@driver: pci driver
+ *	@module: owner module of the driver
+ *
+ *	Registers a driver with the IDE layer. The IDE layer arranges that
+ *	boot time setup is done in the expected device order and then
+ *	hands the controllers off to the core PCI code to do the rest of
+ *	the work.
+ *
+ *	Returns are the same as for pci_register_driver
+ */
+
+int __ide_pci_register_driver(struct pci_driver *driver, struct module=
 *module,
+			      const char *mod_name)
+{
+	if (!pre_init)
+		return __pci_register_driver(driver, module, mod_name);
+	driver->driver.owner =3D module;
+	list_add_tail(&driver->node, &ide_pci_drivers);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(__ide_pci_register_driver);
+
+/**
+ *	ide_scan_pcidev		-	find an IDE driver for a device
+ *	@dev: PCI device to check
+ *
+ *	Look for an IDE driver to handle the device we are considering.
+ *	This is only used during boot up to get the ordering correct. After
+ *	boot up the pci layer takes over the job.
+ */
+
+static int __init ide_scan_pcidev(struct pci_dev *dev)
+{
+	struct list_head *l;
+	struct pci_driver *d;
+
+	list_for_each(l, &ide_pci_drivers) {
+		d =3D list_entry(l, struct pci_driver, node);
+		if (d->id_table) {
+			const struct pci_device_id *id =3D
+				pci_match_id(d->id_table, dev);
+
+			if (id !=3D NULL && d->probe(dev, id) >=3D 0) {
+				dev->driver =3D d;
+				pci_dev_get(dev);
+				return 1;
+			}
+		}
+	}
+	return 0;
+}
+
+/**
+ *	ide_scan_pcibus		-	perform the initial IDE driver scan
+ *
+ *	Perform the initial bus rather than driver ordered scan of the
+ *	PCI drivers. After this all IDE pci handling becomes standard
+ *	module ordering not traditionally ordered.
+ */
+
+int __init ide_scan_pcibus(void)
+{
+	struct pci_dev *dev =3D NULL;
+	struct pci_driver *d;
+	struct list_head *l, *n;
+
+	pre_init =3D 0;
+	if (!ide_scan_direction)
+		while ((dev =3D pci_get_device(PCI_ANY_ID, PCI_ANY_ID, dev)))
+			ide_scan_pcidev(dev);
+	else
+		while ((dev =3D pci_get_device_reverse(PCI_ANY_ID, PCI_ANY_ID,
+						     dev)))
+			ide_scan_pcidev(dev);
+
+	/*
+	 *	Hand the drivers over to the PCI layer now we
+	 *	are post init.
+	 */
+
+	list_for_each_safe(l, n, &ide_pci_drivers) {
+		list_del(l);
+		d =3D list_entry(l, struct pci_driver, node);
+		if (__pci_register_driver(d, d->driver.owner,
+					  d->driver.mod_name))
+			printk(KERN_ERR "%s: failed to register %s driver\n",
+					__FUNCTION__, d->driver.mod_name);
+	}
+
+	return 0;
+}
+
+static int __init ide_scan_pci(void)
+{
+	return ide_scan_pcibus();
+}
+
+module_init(ide_scan_pci);
diff --git a/drivers/ide/ide-tape.c b/drivers/ide/ide-tape.c
index 3cbca3f..d71a584 100644
--- a/drivers/ide/ide-tape.c
+++ b/drivers/ide/ide-tape.c
@@ -1690,6 +1690,11 @@ static int idetape_end_request(ide_drive_t *driv=
e, int uptodate, int nr_sects)
 	if (error)
 		tape->failed_pc =3D NULL;
=20
+	if (!blk_special_request(rq)) {
+		ide_end_request(drive, uptodate, nr_sects);
+		return 0;
+	}
+
 	spin_lock_irqsave(&tape->spinlock, flags);
=20
 	/* The request was a pipelined data transfer request */
diff --git a/drivers/ide/ide-taskfile.c b/drivers/ide/ide-taskfile.c
index 2d63ea9..5eb6fa1 100644
--- a/drivers/ide/ide-taskfile.c
+++ b/drivers/ide/ide-taskfile.c
@@ -35,34 +35,6 @@
 #include <asm/uaccess.h>
 #include <asm/io.h>
=20
-static void ata_bswap_data (void *buffer, int wcount)
-{
-	u16 *p =3D buffer;
-
-	while (wcount--) {
-		*p =3D *p << 8 | *p >> 8; p++;
-		*p =3D *p << 8 | *p >> 8; p++;
-	}
-}
-
-static void taskfile_input_data(ide_drive_t *drive, void *buffer, u32 =
wcount)
-{
-	HWIF(drive)->ata_input_data(drive, buffer, wcount);
-	if (drive->bswap)
-		ata_bswap_data(buffer, wcount);
-}
-
-static void taskfile_output_data(ide_drive_t *drive, void *buffer, u32=
 wcount)
-{
-	if (drive->bswap) {
-		ata_bswap_data(buffer, wcount);
-		HWIF(drive)->ata_output_data(drive, buffer, wcount);
-		ata_bswap_data(buffer, wcount);
-	} else {
-		HWIF(drive)->ata_output_data(drive, buffer, wcount);
-	}
-}
-
 void ide_tf_load(ide_drive_t *drive, ide_task_t *task)
 {
 	ide_hwif_t *hwif =3D drive->hwif;
@@ -77,10 +49,13 @@ void ide_tf_load(ide_drive_t *drive, ide_task_t *ta=
sk)
 		"lbam 0x%02x lbah 0x%02x dev 0x%02x cmd 0x%02x\n",
 		drive->name, tf->feature, tf->nsect, tf->lbal,
 		tf->lbam, tf->lbah, tf->device, tf->command);
+	printk("%s: hob: nsect 0x%02x lbal 0x%02x "
+		"lbam 0x%02x lbah 0x%02x\n",
+		drive->name, tf->hob_nsect, tf->hob_lbal,
+		tf->hob_lbam, tf->hob_lbah);
 #endif
=20
-	if (IDE_CONTROL_REG)
-		hwif->OUTB(drive->ctl, IDE_CONTROL_REG); /* clear nIEN */
+	ide_set_irq(drive, 1);
=20
 	if ((task->tf_flags & IDE_TFLAG_NO_SELECT_MASK) =3D=3D 0)
 		SELECT_MASK(drive, 0);
@@ -124,7 +99,7 @@ int taskfile_lib_get_identify (ide_drive_t *drive, u=
8 *buf)
 		args.tf.command =3D WIN_IDENTIFY;
 	else
 		args.tf.command =3D WIN_PIDENTIFY;
-	args.tf_flags	=3D IDE_TFLAG_OUT_TF | IDE_TFLAG_OUT_DEVICE;
+	args.tf_flags	=3D IDE_TFLAG_TF | IDE_TFLAG_DEVICE;
 	args.data_phase	=3D TASKFILE_IN;
 	return ide_raw_taskfile(drive, &args, buf, 1);
 }
@@ -285,7 +260,7 @@ static ide_startstop_t task_no_data_intr(ide_drive_=
t *drive)
 	return ide_stopped;
 }
=20
-static u8 wait_drive_not_busy(ide_drive_t *drive)
+u8 wait_drive_not_busy(ide_drive_t *drive)
 {
 	ide_hwif_t *hwif =3D HWIF(drive);
 	int retries;
@@ -293,8 +268,7 @@ static u8 wait_drive_not_busy(ide_drive_t *drive)
=20
 	/*
 	 * Last sector was transfered, wait until drive is ready.
-	 * This can take up to 10 usec, but we will wait max 1 ms
-	 * (drive_cmd_intr() waits that long).
+	 * This can take up to 10 usec, but we will wait max 1 ms.
 	 */
 	for (retries =3D 0; retries < 100; retries++) {
 		if ((stat =3D hwif->INB(IDE_STATUS_REG)) & BUSY_STAT)
@@ -349,9 +323,9 @@ static void ide_pio_sector(ide_drive_t *drive, unsi=
gned int write)
=20
 	/* do the actual data transfer */
 	if (write)
-		taskfile_output_data(drive, buf, SECTOR_WORDS);
+		hwif->ata_output_data(drive, buf, SECTOR_WORDS);
 	else
-		taskfile_input_data(drive, buf, SECTOR_WORDS);
+		hwif->ata_input_data(drive, buf, SECTOR_WORDS);
=20
 	kunmap_atomic(buf, KM_BIO_SRC_IRQ);
 #ifdef CONFIG_HIGHMEM
@@ -371,9 +345,18 @@ static void ide_pio_multi(ide_drive_t *drive, unsi=
gned int write)
 static void ide_pio_datablock(ide_drive_t *drive, struct request *rq,
 				     unsigned int write)
 {
+	u8 saved_io_32bit =3D drive->io_32bit;
+
 	if (rq->bio)	/* fs request */
 		rq->errors =3D 0;
=20
+	if (rq->cmd_type =3D=3D REQ_TYPE_ATA_TASKFILE) {
+		ide_task_t *task =3D rq->special;
+
+		if (task->tf_flags & IDE_TFLAG_IO_16BIT)
+			drive->io_32bit =3D 0;
+	}
+
 	touch_softlockup_watchdog();
=20
 	switch (drive->hwif->data_phase) {
@@ -385,6 +368,8 @@ static void ide_pio_datablock(ide_drive_t *drive, s=
truct request *rq,
 		ide_pio_sector(drive, write);
 		break;
 	}
+
+	drive->io_32bit =3D saved_io_32bit;
 }
=20
 static ide_startstop_t task_error(ide_drive_t *drive, struct request *=
rq,
@@ -422,27 +407,22 @@ static ide_startstop_t task_error(ide_drive_t *dr=
ive, struct request *rq,
 	return ide_error(drive, s, stat);
 }
=20
-static void task_end_request(ide_drive_t *drive, struct request *rq, u=
8 stat)
+void task_end_request(ide_drive_t *drive, struct request *rq, u8 stat)
 {
-	HWIF(drive)->cursg =3D NULL;
-
 	if (rq->cmd_type =3D=3D REQ_TYPE_ATA_TASKFILE) {
-		ide_task_t *task =3D rq->special;
+		u8 err =3D drive->hwif->INB(IDE_ERROR_REG);
=20
-		if (task->tf_flags & IDE_TFLAG_FLAGGED) {
-			u8 err =3D drive->hwif->INB(IDE_ERROR_REG);
-			ide_end_drive_cmd(drive, stat, err);
-			return;
-		}
+		ide_end_drive_cmd(drive, stat, err);
+		return;
 	}
=20
 	if (rq->rq_disk) {
 		ide_driver_t *drv;
=20
 		drv =3D *(ide_driver_t **)rq->rq_disk->private_data;;
-		drv->end_request(drive, 1, rq->hard_nr_sectors);
+		drv->end_request(drive, 1, rq->nr_sectors);
 	} else
-		ide_end_request(drive, 1, rq->hard_nr_sectors);
+		ide_end_request(drive, 1, rq->nr_sectors);
 }
=20
 /*
@@ -455,7 +435,7 @@ static ide_startstop_t task_in_intr(ide_drive_t *dr=
ive)
 	u8 stat =3D hwif->INB(IDE_STATUS_REG);
=20
 	/* new way for dealing with premature shared PCI interrupts */
-	if (!OK_STAT(stat, DATA_READY, BAD_R_STAT)) {
+	if (!OK_STAT(stat, DRQ_STAT, BAD_R_STAT)) {
 		if (stat & (ERR_STAT | DRQ_STAT))
 			return task_error(drive, rq, __FUNCTION__, stat);
 		/* No data yet, so wait for another IRQ. */
@@ -468,7 +448,7 @@ static ide_startstop_t task_in_intr(ide_drive_t *dr=
ive)
 	/* If it was the last datablock check status and finish transfer. */
 	if (!hwif->nleft) {
 		stat =3D wait_drive_not_busy(drive);
-		if (!OK_STAT(stat, 0, BAD_R_STAT))
+		if (!OK_STAT(stat, 0, BAD_STAT))
 			return task_error(drive, rq, __FUNCTION__, stat);
 		task_end_request(drive, rq, stat);
 		return ide_stopped;
@@ -512,7 +492,7 @@ static ide_startstop_t pre_task_out_intr(ide_drive_=
t *drive, struct request *rq)
 {
 	ide_startstop_t startstop;
=20
-	if (ide_wait_stat(&startstop, drive, DATA_READY,
+	if (ide_wait_stat(&startstop, drive, DRQ_STAT,
 			  drive->bad_wstat, WAIT_DRQ)) {
 		printk(KERN_ERR "%s: no DRQ after issuing %sWRITE%s\n",
 				drive->name,
@@ -580,7 +560,6 @@ int ide_taskfile_ioctl (ide_drive_t *drive, unsigne=
d int cmd, unsigned long arg)
 	unsigned int taskin	=3D 0;
 	unsigned int taskout	=3D 0;
 	u16 nsect		=3D 0;
-	u8 io_32bit		=3D drive->io_32bit;
 	char __user *buf =3D (char __user *)arg;
=20
 //	printk("IDE Taskfile ...\n");
@@ -633,9 +612,10 @@ int ide_taskfile_ioctl (ide_drive_t *drive, unsign=
ed int cmd, unsigned long arg)
=20
 	args.data_phase =3D req_task->data_phase;
=20
-	args.tf_flags =3D IDE_TFLAG_OUT_DEVICE;
+	args.tf_flags =3D IDE_TFLAG_IO_16BIT | IDE_TFLAG_DEVICE |
+			IDE_TFLAG_IN_TF;
 	if (drive->addressing =3D=3D 1)
-		args.tf_flags |=3D IDE_TFLAG_LBA48;
+		args.tf_flags |=3D (IDE_TFLAG_LBA48 | IDE_TFLAG_IN_HOB);
=20
 	if (req_task->out_flags.all) {
 		args.tf_flags |=3D IDE_TFLAG_FLAGGED;
@@ -671,7 +651,6 @@ int ide_taskfile_ioctl (ide_drive_t *drive, unsigne=
d int cmd, unsigned long arg)
 	if (req_task->in_flags.b.data)
 		args.tf_flags |=3D IDE_TFLAG_IN_DATA;
=20
-	drive->io_32bit =3D 0;
 	switch(req_task->data_phase) {
 		case TASKFILE_MULTI_OUT:
 			if (!drive->mult_count) {
@@ -767,41 +746,24 @@ abort:
=20
 //	printk("IDE Taskfile ioctl ended. rc =3D %i\n", err);
=20
-	drive->io_32bit =3D io_32bit;
-
 	return err;
 }
 #endif
=20
-int ide_wait_cmd (ide_drive_t *drive, u8 cmd, u8 nsect, u8 feature, u8=
 sectors, u8 *buf)
-{
-	struct request rq;
-	u8 buffer[4];
-
-	if (!buf)
-		buf =3D buffer;
-	memset(buf, 0, 4 + SECTOR_WORDS * 4 * sectors);
-	ide_init_drive_cmd(&rq);
-	rq.buffer =3D buf;
-	*buf++ =3D cmd;
-	*buf++ =3D nsect;
-	*buf++ =3D feature;
-	*buf++ =3D sectors;
-	return ide_do_drive_cmd(drive, &rq, ide_wait);
-}
-
 int ide_cmd_ioctl (ide_drive_t *drive, unsigned int cmd, unsigned long=
 arg)
 {
-	int err =3D 0;
-	u8 args[4], *argbuf =3D args;
-	u8 xfer_rate =3D 0;
-	int argsize =3D 4;
+	u8 *buf =3D NULL;
+	int bufsize =3D 0, err =3D 0;
+	u8 args[4], xfer_rate =3D 0;
 	ide_task_t tfargs;
 	struct ide_taskfile *tf =3D &tfargs.tf;
=20
 	if (NULL =3D=3D (void *) arg) {
 		struct request rq;
+
 		ide_init_drive_cmd(&rq);
+		rq.cmd_type =3D REQ_TYPE_ATA_TASKFILE;
+
 		return ide_do_drive_cmd(drive, &rq, ide_wait);
 	}
=20
@@ -810,23 +772,39 @@ int ide_cmd_ioctl (ide_drive_t *drive, unsigned i=
nt cmd, unsigned long arg)
=20
 	memset(&tfargs, 0, sizeof(ide_task_t));
 	tf->feature =3D args[2];
-	tf->nsect   =3D args[3];
-	tf->lbal    =3D args[1];
+	if (args[0] =3D=3D WIN_SMART) {
+		tf->nsect =3D args[3];
+		tf->lbal  =3D args[1];
+		tf->lbam  =3D 0x4f;
+		tf->lbah  =3D 0xc2;
+		tfargs.tf_flags =3D IDE_TFLAG_OUT_TF | IDE_TFLAG_IN_NSECT;
+	} else {
+		tf->nsect =3D args[1];
+		tfargs.tf_flags =3D IDE_TFLAG_OUT_FEATURE |
+				  IDE_TFLAG_OUT_NSECT | IDE_TFLAG_IN_NSECT;
+	}
 	tf->command =3D args[0];
+	tfargs.data_phase =3D args[3] ? TASKFILE_IN : TASKFILE_NO_DATA;
=20
 	if (args[3]) {
-		argsize =3D 4 + (SECTOR_WORDS * 4 * args[3]);
-		argbuf =3D kzalloc(argsize, GFP_KERNEL);
-		if (argbuf =3D=3D NULL)
+		tfargs.tf_flags |=3D IDE_TFLAG_IO_16BIT;
+		bufsize =3D SECTOR_WORDS * 4 * args[3];
+		buf =3D kzalloc(bufsize, GFP_KERNEL);
+		if (buf =3D=3D NULL)
 			return -ENOMEM;
 	}
+
 	if (set_transfer(drive, &tfargs)) {
 		xfer_rate =3D args[1];
 		if (ide_ata66_check(drive, &tfargs))
 			goto abort;
 	}
=20
-	err =3D ide_wait_cmd(drive, args[0], args[1], args[2], args[3], argbu=
f);
+	err =3D ide_raw_taskfile(drive, &tfargs, buf, args[3]);
+
+	args[0] =3D tf->status;
+	args[1] =3D tf->error;
+	args[2] =3D tf->nsect;
=20
 	if (!err && xfer_rate) {
 		/* active-retuning-calls future */
@@ -834,10 +812,13 @@ int ide_cmd_ioctl (ide_drive_t *drive, unsigned i=
nt cmd, unsigned long arg)
 		ide_driveid_update(drive);
 	}
 abort:
-	if (copy_to_user((void __user *)arg, argbuf, argsize))
+	if (copy_to_user((void __user *)arg, &args, 4))
 		err =3D -EFAULT;
-	if (argsize > 4)
-		kfree(argbuf);
+	if (buf) {
+		if (copy_to_user((void __user *)(arg + 4), buf, bufsize))
+			err =3D -EFAULT;
+		kfree(buf);
+	}
 	return err;
 }
=20
@@ -854,7 +835,7 @@ int ide_task_ioctl (ide_drive_t *drive, unsigned in=
t cmd, unsigned long arg)
 	memset(&task, 0, sizeof(task));
 	memcpy(&task.tf_array[7], &args[1], 6);
 	task.tf.command =3D args[0];
-	task.tf_flags =3D IDE_TFLAG_OUT_TF | IDE_TFLAG_OUT_DEVICE;
+	task.tf_flags =3D IDE_TFLAG_TF | IDE_TFLAG_DEVICE;
=20
 	err =3D ide_no_data_taskfile(drive, &task);
=20
diff --git a/drivers/ide/ide.c b/drivers/ide/ide.c
index c6d4f63..97894ab 100644
--- a/drivers/ide/ide.c
+++ b/drivers/ide/ide.c
@@ -95,7 +95,7 @@ DEFINE_MUTEX(ide_cfg_mtx);
  __cacheline_aligned_in_smp DEFINE_SPINLOCK(ide_lock);
=20
 #ifdef CONFIG_IDEPCI_PCIBUS_ORDER
-static int ide_scan_direction; /* THIS was formerly 2.2.x pci=3Drevers=
e */
+int ide_scan_direction; /* THIS was formerly 2.2.x pci=3Dreverse */
 #endif
=20
 int noautodma =3D 0;
@@ -116,7 +116,7 @@ EXPORT_SYMBOL(ide_hwifs);
 /*
  * Do not even *think* about calling this!
  */
-static void init_hwif_data(ide_hwif_t *hwif, unsigned int index)
+void ide_init_port_data(ide_hwif_t *hwif, unsigned int index)
 {
 	unsigned int unit;
=20
@@ -159,6 +159,7 @@ static void init_hwif_data(ide_hwif_t *hwif, unsign=
ed int index)
 		init_completion(&drive->gendev_rel_comp);
 	}
 }
+EXPORT_SYMBOL_GPL(ide_init_port_data);
=20
 static void init_hwif_default(ide_hwif_t *hwif, unsigned int index)
 {
@@ -177,8 +178,6 @@ static void init_hwif_default(ide_hwif_t *hwif, uns=
igned int index)
 #endif
 }
=20
-extern void ide_arm_init(void);
-
 /*
  * init_ide_data() sets reasonable default values into all fields
  * of all instances of the hwifs and drives, but only on the first cal=
l.
@@ -210,16 +209,13 @@ static void __init init_ide_data (void)
 	/* Initialise all interface structures */
 	for (index =3D 0; index < MAX_HWIFS; ++index) {
 		hwif =3D &ide_hwifs[index];
-		init_hwif_data(hwif, index);
+		ide_init_port_data(hwif, index);
 		init_hwif_default(hwif, index);
 #if !defined(CONFIG_PPC32) || !defined(CONFIG_PCI)
 		hwif->irq =3D
 			ide_init_default_irq(hwif->io_ports[IDE_DATA_OFFSET]);
 #endif
 	}
-#ifdef CONFIG_IDE_ARM
-	ide_arm_init();
-#endif
 }
=20
 /**
@@ -414,8 +410,6 @@ static void ide_hwif_restore(ide_hwif_t *hwif, ide_=
hwif_t *tmp_hwif)
 	hwif->cds			=3D tmp_hwif->cds;
 #endif
=20
-	hwif->fixup			=3D tmp_hwif->fixup;
-
 	hwif->set_pio_mode		=3D tmp_hwif->set_pio_mode;
 	hwif->set_dma_mode		=3D tmp_hwif->set_dma_mode;
 	hwif->mdma_filter		=3D tmp_hwif->mdma_filter;
@@ -433,16 +427,13 @@ static void ide_hwif_restore(ide_hwif_t *hwif, id=
e_hwif_t *tmp_hwif)
 	hwif->atapi_input_bytes		=3D tmp_hwif->atapi_input_bytes;
 	hwif->atapi_output_bytes	=3D tmp_hwif->atapi_output_bytes;
=20
+	hwif->dma_host_set		=3D tmp_hwif->dma_host_set;
 	hwif->dma_setup			=3D tmp_hwif->dma_setup;
 	hwif->dma_exec_cmd		=3D tmp_hwif->dma_exec_cmd;
 	hwif->dma_start			=3D tmp_hwif->dma_start;
 	hwif->ide_dma_end		=3D tmp_hwif->ide_dma_end;
-	hwif->ide_dma_on		=3D tmp_hwif->ide_dma_on;
-	hwif->dma_off_quietly		=3D tmp_hwif->dma_off_quietly;
 	hwif->ide_dma_test_irq		=3D tmp_hwif->ide_dma_test_irq;
 	hwif->ide_dma_clear_irq		=3D tmp_hwif->ide_dma_clear_irq;
-	hwif->dma_host_on		=3D tmp_hwif->dma_host_on;
-	hwif->dma_host_off		=3D tmp_hwif->dma_host_off;
 	hwif->dma_lost_irq		=3D tmp_hwif->dma_lost_irq;
 	hwif->dma_timeout		=3D tmp_hwif->dma_timeout;
=20
@@ -614,7 +605,7 @@ void ide_unregister(unsigned int index)
 	tmp_hwif =3D *hwif;
=20
 	/* restore hwif data to pristine status */
-	init_hwif_data(hwif, index);
+	ide_init_port_data(hwif, index);
 	init_hwif_default(hwif, index);
=20
 	ide_hwif_restore(hwif, &tmp_hwif);
@@ -680,24 +671,34 @@ void ide_setup_ports (	hw_regs_t *hw,
  */
 }
=20
+void ide_init_port_hw(ide_hwif_t *hwif, hw_regs_t *hw)
+{
+	memcpy(hwif->io_ports, hw->io_ports, sizeof(hwif->io_ports));
+	hwif->irq =3D hw->irq;
+	hwif->noprobe =3D 0;
+	hwif->chipset =3D hw->chipset;
+	hwif->gendev.parent =3D hw->dev;
+	hwif->ack_intr =3D hw->ack_intr;
+}
+EXPORT_SYMBOL_GPL(ide_init_port_hw);
+
 /**
  *	ide_register_hw		-	register IDE interface
  *	@hw: hardware registers
- *	@fixup: fixup function
- *	@initializing: set while initializing built-in drivers
+ *	@quirkproc: quirkproc function
  *	@hwifp: pointer to returned hwif
  *
  *	Register an IDE interface, specifying exactly the registers etc.
- *	Set init=3D1 iff calling before probes have taken place.
  *
  *	Returns -1 on error.
  */
=20
-int ide_register_hw(hw_regs_t *hw, void (*fixup)(ide_hwif_t *),
-		    int initializing, ide_hwif_t **hwifp)
+int ide_register_hw(hw_regs_t *hw, void (*quirkproc)(ide_drive_t *),
+		    ide_hwif_t **hwifp)
 {
 	int index, retry =3D 1;
 	ide_hwif_t *hwif;
+	u8 idx[4] =3D { 0xff, 0xff, 0xff, 0xff };
=20
 	do {
 		for (index =3D 0; index < MAX_HWIFS; ++index) {
@@ -709,8 +710,7 @@ int ide_register_hw(hw_regs_t *hw, void (*fixup)(id=
e_hwif_t *),
 			hwif =3D &ide_hwifs[index];
 			if (hwif->hold)
 				continue;
-			if ((!hwif->present && !hwif->mate && !initializing) ||
-			    (!hwif->io_ports[IDE_DATA_OFFSET] && initializing))
+			if (!hwif->present && hwif->mate =3D=3D NULL)
 				goto found;
 		}
 		for (index =3D 0; index < MAX_HWIFS; index++)
@@ -721,29 +721,23 @@ found:
 	if (hwif->present)
 		ide_unregister(index);
 	else if (!hwif->hold) {
-		init_hwif_data(hwif, index);
+		ide_init_port_data(hwif, index);
 		init_hwif_default(hwif, index);
 	}
 	if (hwif->present)
 		return -1;
-	memcpy(hwif->io_ports, hw->io_ports, sizeof(hwif->io_ports));
-	hwif->irq =3D hw->irq;
-	hwif->noprobe =3D 0;
-	hwif->fixup =3D fixup;
-	hwif->chipset =3D hw->chipset;
-	hwif->gendev.parent =3D hw->dev;
-	hwif->ack_intr =3D hw->ack_intr;
=20
-	if (initializing =3D=3D 0) {
-		u8 idx[4] =3D { index, 0xff, 0xff, 0xff };
+	ide_init_port_hw(hwif, hw);
+	hwif->quirkproc =3D quirkproc;
=20
-		ide_device_add(idx);
-	}
+	idx[0] =3D index;
+
+	ide_device_add(idx);
=20
 	if (hwifp)
 		*hwifp =3D hwif;
=20
-	return (initializing || hwif->present) ? index : -1;
+	return hwif->present ? index : -1;
 }
=20
 EXPORT_SYMBOL(ide_register_hw);
@@ -836,7 +830,7 @@ int set_using_dma(ide_drive_t *drive, int arg)
 	if (!drive->id || !(drive->id->capability & 1))
 		goto out;
=20
-	if (hwif->ide_dma_on =3D=3D NULL)
+	if (hwif->dma_host_set =3D=3D NULL)
 		goto out;
=20
 	err =3D -EBUSY;
@@ -884,7 +878,10 @@ int set_pio_mode(ide_drive_t *drive, int arg)
=20
 	if (drive->special.b.set_tune)
 		return -EBUSY;
+
 	ide_init_drive_cmd(&rq);
+	rq.cmd_type =3D REQ_TYPE_ATA_TASKFILE;
+
 	drive->tune_req =3D (u8) arg;
 	drive->special.b.set_tune =3D 1;
 	(void) ide_do_drive_cmd(drive, &rq, ide_wait);
@@ -1066,7 +1063,7 @@ int generic_ide_ioctl(ide_drive_t *drive, struct =
file *file, struct block_device
 			ide_init_hwif_ports(&hw, (unsigned long) args[0],
 					    (unsigned long) args[1], NULL);
 			hw.irq =3D args[2];
-			if (ide_register_hw(&hw, NULL, 0, NULL) =3D=3D -1)
+			if (ide_register_hw(&hw, NULL, NULL) =3D=3D -1)
 				return -EIO;
 			return 0;
 		}
@@ -1227,26 +1224,12 @@ static int __init match_parm (char *s, const ch=
ar *keywords[], int vals[], int m
 	return 0;	/* zero =3D nothing matched */
 }
=20
-#ifdef CONFIG_BLK_DEV_ALI14XX
 extern int probe_ali14xx;
-extern int ali14xx_init(void);
-#endif
-#ifdef CONFIG_BLK_DEV_UMC8672
 extern int probe_umc8672;
-extern int umc8672_init(void);
-#endif
-#ifdef CONFIG_BLK_DEV_DTC2278
 extern int probe_dtc2278;
-extern int dtc2278_init(void);
-#endif
-#ifdef CONFIG_BLK_DEV_HT6560B
 extern int probe_ht6560b;
-extern int ht6560b_init(void);
-#endif
-#ifdef CONFIG_BLK_DEV_QD65XX
 extern int probe_qd65xx;
-extern int qd65xx_init(void);
-#endif
+extern int cmd640_vlb;
=20
 static int __initdata is_chipset_set[MAX_HWIFS];
=20
@@ -1323,7 +1306,7 @@ static int __init ide_setup(char *s)
 	if (s[0] =3D=3D 'h' && s[1] =3D=3D 'd' && s[2] >=3D 'a' && s[2] <=3D =
max_drive) {
 		const char *hd_words[] =3D {
 			"none", "noprobe", "nowerr", "cdrom", "nodma",
-			"autotune", "noautotune", "minus8", "swapdata", "bswap",
+			"autotune", "noautotune", "-8", "-9", "-10",
 			"noflush", "remap", "remap63", "scsi", NULL };
 		unit =3D s[2] - 'a';
 		hw   =3D unit / MAX_DRIVES;
@@ -1359,10 +1342,6 @@ static int __init ide_setup(char *s)
 			case -7: /* "noautotune" */
 				drive->autotune =3D IDE_TUNE_NOAUTO;
 				goto obsolete_option;
-			case -9: /* "swapdata" */
-			case -10: /* "bswap" */
-				drive->bswap =3D 1;
-				goto done;
 			case -11: /* noflush */
 				drive->noflush =3D 1;
 				goto done;
@@ -1462,11 +1441,8 @@ static int __init ide_setup(char *s)
 #endif
 #ifdef CONFIG_BLK_DEV_CMD640
 			case -14: /* "cmd640_vlb" */
-			{
-				extern int cmd640_vlb; /* flag for cmd640.c */
 				cmd640_vlb =3D 1;
 				goto done;
-			}
 #endif
 #ifdef CONFIG_BLK_DEV_HT6560B
 			case -13: /* "ht6560b" */
@@ -1556,79 +1532,6 @@ done:
 	return 1;
 }
=20
-extern void __init pnpide_init(void);
-extern void __exit pnpide_exit(void);
-extern void __init h8300_ide_init(void);
-
-/*
- * probe_for_hwifs() finds/initializes "known" IDE interfaces
- */
-static void __init probe_for_hwifs (void)
-{
-#ifdef CONFIG_IDEPCI_PCIBUS_ORDER
-	ide_scan_pcibus(ide_scan_direction);
-#endif
-
-#ifdef CONFIG_ETRAX_IDE
-	{
-		extern void init_e100_ide(void);
-		init_e100_ide();
-	}
-#endif /* CONFIG_ETRAX_IDE */
-#ifdef CONFIG_BLK_DEV_CMD640
-	{
-		extern void ide_probe_for_cmd640x(void);
-		ide_probe_for_cmd640x();
-	}
-#endif /* CONFIG_BLK_DEV_CMD640 */
-#ifdef CONFIG_BLK_DEV_IDE_PMAC
-	{
-		extern int pmac_ide_probe(void);
-		(void)pmac_ide_probe();
-	}
-#endif /* CONFIG_BLK_DEV_IDE_PMAC */
-#ifdef CONFIG_BLK_DEV_GAYLE
-	{
-		extern void gayle_init(void);
-		gayle_init();
-	}
-#endif /* CONFIG_BLK_DEV_GAYLE */
-#ifdef CONFIG_BLK_DEV_FALCON_IDE
-	{
-		extern void falconide_init(void);
-		falconide_init();
-	}
-#endif /* CONFIG_BLK_DEV_FALCON_IDE */
-#ifdef CONFIG_BLK_DEV_MAC_IDE
-	{
-		extern void macide_init(void);
-		macide_init();
-	}
-#endif /* CONFIG_BLK_DEV_MAC_IDE */
-#ifdef CONFIG_BLK_DEV_Q40IDE
-	{
-		extern void q40ide_init(void);
-		q40ide_init();
-	}
-#endif /* CONFIG_BLK_DEV_Q40IDE */
-#ifdef CONFIG_BLK_DEV_BUDDHA
-	{
-		extern void buddha_init(void);
-		buddha_init();
-	}
-#endif /* CONFIG_BLK_DEV_BUDDHA */
-#ifdef CONFIG_BLK_DEV_IDEPNP
-	pnpide_init();
-#endif
-#ifdef CONFIG_H8300
-	h8300_ide_init();
-#endif
-}
-
-/*
- * Probe module
- */
-
 EXPORT_SYMBOL(ide_lock);
=20
 static int ide_bus_match(struct device *dev, struct device_driver *drv=
)
@@ -1775,30 +1678,6 @@ static int __init ide_init(void)
=20
 	proc_ide_create();
=20
-#ifdef CONFIG_BLK_DEV_ALI14XX
-	if (probe_ali14xx)
-		(void)ali14xx_init();
-#endif
-#ifdef CONFIG_BLK_DEV_UMC8672
-	if (probe_umc8672)
-		(void)umc8672_init();
-#endif
-#ifdef CONFIG_BLK_DEV_DTC2278
-	if (probe_dtc2278)
-		(void)dtc2278_init();
-#endif
-#ifdef CONFIG_BLK_DEV_HT6560B
-	if (probe_ht6560b)
-		(void)ht6560b_init();
-#endif
-#ifdef CONFIG_BLK_DEV_QD65XX
-	if (probe_qd65xx)
-		(void)qd65xx_init();
-#endif
-
-	/* Probe for special PCI and other "known" interface chipsets. */
-	probe_for_hwifs();
-
 	return 0;
 }
=20
@@ -1834,10 +1713,6 @@ void __exit cleanup_module (void)
 	for (index =3D 0; index < MAX_HWIFS; ++index)
 		ide_unregister(index);
=20
-#ifdef CONFIG_BLK_DEV_IDEPNP
-	pnpide_exit();
-#endif
-
 	proc_ide_destroy();
=20
 	bus_unregister(&ide_bus_type);
diff --git a/drivers/ide/legacy/Makefile b/drivers/ide/legacy/Makefile
index 4098223..7043ec7 100644
--- a/drivers/ide/legacy/Makefile
+++ b/drivers/ide/legacy/Makefile
@@ -1,15 +1,24 @@
=20
+# link order is important here
+
 obj-$(CONFIG_BLK_DEV_ALI14XX)		+=3D ali14xx.o
+obj-$(CONFIG_BLK_DEV_UMC8672)		+=3D umc8672.o
 obj-$(CONFIG_BLK_DEV_DTC2278)		+=3D dtc2278.o
 obj-$(CONFIG_BLK_DEV_HT6560B)		+=3D ht6560b.o
 obj-$(CONFIG_BLK_DEV_QD65XX)		+=3D qd65xx.o
-obj-$(CONFIG_BLK_DEV_UMC8672)		+=3D umc8672.o
=20
-obj-$(CONFIG_BLK_DEV_IDECS)		+=3D ide-cs.o
+obj-$(CONFIG_BLK_DEV_GAYLE)		+=3D gayle.o
+obj-$(CONFIG_BLK_DEV_FALCON_IDE)	+=3D falconide.o
+obj-$(CONFIG_BLK_DEV_MAC_IDE)		+=3D macide.o
+obj-$(CONFIG_BLK_DEV_Q40IDE)		+=3D q40ide.o
+obj-$(CONFIG_BLK_DEV_BUDDHA)		+=3D buddha.o
=20
-obj-$(CONFIG_BLK_DEV_PLATFORM)		+=3D ide_platform.o
+ifeq ($(CONFIG_BLK_DEV_IDECS), m)
+	obj-m +=3D ide-cs.o
+endif
=20
-# Last of all
-obj-$(CONFIG_BLK_DEV_HD)		+=3D hd.o
+ifeq ($(CONFIG_BLK_DEV_PLATFORM), m)
+	obj-m +=3D ide_platform.o
+endif
=20
 EXTRA_CFLAGS	:=3D -Idrivers/ide
diff --git a/drivers/ide/legacy/ali14xx.c b/drivers/ide/legacy/ali14xx.=
c
index 38c3a6d..5ec0be4 100644
--- a/drivers/ide/legacy/ali14xx.c
+++ b/drivers/ide/legacy/ali14xx.c
@@ -231,8 +231,7 @@ int probe_ali14xx =3D 0;
 module_param_named(probe, probe_ali14xx, bool, 0);
 MODULE_PARM_DESC(probe, "probe for ALI M14xx chipsets");
=20
-/* Can be called directly from ide.c. */
-int __init ali14xx_init(void)
+static int __init ali14xx_init(void)
 {
 	if (probe_ali14xx =3D=3D 0)
 		goto out;
@@ -248,9 +247,7 @@ out:
 	return -ENODEV;
 }
=20
-#ifdef MODULE
 module_init(ali14xx_init);
-#endif
=20
 MODULE_AUTHOR("see local file");
 MODULE_DESCRIPTION("support of ALI 14XX IDE chipsets");
diff --git a/drivers/ide/legacy/buddha.c b/drivers/ide/legacy/buddha.c
index 4a0be25..74d28e0 100644
--- a/drivers/ide/legacy/buddha.c
+++ b/drivers/ide/legacy/buddha.c
@@ -112,6 +112,7 @@ typedef enum BuddhaType_Enum {
     BOARD_BUDDHA, BOARD_CATWEASEL, BOARD_XSURF
 } BuddhaType;
=20
+static const char *buddha_board_name[] =3D { "Buddha", "Catweasel", "X=
-Surf" };
=20
     /*
      *  Check and acknowledge the interrupt status
@@ -143,11 +144,11 @@ static int xsurf_ack_intr(ide_hwif_t *hwif)
      *  Probe for a Buddha or Catweasel IDE interface
      */
=20
-void __init buddha_init(void)
+static int __init buddha_init(void)
 {
 	hw_regs_t hw;
 	ide_hwif_t *hwif;
-	int i, index;
+	int i;
=20
 	struct zorro_dev *z =3D NULL;
 	u_long buddha_board =3D 0;
@@ -156,6 +157,8 @@ void __init buddha_init(void)
=20
 	while ((z =3D zorro_find_device(ZORRO_WILDCARD, z))) {
 		unsigned long board;
+		u8 idx[4] =3D { 0xff, 0xff, 0xff, 0xff };
+
 		if (z->id =3D=3D ZORRO_PROD_INDIVIDUAL_COMPUTERS_BUDDHA) {
 			buddha_num_hwifs =3D BUDDHA_NUM_HWIFS;
 			type=3DBOARD_BUDDHA;
@@ -195,7 +198,10 @@ fail_base2:
 		/* X-Surf doesn't have this.  IRQs are always on */
 		if (type !=3D BOARD_XSURF)
 			z_writeb(0, buddha_board+BUDDHA_IRQ_MR);
-	=09
+
+		printk(KERN_INFO "ide: %s IDE controller\n",
+				 buddha_board_name[type]);
+
 		for(i=3D0;i<buddha_num_hwifs;i++) {
 			if(type !=3D BOARD_XSURF) {
 				ide_setup_ports(&hw, (buddha_board+buddha_bases[i]),
@@ -213,23 +219,23 @@ fail_base2:
 						IRQ_AMIGA_PORTS);
 			}=09
=20
-			index =3D ide_register_hw(&hw, NULL, 1, &hwif);
-			if (index !=3D -1) {
+			hwif =3D ide_find_port(hw.io_ports[IDE_DATA_OFFSET]);
+			if (hwif) {
+				u8 index =3D hwif->index;
+
+				ide_init_port_data(hwif, index);
+				ide_init_port_hw(hwif, &hw);
+
 				hwif->mmio =3D 1;
-				printk("ide%d: ", index);
-				switch(type) {
-				case BOARD_BUDDHA:
-					printk("Buddha");
-					break;
-				case BOARD_CATWEASEL:
-					printk("Catweasel");
-					break;
-				case BOARD_XSURF:
-					printk("X-Surf");
-					break;
-				}
-				printk(" IDE interface\n");	   =20
-			}		     =20
+
+				idx[i] =3D index;
+			}
 		}
+
+		ide_device_add(idx);
 	}
+
+	return 0;
 }
+
+module_init(buddha_init);
diff --git a/drivers/ide/legacy/dtc2278.c b/drivers/ide/legacy/dtc2278.=
c
index 24a845d..13eee6d 100644
--- a/drivers/ide/legacy/dtc2278.c
+++ b/drivers/ide/legacy/dtc2278.c
@@ -150,8 +150,7 @@ int probe_dtc2278 =3D 0;
 module_param_named(probe, probe_dtc2278, bool, 0);
 MODULE_PARM_DESC(probe, "probe for DTC2278xx chipsets");
=20
-/* Can be called directly from ide.c. */
-int __init dtc2278_init(void)
+static int __init dtc2278_init(void)
 {
 	if (probe_dtc2278 =3D=3D 0)
 		return -ENODEV;
@@ -163,9 +162,7 @@ int __init dtc2278_init(void)
 	return 0;
 }
=20
-#ifdef MODULE
 module_init(dtc2278_init);
-#endif
=20
 MODULE_AUTHOR("See Local File");
 MODULE_DESCRIPTION("support of DTC-2278 VLB IDE chipsets");
diff --git a/drivers/ide/legacy/falconide.c b/drivers/ide/legacy/falcon=
ide.c
index 7d7936f..2860956 100644
--- a/drivers/ide/legacy/falconide.c
+++ b/drivers/ide/legacy/falconide.c
@@ -62,19 +62,31 @@ EXPORT_SYMBOL(falconide_intr_lock);
      *  Probe for a Falcon IDE interface
      */
=20
-void __init falconide_init(void)
+static int __init falconide_init(void)
 {
     if (MACH_IS_ATARI && ATARIHW_PRESENT(IDE)) {
 	hw_regs_t hw;
-	int index;
+
+	printk(KERN_INFO "ide: Falcon IDE controller\n");
=20
 	ide_setup_ports(&hw, ATA_HD_BASE, falconide_offsets,
 			0, 0, NULL,
 //			falconide_iops,
 			IRQ_MFP_IDE);
-	index =3D ide_register_hw(&hw, NULL, 1, NULL);
=20
-	if (index !=3D -1)
-	    printk("ide%d: Falcon IDE interface\n", index);
+	hwif =3D ide_find_port(hw.io_ports[IDE_DATA_OFFSET]);
+	if (hwif) {
+		u8 index =3D hwif->index;
+		u8 idx[4] =3D { index, 0xff, 0xff, 0xff };
+
+		ide_init_port_data(hwif, index);
+		ide_init_port_hw(hwif, &hw);
+
+		ide_device_add(idx);
+	}
     }
+
+    return 0;
 }
+
+module_init(falconide_init);
diff --git a/drivers/ide/legacy/gayle.c b/drivers/ide/legacy/gayle.c
index 53331ee..492fa04 100644
--- a/drivers/ide/legacy/gayle.c
+++ b/drivers/ide/legacy/gayle.c
@@ -110,12 +110,13 @@ static int gayle_ack_intr_a1200(ide_hwif_t *hwif)
      *  Probe for a Gayle IDE interface (and optionally for an IDE dou=
bler)
      */
=20
-void __init gayle_init(void)
+static int __init gayle_init(void)
 {
     int a4000, i;
+    u8 idx[4] =3D { 0xff, 0xff, 0xff, 0xff };
=20
     if (!MACH_IS_AMIGA)
-	return;
+	return -ENODEV;
=20
     if ((a4000 =3D AMIGAHW_PRESENT(A4000_IDE)) || AMIGAHW_PRESENT(A120=
0_IDE))
 	goto found;
@@ -125,15 +126,21 @@ void __init gayle_init(void)
 			  NULL))
 	goto found;
 #endif
-    return;
+    return -ENODEV;
=20
 found:
+	printk(KERN_INFO "ide: Gayle IDE controller (A%d style%s)\n",
+			 a4000 ? 4000 : 1200,
+#ifdef CONFIG_BLK_DEV_IDEDOUBLER
+			 ide_doubler ? ", IDE doubler" :
+#endif
+			 "");
+
     for (i =3D 0; i < GAYLE_NUM_PROBE_HWIFS; i++) {
 	unsigned long base, ctrlport, irqport;
 	ide_ack_intr_t *ack_intr;
 	hw_regs_t hw;
 	ide_hwif_t *hwif;
-	int index;
 	unsigned long phys_base, res_start, res_n;
=20
 	if (a4000) {
@@ -165,21 +172,23 @@ found:
 //			&gayle_iops,
 			IRQ_AMIGA_PORTS);
=20
-	index =3D ide_register_hw(&hw, NULL, 1, &hwif);
-	if (index !=3D -1) {
+	hwif =3D ide_find_port(base);
+	if (hwif) {
+	    u8 index =3D hwif->index;
+
+	    ide_init_port_data(hwif, index);
+	    ide_init_port_hw(hwif, &hw);
+
 	    hwif->mmio =3D 1;
-	    switch (i) {
-		case 0:
-		    printk("ide%d: Gayle IDE interface (A%d style)\n", index,
-			   a4000 ? 4000 : 1200);
-		    break;
-#ifdef CONFIG_BLK_DEV_IDEDOUBLER
-		case 1:
-		    printk("ide%d: IDE doubler\n", index);
-		    break;
-#endif /* CONFIG_BLK_DEV_IDEDOUBLER */
-	    }
+
+	    idx[i] =3D index;
 	} else
 	    release_mem_region(res_start, res_n);
     }
+
+    ide_device_add(idx);
+
+    return 0;
 }
+
+module_init(gayle_init);
diff --git a/drivers/ide/legacy/ht6560b.c b/drivers/ide/legacy/ht6560b.=
c
index a4245d1..8da5031 100644
--- a/drivers/ide/legacy/ht6560b.c
+++ b/drivers/ide/legacy/ht6560b.c
@@ -307,8 +307,7 @@ int probe_ht6560b =3D 0;
 module_param_named(probe, probe_ht6560b, bool, 0);
 MODULE_PARM_DESC(probe, "probe for HT6560B chipset");
=20
-/* Can be called directly from ide.c. */
-int __init ht6560b_init(void)
+static int __init ht6560b_init(void)
 {
 	ide_hwif_t *hwif, *mate;
 	static u8 idx[4] =3D { 0, 1, 0xff, 0xff };
@@ -369,9 +368,7 @@ release_region:
 	return -ENODEV;
 }
=20
-#ifdef MODULE
 module_init(ht6560b_init);
-#endif
=20
 MODULE_AUTHOR("See Local File");
 MODULE_DESCRIPTION("HT-6560B EIDE-controller support");
diff --git a/drivers/ide/legacy/ide-cs.c b/drivers/ide/legacy/ide-cs.c
index 03715c0..f4ea15b 100644
--- a/drivers/ide/legacy/ide-cs.c
+++ b/drivers/ide/legacy/ide-cs.c
@@ -153,7 +153,7 @@ static int idecs_register(unsigned long io, unsigne=
d long ctl, unsigned long irq
     hw.irq =3D irq;
     hw.chipset =3D ide_pci;
     hw.dev =3D &handle->dev;
-    return ide_register_hw(&hw, &ide_undecoded_slave, 0, NULL);
+    return ide_register_hw(&hw, &ide_undecoded_slave, NULL);
 }
=20
 /*=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
diff --git a/drivers/ide/legacy/ide_platform.c b/drivers/ide/legacy/ide=
_platform.c
index 7bb79f5..69a0fb0 100644
--- a/drivers/ide/legacy/ide_platform.c
+++ b/drivers/ide/legacy/ide_platform.c
@@ -28,39 +28,27 @@ static struct {
 	int index;
 } hwif_prop;
=20
-static ide_hwif_t *__devinit plat_ide_locate_hwif(void __iomem *base,
-	    void __iomem *ctrl, struct pata_platform_info *pdata, int irq,
-	    int mmio)
+static void __devinit plat_ide_setup_ports(hw_regs_t *hw,
+					   void __iomem *base,
+					   void __iomem *ctrl,
+					   struct pata_platform_info *pdata,
+					   int irq)
 {
 	unsigned long port =3D (unsigned long)base;
-	ide_hwif_t *hwif =3D ide_find_port(port);
 	int i;
=20
-	if (hwif =3D=3D NULL)
-		goto out;
-
-	hwif->io_ports[IDE_DATA_OFFSET] =3D port;
+	hw->io_ports[IDE_DATA_OFFSET] =3D port;
=20
 	port +=3D (1 << pdata->ioport_shift);
 	for (i =3D IDE_ERROR_OFFSET; i <=3D IDE_STATUS_OFFSET;
 	     i++, port +=3D (1 << pdata->ioport_shift))
-		hwif->io_ports[i] =3D port;
-
-	hwif->io_ports[IDE_CONTROL_OFFSET] =3D (unsigned long)ctrl;
+		hw->io_ports[i] =3D port;
=20
-	hwif->irq =3D irq;
+	hw->io_ports[IDE_CONTROL_OFFSET] =3D (unsigned long)ctrl;
=20
-	hwif->chipset =3D ide_generic;
+	hw->irq =3D irq;
=20
-	if (mmio) {
-		hwif->mmio =3D 1;
-		default_hwif_mmiops(hwif);
-	}
-
-	hwif_prop.hwif =3D hwif;
-	hwif_prop.index =3D hwif->index;
-out:
-	return hwif;
+	hw->chipset =3D ide_generic;
 }
=20
 static int __devinit plat_ide_probe(struct platform_device *pdev)
@@ -71,6 +59,7 @@ static int __devinit plat_ide_probe(struct platform_d=
evice *pdev)
 	u8 idx[4] =3D { 0xff, 0xff, 0xff, 0xff };
 	int ret =3D 0;
 	int mmio =3D 0;
+	hw_regs_t hw;
=20
 	pdata =3D pdev->dev.platform_data;
=20
@@ -106,15 +95,27 @@ static int __devinit plat_ide_probe(struct platfor=
m_device *pdev)
 			res_alt->start, res_alt->end - res_alt->start + 1);
 	}
=20
-	hwif =3D plat_ide_locate_hwif(hwif_prop.plat_ide_mapbase,
-	         hwif_prop.plat_ide_alt_mapbase, pdata, res_irq->start, mmio)=
;
-
+	hwif =3D ide_find_port((unsigned long)hwif_prop.plat_ide_mapbase);
 	if (!hwif) {
 		ret =3D -ENODEV;
 		goto out;
 	}
-	hwif->gendev.parent =3D &pdev->dev;
-	hwif->noprobe =3D 0;
+
+	memset(&hw, 0, sizeof(hw));
+	plat_ide_setup_ports(&hw, hwif_prop.plat_ide_mapbase,
+			     hwif_prop.plat_ide_alt_mapbase,
+			     pdata, res_irq->start);
+	hw.dev =3D &pdev->dev;
+
+	ide_init_port_hw(hwif, &hw);
+
+	if (mmio) {
+		hwif->mmio =3D 1;
+		default_hwif_mmiops(hwif);
+	}
+
+	hwif_prop.hwif =3D hwif;
+	hwif_prop.index =3D hwif->index;
=20
 	idx[0] =3D hwif->index;
=20
diff --git a/drivers/ide/legacy/macide.c b/drivers/ide/legacy/macide.c
index 5c6aa77..782d4c7 100644
--- a/drivers/ide/legacy/macide.c
+++ b/drivers/ide/legacy/macide.c
@@ -77,15 +77,17 @@ int macide_ack_intr(ide_hwif_t* hwif)
 	return 0;
 }
=20
+static const char *mac_ide_name[] =3D
+	{ "Quadra", "Powerbook", "Powerbook Baboon" };
+
 /*
  * Probe for a Macintosh IDE interface
  */
=20
-void __init macide_init(void)
+static int __init macide_init(void)
 {
 	hw_regs_t hw;
 	ide_hwif_t *hwif;
-	int index =3D -1;
=20
 	switch (macintosh_config->ide_type) {
 	case MAC_IDE_QUADRA:
@@ -93,48 +95,50 @@ void __init macide_init(void)
 				0, 0, macide_ack_intr,
 //				quadra_ide_iops,
 				IRQ_NUBUS_F);
-		index =3D ide_register_hw(&hw, NULL, 1, &hwif);
 		break;
 	case MAC_IDE_PB:
 		ide_setup_ports(&hw, IDE_BASE, macide_offsets,
 				0, 0, macide_ack_intr,
 //				macide_pb_iops,
 				IRQ_NUBUS_C);
-		index =3D ide_register_hw(&hw, NULL, 1, &hwif);
 		break;
 	case MAC_IDE_BABOON:
 		ide_setup_ports(&hw, BABOON_BASE, macide_offsets,
 				0, 0, NULL,
 //				macide_baboon_iops,
 				IRQ_BABOON_1);
-		index =3D ide_register_hw(&hw, NULL, 1, &hwif);
-		if (index =3D=3D -1) break;
-		if (macintosh_config->ident =3D=3D MAC_MODEL_PB190) {
+		break;
+	default:
+		return -ENODEV;
+	}
+
+	printk(KERN_INFO "ide: Macintosh %s IDE controller\n",
+			 mac_ide_name[macintosh_config->ide_type - 1]);
=20
+	hwif =3D ide_find_port(hw.io_ports[IDE_DATA_OFFSET]);
+	if (hwif) {
+		u8 index =3D hwif->index;
+		u8 idx[4] =3D { index, 0xff, 0xff, 0xff };
+
+		ide_init_port_data(hwif, index);
+		ide_init_port_hw(hwif, &hw);
+
+		if (macintosh_config->ide_type =3D=3D MAC_IDE_BABOON &&
+		    macintosh_config->ident =3D=3D MAC_MODEL_PB190) {
 			/* Fix breakage in ide-disk.c: drive capacity	*/
 			/* is not initialized for drives without a 	*/
 			/* hardware ID, and we can't get that without	*/
 			/* probing the drive which freezes a 190.	*/
-
-			ide_drive_t *drive =3D &ide_hwifs[index].drives[0];
+			ide_drive_t *drive =3D &hwif->drives[0];
 			drive->capacity64 =3D drive->cyl*drive->head*drive->sect;
-
 		}
-		break;
-
-	default:
-	    return;
-	}
=20
-        if (index !=3D -1) {
 		hwif->mmio =3D 1;
-		if (macintosh_config->ide_type =3D=3D MAC_IDE_QUADRA)
-			printk(KERN_INFO "ide%d: Macintosh Quadra IDE interface\n", index);
-		else if (macintosh_config->ide_type =3D=3D MAC_IDE_PB)
-			printk(KERN_INFO "ide%d: Macintosh Powerbook IDE interface\n", inde=
x);
-		else if (macintosh_config->ide_type =3D=3D MAC_IDE_BABOON)
-			printk(KERN_INFO "ide%d: Macintosh Powerbook Baboon IDE interface\n=
", index);
-		else
-			printk(KERN_INFO "ide%d: Unknown Macintosh IDE interface\n", index)=
;
+
+		ide_device_add(idx);
 	}
+
+	return 0;
 }
+
+module_init(macide_init);
diff --git a/drivers/ide/legacy/q40ide.c b/drivers/ide/legacy/q40ide.c
index 6ea46a6..f532973 100644
--- a/drivers/ide/legacy/q40ide.c
+++ b/drivers/ide/legacy/q40ide.c
@@ -111,15 +111,17 @@ static const char *q40_ide_names[Q40IDE_NUM_HWIFS=
]=3D{
  *  Probe for Q40 IDE interfaces
  */
=20
-void __init q40ide_init(void)
+static int __init q40ide_init(void)
 {
     int i;
     ide_hwif_t *hwif;
-    int index;
     const char *name;
+    u8 idx[4] =3D { 0xff, 0xff, 0xff, 0xff };
=20
     if (!MACH_IS_Q40)
-      return ;
+      return -ENODEV;
+
+    printk(KERN_INFO "ide: Q40 IDE controller\n");
=20
     for (i =3D 0; i < Q40IDE_NUM_HWIFS; i++) {
 	hw_regs_t hw;
@@ -141,10 +143,20 @@ void __init q40ide_init(void)
 			0, NULL,
 //			m68kide_iops,
 			q40ide_default_irq(pcide_bases[i]));
-	index =3D ide_register_hw(&hw, NULL, 1, &hwif);
-	// **FIXME**
-	if (index !=3D -1)
+
+	hwif =3D ide_find_port(hw.io_ports[IDE_DATA_OFFSET]);
+	if (hwif) {
+		ide_init_port_data(hwif, hwif->index);
+		ide_init_port_hw(hwif, &hw);
 		hwif->mmio =3D 1;
+
+		idx[i] =3D hwif->index;
+	}
     }
+
+    ide_device_add(idx);
+
+    return 0;
 }
=20
+module_init(q40ide_init);
diff --git a/drivers/ide/legacy/qd65xx.c b/drivers/ide/legacy/qd65xx.c
index 912e738..2bac4c1 100644
--- a/drivers/ide/legacy/qd65xx.c
+++ b/drivers/ide/legacy/qd65xx.c
@@ -478,8 +478,7 @@ int probe_qd65xx =3D 0;
 module_param_named(probe, probe_qd65xx, bool, 0);
 MODULE_PARM_DESC(probe, "probe for QD65xx chipsets");
=20
-/* Can be called directly from ide.c. */
-int __init qd65xx_init(void)
+static int __init qd65xx_init(void)
 {
 	if (probe_qd65xx =3D=3D 0)
 		return -ENODEV;
@@ -492,9 +491,7 @@ int __init qd65xx_init(void)
 	return 0;
 }
=20
-#ifdef MODULE
 module_init(qd65xx_init);
-#endif
=20
 MODULE_AUTHOR("Samuel Thibault");
 MODULE_DESCRIPTION("support of qd65xx vlb ide chipset");
diff --git a/drivers/ide/legacy/umc8672.c b/drivers/ide/legacy/umc8672.=
c
index 79577b9..a1ae1ae 100644
--- a/drivers/ide/legacy/umc8672.c
+++ b/drivers/ide/legacy/umc8672.c
@@ -169,8 +169,7 @@ int probe_umc8672 =3D 0;
 module_param_named(probe, probe_umc8672, bool, 0);
 MODULE_PARM_DESC(probe, "probe for UMC8672 chipset");
=20
-/* Can be called directly from ide.c. */
-int __init umc8672_init(void)
+static int __init umc8672_init(void)
 {
 	if (probe_umc8672 =3D=3D 0)
 		goto out;
@@ -181,9 +180,7 @@ out:
 	return -ENODEV;;
 }
=20
-#ifdef MODULE
 module_init(umc8672_init);
-#endif
=20
 MODULE_AUTHOR("Wolfram Podien");
 MODULE_DESCRIPTION("Support for UMC 8672 IDE chipset");
diff --git a/drivers/ide/mips/au1xxx-ide.c b/drivers/ide/mips/au1xxx-id=
e.c
index a4d0d4c..2d3e511 100644
--- a/drivers/ide/mips/au1xxx-ide.c
+++ b/drivers/ide/mips/au1xxx-ide.c
@@ -395,26 +395,10 @@ static int auide_dma_test_irq(ide_drive_t *drive)
 	return 0;
 }
=20
-static void auide_dma_host_on(ide_drive_t *drive)
+static void auide_dma_host_set(ide_drive_t *drive, int on)
 {
 }
=20
-static int auide_dma_on(ide_drive_t *drive)
-{
-	drive->using_dma =3D 1;
-
-	return 0;
-}
-
-static void auide_dma_host_off(ide_drive_t *drive)
-{
-}
-
-static void auide_dma_off_quietly(ide_drive_t *drive)
-{
-	drive->using_dma =3D 0;
-}
-
 static void auide_dma_lost_irq(ide_drive_t *drive)
 {
 	printk(KERN_ERR "%s: IRQ lost\n", drive->name);
@@ -641,12 +625,13 @@ static int au_ide_probe(struct device *dev)
 	/* FIXME:  This might possibly break PCMCIA IDE devices */
=20
 	hwif                            =3D &ide_hwifs[pdev->id];
-	hwif->irq			=3D ahwif->irq;
-	hwif->chipset                   =3D ide_au1xxx;
=20
 	memset(&hw, 0, sizeof(hw));
 	auide_setup_ports(&hw, ahwif);
-	memcpy(hwif->io_ports, hw.io_ports, sizeof(hwif->io_ports));
+	hw.irq =3D ahwif->irq;
+	hw.chipset =3D ide_au1xxx;
+
+	ide_init_port_hw(hwif, &hw);
=20
 	hwif->ultra_mask                =3D 0x0;  /* Disable Ultra DMA */
 #ifdef CONFIG_BLK_DEV_IDE_AU1XXX_MDMA2_DBDMA
@@ -660,7 +645,6 @@ static int au_ide_probe(struct device *dev)
 	hwif->pio_mask =3D ATA_PIO4;
 	hwif->host_flags =3D IDE_HFLAG_POST_SET_MODE;
=20
-	hwif->noprobe =3D 0;
 	hwif->drives[0].unmask          =3D 1;
 	hwif->drives[1].unmask          =3D 1;
=20
@@ -682,29 +666,25 @@ static int au_ide_probe(struct device *dev)
 	hwif->set_dma_mode		=3D &auide_set_dma_mode;
=20
 #ifdef CONFIG_BLK_DEV_IDE_AU1XXX_MDMA2_DBDMA
-	hwif->dma_off_quietly		=3D &auide_dma_off_quietly;
 	hwif->dma_timeout		=3D &auide_dma_timeout;
=20
 	hwif->mdma_filter		=3D &auide_mdma_filter;
=20
+	hwif->dma_host_set		=3D &auide_dma_host_set;
 	hwif->dma_exec_cmd              =3D &auide_dma_exec_cmd;
 	hwif->dma_start                 =3D &auide_dma_start;
 	hwif->ide_dma_end               =3D &auide_dma_end;
 	hwif->dma_setup                 =3D &auide_dma_setup;
 	hwif->ide_dma_test_irq          =3D &auide_dma_test_irq;
-	hwif->dma_host_off		=3D &auide_dma_host_off;
-	hwif->dma_host_on		=3D &auide_dma_host_on;
 	hwif->dma_lost_irq		=3D &auide_dma_lost_irq;
-	hwif->ide_dma_on                =3D &auide_dma_on;
-#else /* !CONFIG_BLK_DEV_IDE_AU1XXX_MDMA2_DBDMA */
+#endif
 	hwif->channel                   =3D 0;
-	hwif->hold                      =3D 1;
 	hwif->select_data               =3D 0;    /* no chipset-specific code=
 */
 	hwif->config_data               =3D 0;    /* no chipset-specific code=
 */
=20
 	hwif->drives[0].autotune        =3D 1;    /* 1=3Dautotune, 2=3Dnoauto=
tune, 0=3Ddefault */
 	hwif->drives[1].autotune	=3D 1;
-#endif
+
 	hwif->drives[0].no_io_32bit	=3D 1;
 	hwif->drives[1].no_io_32bit	=3D 1;
=20
diff --git a/drivers/ide/mips/swarm.c b/drivers/ide/mips/swarm.c
index 521edd4..8b3959d 100644
--- a/drivers/ide/mips/swarm.c
+++ b/drivers/ide/mips/swarm.c
@@ -117,6 +117,7 @@ static int __devinit swarm_ide_probe(struct device =
*dev)
 	default_hwif_mmiops(hwif);
 	/* Prevent resource map manipulation.  */
 	hwif->mmio =3D 1;
+	hwif->chipset =3D ide_generic;
 	hwif->noprobe =3D 0;
=20
 	for (i =3D IDE_DATA_OFFSET; i <=3D IDE_STATUS_OFFSET; i++)
diff --git a/drivers/ide/pci/Makefile b/drivers/ide/pci/Makefile
index 95d1ea8..9480325 100644
--- a/drivers/ide/pci/Makefile
+++ b/drivers/ide/pci/Makefile
@@ -36,4 +36,8 @@ obj-$(CONFIG_BLK_DEV_VIA82CXXX)		+=3D via82cxxx.o
 # Must appear at the end of the block
 obj-$(CONFIG_BLK_DEV_GENERIC)          +=3D generic.o
=20
+ifeq ($(CONFIG_BLK_DEV_CMD640), m)
+	obj-m +=3D cmd640.o
+endif
+
 EXTRA_CFLAGS	:=3D -Idrivers/ide
diff --git a/drivers/ide/pci/atiixp.c b/drivers/ide/pci/atiixp.c
index 5ae2656..4918719 100644
--- a/drivers/ide/pci/atiixp.c
+++ b/drivers/ide/pci/atiixp.c
@@ -1,5 +1,5 @@
 /*
- *  linux/drivers/ide/pci/atiixp.c	Version 0.03	Aug 3 2007
+ *  linux/drivers/ide/pci/atiixp.c	Version 0.05	Nov 9 2007
  *
  *  Copyright (C) 2003 ATI Inc. <hyu@ati.com>
  *  Copyright (C) 2004,2007 Bartlomiej Zolnierkiewicz
@@ -43,47 +43,8 @@ static atiixp_ide_timing mdma_timing[] =3D {
 	{ 0x02, 0x00 },
 };
=20
-static int save_mdma_mode[4];
-
 static DEFINE_SPINLOCK(atiixp_lock);
=20
-static void atiixp_dma_host_on(ide_drive_t *drive)
-{
-	struct pci_dev *dev =3D drive->hwif->pci_dev;
-	unsigned long flags;
-	u16 tmp16;
-
-	spin_lock_irqsave(&atiixp_lock, flags);
-
-	pci_read_config_word(dev, ATIIXP_IDE_UDMA_CONTROL, &tmp16);
-	if (save_mdma_mode[drive->dn])
-		tmp16 &=3D ~(1 << drive->dn);
-	else
-		tmp16 |=3D (1 << drive->dn);
-	pci_write_config_word(dev, ATIIXP_IDE_UDMA_CONTROL, tmp16);
-
-	spin_unlock_irqrestore(&atiixp_lock, flags);
-
-	ide_dma_host_on(drive);
-}
-
-static void atiixp_dma_host_off(ide_drive_t *drive)
-{
-	struct pci_dev *dev =3D drive->hwif->pci_dev;
-	unsigned long flags;
-	u16 tmp16;
-
-	spin_lock_irqsave(&atiixp_lock, flags);
-
-	pci_read_config_word(dev, ATIIXP_IDE_UDMA_CONTROL, &tmp16);
-	tmp16 &=3D ~(1 << drive->dn);
-	pci_write_config_word(dev, ATIIXP_IDE_UDMA_CONTROL, tmp16);
-
-	spin_unlock_irqrestore(&atiixp_lock, flags);
-
-	ide_dma_host_off(drive);
-}
-
 /**
  *	atiixp_set_pio_mode	-	set host controller for PIO mode
  *	@drive: drive
@@ -132,26 +93,33 @@ static void atiixp_set_dma_mode(ide_drive_t *drive=
, const u8 speed)
 	int timing_shift =3D (drive->dn & 2) ? 16 : 0 + (drive->dn & 1) ? 0 :=
 8;
 	u32 tmp32;
 	u16 tmp16;
+	u16 udma_ctl =3D 0;
=20
 	spin_lock_irqsave(&atiixp_lock, flags);
=20
-	save_mdma_mode[drive->dn] =3D 0;
+	pci_read_config_word(dev, ATIIXP_IDE_UDMA_CONTROL, &udma_ctl);
+
 	if (speed >=3D XFER_UDMA_0) {
 		pci_read_config_word(dev, ATIIXP_IDE_UDMA_MODE, &tmp16);
 		tmp16 &=3D ~(0x07 << (drive->dn * 4));
 		tmp16 |=3D ((speed & 0x07) << (drive->dn * 4));
 		pci_write_config_word(dev, ATIIXP_IDE_UDMA_MODE, tmp16);
-	} else {
-		if ((speed >=3D XFER_MW_DMA_0) && (speed <=3D XFER_MW_DMA_2)) {
-			save_mdma_mode[drive->dn] =3D speed;
-			pci_read_config_dword(dev, ATIIXP_IDE_MDMA_TIMING, &tmp32);
-			tmp32 &=3D ~(0xff << timing_shift);
-			tmp32 |=3D (mdma_timing[speed & 0x03].recover_width << timing_shift=
) |
-				(mdma_timing[speed & 0x03].command_width << (timing_shift + 4));
-			pci_write_config_dword(dev, ATIIXP_IDE_MDMA_TIMING, tmp32);
-		}
+
+		udma_ctl |=3D (1 << drive->dn);
+	} else if (speed >=3D XFER_MW_DMA_0) {
+		u8 i =3D speed & 0x03;
+
+		pci_read_config_dword(dev, ATIIXP_IDE_MDMA_TIMING, &tmp32);
+		tmp32 &=3D ~(0xff << timing_shift);
+		tmp32 |=3D (mdma_timing[i].recover_width << timing_shift) |
+			 (mdma_timing[i].command_width << (timing_shift + 4));
+		pci_write_config_dword(dev, ATIIXP_IDE_MDMA_TIMING, tmp32);
+
+		udma_ctl &=3D ~(1 << drive->dn);
 	}
=20
+	pci_write_config_word(dev, ATIIXP_IDE_UDMA_CONTROL, udma_ctl);
+
 	spin_unlock_irqrestore(&atiixp_lock, flags);
 }
=20
@@ -181,9 +149,6 @@ static void __devinit init_hwif_atiixp(ide_hwif_t *=
hwif)
 		hwif->cbl =3D ATA_CBL_PATA80;
 	else
 		hwif->cbl =3D ATA_CBL_PATA40;
-
-	hwif->dma_host_on =3D &atiixp_dma_host_on;
-	hwif->dma_host_off =3D &atiixp_dma_host_off;
 }
=20
 static const struct ide_port_info atiixp_pci_info[] __devinitdata =3D =
{
diff --git a/drivers/ide/pci/cmd640.c b/drivers/ide/pci/cmd640.c
index 4aa4810..da3565e 100644
--- a/drivers/ide/pci/cmd640.c
+++ b/drivers/ide/pci/cmd640.c
@@ -706,9 +706,9 @@ static int pci_conf2(void)
 }
=20
 /*
- * Probe for a cmd640 chipset, and initialize it if found.  Called fro=
m ide.c
+ * Probe for a cmd640 chipset, and initialize it if found.
  */
-int __init ide_probe_for_cmd640x (void)
+static int __init cmd640x_init(void)
 {
 #ifdef CONFIG_BLK_DEV_CMD640_ENHANCED
 	int second_port_toggled =3D 0;
@@ -717,6 +717,7 @@ int __init ide_probe_for_cmd640x (void)
 	const char *bus_type, *port2;
 	unsigned int index;
 	u8 b, cfr;
+	u8 idx[4] =3D { 0xff, 0xff, 0xff, 0xff };
=20
 	if (cmd640_vlb && probe_for_cmd640_vlb()) {
 		bus_type =3D "VLB";
@@ -769,6 +770,8 @@ int __init ide_probe_for_cmd640x (void)
 	cmd_hwif0->set_pio_mode =3D &cmd640_set_pio_mode;
 #endif /* CONFIG_BLK_DEV_CMD640_ENHANCED */
=20
+	idx[0] =3D cmd_hwif0->index;
+
 	/*
 	 * Ensure compatibility by always using the slowest timings
 	 * for access to the drive's command register block,
@@ -826,6 +829,8 @@ int __init ide_probe_for_cmd640x (void)
 		cmd_hwif1->pio_mask =3D ATA_PIO5;
 		cmd_hwif1->set_pio_mode =3D &cmd640_set_pio_mode;
 #endif /* CONFIG_BLK_DEV_CMD640_ENHANCED */
+
+		idx[1] =3D cmd_hwif1->index;
 	}
 	printk(KERN_INFO "%s: %sserialized, secondary interface %s\n", cmd_hw=
if1->name,
 		cmd_hwif0->serialized ? "" : "not ", port2);
@@ -872,6 +877,13 @@ int __init ide_probe_for_cmd640x (void)
 #ifdef CMD640_DUMP_REGS
 	cmd640_dump_regs();
 #endif
+
+	ide_device_add(idx);
+
 	return 1;
 }
=20
+module_param_named(probe_vlb, cmd640_vlb, bool, 0);
+MODULE_PARM_DESC(probe_vlb, "probe for VLB version of CMD640 chipset")=
;
+
+module_init(cmd640x_init);
diff --git a/drivers/ide/pci/cmd64x.c b/drivers/ide/pci/cmd64x.c
index 0b1e947..cd4eb9d 100644
--- a/drivers/ide/pci/cmd64x.c
+++ b/drivers/ide/pci/cmd64x.c
@@ -1,5 +1,5 @@
 /*
- * linux/drivers/ide/pci/cmd64x.c		Version 1.52	Dec 24, 2007
+ * linux/drivers/ide/pci/cmd64x.c		Version 1.53	Dec 24, 2007
  *
  * cmd64x.c: Enable interrupts at initialization time on Ultra/PCI mac=
hines.
  *           Due to massive hardware bugs, UltraDMA is only supported
@@ -22,8 +22,6 @@
=20
 #include <asm/io.h>
=20
-#define DISPLAY_CMD64X_TIMINGS
-
 #define CMD_DEBUG 0
=20
 #if CMD_DEBUG
@@ -37,11 +35,6 @@
  */
 #define CFR		0x50
 #define   CFR_INTR_CH0		0x04
-#define CNTRL		0x51
-#define   CNTRL_ENA_1ST 	0x04
-#define   CNTRL_ENA_2ND 	0x08
-#define   CNTRL_DIS_RA0 	0x40
-#define   CNTRL_DIS_RA1 	0x80
=20
 #define	CMDTIM		0x52
 #define	ARTTIM0		0x53
@@ -60,108 +53,13 @@
 #define MRDMODE		0x71
 #define   MRDMODE_INTR_CH0	0x04
 #define   MRDMODE_INTR_CH1	0x08
-#define   MRDMODE_BLK_CH0	0x10
-#define   MRDMODE_BLK_CH1	0x20
-#define BMIDESR0	0x72
 #define UDIDETCR0	0x73
 #define DTPR0		0x74
 #define BMIDECR1	0x78
 #define BMIDECSR	0x79
-#define BMIDESR1	0x7A
 #define UDIDETCR1	0x7B
 #define DTPR1		0x7C
=20
-#if defined(DISPLAY_CMD64X_TIMINGS) && defined(CONFIG_IDE_PROC_FS)
-#include <linux/stat.h>
-#include <linux/proc_fs.h>
-
-static u8 cmd64x_proc =3D 0;
-
-#define CMD_MAX_DEVS		5
-
-static struct pci_dev *cmd_devs[CMD_MAX_DEVS];
-static int n_cmd_devs;
-
-static char * print_cmd64x_get_info (char *buf, struct pci_dev *dev, i=
nt index)
-{
-	char *p =3D buf;
-	u8 reg72 =3D 0, reg73 =3D 0;			/* primary */
-	u8 reg7a =3D 0, reg7b =3D 0;			/* secondary */
-	u8 reg50 =3D 1, reg51 =3D 1, reg57 =3D 0, reg71 =3D 0;	/* extra */
-
-	p +=3D sprintf(p, "\nController: %d\n", index);
-	p +=3D sprintf(p, "PCI-%x Chipset.\n", dev->device);
-
-	(void) pci_read_config_byte(dev, CFR,       &reg50);
-	(void) pci_read_config_byte(dev, CNTRL,     &reg51);
-	(void) pci_read_config_byte(dev, ARTTIM23,  &reg57);
-	(void) pci_read_config_byte(dev, MRDMODE,   &reg71);
-	(void) pci_read_config_byte(dev, BMIDESR0,  &reg72);
-	(void) pci_read_config_byte(dev, UDIDETCR0, &reg73);
-	(void) pci_read_config_byte(dev, BMIDESR1,  &reg7a);
-	(void) pci_read_config_byte(dev, UDIDETCR1, &reg7b);
-
-	/* PCI0643/6 originally didn't have the primary channel enable bit */
-	if ((dev->device =3D=3D PCI_DEVICE_ID_CMD_643) ||
-	    (dev->device =3D=3D PCI_DEVICE_ID_CMD_646 && dev->revision < 3))
-		reg51 |=3D CNTRL_ENA_1ST;
-
-	p +=3D sprintf(p, "---------------- Primary Channel "
-			"---------------- Secondary Channel ------------\n");
-	p +=3D sprintf(p, "                 %s                         %s\n",
-		 (reg51 & CNTRL_ENA_1ST) ? "enabled " : "disabled",
-		 (reg51 & CNTRL_ENA_2ND) ? "enabled " : "disabled");
-	p +=3D sprintf(p, "---------------- drive0 --------- drive1 "
-			"-------- drive0 --------- drive1 ------\n");
-	p +=3D sprintf(p, "DMA enabled:     %s              %s"
-			"             %s              %s\n",
-		(reg72 & 0x20) ? "yes" : "no ", (reg72 & 0x40) ? "yes" : "no ",
-		(reg7a & 0x20) ? "yes" : "no ", (reg7a & 0x40) ? "yes" : "no ");
-	p +=3D sprintf(p, "UltraDMA mode:   %s (%c)          %s (%c)",
-		( reg73 & 0x01) ? " on" : "off",
-		((reg73 & 0x30) =3D=3D 0x30) ? ((reg73 & 0x04) ? '3' : '0') :
-		((reg73 & 0x30) =3D=3D 0x20) ? ((reg73 & 0x04) ? '3' : '1') :
-		((reg73 & 0x30) =3D=3D 0x10) ? ((reg73 & 0x04) ? '4' : '2') :
-		((reg73 & 0x30) =3D=3D 0x00) ? ((reg73 & 0x04) ? '5' : '2') : '?',
-		( reg73 & 0x02) ? " on" : "off",
-		((reg73 & 0xC0) =3D=3D 0xC0) ? ((reg73 & 0x08) ? '3' : '0') :
-		((reg73 & 0xC0) =3D=3D 0x80) ? ((reg73 & 0x08) ? '3' : '1') :
-		((reg73 & 0xC0) =3D=3D 0x40) ? ((reg73 & 0x08) ? '4' : '2') :
-		((reg73 & 0xC0) =3D=3D 0x00) ? ((reg73 & 0x08) ? '5' : '2') : '?');
-	p +=3D sprintf(p, "         %s (%c)          %s (%c)\n",
-		( reg7b & 0x01) ? " on" : "off",
-		((reg7b & 0x30) =3D=3D 0x30) ? ((reg7b & 0x04) ? '3' : '0') :
-		((reg7b & 0x30) =3D=3D 0x20) ? ((reg7b & 0x04) ? '3' : '1') :
-		((reg7b & 0x30) =3D=3D 0x10) ? ((reg7b & 0x04) ? '4' : '2') :
-		((reg7b & 0x30) =3D=3D 0x00) ? ((reg7b & 0x04) ? '5' : '2') : '?',
-		( reg7b & 0x02) ? " on" : "off",
-		((reg7b & 0xC0) =3D=3D 0xC0) ? ((reg7b & 0x08) ? '3' : '0') :
-		((reg7b & 0xC0) =3D=3D 0x80) ? ((reg7b & 0x08) ? '3' : '1') :
-		((reg7b & 0xC0) =3D=3D 0x40) ? ((reg7b & 0x08) ? '4' : '2') :
-		((reg7b & 0xC0) =3D=3D 0x00) ? ((reg7b & 0x08) ? '5' : '2') : '?');
-	p +=3D sprintf(p, "Interrupt:       %s, %s                 %s, %s\n",
-		(reg71 & MRDMODE_BLK_CH0  ) ? "blocked" : "enabled",
-		(reg50 & CFR_INTR_CH0	  ) ? "pending" : "clear  ",
-		(reg71 & MRDMODE_BLK_CH1  ) ? "blocked" : "enabled",
-		(reg57 & ARTTIM23_INTR_CH1) ? "pending" : "clear  ");
-
-	return (char *)p;
-}
-
-static int cmd64x_get_info (char *buffer, char **addr, off_t offset, i=
nt count)
-{
-	char *p =3D buffer;
-	int i;
-
-	for (i =3D 0; i < n_cmd_devs; i++) {
-		struct pci_dev *dev	=3D cmd_devs[i];
-		p =3D print_cmd64x_get_info(p, dev, i);
-	}
-	return p-buffer;	/* =3D> must be less than 4k! */
-}
-
-#endif	/* defined(DISPLAY_CMD64X_TIMINGS) && defined(CONFIG_IDE_PROC_F=
S) */
-
 static u8 quantize_timing(int timing, int quant)
 {
 	return (timing + quant - 1) / quant;
@@ -472,16 +370,6 @@ static unsigned int __devinit init_chipset_cmd64x(=
struct pci_dev *dev, const cha
 	mrdmode &=3D ~0x30;
 	(void) pci_write_config_byte(dev, MRDMODE, (mrdmode | 0x02));
=20
-#if defined(DISPLAY_CMD64X_TIMINGS) && defined(CONFIG_IDE_PROC_FS)
-
-	cmd_devs[n_cmd_devs++] =3D dev;
-
-	if (!cmd64x_proc) {
-		cmd64x_proc =3D 1;
-		ide_pci_create_host_proc("cmd64x", cmd64x_get_info);
-	}
-#endif /* DISPLAY_CMD64X_TIMINGS && CONFIG_IDE_PROC_FS */
-
 	return 0;
 }
=20
diff --git a/drivers/ide/pci/cs5520.c b/drivers/ide/pci/cs5520.c
index d1a91bc..6ec00b8 100644
--- a/drivers/ide/pci/cs5520.c
+++ b/drivers/ide/pci/cs5520.c
@@ -71,7 +71,6 @@ static void cs5520_set_pio_mode(ide_drive_t *drive, c=
onst u8 pio)
 	ide_hwif_t *hwif =3D HWIF(drive);
 	struct pci_dev *pdev =3D hwif->pci_dev;
 	int controller =3D drive->dn > 1 ? 1 : 0;
-	u8 reg;
=20
 	/* FIXME: if DMA =3D 1 do we need to set the DMA bit here ? */
=20
@@ -91,11 +90,6 @@ static void cs5520_set_pio_mode(ide_drive_t *drive, =
const u8 pio)
 	pci_write_config_byte(pdev, 0x66 + 4*controller + (drive->dn&1),
 		(cs5520_pio_clocks[pio].recovery << 4) |
 		(cs5520_pio_clocks[pio].assert));
-	=09
-	/* Set the DMA enable/disable flag */
-	reg =3D inb(hwif->dma_base + 0x02 + 8*controller);
-	reg |=3D 1<<((drive->dn&1)+5);
-	outb(reg, hwif->dma_base + 0x02 + 8*controller);
 }
=20
 static void cs5520_set_dma_mode(ide_drive_t *drive, const u8 speed)
@@ -109,13 +103,14 @@ static void cs5520_set_dma_mode(ide_drive_t *driv=
e, const u8 speed)
  *	We wrap the DMA activate to set the vdma flag. This is needed
  *	so that the IDE DMA layer issues PIO not DMA commands over the
  *	DMA channel
+ *
+ *	ATAPI is harder so disable it for now using IDE_HFLAG_NO_ATAPI_DMA
  */
-=20
-static int cs5520_dma_on(ide_drive_t *drive)
+
+static void cs5520_dma_host_set(ide_drive_t *drive, int on)
 {
-	/* ATAPI is harder so leave it for now */
-	drive->vdma =3D 1;
-	return 0;
+	drive->vdma =3D on;
+	ide_dma_host_set(drive, on);
 }
=20
 static void __devinit init_hwif_cs5520(ide_hwif_t *hwif)
@@ -126,7 +121,7 @@ static void __devinit init_hwif_cs5520(ide_hwif_t *=
hwif)
 	if (hwif->dma_base =3D=3D 0)
 		return;
=20
-	hwif->ide_dma_on =3D &cs5520_dma_on;
+	hwif->dma_host_set =3D &cs5520_dma_host_set;
 }
=20
 #define DECLARE_CS_DEV(name_str)				\
diff --git a/drivers/ide/pci/cy82c693.c b/drivers/ide/pci/cy82c693.c
index 1cd4e9c..3ec4c65 100644
--- a/drivers/ide/pci/cy82c693.c
+++ b/drivers/ide/pci/cy82c693.c
@@ -1,5 +1,5 @@
 /*
- * linux/drivers/ide/pci/cy82c693.c		Version 0.42	Oct 23, 2007
+ * linux/drivers/ide/pci/cy82c693.c		Version 0.44	Nov 8, 2007
  *
  *  Copyright (C) 1998-2000 Andreas S. Krebs (akrebs@altavista.net), M=
aintainer
  *  Copyright (C) 1998-2002 Andre Hedrick <andre@linux-ide.org>, Integ=
rator
@@ -176,17 +176,12 @@ static void compute_clocks (u8 pio, pio_clocks_t =
*p_pclk)
  * set DMA mode a specific channel for CY82C693
  */
=20
-static void cy82c693_dma_enable (ide_drive_t *drive, int mode, int sin=
gle)
+static void cy82c693_set_dma_mode(ide_drive_t *drive, const u8 mode)
 {
-	u8 index =3D 0, data =3D 0;
+	ide_hwif_t *hwif =3D drive->hwif;
+	u8 single =3D (mode & 0x10) >> 4, index =3D 0, data =3D 0;
=20
-	if (mode>2)	/* make sure we set a valid mode */
-		mode =3D 2;
-			  =20
-	if (mode > drive->id->tDMA)  /* to be absolutly sure we have a valid =
mode */
-		mode =3D drive->id->tDMA;
-=09
-	index =3D (HWIF(drive)->channel=3D=3D0) ? CY82_INDEX_CHANNEL0 : CY82_=
INDEX_CHANNEL1;
+	index =3D hwif->channel ? CY82_INDEX_CHANNEL1 : CY82_INDEX_CHANNEL0;
=20
 #if CY82C693_DEBUG_LOGS
 	/* for debug let's show the previous values */
@@ -199,7 +194,7 @@ static void cy82c693_dma_enable (ide_drive_t *drive=
, int mode, int single)
 		(data&0x3), ((data>>2)&1));
 #endif /* CY82C693_DEBUG_LOGS */
=20
-	data =3D (u8)mode|(u8)(single<<2);
+	data =3D (mode & 3) | (single << 2);
=20
 	outb(index, CY82_INDEX_PORT);
 	outb(data, CY82_DATA_PORT);
@@ -207,7 +202,7 @@ static void cy82c693_dma_enable (ide_drive_t *drive=
, int mode, int single)
 #if CY82C693_DEBUG_INFO
 	printk(KERN_INFO "%s (ch=3D%d, dev=3D%d): set DMA mode to %d (single=3D=
%d)\n",
 		drive->name, HWIF(drive)->channel, drive->select.b.unit,
-		mode, single);
+		mode & 3, single);
 #endif /* CY82C693_DEBUG_INFO */
=20
 	/*=20
@@ -230,39 +225,6 @@ static void cy82c693_dma_enable (ide_drive_t *driv=
e, int mode, int single)
 #endif /* CY82C693_DEBUG_INFO */
 }
=20
-/*=20
- * used to set DMA mode for CY82C693 (single and multi modes)
- */
-static int cy82c693_ide_dma_on (ide_drive_t *drive)
-{
-	struct hd_driveid *id =3D drive->id;
-
-#if CY82C693_DEBUG_INFO
-	printk (KERN_INFO "dma_on: %s\n", drive->name);
-#endif /* CY82C693_DEBUG_INFO */
-
-	if (id !=3D NULL) {	=09
-		/* Enable DMA on any drive that has DMA
-		 * (multi or single) enabled
-		 */
-		if (id->field_valid & 2) {	/* regular DMA */
-			int mmode, smode;
-
-			mmode =3D id->dma_mword & (id->dma_mword >> 8);
-			smode =3D id->dma_1word & (id->dma_1word >> 8);
-			       		     =20
-			if (mmode !=3D 0) {
-				/* enable multi */
-				cy82c693_dma_enable(drive, (mmode >> 1), 0);
-			} else if (smode !=3D 0) {
-				/* enable single */
-				cy82c693_dma_enable(drive, (smode >> 1), 1);
-			}
-		}
-	}
-        return __ide_dma_on(drive);
-}
-
 static void cy82c693_set_pio_mode(ide_drive_t *drive, const u8 pio)
 {
 	ide_hwif_t *hwif =3D HWIF(drive);
@@ -429,11 +391,7 @@ static unsigned int __devinit init_chipset_cy82c69=
3(struct pci_dev *dev, const c
 static void __devinit init_hwif_cy82c693(ide_hwif_t *hwif)
 {
 	hwif->set_pio_mode =3D &cy82c693_set_pio_mode;
-
-	if (hwif->dma_base =3D=3D 0)
-		return;
-
-	hwif->ide_dma_on =3D &cy82c693_ide_dma_on;
+	hwif->set_dma_mode =3D &cy82c693_set_dma_mode;
 }
=20
 static void __devinit init_iops_cy82c693(ide_hwif_t *hwif)
@@ -454,11 +412,11 @@ static const struct ide_port_info cy82c693_chipse=
t __devinitdata =3D {
 	.init_iops	=3D init_iops_cy82c693,
 	.init_hwif	=3D init_hwif_cy82c693,
 	.chipset	=3D ide_cy82c693,
-	.host_flags	=3D IDE_HFLAG_SINGLE | IDE_HFLAG_TRUST_BIOS_FOR_DMA |
+	.host_flags	=3D IDE_HFLAG_SINGLE | IDE_HFLAG_CY82C693 |
 			  IDE_HFLAG_BOOTABLE,
 	.pio_mask	=3D ATA_PIO4,
-	.swdma_mask	=3D ATA_SWDMA2_ONLY,
-	.mwdma_mask	=3D ATA_MWDMA2_ONLY,
+	.swdma_mask	=3D ATA_SWDMA2,
+	.mwdma_mask	=3D ATA_MWDMA2,
 };
=20
 static int __devinit cy82c693_init_one(struct pci_dev *dev, const stru=
ct pci_device_id *id)
diff --git a/drivers/ide/pci/delkin_cb.c b/drivers/ide/pci/delkin_cb.c
index 8382908..26aa492 100644
--- a/drivers/ide/pci/delkin_cb.c
+++ b/drivers/ide/pci/delkin_cb.c
@@ -80,7 +80,7 @@ delkin_cb_probe (struct pci_dev *dev, const struct pc=
i_device_id *id)
 	hw.irq =3D dev->irq;
 	hw.chipset =3D ide_pci;		/* this enables IRQ sharing */
=20
-	rc =3D ide_register_hw(&hw, &ide_undecoded_slave, 0, &hwif);
+	rc =3D ide_register_hw(&hw, &ide_undecoded_slave, &hwif);
 	if (rc < 0) {
 		printk(KERN_ERR "delkin_cb: ide_register_hw failed (%d)\n", rc);
 		pci_disable_device(dev);
diff --git a/drivers/ide/pci/hpt366.c b/drivers/ide/pci/hpt366.c
index 3777fb8..1268593 100644
--- a/drivers/ide/pci/hpt366.c
+++ b/drivers/ide/pci/hpt366.c
@@ -725,15 +725,18 @@ static void hpt3xx_set_pio_mode(ide_drive_t *driv=
e, const u8 pio)
 	hpt3xx_set_mode(drive, XFER_PIO_0 + pio);
 }
=20
-static int hpt3xx_quirkproc(ide_drive_t *drive)
+static void hpt3xx_quirkproc(ide_drive_t *drive)
 {
 	struct hd_driveid *id	=3D drive->id;
 	const  char **list	=3D quirk_drives;
=20
 	while (*list)
-		if (strstr(id->model, *list++))
-			return 1;
-	return 0;
+		if (strstr(id->model, *list++)) {
+			drive->quirk_list =3D 1;
+			return;
+		}
+
+	drive->quirk_list =3D 0;
 }
=20
 static void hpt3xx_maskproc(ide_drive_t *drive, int mask)
diff --git a/drivers/ide/pci/it821x.c b/drivers/ide/pci/it821x.c
index 99b7d76..e610a53 100644
--- a/drivers/ide/pci/it821x.c
+++ b/drivers/ide/pci/it821x.c
@@ -431,33 +431,29 @@ static u8 __devinit ata66_it821x(ide_hwif_t *hwif=
)
 }
=20
 /**
- *	it821x_fixup	-	post init callback
- *	@hwif: interface
+ *	it821x_quirkproc	-	post init callback
+ *	@drive: drive
  *
- *	This callback is run after the drives have been probed but
+ *	This callback is run after the drive has been probed but
  *	before anything gets attached. It allows drivers to do any
  *	final tuning that is needed, or fixups to work around bugs.
  */
=20
-static void __devinit it821x_fixups(ide_hwif_t *hwif)
+static void __devinit it821x_quirkproc(ide_drive_t *drive)
 {
-	struct it821x_dev *itdev =3D ide_get_hwifdata(hwif);
-	int i;
+	struct it821x_dev *itdev =3D ide_get_hwifdata(drive->hwif);
+	struct hd_driveid *id =3D drive->id;
+	u16 *idbits =3D (u16 *)drive->id;
=20
-	if(!itdev->smart) {
+	if (!itdev->smart) {
 		/*
 		 *	If we are in pass through mode then not much
 		 *	needs to be done, but we do bother to clear the
 		 *	IRQ mask as we may well be in PIO (eg rev 0x10)
 		 *	for now and we know unmasking is safe on this chipset.
 		 */
-		for (i =3D 0; i < 2; i++) {
-			ide_drive_t *drive =3D &hwif->drives[i];
-			if(drive->present)
-				drive->unmask =3D 1;
-		}
-		return;
-	}
+		drive->unmask =3D 1;
+	} else {
 	/*
 	 *	Perform fixups on smart mode. We need to "lose" some
 	 *	capabilities the firmware lacks but does not filter, and
@@ -465,16 +461,6 @@ static void __devinit it821x_fixups(ide_hwif_t *hw=
if)
 	 *	in RAID mode.
 	 */
=20
-	for(i =3D 0; i < 2; i++) {
-		ide_drive_t *drive =3D &hwif->drives[i];
-		struct hd_driveid *id;
-		u16 *idbits;
-
-		if(!drive->present)
-			continue;
-		id =3D drive->id;
-		idbits =3D (u16 *)drive->id;
-
 		/* Check for RAID v native */
 		if(strstr(id->model, "Integrated Technology Express")) {
 			/* In raid mode the ident block is slightly buggy
@@ -537,6 +523,8 @@ static void __devinit init_hwif_it821x(ide_hwif_t *=
hwif)
 	struct it821x_dev *idev =3D kzalloc(sizeof(struct it821x_dev), GFP_KE=
RNEL);
 	u8 conf;
=20
+	hwif->quirkproc =3D &it821x_quirkproc;
+
 	if (idev =3D=3D NULL) {
 		printk(KERN_ERR "it821x: out of memory, falling back to legacy behav=
iour.\n");
 		return;
@@ -633,7 +621,6 @@ static unsigned int __devinit init_chipset_it821x(s=
truct pci_dev *dev, const cha
 		.name		=3D name_str,		\
 		.init_chipset	=3D init_chipset_it821x,	\
 		.init_hwif	=3D init_hwif_it821x,	\
-		.fixup	 	=3D it821x_fixups,	\
 		.host_flags	=3D IDE_HFLAG_BOOTABLE,	\
 		.pio_mask	=3D ATA_PIO4,		\
 	}
diff --git a/drivers/ide/pci/pdc202xx_new.c b/drivers/ide/pci/pdc202xx_=
new.c
index ef4a99b..89d2363 100644
--- a/drivers/ide/pci/pdc202xx_new.c
+++ b/drivers/ide/pci/pdc202xx_new.c
@@ -203,14 +203,17 @@ static u8 pdcnew_cable_detect(ide_hwif_t *hwif)
 		return ATA_CBL_PATA80;
 }
=20
-static int pdcnew_quirkproc(ide_drive_t *drive)
+static void pdcnew_quirkproc(ide_drive_t *drive)
 {
 	const char **list, *model =3D drive->id->model;
=20
 	for (list =3D pdc_quirk_drives; *list !=3D NULL; list++)
-		if (strstr(model, *list) !=3D NULL)
-			return 2;
-	return 0;
+		if (strstr(model, *list) !=3D NULL) {
+			drive->quirk_list =3D 2;
+			return;
+		}
+
+	drive->quirk_list =3D 0;
 }
=20
 static void pdcnew_reset(ide_drive_t *drive)
diff --git a/drivers/ide/pci/pdc202xx_old.c b/drivers/ide/pci/pdc202xx_=
old.c
index 67b2781..3a1e081 100644
--- a/drivers/ide/pci/pdc202xx_old.c
+++ b/drivers/ide/pci/pdc202xx_old.c
@@ -176,14 +176,17 @@ static void pdc_old_disable_66MHz_clock(ide_hwif_=
t *hwif)
 	outb(clock & ~(hwif->channel ? 0x08 : 0x02), clock_reg);
 }
=20
-static int pdc202xx_quirkproc (ide_drive_t *drive)
+static void pdc202xx_quirkproc(ide_drive_t *drive)
 {
 	const char **list, *model =3D drive->id->model;
=20
 	for (list =3D pdc_quirk_drives; *list !=3D NULL; list++)
-		if (strstr(model, *list) !=3D NULL)
-			return 2;
-	return 0;
+		if (strstr(model, *list) !=3D NULL) {
+			drive->quirk_list =3D 2;
+			return;
+		}
+
+	drive->quirk_list =3D 0;
 }
=20
 static void pdc202xx_old_ide_dma_start(ide_drive_t *drive)
diff --git a/drivers/ide/pci/sc1200.c b/drivers/ide/pci/sc1200.c
index fef20bd..32fdf53 100644
--- a/drivers/ide/pci/sc1200.c
+++ b/drivers/ide/pci/sc1200.c
@@ -220,9 +220,9 @@ static void sc1200_set_pio_mode(ide_drive_t *drive,=
 const u8 pio)
 	}
 	if (mode !=3D -1) {
 		printk("SC1200: %s: changing (U)DMA mode\n", drive->name);
-		hwif->dma_off_quietly(drive);
-		if (ide_set_dma_mode(drive, mode) =3D=3D 0)
-			hwif->dma_host_on(drive);
+		ide_dma_off_quietly(drive);
+		if (ide_set_dma_mode(drive, mode) =3D=3D 0 && drive->using_dma)
+			hwif->dma_host_set(drive, 1);
 		return;
 	}
=20
diff --git a/drivers/ide/pci/serverworks.c b/drivers/ide/pci/serverwork=
s.c
index e9bd269..877c09b 100644
--- a/drivers/ide/pci/serverworks.c
+++ b/drivers/ide/pci/serverworks.c
@@ -164,25 +164,12 @@ static void svwks_set_dma_mode(ide_drive_t *drive=
, const u8 speed)
 	ultra_timing	&=3D ~(0x0F << (4*unit));
 	ultra_enable	&=3D ~(0x01 << drive->dn);
=20
-	switch(speed) {
-		case XFER_MW_DMA_2:
-		case XFER_MW_DMA_1:
-		case XFER_MW_DMA_0:
-			dma_timing |=3D dma_modes[speed - XFER_MW_DMA_0];
-			break;
-
-		case XFER_UDMA_5:
-		case XFER_UDMA_4:
-		case XFER_UDMA_3:
-		case XFER_UDMA_2:
-		case XFER_UDMA_1:
-		case XFER_UDMA_0:
-			dma_timing   |=3D dma_modes[2];
-			ultra_timing |=3D ((udma_modes[speed - XFER_UDMA_0]) << (4*unit));
-			ultra_enable |=3D (0x01 << drive->dn);
-		default:
-			break;
-	}
+	if (speed >=3D XFER_UDMA_0) {
+		dma_timing   |=3D dma_modes[2];
+		ultra_timing |=3D (udma_modes[speed - XFER_UDMA_0] << (4 * unit));
+		ultra_enable |=3D (0x01 << drive->dn);
+	} else if (speed >=3D XFER_MW_DMA_0)
+		dma_timing   |=3D dma_modes[speed - XFER_MW_DMA_0];
=20
 	pci_write_config_byte(dev, drive_pci2[drive->dn], dma_timing);
 	pci_write_config_byte(dev, (0x56|hwif->channel), ultra_timing);
diff --git a/drivers/ide/pci/sgiioc4.c b/drivers/ide/pci/sgiioc4.c
index 7e9dade..9e0be7d 100644
--- a/drivers/ide/pci/sgiioc4.c
+++ b/drivers/ide/pci/sgiioc4.c
@@ -277,21 +277,6 @@ sgiioc4_ide_dma_end(ide_drive_t * drive)
 	return dma_stat;
 }
=20
-static int
-sgiioc4_ide_dma_on(ide_drive_t * drive)
-{
-	drive->using_dma =3D 1;
-
-	return 0;
-}
-
-static void sgiioc4_dma_off_quietly(ide_drive_t *drive)
-{
-	drive->using_dma =3D 0;
-
-	drive->hwif->dma_host_off(drive);
-}
-
 static void sgiioc4_set_dma_mode(ide_drive_t *drive, const u8 speed)
 {
 }
@@ -303,13 +288,10 @@ sgiioc4_ide_dma_test_irq(ide_drive_t * drive)
 	return sgiioc4_checkirq(HWIF(drive));
 }
=20
-static void sgiioc4_dma_host_on(ide_drive_t * drive)
-{
-}
-
-static void sgiioc4_dma_host_off(ide_drive_t * drive)
+static void sgiioc4_dma_host_set(ide_drive_t *drive, int on)
 {
-	sgiioc4_clearirq(drive);
+	if (!on)
+		sgiioc4_clearirq(drive);
 }
=20
 static void
@@ -593,14 +575,11 @@ ide_init_sgiioc4(ide_hwif_t * hwif)
=20
 	hwif->mwdma_mask =3D ATA_MWDMA2_ONLY;
=20
+	hwif->dma_host_set =3D &sgiioc4_dma_host_set;
 	hwif->dma_setup =3D &sgiioc4_ide_dma_setup;
 	hwif->dma_start =3D &sgiioc4_ide_dma_start;
 	hwif->ide_dma_end =3D &sgiioc4_ide_dma_end;
-	hwif->ide_dma_on =3D &sgiioc4_ide_dma_on;
-	hwif->dma_off_quietly =3D &sgiioc4_dma_off_quietly;
 	hwif->ide_dma_test_irq =3D &sgiioc4_ide_dma_test_irq;
-	hwif->dma_host_on =3D &sgiioc4_dma_host_on;
-	hwif->dma_host_off =3D &sgiioc4_dma_host_off;
 	hwif->dma_lost_irq =3D &sgiioc4_dma_lost_irq;
 	hwif->dma_timeout =3D &ide_dma_timeout;
 }
@@ -614,6 +593,7 @@ sgiioc4_ide_setup_pci_device(struct pci_dev *dev)
 	ide_hwif_t *hwif;
 	int h;
 	u8 idx[4] =3D { 0xff, 0xff, 0xff, 0xff };
+	hw_regs_t hw;
=20
 	/*
 	 * Find an empty HWIF; if none available, return -ENOMEM.
@@ -653,21 +633,16 @@ sgiioc4_ide_setup_pci_device(struct pci_dev *dev)
 		return -ENOMEM;
 	}
=20
-	if (hwif->io_ports[IDE_DATA_OFFSET] !=3D cmd_base) {
-		hw_regs_t hw;
-
-		/* Initialize the IO registers */
-		memset(&hw, 0, sizeof(hw));
-		sgiioc4_init_hwif_ports(&hw, cmd_base, ctl, irqport);
-		memcpy(hwif->io_ports, hw.io_ports, sizeof(hwif->io_ports));
-		hwif->noprobe =3D !hwif->io_ports[IDE_DATA_OFFSET];
-	}
+	/* Initialize the IO registers */
+	memset(&hw, 0, sizeof(hw));
+	sgiioc4_init_hwif_ports(&hw, cmd_base, ctl, irqport);
+	hw.irq =3D dev->irq;
+	hw.chipset =3D ide_pci;
+	hw.dev =3D &dev->dev;
+	ide_init_port_hw(hwif, &hw);
=20
-	hwif->irq =3D dev->irq;
-	hwif->chipset =3D ide_pci;
 	hwif->pci_dev =3D dev;
 	hwif->channel =3D 0;	/* Single Channel chip */
-	hwif->gendev.parent =3D &dev->dev;/* setup proper ancestral informati=
on */
=20
 	/* The IOC4 uses MMIO rather than Port IO. */
 	default_hwif_mmiops(hwif);
diff --git a/drivers/ide/pci/siimage.c b/drivers/ide/pci/siimage.c
index 7b45eaf..908f37b 100644
--- a/drivers/ide/pci/siimage.c
+++ b/drivers/ide/pci/siimage.c
@@ -713,9 +713,6 @@ static int is_dev_seagate_sata(ide_drive_t *drive)
 	const char *s =3D &drive->id->model[0];
 	unsigned len;
=20
-	if (!drive->present)
-		return 0;
-
 	len =3D strnlen(s, sizeof(drive->id->model));
=20
 	if ((len > 4) && (!memcmp(s, "ST", 2))) {
@@ -730,18 +727,20 @@ static int is_dev_seagate_sata(ide_drive_t *drive=
)
 }
=20
 /**
- *	siimage_fixup		-	post probe fixups
- *	@hwif: interface to fix up
+ *	sil_quirkproc		-	post probe fixups
+ *	@drive: drive
  *
  *	Called after drive probe we use this to decide whether the
  *	Seagate fixup must be applied. This used to be in init_iops but
  *	that can occur before we know what drives are present.
  */
=20
-static void __devinit siimage_fixup(ide_hwif_t *hwif)
+static void __devinit sil_quirkproc(ide_drive_t *drive)
 {
+	ide_hwif_t *hwif =3D drive->hwif;
+
 	/* Try and raise the rqsize */
-	if (!is_sata(hwif) || !is_dev_seagate_sata(&hwif->drives[0]))
+	if (!is_sata(hwif) || !is_dev_seagate_sata(drive))
 		hwif->rqsize =3D 128;
 }
=20
@@ -804,6 +803,7 @@ static void __devinit init_hwif_siimage(ide_hwif_t =
*hwif)
=20
 	hwif->set_pio_mode =3D &sil_set_pio_mode;
 	hwif->set_dma_mode =3D &sil_set_dma_mode;
+	hwif->quirkproc =3D &sil_quirkproc;
=20
 	if (sata) {
 		static int first =3D 1;
@@ -842,7 +842,6 @@ static void __devinit init_hwif_siimage(ide_hwif_t =
*hwif)
 		.init_chipset	=3D init_chipset_siimage,	\
 		.init_iops	=3D init_iops_siimage,	\
 		.init_hwif	=3D init_hwif_siimage,	\
-		.fixup		=3D siimage_fixup,	\
 		.host_flags	=3D IDE_HFLAG_BOOTABLE,	\
 		.pio_mask	=3D ATA_PIO4,		\
 		.mwdma_mask	=3D ATA_MWDMA2,		\
diff --git a/drivers/ide/pci/sl82c105.c b/drivers/ide/pci/sl82c105.c
index 069f104..c7a125b 100644
--- a/drivers/ide/pci/sl82c105.c
+++ b/drivers/ide/pci/sl82c105.c
@@ -13,6 +13,7 @@
  *  -- Benjamin Herrenschmidt (01/11/03) benh@kernel.crashing.org
  *
  * Copyright (C) 2006-2007 MontaVista Software, Inc. <source@mvista.co=
m>
+ * Copyright (C)      2007 Bartlomiej Zolnierkiewicz
  */
=20
 #include <linux/types.h>
@@ -90,14 +91,8 @@ static void sl82c105_set_pio_mode(ide_drive_t *drive=
, const u8 pio)
 	drive->drive_data &=3D 0xffff0000;
 	drive->drive_data |=3D drv_ctrl;
=20
-	if (!drive->using_dma) {
-		/*
-		 * If we are actually using MW DMA, then we can not
-		 * reprogram the interface drive control register.
-		 */
-		pci_write_config_word(dev, reg,  drv_ctrl);
-		pci_read_config_word (dev, reg, &drv_ctrl);
-	}
+	pci_write_config_word(dev, reg,  drv_ctrl);
+	pci_read_config_word (dev, reg, &drv_ctrl);
=20
 	printk(KERN_DEBUG "%s: selected %s (%dns) (%04X)\n", drive->name,
 			  ide_xfer_verbose(pio + XFER_PIO_0),
@@ -123,17 +118,6 @@ static void sl82c105_set_dma_mode(ide_drive_t *dri=
ve, const u8 speed)
 	 */
 	drive->drive_data &=3D 0x0000ffff;
 	drive->drive_data |=3D (unsigned long)drv_ctrl << 16;
-
-	/*
-	 * If we are already using DMA, we just reprogram
-	 * the drive control register.
-	 */
-	if (drive->using_dma) {
-		struct pci_dev *dev	=3D HWIF(drive)->pci_dev;
-		int reg 		=3D 0x44 + drive->dn * 4;
-
-		pci_write_config_word(dev, reg, drv_ctrl);
-	}
 }
=20
 /*
@@ -201,6 +185,11 @@ static void sl82c105_dma_start(ide_drive_t *drive)
 {
 	ide_hwif_t *hwif	=3D HWIF(drive);
 	struct pci_dev *dev	=3D hwif->pci_dev;
+	int reg 		=3D 0x44 + drive->dn * 4;
+
+	DBG(("%s(drive:%s)\n", __FUNCTION__, drive->name));
+
+	pci_write_config_word(dev, reg, drive->drive_data >> 16);
=20
 	sl82c105_reset_host(dev);
 	ide_dma_start(drive);
@@ -214,64 +203,24 @@ static void sl82c105_dma_timeout(ide_drive_t *dri=
ve)
 	ide_dma_timeout(drive);
 }
=20
-static int sl82c105_ide_dma_on(ide_drive_t *drive)
-{
-	struct pci_dev *dev	=3D HWIF(drive)->pci_dev;
-	int rc, reg 		=3D 0x44 + drive->dn * 4;
-
-	DBG(("sl82c105_ide_dma_on(drive:%s)\n", drive->name));
-
-	rc =3D __ide_dma_on(drive);
-	if (rc =3D=3D 0) {
-		pci_write_config_word(dev, reg, drive->drive_data >> 16);
-
-		printk(KERN_INFO "%s: DMA enabled\n", drive->name);
-	}
-	return rc;
-}
-
-static void sl82c105_dma_off_quietly(ide_drive_t *drive)
+static int sl82c105_dma_end(ide_drive_t *drive)
 {
 	struct pci_dev *dev	=3D HWIF(drive)->pci_dev;
 	int reg 		=3D 0x44 + drive->dn * 4;
+	int ret;
=20
-	DBG(("sl82c105_dma_off_quietly(drive:%s)\n", drive->name));
+	DBG(("%s(drive:%s)\n", __FUNCTION__, drive->name));
=20
-	pci_write_config_word(dev, reg, drive->drive_data);
+	ret =3D __ide_dma_end(drive);
=20
-	ide_dma_off_quietly(drive);
-}
+	pci_write_config_word(dev, reg, drive->drive_data);
=20
-/*
- * Ok, that is nasty, but we must make sure the DMA timings
- * won't be used for a PIO access. The solution here is
- * to make sure the 16 bits mode is diabled on the channel
- * when DMA is enabled, thus causing the chip to use PIO0
- * timings for those operations.
- */
-static void sl82c105_selectproc(ide_drive_t *drive)
-{
-	ide_hwif_t *hwif	=3D HWIF(drive);
-	struct pci_dev *dev	=3D hwif->pci_dev;
-	u32 val, old, mask;
-
-	//DBG(("sl82c105_selectproc(drive:%s)\n", drive->name));
-
-	mask =3D hwif->channel ? CTRL_P1F16 : CTRL_P0F16;
-	old =3D val =3D (u32)pci_get_drvdata(dev);
-	if (drive->using_dma)
-		val &=3D ~mask;
-	else
-		val |=3D mask;
-	if (old !=3D val) {
-		pci_write_config_dword(dev, 0x40, val);=09
-		pci_set_drvdata(dev, (void *)val);
-	}
+	return ret;
 }
=20
 /*
  * ATA reset will clear the 16 bits mode in the control
- * register, we need to update our cache
+ * register, we need to reprogram it
  */
 static void sl82c105_resetproc(ide_drive_t *drive)
 {
@@ -281,7 +230,8 @@ static void sl82c105_resetproc(ide_drive_t *drive)
 	DBG(("sl82c105_resetproc(drive:%s)\n", drive->name));
=20
 	pci_read_config_dword(dev, 0x40, &val);
-	pci_set_drvdata(dev, (void *)val);
+	val |=3D (CTRL_P1F16 | CTRL_P0F16);
+	pci_write_config_dword(dev, 0x40, val);
 }
=20
 /*
@@ -334,7 +284,6 @@ static unsigned int __devinit init_chipset_sl82c105=
(struct pci_dev *dev, const c
 	pci_read_config_dword(dev, 0x40, &val);
 	val |=3D CTRL_P0EN | CTRL_P0F16 | CTRL_P1F16;
 	pci_write_config_dword(dev, 0x40, val);
-	pci_set_drvdata(dev, (void *)val);
=20
 	return dev->irq;
 }
@@ -350,7 +299,6 @@ static void __devinit init_hwif_sl82c105(ide_hwif_t=
 *hwif)
=20
 	hwif->set_pio_mode	=3D &sl82c105_set_pio_mode;
 	hwif->set_dma_mode	=3D &sl82c105_set_dma_mode;
-	hwif->selectproc	=3D &sl82c105_selectproc;
 	hwif->resetproc 	=3D &sl82c105_resetproc;
=20
 	if (!hwif->dma_base)
@@ -369,10 +317,9 @@ static void __devinit init_hwif_sl82c105(ide_hwif_=
t *hwif)
=20
 	hwif->mwdma_mask =3D ATA_MWDMA2;
=20
-	hwif->ide_dma_on		=3D &sl82c105_ide_dma_on;
-	hwif->dma_off_quietly		=3D &sl82c105_dma_off_quietly;
 	hwif->dma_lost_irq		=3D &sl82c105_dma_lost_irq;
 	hwif->dma_start			=3D &sl82c105_dma_start;
+	hwif->ide_dma_end		=3D &sl82c105_dma_end;
 	hwif->dma_timeout		=3D &sl82c105_dma_timeout;
=20
 	if (hwif->mate)
diff --git a/drivers/ide/pci/trm290.c b/drivers/ide/pci/trm290.c
index 0151d7f..04cd893 100644
--- a/drivers/ide/pci/trm290.c
+++ b/drivers/ide/pci/trm290.c
@@ -241,11 +241,7 @@ static int trm290_ide_dma_test_irq (ide_drive_t *d=
rive)
 	return (status =3D=3D 0x00ff);
 }
=20
-static void trm290_dma_host_on(ide_drive_t *drive)
-{
-}
-
-static void trm290_dma_host_off(ide_drive_t *drive)
+static void trm290_dma_host_set(ide_drive_t *drive, int on)
 {
 }
=20
@@ -289,8 +285,7 @@ static void __devinit init_hwif_trm290(ide_hwif_t *=
hwif)
=20
 	ide_setup_dma(hwif, (hwif->config_data + 4) ^ (hwif->channel ? 0x0080=
 : 0x0000), 3);
=20
-	hwif->dma_host_off	=3D &trm290_dma_host_off;
-	hwif->dma_host_on	=3D &trm290_dma_host_on;
+	hwif->dma_host_set	=3D &trm290_dma_host_set;
 	hwif->dma_setup 	=3D &trm290_dma_setup;
 	hwif->dma_exec_cmd	=3D &trm290_dma_exec_cmd;
 	hwif->dma_start 	=3D &trm290_dma_start;
diff --git a/drivers/ide/ppc/Makefile b/drivers/ide/ppc/Makefile
new file mode 100644
index 0000000..65af584
--- /dev/null
+++ b/drivers/ide/ppc/Makefile
@@ -0,0 +1,3 @@
+
+obj-$(CONFIG_BLK_DEV_IDE_PMAC)		+=3D pmac.o
+obj-$(CONFIG_BLK_DEV_MPC8xx_IDE)	+=3D mpc8xx.o
diff --git a/drivers/ide/ppc/mpc8xx.c b/drivers/ide/ppc/mpc8xx.c
index 5f0da35..3fd5d45 100644
--- a/drivers/ide/ppc/mpc8xx.c
+++ b/drivers/ide/ppc/mpc8xx.c
@@ -838,3 +838,21 @@ void m8xx_ide_init(void)
 	ppc_ide_md.default_io_base      =3D m8xx_ide_default_io_base;
 	ppc_ide_md.ide_init_hwif        =3D m8xx_ide_init_hwif_ports;
 }
+
+static int __init mpc8xx_ide_probe(void)
+{
+	u8 idx[4] =3D { 0xff, 0xff, 0xff, 0xff };
+
+#ifdef IDE0_BASE_OFFSET
+	idx[0] =3D 0;
+#ifdef IDE1_BASE_OFFSET
+	idx[1] =3D 1;
+#endif
+#endif
+
+	ide_device_add(idx);
+
+	return 0;
+}
+
+module_init(mpc8xx_ide_probe);
diff --git a/drivers/ide/ppc/pmac.c b/drivers/ide/ppc/pmac.c
index 3dce800..736d12c 100644
--- a/drivers/ide/ppc/pmac.c
+++ b/drivers/ide/ppc/pmac.c
@@ -1012,12 +1012,11 @@ pmac_ide_do_resume(ide_hwif_t *hwif)
  * rare machines unfortunately, but it's better this way.
  */
 static int
-pmac_ide_setup_device(pmac_ide_hwif_t *pmif, ide_hwif_t *hwif)
+pmac_ide_setup_device(pmac_ide_hwif_t *pmif, ide_hwif_t *hwif, hw_regs=
_t *hw)
 {
 	struct device_node *np =3D pmif->node;
 	const int *bidp;
 	u8 idx[4] =3D { 0xff, 0xff, 0xff, 0xff };
-	hw_regs_t hw;
=20
 	pmif->cable_80 =3D 0;
 	pmif->broken_dma =3D pmif->broken_dma_warn =3D 0;
@@ -1103,11 +1102,9 @@ pmac_ide_setup_device(pmac_ide_hwif_t *pmif, ide=
_hwif_t *hwif)
 	/* Tell common code _not_ to mess with resources */
 	hwif->mmio =3D 1;
 	hwif->hwif_data =3D pmif;
-	memset(&hw, 0, sizeof(hw));
-	pmac_ide_init_hwif_ports(&hw, pmif->regbase, 0, &hwif->irq);
-	memcpy(hwif->io_ports, hw.io_ports, sizeof(hwif->io_ports));
-	hwif->chipset =3D ide_pmac;
-	hwif->noprobe =3D !hwif->io_ports[IDE_DATA_OFFSET] || pmif->mediabay;
+	hw->chipset =3D ide_pmac;
+	ide_init_port_hw(hwif, hw);
+	hwif->noprobe =3D pmif->mediabay;
 	hwif->hold =3D pmif->mediabay;
 	hwif->cbl =3D pmif->cable_80 ? ATA_CBL_PATA80 : ATA_CBL_PATA40;
 	hwif->drives[0].unmask =3D 1;
@@ -1136,8 +1133,6 @@ pmac_ide_setup_device(pmac_ide_hwif_t *pmif, ide_=
hwif_t *hwif)
 		hwif->noprobe =3D 0;
 #endif /* CONFIG_PMAC_MEDIABAY */
=20
-	hwif->sg_max_nents =3D MAX_DCMDS;
-
 #ifdef CONFIG_BLK_DEV_IDEDMA_PMAC
 	/* has a DBDMA controller channel */
 	if (pmif->dma_regs)
@@ -1163,6 +1158,7 @@ pmac_ide_macio_attach(struct macio_dev *mdev, con=
st struct of_device_id *match)
 	ide_hwif_t *hwif;
 	pmac_ide_hwif_t *pmif;
 	int i, rc;
+	hw_regs_t hw;
=20
 	i =3D 0;
 	while (i < MAX_HWIFS && (ide_hwifs[i].io_ports[IDE_DATA_OFFSET] !=3D =
0
@@ -1205,7 +1201,6 @@ pmac_ide_macio_attach(struct macio_dev *mdev, con=
st struct of_device_id *match)
 	regbase =3D (unsigned long) base;
=20
 	hwif->pci_dev =3D mdev->bus->pdev;
-	hwif->gendev.parent =3D &mdev->ofdev.dev;
=20
 	pmif->mdev =3D mdev;
 	pmif->node =3D mdev->ofdev.node;
@@ -1223,7 +1218,12 @@ pmac_ide_macio_attach(struct macio_dev *mdev, co=
nst struct of_device_id *match)
 #endif /* CONFIG_BLK_DEV_IDEDMA_PMAC */
 	dev_set_drvdata(&mdev->ofdev.dev, hwif);
=20
-	rc =3D pmac_ide_setup_device(pmif, hwif);
+	memset(&hw, 0, sizeof(hw));
+	pmac_ide_init_hwif_ports(&hw, pmif->regbase, 0, NULL);
+	hw.irq =3D irq;
+	hw.dev =3D &mdev->ofdev.dev;
+
+	rc =3D pmac_ide_setup_device(pmif, hwif, &hw);
 	if (rc !=3D 0) {
 		/* The inteface is released to the common IDE layer */
 		dev_set_drvdata(&mdev->ofdev.dev, NULL);
@@ -1282,6 +1282,7 @@ pmac_ide_pci_attach(struct pci_dev *pdev, const s=
truct pci_device_id *id)
 	void __iomem *base;
 	unsigned long rbase, rlen;
 	int i, rc;
+	hw_regs_t hw;
=20
 	np =3D pci_device_to_OF_node(pdev);
 	if (np =3D=3D NULL) {
@@ -1315,7 +1316,6 @@ pmac_ide_pci_attach(struct pci_dev *pdev, const s=
truct pci_device_id *id)
 	}
=20
 	hwif->pci_dev =3D pdev;
-	hwif->gendev.parent =3D &pdev->dev;
 	pmif->mdev =3D NULL;
 	pmif->node =3D np;
=20
@@ -1332,7 +1332,12 @@ pmac_ide_pci_attach(struct pci_dev *pdev, const =
struct pci_device_id *id)
=20
 	pci_set_drvdata(pdev, hwif);
=20
-	rc =3D pmac_ide_setup_device(pmif, hwif);
+	memset(&hw, 0, sizeof(hw));
+	pmac_ide_init_hwif_ports(&hw, pmif->regbase, 0, NULL);
+	hw.irq =3D pdev->irq;
+	hw.dev =3D &pdev->dev;
+
+	rc =3D pmac_ide_setup_device(pmif, hwif, &hw);
 	if (rc !=3D 0) {
 		/* The inteface is released to the common IDE layer */
 		pci_set_drvdata(pdev, NULL);
@@ -1698,11 +1703,7 @@ pmac_ide_dma_test_irq (ide_drive_t *drive)
 	return 1;
 }
=20
-static void pmac_ide_dma_host_off(ide_drive_t *drive)
-{
-}
-
-static void pmac_ide_dma_host_on(ide_drive_t *drive)
+static void pmac_ide_dma_host_set(ide_drive_t *drive, int on)
 {
 }
=20
@@ -1748,15 +1749,14 @@ pmac_ide_setup_dma(pmac_ide_hwif_t *pmif, ide_h=
wif_t *hwif)
 		return;
 	}
=20
-	hwif->dma_off_quietly =3D &ide_dma_off_quietly;
-	hwif->ide_dma_on =3D &__ide_dma_on;
+	hwif->sg_max_nents =3D MAX_DCMDS;
+
+	hwif->dma_host_set =3D &pmac_ide_dma_host_set;
 	hwif->dma_setup =3D &pmac_ide_dma_setup;
 	hwif->dma_exec_cmd =3D &pmac_ide_dma_exec_cmd;
 	hwif->dma_start =3D &pmac_ide_dma_start;
 	hwif->ide_dma_end =3D &pmac_ide_dma_end;
 	hwif->ide_dma_test_irq =3D &pmac_ide_dma_test_irq;
-	hwif->dma_host_off =3D &pmac_ide_dma_host_off;
-	hwif->dma_host_on =3D &pmac_ide_dma_host_on;
 	hwif->dma_timeout =3D &ide_dma_timeout;
 	hwif->dma_lost_irq =3D &pmac_ide_dma_lost_irq;
=20
@@ -1786,3 +1786,5 @@ pmac_ide_setup_dma(pmac_ide_hwif_t *pmif, ide_hwi=
f_t *hwif)
 }
=20
 #endif /* CONFIG_BLK_DEV_IDEDMA_PMAC */
+
+module_init(pmac_ide_probe);
diff --git a/drivers/ide/setup-pci.c b/drivers/ide/setup-pci.c
index d2cd5a3..676c66e 100644
--- a/drivers/ide/setup-pci.c
+++ b/drivers/ide/setup-pci.c
@@ -165,13 +165,17 @@ static unsigned long ide_get_or_set_dma_base(cons=
t struct ide_port_info *d, ide_
=20
 		dma_base =3D pci_resource_start(dev, baridx);
=20
-		if (dma_base =3D=3D 0)
+		if (dma_base =3D=3D 0) {
 			printk(KERN_ERR "%s: DMA base is invalid\n", d->name);
+			return 0;
+		}
 	}
=20
-	if ((d->host_flags & IDE_HFLAG_CS5520) =3D=3D 0 && dma_base) {
+	if (hwif->channel)
+		dma_base +=3D 8;
+
+	if ((d->host_flags & IDE_HFLAG_CS5520) =3D=3D 0) {
 		u8 simplex_stat =3D 0;
-		dma_base +=3D hwif->channel ? 8 : 0;
=20
 		switch(dev->device) {
 			case PCI_DEVICE_ID_AL_M5219:
@@ -359,6 +363,8 @@ static ide_hwif_t *ide_hwif_configure(struct pci_de=
v *dev, const struct ide_port
 	unsigned long ctl =3D 0, base =3D 0;
 	ide_hwif_t *hwif;
 	u8 bootable =3D (d->host_flags & IDE_HFLAG_BOOTABLE) ? 1 : 0;
+	u8 oldnoprobe =3D 0;
+	struct hw_regs_s hw;
=20
 	if ((d->host_flags & IDE_HFLAG_ISA_PORTS) =3D=3D 0) {
 		/*  Possibly we should fail if these checks report true */
@@ -381,26 +387,25 @@ static ide_hwif_t *ide_hwif_configure(struct pci_=
dev *dev, const struct ide_port
 	}
 	if ((hwif =3D ide_match_hwif(base, bootable, d->name)) =3D=3D NULL)
 		return NULL;	/* no room in ide_hwifs[] */
-	if (hwif->io_ports[IDE_DATA_OFFSET] !=3D base ||
-	    hwif->io_ports[IDE_CONTROL_OFFSET] !=3D (ctl | 2)) {
-		hw_regs_t hw;
-
-		memset(&hw, 0, sizeof(hw));
-#ifndef CONFIG_IDE_ARCH_OBSOLETE_INIT
-		ide_std_init_ports(&hw, base, ctl | 2);
-#else
-		ide_init_hwif_ports(&hw, base, ctl | 2, NULL);
-#endif
-		memcpy(hwif->io_ports, hw.io_ports, sizeof(hwif->io_ports));
-		hwif->noprobe =3D !hwif->io_ports[IDE_DATA_OFFSET];
-	}
-	hwif->chipset =3D d->chipset ? d->chipset : ide_pci;
+
+	memset(&hw, 0, sizeof(hw));
+	hw.irq =3D hwif->irq ? hwif->irq : irq;
+	hw.dev =3D &dev->dev;
+	hw.chipset =3D d->chipset ? d->chipset : ide_pci;
+	ide_std_init_ports(&hw, base, ctl | 2);
+
+	if (hwif->io_ports[IDE_DATA_OFFSET] =3D=3D base &&
+	    hwif->io_ports[IDE_CONTROL_OFFSET] =3D=3D (ctl | 2))
+		oldnoprobe =3D hwif->noprobe;
+
+	ide_init_port_hw(hwif, &hw);
+
+	hwif->noprobe =3D oldnoprobe;
+
 	hwif->pci_dev =3D dev;
 	hwif->cds =3D d;
 	hwif->channel =3D port;
=20
-	if (!hwif->irq)
-		hwif->irq =3D irq;
 	if (mate) {
 		hwif->mate =3D mate;
 		mate->mate =3D hwif;
@@ -535,12 +540,8 @@ void ide_pci_setup_ports(struct pci_dev *dev, cons=
t struct ide_port_info *d, int
 		if ((hwif =3D ide_hwif_configure(dev, d, mate, port, pciirq)) =3D=3D=
 NULL)
 			continue;
=20
-		/* setup proper ancestral information */
-		hwif->gendev.parent =3D &dev->dev;
-
 		*(idx + port) =3D hwif->index;
=20
-	=09
 		if (d->init_iops)
 			d->init_iops(hwif);
=20
@@ -551,8 +552,6 @@ void ide_pci_setup_ports(struct pci_dev *dev, const=
 struct ide_port_info *d, int
 		    (d->host_flags & IDE_HFLAG_FORCE_LEGACY_IRQS))
 			hwif->irq =3D port ? 15 : 14;
=20
-		hwif->fixup =3D d->fixup;
-
 		hwif->host_flags =3D d->host_flags;
 		hwif->pio_mask =3D d->pio_mask;
=20
@@ -699,105 +698,3 @@ out:
 }
=20
 EXPORT_SYMBOL_GPL(ide_setup_pci_devices);
-
-#ifdef CONFIG_IDEPCI_PCIBUS_ORDER
-/*
- *	Module interfaces
- */
-
-static int pre_init =3D 1;		/* Before first ordered IDE scan */
-static LIST_HEAD(ide_pci_drivers);
-
-/*
- *	__ide_pci_register_driver	-	attach IDE driver
- *	@driver: pci driver
- *	@module: owner module of the driver
- *
- *	Registers a driver with the IDE layer. The IDE layer arranges that
- *	boot time setup is done in the expected device order and then
- *	hands the controllers off to the core PCI code to do the rest of
- *	the work.
- *
- *	Returns are the same as for pci_register_driver
- */
-
-int __ide_pci_register_driver(struct pci_driver *driver, struct module=
 *module,
-			      const char *mod_name)
-{
-	if (!pre_init)
-		return __pci_register_driver(driver, module, mod_name);
-	driver->driver.owner =3D module;
-	list_add_tail(&driver->node, &ide_pci_drivers);
-	return 0;
-}
-EXPORT_SYMBOL_GPL(__ide_pci_register_driver);
-
-/**
- *	ide_scan_pcidev		-	find an IDE driver for a device
- *	@dev: PCI device to check
- *
- *	Look for an IDE driver to handle the device we are considering.
- *	This is only used during boot up to get the ordering correct. After
- *	boot up the pci layer takes over the job.
- */
-
-static int __init ide_scan_pcidev(struct pci_dev *dev)
-{
-	struct list_head *l;
-	struct pci_driver *d;
-
-	list_for_each(l, &ide_pci_drivers) {
-		d =3D list_entry(l, struct pci_driver, node);
-		if (d->id_table) {
-			const struct pci_device_id *id =3D
-				pci_match_id(d->id_table, dev);
-
-			if (id !=3D NULL && d->probe(dev, id) >=3D 0) {
-				dev->driver =3D d;
-				pci_dev_get(dev);
-				return 1;
-			}
-		}
-	}
-	return 0;
-}
-
-/**
- *	ide_scan_pcibus		-	perform the initial IDE driver scan
- *	@scan_direction: set for reverse order scanning
- *
- *	Perform the initial bus rather than driver ordered scan of the
- *	PCI drivers. After this all IDE pci handling becomes standard
- *	module ordering not traditionally ordered.
- */
- =09
-void __init ide_scan_pcibus (int scan_direction)
-{
-	struct pci_dev *dev =3D NULL;
-	struct pci_driver *d;
-	struct list_head *l, *n;
-
-	pre_init =3D 0;
-	if (!scan_direction)
-		while ((dev =3D pci_get_device(PCI_ANY_ID, PCI_ANY_ID, dev)))
-			ide_scan_pcidev(dev);
-	else
-		while ((dev =3D pci_get_device_reverse(PCI_ANY_ID, PCI_ANY_ID,
-						     dev)))
-			ide_scan_pcidev(dev);
-
-	/*
-	 *	Hand the drivers over to the PCI layer now we
-	 *	are post init.
-	 */
-
-	list_for_each_safe(l, n, &ide_pci_drivers) {
-		list_del(l);
-		d =3D list_entry(l, struct pci_driver, node);
-		if (__pci_register_driver(d, d->driver.owner,
-					  d->driver.mod_name))
-			printk(KERN_ERR "%s: failed to register %s driver\n",
-					__FUNCTION__, d->driver.mod_name);
-	}
-}
-#endif
diff --git a/drivers/macintosh/mediabay.c b/drivers/macintosh/mediabay.=
c
index 48d647a..eaba4a9 100644
--- a/drivers/macintosh/mediabay.c
+++ b/drivers/macintosh/mediabay.c
@@ -563,7 +563,8 @@ static void media_bay_step(int i)
 				ide_init_hwif_ports(&hw, (unsigned long) bay->cd_base, (unsigned l=
ong) 0, NULL);
 				hw.irq =3D bay->cd_irq;
 				hw.chipset =3D ide_pmac;
-				bay->cd_index =3D ide_register_hw(&hw, NULL, 0, NULL);
+				bay->cd_index =3D
+					ide_register_hw(&hw, NULL, NULL);
 				pmu_resume();
 			}
 			if (bay->cd_index =3D=3D -1) {
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index bd20a4e..49b7a4c 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -143,7 +143,6 @@ enum rq_cmd_type_bits {
 	 * use REQ_TYPE_SPECIAL and use rq->cmd[0] with the range of driver
 	 * private REQ_LB opcodes to differentiate what type of request this =
is
 	 */
-	REQ_TYPE_ATA_CMD,
 	REQ_TYPE_ATA_TASKFILE,
 	REQ_TYPE_ATA_PC,
 };
diff --git a/include/linux/ide.h b/include/linux/ide.h
index 1e44099..27cb39d 100644
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -107,7 +107,6 @@ typedef unsigned char	byte;	/* used everywhere */
 #define BAD_W_STAT		(BAD_R_STAT  | WRERR_STAT)
 #define BAD_STAT		(BAD_R_STAT  | DRQ_STAT)
 #define DRIVE_READY		(READY_STAT  | SEEK_STAT)
-#define DATA_READY		(DRQ_STAT)
=20
 #define BAD_CRC			(ABRT_ERR    | ICRC_ERR)
=20
@@ -198,8 +197,11 @@ typedef struct hw_regs_s {
 } hw_regs_t;
=20
 struct hwif_s * ide_find_port(unsigned long);
+void ide_init_port_data(struct hwif_s *, unsigned int);
+void ide_init_port_hw(struct hwif_s *, hw_regs_t *);
=20
-int ide_register_hw(hw_regs_t *, void (*)(struct hwif_s *), int,
+struct ide_drive_s;
+int ide_register_hw(hw_regs_t *, void (*)(struct ide_drive_s *),
 		    struct hwif_s **);
=20
 void ide_setup_ports(	hw_regs_t *hw,
@@ -391,7 +393,6 @@ typedef struct ide_drive_s {
 	u8	state;			/* retry state */
 	u8	waiting_for_dma;	/* dma currently in progress */
 	u8	unmask;			/* okay to unmask other irqs */
-	u8	bswap;			/* byte swap data */
 	u8	noflush;		/* don't attempt flushes */
 	u8	dsc_overlap;		/* DSC overlap */
 	u8	nice1;			/* give potential excess bandwidth */
@@ -527,31 +528,26 @@ typedef struct hwif_s {
 	/* special host masking for drive selection */
 	void	(*maskproc)(ide_drive_t *, int);
 	/* check host's drive quirk list */
-	int	(*quirkproc)(ide_drive_t *);
+	void	(*quirkproc)(ide_drive_t *);
 	/* driver soft-power interface */
 	int	(*busproc)(ide_drive_t *, int);
 #endif
 	u8 (*mdma_filter)(ide_drive_t *);
 	u8 (*udma_filter)(ide_drive_t *);
=20
-	void (*fixup)(struct hwif_s *);
-
 	void (*ata_input_data)(ide_drive_t *, void *, u32);
 	void (*ata_output_data)(ide_drive_t *, void *, u32);
=20
 	void (*atapi_input_bytes)(ide_drive_t *, void *, u32);
 	void (*atapi_output_bytes)(ide_drive_t *, void *, u32);
=20
+	void (*dma_host_set)(ide_drive_t *, int);
 	int (*dma_setup)(ide_drive_t *);
 	void (*dma_exec_cmd)(ide_drive_t *, u8);
 	void (*dma_start)(ide_drive_t *);
 	int (*ide_dma_end)(ide_drive_t *drive);
-	int (*ide_dma_on)(ide_drive_t *drive);
-	void (*dma_off_quietly)(ide_drive_t *drive);
 	int (*ide_dma_test_irq)(ide_drive_t *drive);
 	void (*ide_dma_clear_irq)(ide_drive_t *drive);
-	void (*dma_host_on)(ide_drive_t *drive);
-	void (*dma_host_off)(ide_drive_t *drive);
 	void (*dma_lost_irq)(ide_drive_t *drive);
 	void (*dma_timeout)(ide_drive_t *drive);
=20
@@ -874,14 +870,6 @@ extern int ide_do_drive_cmd(ide_drive_t *, struct =
request *, ide_action_t);
=20
 extern void ide_end_drive_cmd(ide_drive_t *, u8, u8);
=20
-/*
- * Issue ATA command and wait for completion.
- * Use for implementing commands in kernel
- *
- *  (ide_drive_t *drive, u8 cmd, u8 nsect, u8 feature, u8 sectors, u8 =
*buf)
- */
-extern int ide_wait_cmd(ide_drive_t *, u8, u8, u8, u8, u8 *);
-
 enum {
 	IDE_TFLAG_LBA48			=3D (1 << 0),
 	IDE_TFLAG_NO_SELECT_MASK	=3D (1 << 1),
@@ -934,6 +922,14 @@ enum {
 	IDE_TFLAG_IN_TF			=3D IDE_TFLAG_IN_NSECT |
 					  IDE_TFLAG_IN_LBA,
 	IDE_TFLAG_IN_DEVICE		=3D (1 << 29),
+	IDE_TFLAG_HOB			=3D IDE_TFLAG_OUT_HOB |
+					  IDE_TFLAG_IN_HOB,
+	IDE_TFLAG_TF			=3D IDE_TFLAG_OUT_TF |
+					  IDE_TFLAG_IN_TF,
+	IDE_TFLAG_DEVICE		=3D IDE_TFLAG_OUT_DEVICE |
+					  IDE_TFLAG_IN_DEVICE,
+	/* force 16-bit I/O operations */
+	IDE_TFLAG_IO_16BIT		=3D (1 << 30),
 };
=20
 struct ide_taskfile {
@@ -988,6 +984,10 @@ void ide_pktcmd_tf_load(ide_drive_t *, u32, u16, u=
8);
=20
 ide_startstop_t do_rw_taskfile(ide_drive_t *, ide_task_t *);
=20
+void task_end_request(ide_drive_t *, struct request *, u8);
+
+u8 wait_drive_not_busy(ide_drive_t *);
+
 int ide_raw_taskfile(ide_drive_t *, ide_task_t *, u8 *, u16);
 int ide_no_data_taskfile(ide_drive_t *, ide_task_t *);
=20
@@ -1015,10 +1015,9 @@ extern void do_ide_request(struct request_queue =
*);
=20
 void ide_init_disk(struct gendisk *, ide_drive_t *);
=20
-extern int ideprobe_init(void);
-
 #ifdef CONFIG_IDEPCI_PCIBUS_ORDER
-extern void ide_scan_pcibus(int scan_direction) __init;
+extern int ide_scan_direction;
+int __init ide_scan_pcibus(void);
 extern int __ide_pci_register_driver(struct pci_driver *driver, struct=
 module *owner, const char *mod_name);
 #define ide_pci_register_driver(d) __ide_pci_register_driver(d, THIS_M=
ODULE, KBUILD_MODNAME)
 #else
@@ -1095,6 +1094,8 @@ enum {
 	/* unmask IRQs */
 	IDE_HFLAG_UNMASK_IRQS		=3D (1 << 25),
 	IDE_HFLAG_ABUSE_SET_DMA_MODE	=3D (1 << 26),
+	/* host is CY82C693 */
+	IDE_HFLAG_CY82C693		=3D (1 << 27),
 };
=20
 #ifdef CONFIG_BLK_DEV_OFFBOARD
@@ -1109,7 +1110,6 @@ struct ide_port_info {
 	void			(*init_iops)(ide_hwif_t *);
 	void                    (*init_hwif)(ide_hwif_t *);
 	void			(*init_dma)(ide_hwif_t *, unsigned long);
-	void			(*fixup)(ide_hwif_t *);
 	ide_pci_enablebit_t	enablebits[2];
 	hwif_chipset_t		chipset;
 	u8			extra;
@@ -1147,7 +1147,9 @@ static inline u8 ide_max_dma_mode(ide_drive_t *dr=
ive)
 	return ide_find_dma_mode(drive, XFER_UDMA_6);
 }
=20
+void ide_dma_off_quietly(ide_drive_t *);
 void ide_dma_off(ide_drive_t *);
+void ide_dma_on(ide_drive_t *);
 int ide_set_dma(ide_drive_t *);
 ide_startstop_t ide_dma_intr(ide_drive_t *);
=20
@@ -1158,10 +1160,7 @@ extern void ide_destroy_dmatable(ide_drive_t *);
 extern int ide_release_dma(ide_hwif_t *);
 extern void ide_setup_dma(ide_hwif_t *, unsigned long, unsigned int);
=20
-void ide_dma_host_off(ide_drive_t *);
-void ide_dma_off_quietly(ide_drive_t *);
-void ide_dma_host_on(ide_drive_t *);
-extern int __ide_dma_on(ide_drive_t *);
+void ide_dma_host_set(ide_drive_t *, int);
 extern int ide_dma_setup(ide_drive_t *);
 extern void ide_dma_start(ide_drive_t *);
 extern int __ide_dma_end(ide_drive_t *);
@@ -1173,7 +1172,9 @@ extern void ide_dma_timeout(ide_drive_t *);
 static inline int ide_id_dma_bug(ide_drive_t *drive) { return 0; }
 static inline u8 ide_find_dma_mode(ide_drive_t *drive, u8 speed) { ret=
urn 0; }
 static inline u8 ide_max_dma_mode(ide_drive_t *drive) { return 0; }
+static inline void ide_dma_off_quietly(ide_drive_t *drive) { ; }
 static inline void ide_dma_off(ide_drive_t *drive) { ; }
+static inline void ide_dma_on(ide_drive_t *drive) { ; }
 static inline void ide_dma_verbose(ide_drive_t *drive) { ; }
 static inline int ide_set_dma(ide_drive_t *drive) { return 1; }
 #endif /* CONFIG_BLK_DEV_IDEDMA */
@@ -1203,8 +1204,9 @@ extern void ide_unregister (unsigned int index);
 void ide_register_region(struct gendisk *);
 void ide_unregister_region(struct gendisk *);
=20
-void ide_undecoded_slave(ide_hwif_t *);
+void ide_undecoded_slave(ide_drive_t *);
=20
+int ide_device_add_all(u8 *idx);
 int ide_device_add(u8 idx[4]);
=20
 static inline void *ide_get_hwifdata (ide_hwif_t * hwif)
@@ -1302,4 +1304,9 @@ static inline ide_drive_t *ide_get_paired_drive(i=
de_drive_t *drive)
 	return &hwif->drives[(drive->dn ^ 1) & 1];
 }
=20
+static inline void ide_set_irq(ide_drive_t *drive, int on)
+{
+	drive->hwif->OUTB(drive->ctl | (on ? 0 : 2), IDE_CONTROL_REG);
+}
+
 #endif /* _IDE_H */
