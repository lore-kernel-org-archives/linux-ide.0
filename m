From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [git patches] IDE updates part #1
Date: Fri, 25 Jan 2008 22:51:31 +0100
Message-ID: <200801252251.31596.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.190]:27768 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755194AbYAYVkL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 25 Jan 2008 16:40:11 -0500
Received: by fk-out-0910.google.com with SMTP id z23so776886fkz.5
        for <linux-ide@vger.kernel.org>; Fri, 25 Jan 2008 13:40:08 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org


Hi,

What's inside:

* hpt366 host driver cleanups (Sergei Shtylyov)

* ide-cd oops fix for dead drives (Aristeu Rozanski)

* unify handling of REQ_TYPE_ATA_TASK and REQ_TYPE_ATA_TASKFILE request=
s
  (me, heavily based on the earlier patches from Tejun Heo)

* unify LBA28 and LBA48 HPA handling in ide-disk device driver (me)

* cleanups all over the map - remove needless typedefs, dead code, etc.=
,
  and some bugfixes discovered in the process (me)

Extra thanks to Sergei for feedback and reviewing majority of patches!


Linus, please pull from:

master.kernel.org:/pub/scm/linux/kernel/git/bart/ide-2.6.git/

to receive the following updates:

 drivers/ide/Kconfig             |   12 -
 drivers/ide/arm/icside.c        |    2 -
 drivers/ide/cris/ide-cris.c     |    2 -
 drivers/ide/ide-acpi.c          |   16 +-
 drivers/ide/ide-cd.c            |   12 +-
 drivers/ide/ide-disk.c          |  418 ++++++++++++++-----------------=
--
 drivers/ide/ide-dma.c           |   36 +--
 drivers/ide/ide-floppy.c        |  123 ++++-------
 drivers/ide/ide-io.c            |  293 +++++++++++------------
 drivers/ide/ide-iops.c          |   50 +---
 drivers/ide/ide-lib.c           |  207 ++++++++---------
 drivers/ide/ide-probe.c         |   32 +--
 drivers/ide/ide-tape.c          |  124 ++++------
 drivers/ide/ide-taskfile.c      |  492 +++++++++++++++++++------------=
-------
 drivers/ide/ide.c               |    6 +-
 drivers/ide/mips/au1xxx-ide.c   |    2 -
 drivers/ide/pci/aec62xx.c       |   13 +-
 drivers/ide/pci/alim15x3.c      |    3 -
 drivers/ide/pci/amd74xx.c       |    1 +
 drivers/ide/pci/atiixp.c        |    3 -
 drivers/ide/pci/cmd64x.c        |   10 +-
 drivers/ide/pci/cs5520.c        |    1 +
 drivers/ide/pci/cs5530.c        |    2 -
 drivers/ide/pci/cs5535.c        |    2 +-
 drivers/ide/pci/hpt34x.c        |   12 +-
 drivers/ide/pci/hpt366.c        |  194 +++++++---------
 drivers/ide/pci/it8213.c        |   21 +--
 drivers/ide/pci/pdc202xx_new.c  |   64 ++----
 drivers/ide/pci/pdc202xx_old.c  |   24 +-
 drivers/ide/pci/piix.c          |   17 +-
 drivers/ide/pci/sc1200.c        |  172 +++++---------
 drivers/ide/pci/scc_pata.c      |   14 +-
 drivers/ide/pci/serverworks.c   |   17 +-
 drivers/ide/pci/sgiioc4.c       |    1 -
 drivers/ide/pci/siimage.c       |   29 +--
 drivers/ide/pci/sis5513.c       |   99 ++++----
 drivers/ide/pci/sl82c105.c      |   40 ++--
 drivers/ide/pci/slc90e66.c      |   14 +-
 drivers/ide/pci/tc86c001.c      |    3 +-
 drivers/ide/pci/triflex.c       |    2 -
 drivers/ide/pci/via82cxxx.c     |    1 +
 drivers/ide/ppc/pmac.c          |   51 ++---
 drivers/scsi/ide-scsi.c         |   75 +++---
 include/asm-cris/arch-v10/ide.h |    5 -
 include/asm-cris/arch-v32/ide.h |    5 -
 include/asm-frv/ide.h           |    6 -
 include/asm-powerpc/ide.h       |    3 -
 include/linux/blkdev.h          |    1 -
 include/linux/hdreg.h           |   64 +++---
 include/linux/ide.h             |  322 ++++++++-----------------
 50 files changed, 1265 insertions(+), 1853 deletions(-)


Andrew Morton (1):
      ide: printk fix

Aristeu Rozanski (1):
      ide-io: set REQ_FAILED when drive is dead

Bartlomiej Zolnierkiewicz (62):
      ide: remove ->dma_master field from ide_hwif_t (take 5)
      ide: remove task_ioreg_t typedef (take 2)
      ide: add struct ide_taskfile (take 2)
      ide-disk: merge LBA28 and LBA48 Host Protected Area support code =
(take 2)
      ide-disk: fix taskfile registers loading order in __ide_do_rw_dis=
k()
      ide-disk: use struct ide_taskfile in __ide_do_rw_disk()
      ide: add ide_tf_load() helper
      ide: add ide_no_data_taskfile() helper
      ide: use do_rw_taskfile() in flagged_taskfile()
      ide-pmac: fix pmac_ide_init_hwif_ports()
      ide: remove IRQF_DISABLED from IRQ flags for IDE IRQ handler
      ide: remove CONFIG_IDEPCI_SHARE_IRQ config option
      ide: remove stale ide.h "configuration options"
      ide-tape: remove dead USE_IOTRACE code
      ide: fix registers loading order for WIN_SMART in execute_drive_c=
md()
      ide: fix registers loading order for IDE_NSECTOR_REG in execute_d=
rive_cmd()
      ide: execute_drive_cmd() cleanup
      ide: remove ide_cmd() helper
      ide: use ide_tf_load() in execute_drive_cmd()
      ide: use IDE_TFLAG_LBA48 for REQ_TYPE_ATA_TASKFILE requests
      ide: remove unnecessary writes to HOB taskfile registers
      ide: extend timeout for REQ_TYPE_ATA_{CMD,TASK} requests
      ide: switch idedisk_prepare_flush() to use REQ_TYPE_ATA_TASKFILE =
requests
      ide: switch ide_task_ioctl() to use REQ_TYPE_ATA_TASKFILE request=
s
      ide: remove REQ_TYPE_ATA_TASK
      ide-floppy: remove dead code
      ide: CPU endianness doesn't matter for special_t
      ide: remove ata_status_t and atapi_status_t
      ide: remove atapi_error_t (take 2)
      ide: remove atapi_feature_t
      ide: remove ata_nsector_t, ata_data_t and atapi_bcount_t
      ide: remove atapi_ireason_t (take 3)
      ide-cd: fix register loading order in cdrom_start_packet_command(=
)
      ide-{floppy,tape,scsi}: fix register loading order when issuing p=
acket command
      ide: add ide_pktcmd_tf_load() helper
      ide: remove QUIRK_LIST()
      ide: remove SELECT_INTERRUPT()
      ide: remove hwif->intrproc
      ide: remove 'command_type' field from ide_task_t
      ide: remove 'tf_in_flags' field from ide_task_t
      sc1200: remove pointless hwif lookup loop
      ide-disk: fix __ide_do_rw_disk() to use ->OUTBSYNC
      ide-disk: guarantee 400ns delay after writing command register
      ide: merge flagged_taskfile() into do_rw_taskfile()
      ide: convert do_rw_taskfile() to use ->data_phase
      ide: use ->data_phase to set ->handler in do_rw_taskfile()
      ide: remove 'handler' field from ide_task_t (take 2)
      ide-disk: extend timeout for PIO-in commands
      ide-disk: add ide_tf_set_cmd() helper
      ide-disk: use do_rw_taskfile() (take 2)
      ide: fix registers loading order in ide_dump_ata_status()
      ide: add ide_tf_read() helper
      ide-disk: use ide_get_lba_addr()
      ide: kill duplicate code in ide_dump_{ata,atapi}_status()
      ide: make 'extra' field in struct ide_port_info u8
      pdc202xx_new: move PIO programming code to pdcnew_set_pio_mode()
      sis5513: factor out UDMA programming code
      ide: add IDE_HFLAG_ABUSE_SET_DMA_MODE host flag
      sc1200: move DMA timings to timing tables
      ide: remove redundant ->ide_dma_on call from set_using_dma()
      ide: cleanup ide_set_dma()
      ide: remove redundant DMA blacklist check from __ide_dma_on()

Sergei Shtylyov (3):
      hpt366: change timing register masks
      hpt366: kill set_dma_mode() method wrapper
      hpt366: merge set_dma_mode() methods


diff --git a/drivers/ide/Kconfig b/drivers/ide/Kconfig
index fb06555..ee01e27 100644
--- a/drivers/ide/Kconfig
+++ b/drivers/ide/Kconfig
@@ -374,17 +374,6 @@ comment "PCI IDE chipsets support"
 config BLK_DEV_IDEPCI
 	bool
=20
-config IDEPCI_SHARE_IRQ
-	bool "Sharing PCI IDE interrupts support"
-	depends on BLK_DEV_IDEPCI
-	help
-	  Some ATA/IDE chipsets have hardware support which allows for
-	  sharing a single IRQ with other cards. To enable support for
-	  this in the ATA/IDE driver, say Y here.
-
-	  It is safe to say Y to this question, in most cases.
-	  If unsure, say N.
-
 config IDEPCI_PCIBUS_ORDER
 	def_bool BLK_DEV_IDE=3Dy && BLK_DEV_IDEPCI
=20
@@ -707,7 +696,6 @@ config BLK_DEV_SVWKS
 config BLK_DEV_SGIIOC4
 	tristate "Silicon Graphics IOC4 chipset ATA/ATAPI support"
 	depends on (IA64_SGI_SN2 || IA64_GENERIC) && SGI_IOC4
-	select IDEPCI_SHARE_IRQ
 	select BLK_DEV_IDEDMA_PCI
 	help
 	  This driver adds PIO & MultiMode DMA-2 support for the SGI IOC4
diff --git a/drivers/ide/arm/icside.c b/drivers/ide/arm/icside.c
index 93f71fc..673402f 100644
--- a/drivers/ide/arm/icside.c
+++ b/drivers/ide/arm/icside.c
@@ -272,8 +272,6 @@ static void icside_set_dma_mode(ide_drive_t *drive,=
 const u8 xfer_mode)
 	case XFER_SW_DMA_0:
 		cycle_time =3D 480;
 		break;
-	default:
-		return;
 	}
=20
 	/*
diff --git a/drivers/ide/cris/ide-cris.c b/drivers/ide/cris/ide-cris.c
index 476e0d6..325e608 100644
--- a/drivers/ide/cris/ide-cris.c
+++ b/drivers/ide/cris/ide-cris.c
@@ -747,8 +747,6 @@ static void cris_set_dma_mode(ide_drive_t *drive, c=
onst u8 speed)
 			strobe =3D ATA_DMA2_STROBE;
 			hold =3D ATA_DMA2_HOLD;
 			break;
-		default:
-			return;
 	}
=20
 	if (speed >=3D XFER_UDMA_0)
diff --git a/drivers/ide/ide-acpi.c b/drivers/ide/ide-acpi.c
index 899d565..e0bb0cf 100644
--- a/drivers/ide/ide-acpi.c
+++ b/drivers/ide/ide-acpi.c
@@ -383,27 +383,19 @@ static int taskfile_load_raw(ide_drive_t *drive,
 	       gtf->tfa[3], gtf->tfa[4], gtf->tfa[5], gtf->tfa[6]);
=20
 	memset(&args, 0, sizeof(ide_task_t));
-	args.command_type =3D IDE_DRIVE_TASK_NO_DATA;
-	args.data_phase   =3D TASKFILE_NO_DATA;
-	args.handler      =3D &task_no_data_intr;
=20
 	/* convert gtf to IDE Taskfile */
-	args.tfRegister[1] =3D gtf->tfa[0];	/* 0x1f1 */
-	args.tfRegister[2] =3D gtf->tfa[1];	/* 0x1f2 */
-	args.tfRegister[3] =3D gtf->tfa[2];	/* 0x1f3 */
-	args.tfRegister[4] =3D gtf->tfa[3];	/* 0x1f4 */
-	args.tfRegister[5] =3D gtf->tfa[4];	/* 0x1f5 */
-	args.tfRegister[6] =3D gtf->tfa[5];	/* 0x1f6 */
-	args.tfRegister[7] =3D gtf->tfa[6];	/* 0x1f7 */
+	memcpy(&args.tf_array[7], &gtf->tfa, 7);
+	args.tf_flags =3D IDE_TFLAG_OUT_TF | IDE_TFLAG_OUT_DEVICE;
=20
 	if (ide_noacpitfs) {
 		DEBPRINT("_GTF execution disabled\n");
 		return err;
 	}
=20
-	err =3D ide_raw_taskfile(drive, &args, NULL);
+	err =3D ide_no_data_taskfile(drive, &args);
 	if (err)
-		printk(KERN_ERR "%s: ide_raw_taskfile failed: %u\n",
+		printk(KERN_ERR "%s: ide_no_data_taskfile failed: %u\n",
 		       __FUNCTION__, err);
=20
 	return err;
diff --git a/drivers/ide/ide-cd.c b/drivers/ide/ide-cd.c
index c7d77f0..44b033e 100644
--- a/drivers/ide/ide-cd.c
+++ b/drivers/ide/ide-cd.c
@@ -917,19 +917,13 @@ static ide_startstop_t cdrom_start_packet_command=
(ide_drive_t *drive,
 	if (ide_wait_stat(&startstop, drive, 0, BUSY_STAT, WAIT_READY))
 		return startstop;
=20
+	/* FIXME: for Virtual DMA we must check harder */
 	if (info->dma)
 		info->dma =3D !hwif->dma_setup(drive);
=20
 	/* Set up the controller registers. */
-	/* FIXME: for Virtual DMA we must check harder */
-	HWIF(drive)->OUTB(info->dma, IDE_FEATURE_REG);
-	HWIF(drive)->OUTB(0, IDE_IREASON_REG);
-	HWIF(drive)->OUTB(0, IDE_SECTOR_REG);
-
-	HWIF(drive)->OUTB(xferlen & 0xff, IDE_BCOUNTL_REG);
-	HWIF(drive)->OUTB(xferlen >> 8  , IDE_BCOUNTH_REG);
-	if (IDE_CONTROL_REG)
-		HWIF(drive)->OUTB(drive->ctl, IDE_CONTROL_REG);
+	ide_pktcmd_tf_load(drive, IDE_TFLAG_OUT_NSECT | IDE_TFLAG_OUT_LBAL |
+			   IDE_TFLAG_NO_SELECT_MASK, xferlen, info->dma);
 =20
 	if (CDROM_CONFIG_FLAGS (drive)->drq_interrupt) {
 		/* waiting for CDB interrupt, not DMA yet. */
diff --git a/drivers/ide/ide-disk.c b/drivers/ide/ide-disk.c
index b178190..d8fdd86 100644
--- a/drivers/ide/ide-disk.c
+++ b/drivers/ide/ide-disk.c
@@ -129,6 +129,50 @@ static int lba_capacity_is_ok (struct hd_driveid *=
id)
 	return 0;	/* lba_capacity value may be bad */
 }
=20
+static const u8 ide_rw_cmds[] =3D {
+	WIN_MULTREAD,
+	WIN_MULTWRITE,
+	WIN_MULTREAD_EXT,
+	WIN_MULTWRITE_EXT,
+	WIN_READ,
+	WIN_WRITE,
+	WIN_READ_EXT,
+	WIN_WRITE_EXT,
+	WIN_READDMA,
+	WIN_WRITEDMA,
+	WIN_READDMA_EXT,
+	WIN_WRITEDMA_EXT,
+};
+
+static const u8 ide_data_phases[] =3D {
+	TASKFILE_MULTI_IN,
+	TASKFILE_MULTI_OUT,
+	TASKFILE_IN,
+	TASKFILE_OUT,
+	TASKFILE_IN_DMA,
+	TASKFILE_OUT_DMA,
+};
+
+static void ide_tf_set_cmd(ide_drive_t *drive, ide_task_t *task, u8 dm=
a)
+{
+	u8 index, lba48, write;
+
+	lba48 =3D (task->tf_flags & IDE_TFLAG_LBA48) ? 2 : 0;
+	write =3D (task->tf_flags & IDE_TFLAG_WRITE) ? 1 : 0;
+
+	if (dma)
+		index =3D drive->vdma ? 4 : 8;
+	else
+		index =3D drive->mult_count ? 0 : 4;
+
+	task->tf.command =3D ide_rw_cmds[index + lba48 + write];
+
+	if (dma)
+		index =3D 8; /* fixup index */
+
+	task->data_phase =3D ide_data_phases[index / 2 + write];
+}
+
 /*
  * __ide_do_rw_disk() issues READ and WRITE commands to a disk,
  * using LBA if supported, or CHS otherwise, to address sectors.
@@ -137,11 +181,11 @@ static ide_startstop_t __ide_do_rw_disk(ide_drive=
_t *drive, struct request *rq,
 {
 	ide_hwif_t *hwif	=3D HWIF(drive);
 	unsigned int dma	=3D drive->using_dma;
+	u16 nsectors		=3D (u16)rq->nr_sectors;
 	u8 lba48		=3D (drive->addressing =3D=3D 1) ? 1 : 0;
-	task_ioreg_t command	=3D WIN_NOP;
-	ata_nsector_t		nsectors;
-
-	nsectors.all		=3D (u16) rq->nr_sectors;
+	ide_task_t		task;
+	struct ide_taskfile	*tf =3D &task.tf;
+	ide_startstop_t		rc;
=20
 	if ((hwif->host_flags & IDE_HFLAG_NO_LBA48_DMA) && lba48 && dma) {
 		if (block + rq->nr_sectors > 1ULL << 28)
@@ -155,121 +199,76 @@ static ide_startstop_t __ide_do_rw_disk(ide_driv=
e_t *drive, struct request *rq,
 		ide_map_sg(drive, rq);
 	}
=20
-	if (IDE_CONTROL_REG)
-		hwif->OUTB(drive->ctl, IDE_CONTROL_REG);
-
-	/* FIXME: SELECT_MASK(drive, 0) ? */
+	memset(&task, 0, sizeof(task));
+	task.tf_flags =3D IDE_TFLAG_NO_SELECT_MASK;  /* FIXME? */
+	task.tf_flags |=3D (IDE_TFLAG_OUT_TF | IDE_TFLAG_OUT_DEVICE);
=20
 	if (drive->select.b.lba) {
 		if (lba48) {
-			task_ioreg_t tasklets[10];
-
 			pr_debug("%s: LBA=3D0x%012llx\n", drive->name,
 					(unsigned long long)block);
=20
-			tasklets[0] =3D 0;
-			tasklets[1] =3D 0;
-			tasklets[2] =3D nsectors.b.low;
-			tasklets[3] =3D nsectors.b.high;
-			tasklets[4] =3D (task_ioreg_t) block;
-			tasklets[5] =3D (task_ioreg_t) (block>>8);
-			tasklets[6] =3D (task_ioreg_t) (block>>16);
-			tasklets[7] =3D (task_ioreg_t) (block>>24);
-			if (sizeof(block) =3D=3D 4) {
-				tasklets[8] =3D (task_ioreg_t) 0;
-				tasklets[9] =3D (task_ioreg_t) 0;
-			} else {
-				tasklets[8] =3D (task_ioreg_t)((u64)block >> 32);
-				tasklets[9] =3D (task_ioreg_t)((u64)block >> 40);
+			tf->hob_nsect =3D (nsectors >> 8) & 0xff;
+			tf->hob_lbal  =3D (u8)(block >> 24);
+			if (sizeof(block) !=3D 4) {
+				tf->hob_lbam =3D (u8)((u64)block >> 32);
+				tf->hob_lbah =3D (u8)((u64)block >> 40);
 			}
+
+			tf->nsect  =3D nsectors & 0xff;
+			tf->lbal   =3D (u8) block;
+			tf->lbam   =3D (u8)(block >>  8);
+			tf->lbah   =3D (u8)(block >> 16);
 #ifdef DEBUG
 			printk("%s: 0x%02x%02x 0x%02x%02x%02x%02x%02x%02x\n",
-				drive->name, tasklets[3], tasklets[2],
-				tasklets[9], tasklets[8], tasklets[7],
-				tasklets[6], tasklets[5], tasklets[4]);
+				drive->name, tf->hob_nsect, tf->nsect,
+				tf->hob_lbah, tf->hob_lbam, tf->hob_lbal,
+				tf->lbah, tf->lbam, tf->lbal);
 #endif
-			hwif->OUTB(tasklets[1], IDE_FEATURE_REG);
-			hwif->OUTB(tasklets[3], IDE_NSECTOR_REG);
-			hwif->OUTB(tasklets[7], IDE_SECTOR_REG);
-			hwif->OUTB(tasklets[8], IDE_LCYL_REG);
-			hwif->OUTB(tasklets[9], IDE_HCYL_REG);
-
-			hwif->OUTB(tasklets[0], IDE_FEATURE_REG);
-			hwif->OUTB(tasklets[2], IDE_NSECTOR_REG);
-			hwif->OUTB(tasklets[4], IDE_SECTOR_REG);
-			hwif->OUTB(tasklets[5], IDE_LCYL_REG);
-			hwif->OUTB(tasklets[6], IDE_HCYL_REG);
-			hwif->OUTB(0x00|drive->select.all,IDE_SELECT_REG);
+			task.tf_flags |=3D (IDE_TFLAG_LBA48 | IDE_TFLAG_OUT_HOB);
 		} else {
-			hwif->OUTB(0x00, IDE_FEATURE_REG);
-			hwif->OUTB(nsectors.b.low, IDE_NSECTOR_REG);
-			hwif->OUTB(block, IDE_SECTOR_REG);
-			hwif->OUTB(block>>=3D8, IDE_LCYL_REG);
-			hwif->OUTB(block>>=3D8, IDE_HCYL_REG);
-			hwif->OUTB(((block>>8)&0x0f)|drive->select.all,IDE_SELECT_REG);
+			tf->nsect  =3D nsectors & 0xff;
+			tf->lbal   =3D block;
+			tf->lbam   =3D block >>=3D 8;
+			tf->lbah   =3D block >>=3D 8;
+			tf->device =3D (block >> 8) & 0xf;
 		}
 	} else {
 		unsigned int sect,head,cyl,track;
 		track =3D (int)block / drive->sect;
 		sect  =3D (int)block % drive->sect + 1;
-		hwif->OUTB(sect, IDE_SECTOR_REG);
 		head  =3D track % drive->head;
 		cyl   =3D track / drive->head;
=20
 		pr_debug("%s: CHS=3D%u/%u/%u\n", drive->name, cyl, head, sect);
=20
-		hwif->OUTB(0x00, IDE_FEATURE_REG);
-		hwif->OUTB(nsectors.b.low, IDE_NSECTOR_REG);
-		hwif->OUTB(cyl, IDE_LCYL_REG);
-		hwif->OUTB(cyl>>8, IDE_HCYL_REG);
-		hwif->OUTB(head|drive->select.all,IDE_SELECT_REG);
+		tf->nsect  =3D nsectors & 0xff;
+		tf->lbal   =3D sect;
+		tf->lbam   =3D cyl;
+		tf->lbah   =3D cyl >> 8;
+		tf->device =3D head;
 	}
=20
-	if (dma) {
-		if (!hwif->dma_setup(drive)) {
-			if (rq_data_dir(rq)) {
-				command =3D lba48 ? WIN_WRITEDMA_EXT : WIN_WRITEDMA;
-				if (drive->vdma)
-					command =3D lba48 ? WIN_WRITE_EXT: WIN_WRITE;
-			} else {
-				command =3D lba48 ? WIN_READDMA_EXT : WIN_READDMA;
-				if (drive->vdma)
-					command =3D lba48 ? WIN_READ_EXT: WIN_READ;
-			}
-			hwif->dma_exec_cmd(drive, command);
-			hwif->dma_start(drive);
-			return ide_started;
-		}
-		/* fallback to PIO */
-		ide_init_sg_cmd(drive, rq);
-	}
+	if (rq_data_dir(rq))
+		task.tf_flags |=3D IDE_TFLAG_WRITE;
=20
-	if (rq_data_dir(rq) =3D=3D READ) {
+	ide_tf_set_cmd(drive, &task, dma);
+	if (!dma)
+		hwif->data_phase =3D task.data_phase;
+	task.rq =3D rq;
=20
-		if (drive->mult_count) {
-			hwif->data_phase =3D TASKFILE_MULTI_IN;
-			command =3D lba48 ? WIN_MULTREAD_EXT : WIN_MULTREAD;
-		} else {
-			hwif->data_phase =3D TASKFILE_IN;
-			command =3D lba48 ? WIN_READ_EXT : WIN_READ;
-		}
+	rc =3D do_rw_taskfile(drive, &task);
=20
-		ide_execute_command(drive, command, &task_in_intr, WAIT_CMD, NULL);
-		return ide_started;
-	} else {
-		if (drive->mult_count) {
-			hwif->data_phase =3D TASKFILE_MULTI_OUT;
-			command =3D lba48 ? WIN_MULTWRITE_EXT : WIN_MULTWRITE;
-		} else {
-			hwif->data_phase =3D TASKFILE_OUT;
-			command =3D lba48 ? WIN_WRITE_EXT : WIN_WRITE;
-		}
-
-		/* FIXME: ->OUTBSYNC ? */
-		hwif->OUTB(command, IDE_COMMAND_REG);
-
-		return pre_task_out_intr(drive, rq);
+	if (rc =3D=3D ide_stopped && dma) {
+		/* fallback to PIO */
+		task.tf_flags |=3D IDE_TFLAG_DMA_PIO_FALLBACK;
+		ide_tf_set_cmd(drive, &task, 0);
+		hwif->data_phase =3D task.data_phase;
+		ide_init_sg_cmd(drive, rq);
+		rc =3D do_rw_taskfile(drive, &task);
 	}
+
+	return rc;
 }
=20
 /*
@@ -307,57 +306,29 @@ static ide_startstop_t ide_do_rw_disk (ide_drive_=
t *drive, struct request *rq, s
  * Queries for true maximum capacity of the drive.
  * Returns maximum LBA address (> 0) of the drive, 0 if failed.
  */
-static unsigned long idedisk_read_native_max_address(ide_drive_t *driv=
e)
+static u64 idedisk_read_native_max_address(ide_drive_t *drive, int lba=
48)
 {
 	ide_task_t args;
-	unsigned long addr =3D 0;
+	struct ide_taskfile *tf =3D &args.tf;
+	u64 addr =3D 0;
=20
 	/* Create IDE/ATA command request structure */
 	memset(&args, 0, sizeof(ide_task_t));
-	args.tfRegister[IDE_SELECT_OFFSET]	=3D 0x40;
-	args.tfRegister[IDE_COMMAND_OFFSET]	=3D WIN_READ_NATIVE_MAX;
-	args.command_type			=3D IDE_DRIVE_TASK_NO_DATA;
-	args.handler				=3D &task_no_data_intr;
+	if (lba48)
+		tf->command =3D WIN_READ_NATIVE_MAX_EXT;
+	else
+		tf->command =3D WIN_READ_NATIVE_MAX;
+	tf->device  =3D ATA_LBA;
+	args.tf_flags =3D IDE_TFLAG_OUT_TF | IDE_TFLAG_OUT_DEVICE;
+	if (lba48)
+		args.tf_flags |=3D (IDE_TFLAG_LBA48 | IDE_TFLAG_OUT_HOB);
 	/* submit command request */
-	ide_raw_taskfile(drive, &args, NULL);
+	ide_no_data_taskfile(drive, &args);
=20
 	/* if OK, compute maximum address value */
-	if ((args.tfRegister[IDE_STATUS_OFFSET] & 0x01) =3D=3D 0) {
-		addr =3D ((args.tfRegister[IDE_SELECT_OFFSET] & 0x0f) << 24)
-		     | ((args.tfRegister[  IDE_HCYL_OFFSET]       ) << 16)
-		     | ((args.tfRegister[  IDE_LCYL_OFFSET]       ) <<  8)
-		     | ((args.tfRegister[IDE_SECTOR_OFFSET]       ));
-		addr++;	/* since the return value is (maxlba - 1), we add 1 */
-	}
-	return addr;
-}
-
-static unsigned long long idedisk_read_native_max_address_ext(ide_driv=
e_t *drive)
-{
-	ide_task_t args;
-	unsigned long long addr =3D 0;
-
-	/* Create IDE/ATA command request structure */
-	memset(&args, 0, sizeof(ide_task_t));
+	if ((tf->status & 0x01) =3D=3D 0)
+		addr =3D ide_get_lba_addr(tf, lba48) + 1;
=20
-	args.tfRegister[IDE_SELECT_OFFSET]	=3D 0x40;
-	args.tfRegister[IDE_COMMAND_OFFSET]	=3D WIN_READ_NATIVE_MAX_EXT;
-	args.command_type			=3D IDE_DRIVE_TASK_NO_DATA;
-	args.handler				=3D &task_no_data_intr;
-        /* submit command request */
-        ide_raw_taskfile(drive, &args, NULL);
-
-	/* if OK, compute maximum address value */
-	if ((args.tfRegister[IDE_STATUS_OFFSET] & 0x01) =3D=3D 0) {
-		u32 high =3D (args.hobRegister[IDE_HCYL_OFFSET] << 16) |
-			   (args.hobRegister[IDE_LCYL_OFFSET] <<  8) |
-			    args.hobRegister[IDE_SECTOR_OFFSET];
-		u32 low  =3D ((args.tfRegister[IDE_HCYL_OFFSET])<<16) |
-			   ((args.tfRegister[IDE_LCYL_OFFSET])<<8) |
-			    (args.tfRegister[IDE_SECTOR_OFFSET]);
-		addr =3D ((__u64)high << 24) | low;
-		addr++;	/* since the return value is (maxlba - 1), we add 1 */
-	}
 	return addr;
 }
=20
@@ -365,67 +336,37 @@ static unsigned long long idedisk_read_native_max=
_address_ext(ide_drive_t *drive
  * Sets maximum virtual LBA address of the drive.
  * Returns new maximum virtual LBA address (> 0) or 0 on failure.
  */
-static unsigned long idedisk_set_max_address(ide_drive_t *drive, unsig=
ned long addr_req)
+static u64 idedisk_set_max_address(ide_drive_t *drive, u64 addr_req, i=
nt lba48)
 {
 	ide_task_t args;
-	unsigned long addr_set =3D 0;
-=09
-	addr_req--;
-	/* Create IDE/ATA command request structure */
-	memset(&args, 0, sizeof(ide_task_t));
-	args.tfRegister[IDE_SECTOR_OFFSET]	=3D ((addr_req >>  0) & 0xff);
-	args.tfRegister[IDE_LCYL_OFFSET]	=3D ((addr_req >>  8) & 0xff);
-	args.tfRegister[IDE_HCYL_OFFSET]	=3D ((addr_req >> 16) & 0xff);
-	args.tfRegister[IDE_SELECT_OFFSET]	=3D ((addr_req >> 24) & 0x0f) | 0x=
40;
-	args.tfRegister[IDE_COMMAND_OFFSET]	=3D WIN_SET_MAX;
-	args.command_type			=3D IDE_DRIVE_TASK_NO_DATA;
-	args.handler				=3D &task_no_data_intr;
-	/* submit command request */
-	ide_raw_taskfile(drive, &args, NULL);
-	/* if OK, read new maximum address value */
-	if ((args.tfRegister[IDE_STATUS_OFFSET] & 0x01) =3D=3D 0) {
-		addr_set =3D ((args.tfRegister[IDE_SELECT_OFFSET] & 0x0f) << 24)
-			 | ((args.tfRegister[  IDE_HCYL_OFFSET]       ) << 16)
-			 | ((args.tfRegister[  IDE_LCYL_OFFSET]       ) <<  8)
-			 | ((args.tfRegister[IDE_SECTOR_OFFSET]       ));
-		addr_set++;
-	}
-	return addr_set;
-}
-
-static unsigned long long idedisk_set_max_address_ext(ide_drive_t *dri=
ve, unsigned long long addr_req)
-{
-	ide_task_t args;
-	unsigned long long addr_set =3D 0;
+	struct ide_taskfile *tf =3D &args.tf;
+	u64 addr_set =3D 0;
=20
 	addr_req--;
 	/* Create IDE/ATA command request structure */
 	memset(&args, 0, sizeof(ide_task_t));
-	args.tfRegister[IDE_SECTOR_OFFSET]	=3D ((addr_req >>  0) & 0xff);
-	args.tfRegister[IDE_LCYL_OFFSET]	=3D ((addr_req >>=3D 8) & 0xff);
-	args.tfRegister[IDE_HCYL_OFFSET]	=3D ((addr_req >>=3D 8) & 0xff);
-	args.tfRegister[IDE_SELECT_OFFSET]      =3D 0x40;
-	args.tfRegister[IDE_COMMAND_OFFSET]	=3D WIN_SET_MAX_EXT;
-	args.hobRegister[IDE_SECTOR_OFFSET]	=3D (addr_req >>=3D 8) & 0xff;
-	args.hobRegister[IDE_LCYL_OFFSET]	=3D (addr_req >>=3D 8) & 0xff;
-	args.hobRegister[IDE_HCYL_OFFSET]	=3D (addr_req >>=3D 8) & 0xff;
-	args.hobRegister[IDE_SELECT_OFFSET]	=3D 0x40;
-	args.hobRegister[IDE_CONTROL_OFFSET_HOB]=3D (drive->ctl|0x80);
-	args.command_type			=3D IDE_DRIVE_TASK_NO_DATA;
-	args.handler				=3D &task_no_data_intr;
+	tf->lbal     =3D (addr_req >>  0) & 0xff;
+	tf->lbam     =3D (addr_req >>=3D 8) & 0xff;
+	tf->lbah     =3D (addr_req >>=3D 8) & 0xff;
+	if (lba48) {
+		tf->hob_lbal =3D (addr_req >>=3D 8) & 0xff;
+		tf->hob_lbam =3D (addr_req >>=3D 8) & 0xff;
+		tf->hob_lbah =3D (addr_req >>=3D 8) & 0xff;
+		tf->command  =3D WIN_SET_MAX_EXT;
+	} else {
+		tf->device   =3D (addr_req >>=3D 8) & 0x0f;
+		tf->command  =3D WIN_SET_MAX;
+	}
+	tf->device |=3D ATA_LBA;
+	args.tf_flags =3D IDE_TFLAG_OUT_TF | IDE_TFLAG_OUT_DEVICE;
+	if (lba48)
+		args.tf_flags |=3D (IDE_TFLAG_LBA48 | IDE_TFLAG_OUT_HOB);
 	/* submit command request */
-	ide_raw_taskfile(drive, &args, NULL);
+	ide_no_data_taskfile(drive, &args);
 	/* if OK, compute maximum address value */
-	if ((args.tfRegister[IDE_STATUS_OFFSET] & 0x01) =3D=3D 0) {
-		u32 high =3D (args.hobRegister[IDE_HCYL_OFFSET] << 16) |
-			   (args.hobRegister[IDE_LCYL_OFFSET] <<  8) |
-			    args.hobRegister[IDE_SECTOR_OFFSET];
-		u32 low  =3D ((args.tfRegister[IDE_HCYL_OFFSET])<<16) |
-			   ((args.tfRegister[IDE_LCYL_OFFSET])<<8) |
-			    (args.tfRegister[IDE_SECTOR_OFFSET]);
-		addr_set =3D ((__u64)high << 24) | low;
-		addr_set++;
-	}
+	if ((tf->status & 0x01) =3D=3D 0)
+		addr_set =3D ide_get_lba_addr(tf, lba48) + 1;
+
 	return addr_set;
 }
=20
@@ -471,10 +412,8 @@ static void idedisk_check_hpa(ide_drive_t *drive)
 	int lba48 =3D idedisk_supports_lba48(drive->id);
=20
 	capacity =3D drive->capacity64;
-	if (lba48)
-		set_max =3D idedisk_read_native_max_address_ext(drive);
-	else
-		set_max =3D idedisk_read_native_max_address(drive);
+
+	set_max =3D idedisk_read_native_max_address(drive, lba48);
=20
 	if (ide_in_drive_list(drive->id, hpa_list)) {
 		/*
@@ -495,10 +434,8 @@ static void idedisk_check_hpa(ide_drive_t *drive)
 			 capacity, sectors_to_MB(capacity),
 			 set_max, sectors_to_MB(set_max));
=20
-	if (lba48)
-		set_max =3D idedisk_set_max_address_ext(drive, set_max);
-	else
-		set_max =3D idedisk_set_max_address(drive, set_max);
+	set_max =3D idedisk_set_max_address(drive, set_max, lba48);
+
 	if (set_max) {
 		drive->capacity64 =3D set_max;
 		printk(KERN_INFO "%s: Host Protected Area disabled.\n",
@@ -556,32 +493,32 @@ static sector_t idedisk_capacity (ide_drive_t *dr=
ive)
 static int smart_enable(ide_drive_t *drive)
 {
 	ide_task_t args;
+	struct ide_taskfile *tf =3D &args.tf;
=20
 	memset(&args, 0, sizeof(ide_task_t));
-	args.tfRegister[IDE_FEATURE_OFFSET]	=3D SMART_ENABLE;
-	args.tfRegister[IDE_LCYL_OFFSET]	=3D SMART_LCYL_PASS;
-	args.tfRegister[IDE_HCYL_OFFSET]	=3D SMART_HCYL_PASS;
-	args.tfRegister[IDE_COMMAND_OFFSET]	=3D WIN_SMART;
-	args.command_type			=3D IDE_DRIVE_TASK_NO_DATA;
-	args.handler				=3D &task_no_data_intr;
-	return ide_raw_taskfile(drive, &args, NULL);
+	tf->feature =3D SMART_ENABLE;
+	tf->lbam    =3D SMART_LCYL_PASS;
+	tf->lbah    =3D SMART_HCYL_PASS;
+	tf->command =3D WIN_SMART;
+	args.tf_flags =3D IDE_TFLAG_OUT_TF | IDE_TFLAG_OUT_DEVICE;
+	return ide_no_data_taskfile(drive, &args);
 }
=20
 static int get_smart_data(ide_drive_t *drive, u8 *buf, u8 sub_cmd)
 {
 	ide_task_t args;
+	struct ide_taskfile *tf =3D &args.tf;
=20
 	memset(&args, 0, sizeof(ide_task_t));
-	args.tfRegister[IDE_FEATURE_OFFSET]	=3D sub_cmd;
-	args.tfRegister[IDE_NSECTOR_OFFSET]	=3D 0x01;
-	args.tfRegister[IDE_LCYL_OFFSET]	=3D SMART_LCYL_PASS;
-	args.tfRegister[IDE_HCYL_OFFSET]	=3D SMART_HCYL_PASS;
-	args.tfRegister[IDE_COMMAND_OFFSET]	=3D WIN_SMART;
-	args.command_type			=3D IDE_DRIVE_TASK_IN;
-	args.data_phase				=3D TASKFILE_IN;
-	args.handler				=3D &task_in_intr;
+	tf->feature =3D sub_cmd;
+	tf->nsect   =3D 0x01;
+	tf->lbam    =3D SMART_LCYL_PASS;
+	tf->lbah    =3D SMART_HCYL_PASS;
+	tf->command =3D WIN_SMART;
+	args.tf_flags	=3D IDE_TFLAG_OUT_TF | IDE_TFLAG_OUT_DEVICE;
+	args.data_phase	=3D TASKFILE_IN;
 	(void) smart_enable(drive);
-	return ide_raw_taskfile(drive, &args, buf);
+	return ide_raw_taskfile(drive, &args, buf, 1);
 }
=20
 static int proc_idedisk_read_cache
@@ -659,19 +596,20 @@ static ide_proc_entry_t idedisk_proc[] =3D {
 static void idedisk_prepare_flush(struct request_queue *q, struct requ=
est *rq)
 {
 	ide_drive_t *drive =3D q->queuedata;
+	ide_task_t task;
=20
-	memset(rq->cmd, 0, sizeof(rq->cmd));
-
+	memset(&task, 0, sizeof(task));
 	if (ide_id_has_flush_cache_ext(drive->id) &&
 	    (drive->capacity64 >=3D (1UL << 28)))
-		rq->cmd[0] =3D WIN_FLUSH_CACHE_EXT;
+		task.tf.command =3D WIN_FLUSH_CACHE_EXT;
 	else
-		rq->cmd[0] =3D WIN_FLUSH_CACHE;
-
+		task.tf.command =3D WIN_FLUSH_CACHE;
+	task.tf_flags	=3D IDE_TFLAG_OUT_TF | IDE_TFLAG_OUT_DEVICE;
+	task.data_phase	=3D TASKFILE_NO_DATA;
=20
-	rq->cmd_type =3D REQ_TYPE_ATA_TASK;
+	rq->cmd_type =3D REQ_TYPE_ATA_TASKFILE;
 	rq->cmd_flags |=3D REQ_SOFTBARRIER;
-	rq->buffer =3D rq->cmd;
+	rq->special =3D &task;
 }
=20
 /*
@@ -753,12 +691,11 @@ static int write_cache(ide_drive_t *drive, int ar=
g)
=20
 	if (ide_id_has_flush_cache(drive->id)) {
 		memset(&args, 0, sizeof(ide_task_t));
-		args.tfRegister[IDE_FEATURE_OFFSET]	=3D (arg) ?
+		args.tf.feature =3D arg ?
 			SETFEATURES_EN_WCACHE : SETFEATURES_DIS_WCACHE;
-		args.tfRegister[IDE_COMMAND_OFFSET]	=3D WIN_SETFEATURES;
-		args.command_type		=3D IDE_DRIVE_TASK_NO_DATA;
-		args.handler			=3D &task_no_data_intr;
-		err =3D ide_raw_taskfile(drive, &args, NULL);
+		args.tf.command =3D WIN_SETFEATURES;
+		args.tf_flags =3D IDE_TFLAG_OUT_TF | IDE_TFLAG_OUT_DEVICE;
+		err =3D ide_no_data_taskfile(drive, &args);
 		if (err =3D=3D 0)
 			drive->wcache =3D arg;
 	}
@@ -774,12 +711,11 @@ static int do_idedisk_flushcache (ide_drive_t *dr=
ive)
=20
 	memset(&args, 0, sizeof(ide_task_t));
 	if (ide_id_has_flush_cache_ext(drive->id))
-		args.tfRegister[IDE_COMMAND_OFFSET]	=3D WIN_FLUSH_CACHE_EXT;
+		args.tf.command =3D WIN_FLUSH_CACHE_EXT;
 	else
-		args.tfRegister[IDE_COMMAND_OFFSET]	=3D WIN_FLUSH_CACHE;
-	args.command_type			=3D IDE_DRIVE_TASK_NO_DATA;
-	args.handler				=3D &task_no_data_intr;
-	return ide_raw_taskfile(drive, &args, NULL);
+		args.tf.command =3D WIN_FLUSH_CACHE;
+	args.tf_flags =3D IDE_TFLAG_OUT_TF | IDE_TFLAG_OUT_DEVICE;
+	return ide_no_data_taskfile(drive, &args);
 }
=20
 static int set_acoustic (ide_drive_t *drive, int arg)
@@ -790,13 +726,11 @@ static int set_acoustic (ide_drive_t *drive, int =
arg)
 		return -EINVAL;
=20
 	memset(&args, 0, sizeof(ide_task_t));
-	args.tfRegister[IDE_FEATURE_OFFSET]	=3D (arg) ? SETFEATURES_EN_AAM :
-							  SETFEATURES_DIS_AAM;
-	args.tfRegister[IDE_NSECTOR_OFFSET]	=3D arg;
-	args.tfRegister[IDE_COMMAND_OFFSET]	=3D WIN_SETFEATURES;
-	args.command_type =3D IDE_DRIVE_TASK_NO_DATA;
-	args.handler	  =3D &task_no_data_intr;
-	ide_raw_taskfile(drive, &args, NULL);
+	args.tf.feature =3D arg ? SETFEATURES_EN_AAM : SETFEATURES_DIS_AAM;
+	args.tf.nsect   =3D arg;
+	args.tf.command =3D WIN_SETFEATURES;
+	args.tf_flags =3D IDE_TFLAG_OUT_TF | IDE_TFLAG_OUT_DEVICE;
+	ide_no_data_taskfile(drive, &args);
 	drive->acoustic =3D arg;
 	return 0;
 }
@@ -1057,16 +991,15 @@ static int idedisk_open(struct inode *inode, str=
uct file *filp)
 	if (drive->removable && idkp->openers =3D=3D 1) {
 		ide_task_t args;
 		memset(&args, 0, sizeof(ide_task_t));
-		args.tfRegister[IDE_COMMAND_OFFSET] =3D WIN_DOORLOCK;
-		args.command_type =3D IDE_DRIVE_TASK_NO_DATA;
-		args.handler	  =3D &task_no_data_intr;
+		args.tf.command =3D WIN_DOORLOCK;
+		args.tf_flags =3D IDE_TFLAG_OUT_TF | IDE_TFLAG_OUT_DEVICE;
 		check_disk_change(inode->i_bdev);
 		/*
 		 * Ignore the return code from door_lock,
 		 * since the open() has already succeeded,
 		 * and the door_lock is irrelevant at this point.
 		 */
-		if (drive->doorlocking && ide_raw_taskfile(drive, &args, NULL))
+		if (drive->doorlocking && ide_no_data_taskfile(drive, &args))
 			drive->doorlocking =3D 0;
 	}
 	return 0;
@@ -1084,10 +1017,9 @@ static int idedisk_release(struct inode *inode, =
struct file *filp)
 	if (drive->removable && idkp->openers =3D=3D 1) {
 		ide_task_t args;
 		memset(&args, 0, sizeof(ide_task_t));
-		args.tfRegister[IDE_COMMAND_OFFSET] =3D WIN_DOORUNLOCK;
-		args.command_type =3D IDE_DRIVE_TASK_NO_DATA;
-		args.handler	  =3D &task_no_data_intr;
-		if (drive->doorlocking && ide_raw_taskfile(drive, &args, NULL))
+		args.tf.command =3D WIN_DOORUNLOCK;
+		args.tf_flags =3D IDE_TFLAG_OUT_TF | IDE_TFLAG_OUT_DEVICE;
+		if (drive->doorlocking && ide_no_data_taskfile(drive, &args))
 			drive->doorlocking =3D 0;
 	}
=20
diff --git a/drivers/ide/ide-dma.c b/drivers/ide/ide-dma.c
index 4703837..18c78ad 100644
--- a/drivers/ide/ide-dma.c
+++ b/drivers/ide/ide-dma.c
@@ -491,10 +491,6 @@ EXPORT_SYMBOL(ide_dma_host_on);
 =20
 int __ide_dma_on (ide_drive_t *drive)
 {
-	/* consult the list of known "bad" drives */
-	if (__ide_dma_bad_drive(drive))
-		return 1;
-
 	drive->using_dma =3D 1;
 	ide_toggle_bounce(drive, 1);
=20
@@ -827,22 +823,19 @@ int ide_set_dma(ide_drive_t *drive)
 	ide_hwif_t *hwif =3D drive->hwif;
 	int rc;
=20
-	rc =3D ide_dma_check(drive);
+	/*
+	 * Force DMAing for the beginning of the check.
+	 * Some chipsets appear to do interesting
+	 * things, if not checked and cleared.
+	 *   PARANOIA!!!
+	 */
+	hwif->dma_off_quietly(drive);
=20
-	switch(rc) {
-	case -1: /* DMA needs to be disabled */
-		hwif->dma_off_quietly(drive);
-		return -1;
-	case  0: /* DMA needs to be enabled */
-		return hwif->ide_dma_on(drive);
-	case  1: /* DMA setting cannot be changed */
-		break;
-	default:
-		BUG();
-		break;
-	}
+	rc =3D ide_dma_check(drive);
+	if (rc)
+		return rc;
=20
-	return rc;
+	return hwif->ide_dma_on(drive);
 }
=20
 #ifdef CONFIG_BLK_DEV_IDEDMA_PCI
@@ -968,11 +961,6 @@ void ide_setup_dma(ide_hwif_t *hwif, unsigned long=
 base, unsigned num_ports)
=20
 	hwif->dma_base =3D base;
=20
-	if (hwif->mate)
-		hwif->dma_master =3D hwif->channel ? hwif->mate->dma_base : base;
-	else
-		hwif->dma_master =3D base;
-
 	if (!(hwif->dma_command))
 		hwif->dma_command	=3D hwif->dma_base;
 	if (!(hwif->dma_vendor1))
@@ -1014,8 +1002,6 @@ void ide_setup_dma(ide_hwif_t *hwif, unsigned lon=
g base, unsigned num_ports)
 		       hwif->drives[1].name, (dma_stat & 0x40) ? "DMA" : "pio");
 	}
 	printk("\n");
-
-	BUG_ON(!hwif->dma_master);
 }
=20
 EXPORT_SYMBOL_GPL(ide_setup_dma);
diff --git a/drivers/ide/ide-floppy.c b/drivers/ide/ide-floppy.c
index 04a3578..ff8232e 100644
--- a/drivers/ide/ide-floppy.c
+++ b/drivers/ide/ide-floppy.c
@@ -369,27 +369,6 @@ typedef struct ide_floppy_obj {
 #define	IDEFLOPPY_IOCTL_FORMAT_START		0x4602
 #define IDEFLOPPY_IOCTL_FORMAT_GET_PROGRESS	0x4603
=20
-#if 0
-/*
- *	Special requests for our block device strategy routine.
- */
-#define	IDEFLOPPY_FIRST_RQ	90
-
-/*
- * 	IDEFLOPPY_PC_RQ is used to queue a packet command in the request q=
ueue.
- */
-#define	IDEFLOPPY_PC_RQ		90
-
-#define IDEFLOPPY_LAST_RQ	90
-
-/*
- *	A macro which can be used to check if a given request command
- *	originated in the driver or in the buffer cache layer.
- */
-#define IDEFLOPPY_RQ_CMD(cmd) 	((cmd >=3D IDEFLOPPY_FIRST_RQ) && (cmd =
<=3D IDEFLOPPY_LAST_RQ))
-
-#endif
-
 /*
  *	Error codes which are returned in rq->errors to the higher part
  *	of the driver.
@@ -793,9 +772,8 @@ static void idefloppy_retry_pc (ide_drive_t *drive)
 {
 	idefloppy_pc_t *pc;
 	struct request *rq;
-	atapi_error_t error;
=20
-	error.all =3D HWIF(drive)->INB(IDE_ERROR_REG);
+	(void)drive->hwif->INB(IDE_ERROR_REG);
 	pc =3D idefloppy_next_pc_storage(drive);
 	rq =3D idefloppy_next_rq_storage(drive);
 	idefloppy_create_request_sense_cmd(pc);
@@ -809,12 +787,12 @@ static void idefloppy_retry_pc (ide_drive_t *driv=
e)
 static ide_startstop_t idefloppy_pc_intr (ide_drive_t *drive)
 {
 	idefloppy_floppy_t *floppy =3D drive->driver_data;
-	atapi_status_t status;
-	atapi_bcount_t bcount;
-	atapi_ireason_t ireason;
+	ide_hwif_t *hwif =3D drive->hwif;
 	idefloppy_pc_t *pc =3D floppy->pc;
 	struct request *rq =3D pc->rq;
 	unsigned int temp;
+	u16 bcount;
+	u8 stat, ireason;
=20
 	debug_log(KERN_INFO "ide-floppy: Reached %s interrupt handler\n",
 		__FUNCTION__);
@@ -830,16 +808,16 @@ static ide_startstop_t idefloppy_pc_intr (ide_dri=
ve_t *drive)
 	}
=20
 	/* Clear the interrupt */
-	status.all =3D HWIF(drive)->INB(IDE_STATUS_REG);
+	stat =3D drive->hwif->INB(IDE_STATUS_REG);
=20
-	if (!status.b.drq) {			/* No more interrupts */
+	if ((stat & DRQ_STAT) =3D=3D 0) {		/* No more interrupts */
 		debug_log(KERN_INFO "Packet command completed, %d bytes "
 			"transferred\n", pc->actually_transferred);
 		clear_bit(PC_DMA_IN_PROGRESS, &pc->flags);
=20
 		local_irq_enable_in_hardirq();
=20
-		if (status.b.check || test_bit(PC_DMA_ERROR, &pc->flags)) {
+		if ((stat & ERR_STAT) || test_bit(PC_DMA_ERROR, &pc->flags)) {
 			/* Error detected */
 			debug_log(KERN_INFO "ide-floppy: %s: I/O error\n",
 				drive->name);
@@ -870,32 +848,32 @@ static ide_startstop_t idefloppy_pc_intr (ide_dri=
ve_t *drive)
 	}
=20
 	/* Get the number of bytes to transfer */
-	bcount.b.high =3D HWIF(drive)->INB(IDE_BCOUNTH_REG);
-	bcount.b.low =3D HWIF(drive)->INB(IDE_BCOUNTL_REG);
+	bcount =3D (hwif->INB(IDE_BCOUNTH_REG) << 8) |
+		  hwif->INB(IDE_BCOUNTL_REG);
 	/* on this interrupt */
-	ireason.all =3D HWIF(drive)->INB(IDE_IREASON_REG);
+	ireason =3D hwif->INB(IDE_IREASON_REG);
=20
-	if (ireason.b.cod) {
+	if (ireason & CD) {
 		printk(KERN_ERR "ide-floppy: CoD !=3D 0 in idefloppy_pc_intr\n");
 		return ide_do_reset(drive);
 	}
-	if (ireason.b.io =3D=3D test_bit(PC_WRITING, &pc->flags)) {
+	if (((ireason & IO) =3D=3D IO) =3D=3D test_bit(PC_WRITING, &pc->flags=
)) {
 		/* Hopefully, we will never get here */
 		printk(KERN_ERR "ide-floppy: We wanted to %s, ",
-			ireason.b.io ? "Write":"Read");
+				(ireason & IO) ? "Write" : "Read");
 		printk(KERN_ERR "but the floppy wants us to %s !\n",
-			ireason.b.io ? "Read":"Write");
+				(ireason & IO) ? "Read" : "Write");
 		return ide_do_reset(drive);
 	}
 	if (!test_bit(PC_WRITING, &pc->flags)) {
 		/* Reading - Check that we have enough space */
-		temp =3D pc->actually_transferred + bcount.all;
+		temp =3D pc->actually_transferred + bcount;
 		if (temp > pc->request_transfer) {
 			if (temp > pc->buffer_size) {
 				printk(KERN_ERR "ide-floppy: The floppy wants "
 					"to send us more data than expected "
 					"- discarding data\n");
-				idefloppy_discard_data(drive,bcount.all);
+				idefloppy_discard_data(drive, bcount);
 				BUG_ON(HWGROUP(drive)->handler !=3D NULL);
 				ide_set_handler(drive,
 						&idefloppy_pc_intr,
@@ -911,23 +889,21 @@ static ide_startstop_t idefloppy_pc_intr (ide_dri=
ve_t *drive)
 	if (test_bit(PC_WRITING, &pc->flags)) {
 		if (pc->buffer !=3D NULL)
 			/* Write the current buffer */
-			HWIF(drive)->atapi_output_bytes(drive,
-						pc->current_position,
-						bcount.all);
+			hwif->atapi_output_bytes(drive, pc->current_position,
+						 bcount);
 		else
-			idefloppy_output_buffers(drive, pc, bcount.all);
+			idefloppy_output_buffers(drive, pc, bcount);
 	} else {
 		if (pc->buffer !=3D NULL)
 			/* Read the current buffer */
-			HWIF(drive)->atapi_input_bytes(drive,
-						pc->current_position,
-						bcount.all);
+			hwif->atapi_input_bytes(drive, pc->current_position,
+						bcount);
 		else
-			idefloppy_input_buffers(drive, pc, bcount.all);
+			idefloppy_input_buffers(drive, pc, bcount);
 	}
 	/* Update the current position */
-	pc->actually_transferred +=3D bcount.all;
-	pc->current_position +=3D bcount.all;
+	pc->actually_transferred +=3D bcount;
+	pc->current_position +=3D bcount;
=20
 	BUG_ON(HWGROUP(drive)->handler !=3D NULL);
 	ide_set_handler(drive, &idefloppy_pc_intr, IDEFLOPPY_WAIT_CMD, NULL);=
		/* And set the interrupt handler again */
@@ -943,15 +919,15 @@ static ide_startstop_t idefloppy_transfer_pc (ide=
_drive_t *drive)
 {
 	ide_startstop_t startstop;
 	idefloppy_floppy_t *floppy =3D drive->driver_data;
-	atapi_ireason_t ireason;
+	u8 ireason;
=20
 	if (ide_wait_stat(&startstop, drive, DRQ_STAT, BUSY_STAT, WAIT_READY)=
) {
 		printk(KERN_ERR "ide-floppy: Strange, packet command "
 				"initiated yet DRQ isn't asserted\n");
 		return startstop;
 	}
-	ireason.all =3D HWIF(drive)->INB(IDE_IREASON_REG);
-	if (!ireason.b.cod || ireason.b.io) {
+	ireason =3D drive->hwif->INB(IDE_IREASON_REG);
+	if ((ireason & CD) =3D=3D 0 || (ireason & IO)) {
 		printk(KERN_ERR "ide-floppy: (IO,CoD) !=3D (0,1) while "
 				"issuing a packet command\n");
 		return ide_do_reset(drive);
@@ -991,15 +967,15 @@ static ide_startstop_t idefloppy_transfer_pc1 (id=
e_drive_t *drive)
 {
 	idefloppy_floppy_t *floppy =3D drive->driver_data;
 	ide_startstop_t startstop;
-	atapi_ireason_t ireason;
+	u8 ireason;
=20
 	if (ide_wait_stat(&startstop, drive, DRQ_STAT, BUSY_STAT, WAIT_READY)=
) {
 		printk(KERN_ERR "ide-floppy: Strange, packet command "
 				"initiated yet DRQ isn't asserted\n");
 		return startstop;
 	}
-	ireason.all =3D HWIF(drive)->INB(IDE_IREASON_REG);
-	if (!ireason.b.cod || ireason.b.io) {
+	ireason =3D drive->hwif->INB(IDE_IREASON_REG);
+	if ((ireason & CD) =3D=3D 0 || (ireason & IO)) {
 		printk(KERN_ERR "ide-floppy: (IO,CoD) !=3D (0,1) "
 				"while issuing a packet command\n");
 		return ide_do_reset(drive);
@@ -1041,21 +1017,9 @@ static ide_startstop_t idefloppy_issue_pc (ide_d=
rive_t *drive, idefloppy_pc_t *p
 {
 	idefloppy_floppy_t *floppy =3D drive->driver_data;
 	ide_hwif_t *hwif =3D drive->hwif;
-	atapi_feature_t feature;
-	atapi_bcount_t bcount;
 	ide_handler_t *pkt_xfer_routine;
-
-#if 0 /* Accessing floppy->pc is not valid here, the previous pc may b=
e gone
-         and have lived on another thread's stack; that stack may have=
 become
-         unmapped meanwhile (CONFIG_DEBUG_PAGEALLOC). */
-#if IDEFLOPPY_DEBUG_BUGS
-	if (floppy->pc->c[0] =3D=3D IDEFLOPPY_REQUEST_SENSE_CMD &&
-	    pc->c[0] =3D=3D IDEFLOPPY_REQUEST_SENSE_CMD) {
-		printk(KERN_ERR "ide-floppy: possible ide-floppy.c bug - "
-			"Two request sense in serial were issued\n");
-	}
-#endif /* IDEFLOPPY_DEBUG_BUGS */
-#endif
+	u16 bcount;
+	u8 dma;
=20
 	if (floppy->failed_pc =3D=3D NULL &&
 	    pc->c[0] !=3D IDEFLOPPY_REQUEST_SENSE_CMD)
@@ -1093,25 +1057,20 @@ static ide_startstop_t idefloppy_issue_pc (ide_=
drive_t *drive, idefloppy_pc_t *p
 	/* We haven't transferred any data yet */
 	pc->actually_transferred =3D 0;
 	pc->current_position =3D pc->buffer;
-	bcount.all =3D min(pc->request_transfer, 63 * 1024);
+	bcount =3D min(pc->request_transfer, 63 * 1024);
=20
 	if (test_and_clear_bit(PC_DMA_ERROR, &pc->flags))
 		ide_dma_off(drive);
=20
-	feature.all =3D 0;
+	dma =3D 0;
=20
 	if (test_bit(PC_DMA_RECOMMENDED, &pc->flags) && drive->using_dma)
-		feature.b.dma =3D !hwif->dma_setup(drive);
+		dma =3D !hwif->dma_setup(drive);
=20
-	if (IDE_CONTROL_REG)
-		HWIF(drive)->OUTB(drive->ctl, IDE_CONTROL_REG);
-	/* Use PIO/DMA */
-	HWIF(drive)->OUTB(feature.all, IDE_FEATURE_REG);
-	HWIF(drive)->OUTB(bcount.b.high, IDE_BCOUNTH_REG);
-	HWIF(drive)->OUTB(bcount.b.low, IDE_BCOUNTL_REG);
-	HWIF(drive)->OUTB(drive->select.all, IDE_SELECT_REG);
+	ide_pktcmd_tf_load(drive, IDE_TFLAG_NO_SELECT_MASK |
+			   IDE_TFLAG_OUT_DEVICE, bcount, dma);
=20
-	if (feature.b.dma) {	/* Begin DMA, if necessary */
+	if (dma) {	/* Begin DMA, if necessary */
 		set_bit(PC_DMA_IN_PROGRESS, &pc->flags);
 		hwif->dma_start(drive);
 	}
@@ -1665,14 +1624,14 @@ static int idefloppy_get_format_progress(ide_dr=
ive_t *drive, int __user *arg)
 		/* Else assume format_unit has finished, and we're
 		** at 0x10000 */
 	} else {
-		atapi_status_t status;
 		unsigned long flags;
+		u8 stat;
=20
 		local_irq_save(flags);
-		status.all =3D HWIF(drive)->INB(IDE_STATUS_REG);
+		stat =3D drive->hwif->INB(IDE_STATUS_REG);
 		local_irq_restore(flags);
=20
-		progress_indication =3D !status.b.dsc ? 0 : 0x10000;
+		progress_indication =3D ((stat & SEEK_STAT) =3D=3D 0) ? 0 : 0x10000;
 	}
 	if (put_user(progress_indication, arg))
 		return (-EFAULT);
diff --git a/drivers/ide/ide-io.c b/drivers/ide/ide-io.c
index bef781f..2711b5a 100644
--- a/drivers/ide/ide-io.c
+++ b/drivers/ide/ide-io.c
@@ -189,18 +189,14 @@ static ide_startstop_t ide_start_power_step(ide_d=
rive_t *drive, struct request *
 			return ide_stopped;
 		}
 		if (ide_id_has_flush_cache_ext(drive->id))
-			args->tfRegister[IDE_COMMAND_OFFSET] =3D WIN_FLUSH_CACHE_EXT;
+			args->tf.command =3D WIN_FLUSH_CACHE_EXT;
 		else
-			args->tfRegister[IDE_COMMAND_OFFSET] =3D WIN_FLUSH_CACHE;
-		args->command_type =3D IDE_DRIVE_TASK_NO_DATA;
-		args->handler	   =3D &task_no_data_intr;
-		return do_rw_taskfile(drive, args);
+			args->tf.command =3D WIN_FLUSH_CACHE;
+		goto out_do_tf;
=20
 	case idedisk_pm_standby:	/* Suspend step 2 (standby) */
-		args->tfRegister[IDE_COMMAND_OFFSET] =3D WIN_STANDBYNOW1;
-		args->command_type =3D IDE_DRIVE_TASK_NO_DATA;
-		args->handler	   =3D &task_no_data_intr;
-		return do_rw_taskfile(drive, args);
+		args->tf.command =3D WIN_STANDBYNOW1;
+		goto out_do_tf;
=20
 	case idedisk_pm_restore_pio:	/* Resume step 1 (restore PIO) */
 		ide_set_max_pio(drive);
@@ -214,10 +210,8 @@ static ide_startstop_t ide_start_power_step(ide_dr=
ive_t *drive, struct request *
 		return ide_stopped;
=20
 	case idedisk_pm_idle:		/* Resume step 2 (idle) */
-		args->tfRegister[IDE_COMMAND_OFFSET] =3D WIN_IDLEIMMEDIATE;
-		args->command_type =3D IDE_DRIVE_TASK_NO_DATA;
-		args->handler =3D task_no_data_intr;
-		return do_rw_taskfile(drive, args);
+		args->tf.command =3D WIN_IDLEIMMEDIATE;
+		goto out_do_tf;
=20
 	case ide_pm_restore_dma:	/* Resume step 3 (restore DMA) */
 		/*
@@ -227,7 +221,6 @@ static ide_startstop_t ide_start_power_step(ide_dri=
ve_t *drive, struct request *
 		 */
 		if (drive->hwif->ide_dma_on =3D=3D NULL)
 			break;
-		drive->hwif->dma_off_quietly(drive);
 		/*
 		 * TODO: respect ->using_dma setting
 		 */
@@ -236,6 +229,11 @@ static ide_startstop_t ide_start_power_step(ide_dr=
ive_t *drive, struct request *
 	}
 	pm->pm_step =3D ide_pm_state_completed;
 	return ide_stopped;
+
+out_do_tf:
+	args->tf_flags	 =3D IDE_TFLAG_OUT_TF | IDE_TFLAG_OUT_DEVICE;
+	args->data_phase =3D TASKFILE_NO_DATA;
+	return do_rw_taskfile(drive, args);
 }
=20
 /**
@@ -298,6 +296,48 @@ static void ide_complete_pm_request (ide_drive_t *=
drive, struct request *rq)
 	spin_unlock_irqrestore(&ide_lock, flags);
 }
=20
+void ide_tf_read(ide_drive_t *drive, ide_task_t *task)
+{
+	ide_hwif_t *hwif =3D drive->hwif;
+	struct ide_taskfile *tf =3D &task->tf;
+
+	if (task->tf_flags & IDE_TFLAG_IN_DATA) {
+		u16 data =3D hwif->INW(IDE_DATA_REG);
+
+		tf->data =3D data & 0xff;
+		tf->hob_data =3D (data >> 8) & 0xff;
+	}
+
+	/* be sure we're looking at the low order bits */
+	hwif->OUTB(drive->ctl & ~0x80, IDE_CONTROL_REG);
+
+	if (task->tf_flags & IDE_TFLAG_IN_NSECT)
+		tf->nsect  =3D hwif->INB(IDE_NSECTOR_REG);
+	if (task->tf_flags & IDE_TFLAG_IN_LBAL)
+		tf->lbal   =3D hwif->INB(IDE_SECTOR_REG);
+	if (task->tf_flags & IDE_TFLAG_IN_LBAM)
+		tf->lbam   =3D hwif->INB(IDE_LCYL_REG);
+	if (task->tf_flags & IDE_TFLAG_IN_LBAH)
+		tf->lbah   =3D hwif->INB(IDE_HCYL_REG);
+	if (task->tf_flags & IDE_TFLAG_IN_DEVICE)
+		tf->device =3D hwif->INB(IDE_SELECT_REG);
+
+	if (task->tf_flags & IDE_TFLAG_LBA48) {
+		hwif->OUTB(drive->ctl | 0x80, IDE_CONTROL_REG);
+
+		if (task->tf_flags & IDE_TFLAG_IN_HOB_FEATURE)
+			tf->hob_feature =3D hwif->INB(IDE_FEATURE_REG);
+		if (task->tf_flags & IDE_TFLAG_IN_HOB_NSECT)
+			tf->hob_nsect   =3D hwif->INB(IDE_NSECTOR_REG);
+		if (task->tf_flags & IDE_TFLAG_IN_HOB_LBAL)
+			tf->hob_lbal    =3D hwif->INB(IDE_SECTOR_REG);
+		if (task->tf_flags & IDE_TFLAG_IN_HOB_LBAM)
+			tf->hob_lbam    =3D hwif->INB(IDE_LCYL_REG);
+		if (task->tf_flags & IDE_TFLAG_IN_HOB_LBAH)
+			tf->hob_lbah    =3D hwif->INB(IDE_HCYL_REG);
+	}
+}
+
 /**
  *	ide_end_drive_cmd	-	end an explicit drive command
  *	@drive: command=20
@@ -332,51 +372,22 @@ void ide_end_drive_cmd (ide_drive_t *drive, u8 st=
at, u8 err)
 			args[1] =3D err;
 			args[2] =3D hwif->INB(IDE_NSECTOR_REG);
 		}
-	} else if (rq->cmd_type =3D=3D REQ_TYPE_ATA_TASK) {
-		u8 *args =3D (u8 *) rq->buffer;
-		if (rq->errors =3D=3D 0)
-			rq->errors =3D !OK_STAT(stat,READY_STAT,BAD_STAT);
-
-		if (args) {
-			args[0] =3D stat;
-			args[1] =3D err;
-			/* be sure we're looking at the low order bits */
-			hwif->OUTB(drive->ctl & ~0x80, IDE_CONTROL_REG);
-			args[2] =3D hwif->INB(IDE_NSECTOR_REG);
-			args[3] =3D hwif->INB(IDE_SECTOR_REG);
-			args[4] =3D hwif->INB(IDE_LCYL_REG);
-			args[5] =3D hwif->INB(IDE_HCYL_REG);
-			args[6] =3D hwif->INB(IDE_SELECT_REG);
-		}
 	} else if (rq->cmd_type =3D=3D REQ_TYPE_ATA_TASKFILE) {
 		ide_task_t *args =3D (ide_task_t *) rq->special;
 		if (rq->errors =3D=3D 0)
 			rq->errors =3D !OK_STAT(stat,READY_STAT,BAD_STAT);
 		=09
 		if (args) {
-			if (args->tf_in_flags.b.data) {
-				u16 data				=3D hwif->INW(IDE_DATA_REG);
-				args->tfRegister[IDE_DATA_OFFSET]	=3D (data) & 0xFF;
-				args->hobRegister[IDE_DATA_OFFSET]	=3D (data >> 8) & 0xFF;
-			}
-			args->tfRegister[IDE_ERROR_OFFSET]   =3D err;
-			/* be sure we're looking at the low order bits */
-			hwif->OUTB(drive->ctl & ~0x80, IDE_CONTROL_REG);
-			args->tfRegister[IDE_NSECTOR_OFFSET] =3D hwif->INB(IDE_NSECTOR_REG)=
;
-			args->tfRegister[IDE_SECTOR_OFFSET]  =3D hwif->INB(IDE_SECTOR_REG);
-			args->tfRegister[IDE_LCYL_OFFSET]    =3D hwif->INB(IDE_LCYL_REG);
-			args->tfRegister[IDE_HCYL_OFFSET]    =3D hwif->INB(IDE_HCYL_REG);
-			args->tfRegister[IDE_SELECT_OFFSET]  =3D hwif->INB(IDE_SELECT_REG);
-			args->tfRegister[IDE_STATUS_OFFSET]  =3D stat;
-
-			if (drive->addressing =3D=3D 1) {
-				hwif->OUTB(drive->ctl|0x80, IDE_CONTROL_REG);
-				args->hobRegister[IDE_FEATURE_OFFSET]	=3D hwif->INB(IDE_FEATURE_RE=
G);
-				args->hobRegister[IDE_NSECTOR_OFFSET]	=3D hwif->INB(IDE_NSECTOR_RE=
G);
-				args->hobRegister[IDE_SECTOR_OFFSET]	=3D hwif->INB(IDE_SECTOR_REG)=
;
-				args->hobRegister[IDE_LCYL_OFFSET]	=3D hwif->INB(IDE_LCYL_REG);
-				args->hobRegister[IDE_HCYL_OFFSET]	=3D hwif->INB(IDE_HCYL_REG);
-			}
+			struct ide_taskfile *tf =3D &args->tf;
+
+			tf->error =3D err;
+			tf->status =3D stat;
+
+			args->tf_flags |=3D (IDE_TFLAG_IN_TF|IDE_TFLAG_IN_DEVICE);
+			if (args->tf_flags & IDE_TFLAG_LBA48)
+				args->tf_flags |=3D IDE_TFLAG_IN_HOB;
+
+			ide_tf_read(drive, args);
 		}
 	} else if (blk_pm_request(rq)) {
 		struct request_pm_state *pm =3D rq->data;
@@ -616,28 +627,6 @@ ide_startstop_t ide_abort(ide_drive_t *drive, cons=
t char *msg)
 }
=20
 /**
- *	ide_cmd		-	issue a simple drive command
- *	@drive: drive the command is for
- *	@cmd: command byte
- *	@nsect: sector byte
- *	@handler: handler for the command completion
- *
- *	Issue a simple drive command with interrupts.
- *	The drive must be selected beforehand.
- */
-
-static void ide_cmd (ide_drive_t *drive, u8 cmd, u8 nsect,
-		ide_handler_t *handler)
-{
-	ide_hwif_t *hwif =3D HWIF(drive);
-	if (IDE_CONTROL_REG)
-		hwif->OUTB(drive->ctl,IDE_CONTROL_REG);	/* clear nIEN */
-	SELECT_MASK(drive,0);
-	hwif->OUTB(nsect,IDE_NSECTOR_REG);
-	ide_execute_command(drive, cmd, handler, WAIT_CMD, NULL);
-}
-
-/**
  *	drive_cmd_intr		- 	drive command completion interrupt
  *	@drive: drive the completion interrupt occurred on
  *
@@ -673,32 +662,26 @@ static ide_startstop_t drive_cmd_intr (ide_drive_=
t *drive)
 	return ide_stopped;
 }
=20
-static void ide_init_specify_cmd(ide_drive_t *drive, ide_task_t *task)
+static void ide_tf_set_specify_cmd(ide_drive_t *drive, struct ide_task=
file *tf)
 {
-	task->tfRegister[IDE_NSECTOR_OFFSET] =3D drive->sect;
-	task->tfRegister[IDE_SECTOR_OFFSET]  =3D drive->sect;
-	task->tfRegister[IDE_LCYL_OFFSET]    =3D drive->cyl;
-	task->tfRegister[IDE_HCYL_OFFSET]    =3D drive->cyl>>8;
-	task->tfRegister[IDE_SELECT_OFFSET]  =3D ((drive->head-1)|drive->sele=
ct.all)&0xBF;
-	task->tfRegister[IDE_COMMAND_OFFSET] =3D WIN_SPECIFY;
-
-	task->handler =3D &set_geometry_intr;
+	tf->nsect   =3D drive->sect;
+	tf->lbal    =3D drive->sect;
+	tf->lbam    =3D drive->cyl;
+	tf->lbah    =3D drive->cyl >> 8;
+	tf->device  =3D ((drive->head - 1) | drive->select.all) & ~ATA_LBA;
+	tf->command =3D WIN_SPECIFY;
 }
=20
-static void ide_init_restore_cmd(ide_drive_t *drive, ide_task_t *task)
+static void ide_tf_set_restore_cmd(ide_drive_t *drive, struct ide_task=
file *tf)
 {
-	task->tfRegister[IDE_NSECTOR_OFFSET] =3D drive->sect;
-	task->tfRegister[IDE_COMMAND_OFFSET] =3D WIN_RESTORE;
-
-	task->handler =3D &recal_intr;
+	tf->nsect   =3D drive->sect;
+	tf->command =3D WIN_RESTORE;
 }
=20
-static void ide_init_setmult_cmd(ide_drive_t *drive, ide_task_t *task)
+static void ide_tf_set_setmult_cmd(ide_drive_t *drive, struct ide_task=
file *tf)
 {
-	task->tfRegister[IDE_NSECTOR_OFFSET] =3D drive->mult_req;
-	task->tfRegister[IDE_COMMAND_OFFSET] =3D WIN_SETMULT;
-
-	task->handler =3D &set_multmode_intr;
+	tf->nsect   =3D drive->mult_req;
+	tf->command =3D WIN_SETMULT;
 }
=20
 static ide_startstop_t ide_disk_special(ide_drive_t *drive)
@@ -707,19 +690,19 @@ static ide_startstop_t ide_disk_special(ide_drive=
_t *drive)
 	ide_task_t args;
=20
 	memset(&args, 0, sizeof(ide_task_t));
-	args.command_type =3D IDE_DRIVE_TASK_NO_DATA;
+	args.data_phase =3D TASKFILE_NO_DATA;
=20
 	if (s->b.set_geometry) {
 		s->b.set_geometry =3D 0;
-		ide_init_specify_cmd(drive, &args);
+		ide_tf_set_specify_cmd(drive, &args.tf);
 	} else if (s->b.recalibrate) {
 		s->b.recalibrate =3D 0;
-		ide_init_restore_cmd(drive, &args);
+		ide_tf_set_restore_cmd(drive, &args.tf);
 	} else if (s->b.set_multmode) {
 		s->b.set_multmode =3D 0;
 		if (drive->mult_req > drive->id->max_multsect)
 			drive->mult_req =3D drive->id->max_multsect;
-		ide_init_setmult_cmd(drive, &args);
+		ide_tf_set_setmult_cmd(drive, &args.tf);
 	} else if (s->all) {
 		int special =3D s->all;
 		s->all =3D 0;
@@ -727,6 +710,9 @@ static ide_startstop_t ide_disk_special(ide_drive_t=
 *drive)
 		return ide_stopped;
 	}
=20
+	args.tf_flags =3D IDE_TFLAG_OUT_TF | IDE_TFLAG_OUT_DEVICE |
+			IDE_TFLAG_CUSTOM_HANDLER;
+
 	do_rw_taskfile(drive, &args);
=20
 	return ide_started;
@@ -861,13 +847,17 @@ static ide_startstop_t execute_drive_cmd (ide_dri=
ve_t *drive,
 		struct request *rq)
 {
 	ide_hwif_t *hwif =3D HWIF(drive);
+	u8 *args =3D rq->buffer;
+	ide_task_t ltask;
+	struct ide_taskfile *tf =3D &ltask.tf;
+
 	if (rq->cmd_type =3D=3D REQ_TYPE_ATA_TASKFILE) {
- 		ide_task_t *args =3D rq->special;
+		ide_task_t *task =3D rq->special;
 =20
-		if (!args)
+		if (task =3D=3D NULL)
 			goto done;
=20
-		hwif->data_phase =3D args->data_phase;
+		hwif->data_phase =3D task->data_phase;
=20
 		switch (hwif->data_phase) {
 		case TASKFILE_MULTI_OUT:
@@ -880,55 +870,34 @@ static ide_startstop_t execute_drive_cmd (ide_dri=
ve_t *drive,
 			break;
 		}
=20
-		if (args->tf_out_flags.all !=3D 0)=20
-			return flagged_taskfile(drive, args);
-		return do_rw_taskfile(drive, args);
-	} else if (rq->cmd_type =3D=3D REQ_TYPE_ATA_TASK) {
-		u8 *args =3D rq->buffer;
-=20
-		if (!args)
-			goto done;
-#ifdef DEBUG
- 		printk("%s: DRIVE_TASK_CMD ", drive->name);
- 		printk("cmd=3D0x%02x ", args[0]);
- 		printk("fr=3D0x%02x ", args[1]);
- 		printk("ns=3D0x%02x ", args[2]);
- 		printk("sc=3D0x%02x ", args[3]);
- 		printk("lcyl=3D0x%02x ", args[4]);
- 		printk("hcyl=3D0x%02x ", args[5]);
- 		printk("sel=3D0x%02x\n", args[6]);
-#endif
- 		hwif->OUTB(args[1], IDE_FEATURE_REG);
- 		hwif->OUTB(args[3], IDE_SECTOR_REG);
- 		hwif->OUTB(args[4], IDE_LCYL_REG);
- 		hwif->OUTB(args[5], IDE_HCYL_REG);
- 		hwif->OUTB((args[6] & 0xEF)|drive->select.all, IDE_SELECT_REG);
- 		ide_cmd(drive, args[0], args[2], &drive_cmd_intr);
- 		return ide_started;
- 	} else if (rq->cmd_type =3D=3D REQ_TYPE_ATA_CMD) {
- 		u8 *args =3D rq->buffer;
-
-		if (!args)
-			goto done;
+		return do_rw_taskfile(drive, task);
+	}
+
+	if (args =3D=3D NULL)
+		goto done;
+
+	memset(&ltask, 0, sizeof(ltask));
+	if (rq->cmd_type =3D=3D REQ_TYPE_ATA_CMD) {
 #ifdef DEBUG
- 		printk("%s: DRIVE_CMD ", drive->name);
- 		printk("cmd=3D0x%02x ", args[0]);
- 		printk("sc=3D0x%02x ", args[1]);
- 		printk("fr=3D0x%02x ", args[2]);
- 		printk("xx=3D0x%02x\n", args[3]);
+		printk("%s: DRIVE_CMD\n", drive->name);
 #endif
- 		if (args[0] =3D=3D WIN_SMART) {
- 			hwif->OUTB(0x4f, IDE_LCYL_REG);
- 			hwif->OUTB(0xc2, IDE_HCYL_REG);
- 			hwif->OUTB(args[2],IDE_FEATURE_REG);
- 			hwif->OUTB(args[1],IDE_SECTOR_REG);
- 			ide_cmd(drive, args[0], args[3], &drive_cmd_intr);
- 			return ide_started;
- 		}
- 		hwif->OUTB(args[2],IDE_FEATURE_REG);
- 		ide_cmd(drive, args[0], args[1], &drive_cmd_intr);
- 		return ide_started;
+		tf->feature =3D args[2];
+		if (args[0] =3D=3D WIN_SMART) {
+			tf->nsect =3D args[3];
+			tf->lbal  =3D args[1];
+			tf->lbam  =3D 0x4f;
+			tf->lbah  =3D 0xc2;
+			ltask.tf_flags =3D IDE_TFLAG_OUT_TF;
+		} else {
+			tf->nsect =3D args[1];
+			ltask.tf_flags =3D IDE_TFLAG_OUT_FEATURE |
+					 IDE_TFLAG_OUT_NSECT;
+		}
  	}
+	tf->command =3D args[0];
+	ide_tf_load(drive, &ltask);
+	ide_execute_command(drive, args[0], &drive_cmd_intr, WAIT_WORSTCASE, =
NULL);
+	return ide_started;
=20
 done:
  	/*
@@ -1003,6 +972,7 @@ static ide_startstop_t start_request (ide_drive_t =
*drive, struct request *rq)
=20
 	/* bail early if we've exceeded max_failures */
 	if (drive->max_failures && (drive->failures > drive->max_failures)) {
+		rq->cmd_flags |=3D REQ_FAILED;
 		goto kill_rq;
 	}
=20
@@ -1035,7 +1005,6 @@ static ide_startstop_t start_request (ide_drive_t=
 *drive, struct request *rq)
 			ide_config_drive_speed(drive, drive->desired_speed);
=20
 		if (rq->cmd_type =3D=3D REQ_TYPE_ATA_CMD ||
-		    rq->cmd_type =3D=3D REQ_TYPE_ATA_TASK ||
 		    rq->cmd_type =3D=3D REQ_TYPE_ATA_TASKFILE)
 			return execute_drive_cmd(drive, rq);
 		else if (blk_pm_request(rq)) {
@@ -1247,8 +1216,12 @@ static void ide_do_request (ide_hwgroup_t *hwgro=
up, int masked_irq)
 		if (hwgroup->hwif->sharing_irq &&
 		    hwif !=3D hwgroup->hwif &&
 		    hwif->io_ports[IDE_CONTROL_OFFSET]) {
-			/* set nIEN for previous hwif */
-			SELECT_INTERRUPT(drive);
+			/*
+			 * set nIEN for previous hwif, drives in the
+			 * quirk_list may not like intr setups/cleanups
+			 */
+			if (drive->quirk_list !=3D 1)
+				hwif->OUTB(drive->ctl | 2, IDE_CONTROL_REG);
 		}
 		hwgroup->hwif =3D hwif;
 		hwgroup->drive =3D drive;
@@ -1454,12 +1427,8 @@ void ide_timer_expiry (unsigned long data)
 			 */
 			spin_unlock(&ide_lock);
 			hwif  =3D HWIF(drive);
-#if DISABLE_IRQ_NOSYNC
-			disable_irq_nosync(hwif->irq);
-#else
 			/* disable_irq_nosync ?? */
 			disable_irq(hwif->irq);
-#endif /* DISABLE_IRQ_NOSYNC */
 			/* local CPU only,
 			 * as if we were handling an interrupt */
 			local_irq_disable();
@@ -1785,3 +1754,19 @@ int ide_do_drive_cmd (ide_drive_t *drive, struct=
 request *rq, ide_action_t actio
 }
=20
 EXPORT_SYMBOL(ide_do_drive_cmd);
+
+void ide_pktcmd_tf_load(ide_drive_t *drive, u32 tf_flags, u16 bcount, =
u8 dma)
+{
+	ide_task_t task;
+
+	memset(&task, 0, sizeof(task));
+	task.tf_flags =3D IDE_TFLAG_OUT_LBAH | IDE_TFLAG_OUT_LBAM |
+			IDE_TFLAG_OUT_FEATURE | tf_flags;
+	task.tf.feature =3D dma;		/* Use PIO/DMA */
+	task.tf.lbam    =3D bcount & 0xff;
+	task.tf.lbah    =3D (bcount >> 8) & 0xff;
+
+	ide_tf_load(drive, &task);
+}
+
+EXPORT_SYMBOL_GPL(ide_pktcmd_tf_load);
diff --git a/drivers/ide/ide-iops.c b/drivers/ide/ide-iops.c
index bb9693d..c97c071 100644
--- a/drivers/ide/ide-iops.c
+++ b/drivers/ide/ide-iops.c
@@ -158,14 +158,6 @@ void default_hwif_mmiops (ide_hwif_t *hwif)
=20
 EXPORT_SYMBOL(default_hwif_mmiops);
=20
-u32 ide_read_24 (ide_drive_t *drive)
-{
-	u8 hcyl =3D HWIF(drive)->INB(IDE_HCYL_REG);
-	u8 lcyl =3D HWIF(drive)->INB(IDE_LCYL_REG);
-	u8 sect =3D HWIF(drive)->INB(IDE_SECTOR_REG);
-	return (hcyl<<16)|(lcyl<<8)|sect;
-}
-
 void SELECT_DRIVE (ide_drive_t *drive)
 {
 	if (HWIF(drive)->selectproc)
@@ -175,26 +167,12 @@ void SELECT_DRIVE (ide_drive_t *drive)
=20
 EXPORT_SYMBOL(SELECT_DRIVE);
=20
-void SELECT_INTERRUPT (ide_drive_t *drive)
-{
-	if (HWIF(drive)->intrproc)
-		HWIF(drive)->intrproc(drive);
-	else
-		HWIF(drive)->OUTB(drive->ctl|2, IDE_CONTROL_REG);
-}
-
 void SELECT_MASK (ide_drive_t *drive, int mask)
 {
 	if (HWIF(drive)->maskproc)
 		HWIF(drive)->maskproc(drive, mask);
 }
=20
-void QUIRK_LIST (ide_drive_t *drive)
-{
-	if (HWIF(drive)->quirkproc)
-		drive->quirk_list =3D HWIF(drive)->quirkproc(drive);
-}
-
 /*
  * Some localbus EIDE interfaces require a special access sequence
  * when using 32-bit I/O instructions to transfer data.  We call this
@@ -449,7 +427,6 @@ int drive_is_ready (ide_drive_t *drive)
 	udelay(1);
 #endif
=20
-#ifdef CONFIG_IDEPCI_SHARE_IRQ
 	/*
 	 * We do a passive status test under shared PCI interrupts on
 	 * cards that truly share the ATA side interrupt, but may also share
@@ -459,7 +436,6 @@ int drive_is_ready (ide_drive_t *drive)
 	if (IDE_CONTROL_REG)
 		stat =3D hwif->INB(IDE_ALTSTATUS_REG);
 	else
-#endif /* CONFIG_IDEPCI_SHARE_IRQ */
 		/* Note: this may clear a pending IRQ!! */
 		stat =3D hwif->INB(IDE_STATUS_REG);
=20
@@ -642,9 +618,9 @@ no_80w:
=20
 int ide_ata66_check (ide_drive_t *drive, ide_task_t *args)
 {
-	if ((args->tfRegister[IDE_COMMAND_OFFSET] =3D=3D WIN_SETFEATURES) &&
-	    (args->tfRegister[IDE_SECTOR_OFFSET] > XFER_UDMA_2) &&
-	    (args->tfRegister[IDE_FEATURE_OFFSET] =3D=3D SETFEATURES_XFER)) {
+	if (args->tf.command =3D=3D WIN_SETFEATURES &&
+	    args->tf.lbal > XFER_UDMA_2 &&
+	    args->tf.feature =3D=3D SETFEATURES_XFER) {
 		if (eighty_ninty_three(drive) =3D=3D 0) {
 			printk(KERN_WARNING "%s: UDMA speeds >UDMA33 cannot "
 					    "be set\n", drive->name);
@@ -662,9 +638,9 @@ int ide_ata66_check (ide_drive_t *drive, ide_task_t=
 *args)
  */
 int set_transfer (ide_drive_t *drive, ide_task_t *args)
 {
-	if ((args->tfRegister[IDE_COMMAND_OFFSET] =3D=3D WIN_SETFEATURES) &&
-	    (args->tfRegister[IDE_SECTOR_OFFSET] >=3D XFER_SW_DMA_0) &&
-	    (args->tfRegister[IDE_FEATURE_OFFSET] =3D=3D SETFEATURES_XFER) &&
+	if (args->tf.command =3D=3D WIN_SETFEATURES &&
+	    args->tf.lbal >=3D XFER_SW_DMA_0 &&
+	    args->tf.feature =3D=3D SETFEATURES_XFER &&
 	    (drive->id->dma_ultra ||
 	     drive->id->dma_mword ||
 	     drive->id->dma_1word))
@@ -902,8 +878,9 @@ EXPORT_SYMBOL(ide_set_handler);
  *	handler and IRQ setup do not race. All IDE command kick off
  *	should go via this function or do equivalent locking.
  */
-=20
-void ide_execute_command(ide_drive_t *drive, task_ioreg_t cmd, ide_han=
dler_t *handler, unsigned timeout, ide_expiry_t *expiry)
+
+void ide_execute_command(ide_drive_t *drive, u8 cmd, ide_handler_t *ha=
ndler,
+			 unsigned timeout, ide_expiry_t *expiry)
 {
 	unsigned long flags;
 	ide_hwgroup_t *hwgroup =3D HWGROUP(drive);
@@ -1051,8 +1028,7 @@ static void ide_disk_pre_reset(ide_drive_t *drive=
)
 	drive->special.all =3D 0;
 	drive->special.b.set_geometry =3D legacy;
 	drive->special.b.recalibrate  =3D legacy;
-	if (OK_TO_RESET_CONTROLLER)
-		drive->mult_count =3D 0;
+	drive->mult_count =3D 0;
 	if (!drive->keep_settings && !drive->using_dma)
 		drive->mult_req =3D 0;
 	if (drive->mult_req !=3D drive->mult_count)
@@ -1137,7 +1113,6 @@ static ide_startstop_t do_reset1 (ide_drive_t *dr=
ive, int do_not_try_atapi)
 	for (unit =3D 0; unit < MAX_DRIVES; ++unit)
 		pre_reset(&hwif->drives[unit]);
=20
-#if OK_TO_RESET_CONTROLLER
 	if (!IDE_CONTROL_REG) {
 		spin_unlock_irqrestore(&ide_lock, flags);
 		return ide_stopped;
@@ -1174,11 +1149,8 @@ static ide_startstop_t do_reset1 (ide_drive_t *d=
rive, int do_not_try_atapi)
 	 * state when the disks are reset this way. At least, the Winbond
 	 * 553 documentation says that
 	 */
-	if (hwif->resetproc !=3D NULL) {
+	if (hwif->resetproc)
 		hwif->resetproc(drive);
-	}
-=09
-#endif	/* OK_TO_RESET_CONTROLLER */
=20
 	spin_unlock_irqrestore(&ide_lock, flags);
 	return ide_started;
diff --git a/drivers/ide/ide-lib.c b/drivers/ide/ide-lib.c
index 062d3bc..a3bd8e8 100644
--- a/drivers/ide/ide-lib.c
+++ b/drivers/ide/ide-lib.c
@@ -441,6 +441,12 @@ int ide_set_xfer_rate(ide_drive_t *drive, u8 rate)
 	 * case could happen iff the transfer mode has already been set on
 	 * the device by ide-proc.c::set_xfer_rate()).
 	 */
+	if (rate < XFER_PIO_0) {
+		if (hwif->host_flags & IDE_HFLAG_ABUSE_SET_DMA_MODE)
+			return ide_set_dma_mode(drive, rate);
+		else
+			return ide_config_drive_speed(drive, rate);
+	}
=20
 	return ide_set_dma_mode(drive, rate);
 }
@@ -458,8 +464,7 @@ static void ide_dump_opcode(ide_drive_t *drive)
 	spin_unlock(&ide_lock);
 	if (!rq)
 		return;
-	if (rq->cmd_type =3D=3D REQ_TYPE_ATA_CMD ||
-	    rq->cmd_type =3D=3D REQ_TYPE_ATA_TASK) {
+	if (rq->cmd_type =3D=3D REQ_TYPE_ATA_CMD) {
 		char *args =3D rq->buffer;
 		if (args) {
 			opcode =3D args[0];
@@ -468,8 +473,7 @@ static void ide_dump_opcode(ide_drive_t *drive)
 	} else if (rq->cmd_type =3D=3D REQ_TYPE_ATA_TASKFILE) {
 		ide_task_t *args =3D rq->special;
 		if (args) {
-			task_struct_t *tf =3D (task_struct_t *) args->tfRegister;
-			opcode =3D tf->command;
+			opcode =3D args->tf.command;
 			found =3D 1;
 		}
 	}
@@ -481,141 +485,118 @@ static void ide_dump_opcode(ide_drive_t *drive)
 		printk("0x%02x\n", opcode);
 }
=20
-static u8 ide_dump_ata_status(ide_drive_t *drive, const char *msg, u8 =
stat)
+u64 ide_get_lba_addr(struct ide_taskfile *tf, int lba48)
 {
-	ide_hwif_t *hwif =3D HWIF(drive);
-	unsigned long flags;
-	u8 err =3D 0;
+	u32 high, low;
=20
-	local_irq_save(flags);
-	printk("%s: %s: status=3D0x%02x { ", drive->name, msg, stat);
-	if (stat & BUSY_STAT)
-		printk("Busy ");
-	else {
-		if (stat & READY_STAT)	printk("DriveReady ");
-		if (stat & WRERR_STAT)	printk("DeviceFault ");
-		if (stat & SEEK_STAT)	printk("SeekComplete ");
-		if (stat & DRQ_STAT)	printk("DataRequest ");
-		if (stat & ECC_STAT)	printk("CorrectedError ");
-		if (stat & INDEX_STAT)	printk("Index ");
-		if (stat & ERR_STAT)	printk("Error ");
+	if (lba48)
+		high =3D (tf->hob_lbah << 16) | (tf->hob_lbam << 8) |
+			tf->hob_lbal;
+	else
+		high =3D tf->device & 0xf;
+	low  =3D (tf->lbah << 16) | (tf->lbam << 8) | tf->lbal;
+
+	return ((u64)high << 24) | low;
+}
+EXPORT_SYMBOL_GPL(ide_get_lba_addr);
+
+static void ide_dump_sector(ide_drive_t *drive)
+{
+	ide_task_t task;
+	struct ide_taskfile *tf =3D &task.tf;
+	int lba48 =3D (drive->addressing =3D=3D 1) ? 1 : 0;
+
+	memset(&task, 0, sizeof(task));
+	if (lba48)
+		task.tf_flags =3D IDE_TFLAG_IN_LBA | IDE_TFLAG_IN_HOB_LBA |
+				IDE_TFLAG_LBA48;
+	else
+		task.tf_flags =3D IDE_TFLAG_IN_LBA | IDE_TFLAG_IN_DEVICE;
+
+	ide_tf_read(drive, &task);
+
+	if (lba48 || (tf->device & ATA_LBA))
+		printk(", LBAsect=3D%llu",
+			(unsigned long long)ide_get_lba_addr(tf, lba48));
+	else
+		printk(", CHS=3D%d/%d/%d", (tf->lbah << 8) + tf->lbam,
+					 tf->device & 0xf, tf->lbal);
+}
+
+static void ide_dump_ata_error(ide_drive_t *drive, u8 err)
+{
+	printk("{ ");
+	if (err & ABRT_ERR)	printk("DriveStatusError ");
+	if (err & ICRC_ERR)
+		printk((err & ABRT_ERR) ? "BadCRC " : "BadSector ");
+	if (err & ECC_ERR)	printk("UncorrectableError ");
+	if (err & ID_ERR)	printk("SectorIdNotFound ");
+	if (err & TRK0_ERR)	printk("TrackZeroNotFound ");
+	if (err & MARK_ERR)	printk("AddrMarkNotFound ");
+	printk("}");
+	if ((err & (BBD_ERR | ABRT_ERR)) =3D=3D BBD_ERR ||
+	    (err & (ECC_ERR|ID_ERR|MARK_ERR))) {
+		ide_dump_sector(drive);
+		if (HWGROUP(drive) && HWGROUP(drive)->rq)
+			printk(", sector=3D%llu",
+			       (unsigned long long)HWGROUP(drive)->rq->sector);
 	}
+	printk("\n");
+}
+
+static void ide_dump_atapi_error(ide_drive_t *drive, u8 err)
+{
+	printk("{ ");
+	if (err & ILI_ERR)	printk("IllegalLengthIndication ");
+	if (err & EOM_ERR)	printk("EndOfMedia ");
+	if (err & ABRT_ERR)	printk("AbortedCommand ");
+	if (err & MCR_ERR)	printk("MediaChangeRequested ");
+	if (err & LFS_ERR)	printk("LastFailedSense=3D0x%02x ",
+				       (err & LFS_ERR) >> 4);
 	printk("}\n");
-	if ((stat & (BUSY_STAT|ERR_STAT)) =3D=3D ERR_STAT) {
-		err =3D hwif->INB(IDE_ERROR_REG);
-		printk("%s: %s: error=3D0x%02x { ", drive->name, msg, err);
-		if (err & ABRT_ERR)	printk("DriveStatusError ");
-		if (err & ICRC_ERR)
-			printk((err & ABRT_ERR) ? "BadCRC " : "BadSector ");
-		if (err & ECC_ERR)	printk("UncorrectableError ");
-		if (err & ID_ERR)	printk("SectorIdNotFound ");
-		if (err & TRK0_ERR)	printk("TrackZeroNotFound ");
-		if (err & MARK_ERR)	printk("AddrMarkNotFound ");
-		printk("}");
-		if ((err & (BBD_ERR | ABRT_ERR)) =3D=3D BBD_ERR ||
-		    (err & (ECC_ERR|ID_ERR|MARK_ERR))) {
-			if (drive->addressing =3D=3D 1) {
-				__u64 sectors =3D 0;
-				u32 low =3D 0, high =3D 0;
-				hwif->OUTB(drive->ctl&~0x80, IDE_CONTROL_REG);
-				low =3D ide_read_24(drive);
-				hwif->OUTB(drive->ctl|0x80, IDE_CONTROL_REG);
-				high =3D ide_read_24(drive);
-				sectors =3D ((__u64)high << 24) | low;
-				printk(", LBAsect=3D%llu, high=3D%d, low=3D%d",
-				       (unsigned long long) sectors,
-				       high, low);
-			} else {
-				u8 cur =3D hwif->INB(IDE_SELECT_REG);
-				if (cur & 0x40) {	/* using LBA? */
-					printk(", LBAsect=3D%ld", (unsigned long)
-					 ((cur&0xf)<<24)
-					 |(hwif->INB(IDE_HCYL_REG)<<16)
-					 |(hwif->INB(IDE_LCYL_REG)<<8)
-					 | hwif->INB(IDE_SECTOR_REG));
-				} else {
-					printk(", CHS=3D%d/%d/%d",
-					 (hwif->INB(IDE_HCYL_REG)<<8) +
-					  hwif->INB(IDE_LCYL_REG),
-					  cur & 0xf,
-					  hwif->INB(IDE_SECTOR_REG));
-				}
-			}
-			if (HWGROUP(drive) && HWGROUP(drive)->rq)
-				printk(", sector=3D%llu",
-					(unsigned long long)HWGROUP(drive)->rq->sector);
-		}
-		printk("\n");
-	}
-	ide_dump_opcode(drive);
-	local_irq_restore(flags);
-	return err;
 }
=20
 /**
- *	ide_dump_atapi_status       -       print human readable atapi stat=
us
+ *	ide_dump_status		-	translate ATA/ATAPI error
  *	@drive: drive that status applies to
  *	@msg: text message to print
  *	@stat: status byte to decode
  *
  *	Error reporting, in human readable form (luxurious, but a memory ho=
g).
+ *	Combines the drive name, message and status byte to provide a
+ *	user understandable explanation of the device error.
  */
=20
-static u8 ide_dump_atapi_status(ide_drive_t *drive, const char *msg, u=
8 stat)
+u8 ide_dump_status(ide_drive_t *drive, const char *msg, u8 stat)
 {
 	unsigned long flags;
+	u8 err =3D 0;
=20
-	atapi_status_t status;
-	atapi_error_t error;
-
-	status.all =3D stat;
-	error.all =3D 0;
 	local_irq_save(flags);
 	printk("%s: %s: status=3D0x%02x { ", drive->name, msg, stat);
-	if (status.b.bsy)
+	if (stat & BUSY_STAT)
 		printk("Busy ");
 	else {
-		if (status.b.drdy)	printk("DriveReady ");
-		if (status.b.df)	printk("DeviceFault ");
-		if (status.b.dsc)	printk("SeekComplete ");
-		if (status.b.drq)	printk("DataRequest ");
-		if (status.b.corr)	printk("CorrectedError ");
-		if (status.b.idx)	printk("Index ");
-		if (status.b.check)	printk("Error ");
+		if (stat & READY_STAT)	printk("DriveReady ");
+		if (stat & WRERR_STAT)	printk("DeviceFault ");
+		if (stat & SEEK_STAT)	printk("SeekComplete ");
+		if (stat & DRQ_STAT)	printk("DataRequest ");
+		if (stat & ECC_STAT)	printk("CorrectedError ");
+		if (stat & INDEX_STAT)	printk("Index ");
+		if (stat & ERR_STAT)	printk("Error ");
 	}
 	printk("}\n");
-	if (status.b.check && !status.b.bsy) {
-		error.all =3D HWIF(drive)->INB(IDE_ERROR_REG);
-		printk("%s: %s: error=3D0x%02x { ", drive->name, msg, error.all);
-		if (error.b.ili)	printk("IllegalLengthIndication ");
-		if (error.b.eom)	printk("EndOfMedia ");
-		if (error.b.abrt)	printk("AbortedCommand ");
-		if (error.b.mcr)	printk("MediaChangeRequested ");
-		if (error.b.sense_key)	printk("LastFailedSense=3D0x%02x ",
-						error.b.sense_key);
-		printk("}\n");
+	if ((stat & (BUSY_STAT|ERR_STAT)) =3D=3D ERR_STAT) {
+		err =3D drive->hwif->INB(IDE_ERROR_REG);
+		printk("%s: %s: error=3D0x%02x ", drive->name, msg, err);
+		if (drive->media =3D=3D ide_disk)
+			ide_dump_ata_error(drive, err);
+		else
+			ide_dump_atapi_error(drive, err);
 	}
 	ide_dump_opcode(drive);
 	local_irq_restore(flags);
-	return error.all;
-}
-
-/**
- *	ide_dump_status		-	translate ATA/ATAPI error
- *	@drive: drive the error occured on
- *	@msg: information string
- *	@stat: status byte
- *
- *	Error reporting, in human readable form (luxurious, but a memory ho=
g).
- *	Combines the drive name, message and status byte to provide a
- *	user understandable explanation of the device error.
- */
-
-u8 ide_dump_status(ide_drive_t *drive, const char *msg, u8 stat)
-{
-	if (drive->media =3D=3D ide_disk)
-		return ide_dump_ata_status(drive, msg, stat);
-	return ide_dump_atapi_status(drive, msg, stat);
+	return err;
 }
=20
 EXPORT_SYMBOL(ide_dump_status);
diff --git a/drivers/ide/ide-probe.c b/drivers/ide/ide-probe.c
index 0cb3d2b..0379d1f 100644
--- a/drivers/ide/ide-probe.c
+++ b/drivers/ide/ide-probe.c
@@ -95,10 +95,10 @@ static void ide_disk_init_mult_count(ide_drive_t *d=
rive)
 #ifdef CONFIG_IDEDISK_MULTI_MODE
 		id->multsect =3D ((id->max_multsect/2) > 1) ? id->max_multsect : 0;
 		id->multsect_valid =3D id->multsect ? 1 : 0;
-		drive->mult_req =3D id->multsect_valid ? id->max_multsect : INITIAL_=
MULT_COUNT;
+		drive->mult_req =3D id->multsect_valid ? id->max_multsect : 0;
 		drive->special.b.set_multmode =3D drive->mult_req ? 1 : 0;
 #else	/* original, pre IDE-NFG, per request of AC */
-		drive->mult_req =3D INITIAL_MULT_COUNT;
+		drive->mult_req =3D 0;
 		if (drive->mult_req > id->max_multsect)
 			drive->mult_req =3D id->max_multsect;
 		if (drive->mult_req || ((id->multsect_valid & 1) && id->multsect))
@@ -234,7 +234,10 @@ static inline void do_identify (ide_drive_t *drive=
, u8 cmd)
=20
 	drive->media =3D ide_disk;
 	printk("%s DISK drive\n", (id->config =3D=3D 0x848a) ? "CFA" : "ATA" =
);
-	QUIRK_LIST(drive);
+
+	if (hwif->quirkproc)
+		drive->quirk_list =3D hwif->quirkproc(drive);
+
 	return;
=20
 err_misc:
@@ -830,16 +833,8 @@ static void probe_hwif(ide_hwif_t *hwif)
=20
 			drive->nice1 =3D 1;
=20
-			if (hwif->ide_dma_on) {
-				/*
-				 * Force DMAing for the beginning of the check.
-				 * Some chipsets appear to do interesting
-				 * things, if not checked and cleared.
-				 *   PARANOIA!!!
-				 */
-				hwif->dma_off_quietly(drive);
+			if (hwif->ide_dma_on)
 				ide_set_dma(drive);
-			}
 		}
 	}
=20
@@ -968,11 +963,6 @@ static int ide_init_queue(ide_drive_t *drive)
  * Much of the code is for correctly detecting/handling irq sharing
  * and irq serialization situations.  This is somewhat complex because
  * it handles static as well as dynamic (PCMCIA) IDE interfaces.
- *
- * The IRQF_DISABLED in sa_flags means ide_intr() is always entered wi=
th
- * interrupts completely disabled.  This can be bad for interrupt late=
ncy,
- * but anything else has led to problems on some machines.  We re-enab=
le
- * interrupts as much as we can safely do in most places.
  */
 static int init_irq (ide_hwif_t *hwif)
 {
@@ -1055,17 +1045,13 @@ static int init_irq (ide_hwif_t *hwif)
 	 * Allocate the irq, if not already obtained for another hwif
 	 */
 	if (!match || match->irq !=3D hwif->irq) {
-		int sa =3D IRQF_DISABLED;
+		int sa =3D 0;
 #if defined(__mc68000__) || defined(CONFIG_APUS)
 		sa =3D IRQF_SHARED;
 #endif /* __mc68000__ || CONFIG_APUS */
=20
-		if (IDE_CHIPSET_IS_PCI(hwif->chipset)) {
+		if (IDE_CHIPSET_IS_PCI(hwif->chipset))
 			sa =3D IRQF_SHARED;
-#ifndef CONFIG_IDEPCI_SHARE_IRQ
-			sa |=3D IRQF_DISABLED;
-#endif /* CONFIG_IDEPCI_SHARE_IRQ */
-		}
=20
 		if (hwif->io_ports[IDE_CONTROL_OFFSET])
 			/* clear nIEN */
diff --git a/drivers/ide/ide-tape.c b/drivers/ide/ide-tape.c
index 1495792..3cbca3f 100644
--- a/drivers/ide/ide-tape.c
+++ b/drivers/ide/ide-tape.c
@@ -615,16 +615,6 @@ typedef struct os_dat_s {
 /*************************** End of tunable parameters ***************=
********/
=20
 /*
- *	Debugging/Performance analysis
- *
- *	I/O trace support
- */
-#define USE_IOTRACE	0
-#if USE_IOTRACE
-#define IO_IDETAPE_FIFO	500
-#endif
-
-/*
  *	Read/Write error simulation
  */
 #define SIMULATE_ERRORS			0
@@ -1818,9 +1808,8 @@ static ide_startstop_t idetape_retry_pc (ide_driv=
e_t *drive)
 	idetape_tape_t *tape =3D drive->driver_data;
 	idetape_pc_t *pc;
 	struct request *rq;
-	atapi_error_t error;
=20
-	error.all =3D HWIF(drive)->INB(IDE_ERROR_REG);
+	(void)drive->hwif->INB(IDE_ERROR_REG);
 	pc =3D idetape_next_pc_storage(drive);
 	rq =3D idetape_next_rq_storage(drive);
 	idetape_create_request_sense_cmd(pc);
@@ -1858,15 +1847,13 @@ static ide_startstop_t idetape_pc_intr (ide_dri=
ve_t *drive)
 {
 	ide_hwif_t *hwif =3D drive->hwif;
 	idetape_tape_t *tape =3D drive->driver_data;
-	atapi_status_t status;
-	atapi_bcount_t bcount;
-	atapi_ireason_t ireason;
 	idetape_pc_t *pc =3D tape->pc;
-
 	unsigned int temp;
 #if SIMULATE_ERRORS
 	static int error_sim_count =3D 0;
 #endif
+	u16 bcount;
+	u8 stat, ireason;
=20
 #if IDETAPE_DEBUG_LOG
 	if (tape->debug_level >=3D 4)
@@ -1875,10 +1862,10 @@ static ide_startstop_t idetape_pc_intr (ide_dri=
ve_t *drive)
 #endif /* IDETAPE_DEBUG_LOG */=09
=20
 	/* Clear the interrupt */
-	status.all =3D HWIF(drive)->INB(IDE_STATUS_REG);
+	stat =3D hwif->INB(IDE_STATUS_REG);
=20
 	if (test_bit(PC_DMA_IN_PROGRESS, &pc->flags)) {
-		if (HWIF(drive)->ide_dma_end(drive) || status.b.check) {
+		if (hwif->ide_dma_end(drive) || (stat & ERR_STAT)) {
 			/*
 			 * A DMA error is sometimes expected. For example,
 			 * if the tape is crossing a filemark during a
@@ -1912,7 +1899,7 @@ static ide_startstop_t idetape_pc_intr (ide_drive=
_t *drive)
 	}
=20
 	/* No more interrupts */
-	if (!status.b.drq) {
+	if ((stat & DRQ_STAT) =3D=3D 0) {
 #if IDETAPE_DEBUG_LOG
 		if (tape->debug_level >=3D 2)
 			printk(KERN_INFO "ide-tape: Packet command completed, %d bytes tran=
sferred\n", pc->actually_transferred);
@@ -1927,12 +1914,13 @@ static ide_startstop_t idetape_pc_intr (ide_dri=
ve_t *drive)
 		    (++error_sim_count % 100) =3D=3D 0) {
 			printk(KERN_INFO "ide-tape: %s: simulating error\n",
 				tape->name);
-			status.b.check =3D 1;
+			stat |=3D ERR_STAT;
 		}
 #endif
-		if (status.b.check && pc->c[0] =3D=3D IDETAPE_REQUEST_SENSE_CMD)
-			status.b.check =3D 0;
-		if (status.b.check || test_bit(PC_DMA_ERROR, &pc->flags)) {	/* Error=
 detected */
+		if ((stat & ERR_STAT) && pc->c[0] =3D=3D IDETAPE_REQUEST_SENSE_CMD)
+			stat &=3D ~ERR_STAT;
+		if ((stat & ERR_STAT) || test_bit(PC_DMA_ERROR, &pc->flags)) {
+			/* Error detected */
 #if IDETAPE_DEBUG_LOG
 			if (tape->debug_level >=3D 1)
 				printk(KERN_INFO "ide-tape: %s: I/O error\n",
@@ -1951,7 +1939,7 @@ static ide_startstop_t idetape_pc_intr (ide_drive=
_t *drive)
 		}
 		pc->error =3D 0;
 		if (test_bit(PC_WAIT_FOR_DSC, &pc->flags) &&
-		    !status.b.dsc) {
+		    (stat & SEEK_STAT) =3D=3D 0) {
 			/* Media access command */
 			tape->dsc_polling_start =3D jiffies;
 			tape->dsc_polling_frequency =3D IDETAPE_DSC_MA_FAST;
@@ -1973,30 +1961,30 @@ static ide_startstop_t idetape_pc_intr (ide_dri=
ve_t *drive)
 		return ide_do_reset(drive);
 	}
 	/* Get the number of bytes to transfer on this interrupt. */
-	bcount.b.high =3D hwif->INB(IDE_BCOUNTH_REG);
-	bcount.b.low =3D hwif->INB(IDE_BCOUNTL_REG);
+	bcount =3D (hwif->INB(IDE_BCOUNTH_REG) << 8) |
+		  hwif->INB(IDE_BCOUNTL_REG);
=20
-	ireason.all =3D hwif->INB(IDE_IREASON_REG);
+	ireason =3D hwif->INB(IDE_IREASON_REG);
=20
-	if (ireason.b.cod) {
+	if (ireason & CD) {
 		printk(KERN_ERR "ide-tape: CoD !=3D 0 in idetape_pc_intr\n");
 		return ide_do_reset(drive);
 	}
-	if (ireason.b.io =3D=3D test_bit(PC_WRITING, &pc->flags)) {
+	if (((ireason & IO) =3D=3D IO) =3D=3D test_bit(PC_WRITING, &pc->flags=
)) {
 		/* Hopefully, we will never get here */
 		printk(KERN_ERR "ide-tape: We wanted to %s, ",
-			ireason.b.io ? "Write":"Read");
+				(ireason & IO) ? "Write" : "Read");
 		printk(KERN_ERR "ide-tape: but the tape wants us to %s !\n",
-			ireason.b.io ? "Read":"Write");
+				(ireason & IO) ? "Read" : "Write");
 		return ide_do_reset(drive);
 	}
 	if (!test_bit(PC_WRITING, &pc->flags)) {
 		/* Reading - Check that we have enough space */
-		temp =3D pc->actually_transferred + bcount.all;
+		temp =3D pc->actually_transferred + bcount;
 		if (temp > pc->request_transfer) {
 			if (temp > pc->buffer_size) {
 				printk(KERN_ERR "ide-tape: The tape wants to send us more data tha=
n expected - discarding data\n");
-				idetape_discard_data(drive, bcount.all);
+				idetape_discard_data(drive, bcount);
 				ide_set_handler(drive, &idetape_pc_intr, IDETAPE_WAIT_CMD, NULL);
 				return ide_started;
 			}
@@ -2008,23 +1996,26 @@ static ide_startstop_t idetape_pc_intr (ide_dri=
ve_t *drive)
 	}
 	if (test_bit(PC_WRITING, &pc->flags)) {
 		if (pc->bh !=3D NULL)
-			idetape_output_buffers(drive, pc, bcount.all);
+			idetape_output_buffers(drive, pc, bcount);
 		else
 			/* Write the current buffer */
-			HWIF(drive)->atapi_output_bytes(drive, pc->current_position, bcount=
=2Eall);
+			hwif->atapi_output_bytes(drive, pc->current_position,
+						 bcount);
 	} else {
 		if (pc->bh !=3D NULL)
-			idetape_input_buffers(drive, pc, bcount.all);
+			idetape_input_buffers(drive, pc, bcount);
 		else
 			/* Read the current buffer */
-			HWIF(drive)->atapi_input_bytes(drive, pc->current_position, bcount.=
all);
+			hwif->atapi_input_bytes(drive, pc->current_position,
+						bcount);
 	}
 	/* Update the current position */
-	pc->actually_transferred +=3D bcount.all;
-	pc->current_position +=3D bcount.all;
+	pc->actually_transferred +=3D bcount;
+	pc->current_position +=3D bcount;
 #if IDETAPE_DEBUG_LOG
 	if (tape->debug_level >=3D 2)
-		printk(KERN_INFO "ide-tape: [cmd %x] transferred %d bytes on that in=
terrupt\n", pc->c[0], bcount.all);
+		printk(KERN_INFO "ide-tape: [cmd %x] transferred %d bytes "
+				 "on that interrupt\n", pc->c[0], bcount);
 #endif
 	/* And set the interrupt handler again */
 	ide_set_handler(drive, &idetape_pc_intr, IDETAPE_WAIT_CMD, NULL);
@@ -2078,28 +2069,28 @@ static ide_startstop_t idetape_transfer_pc(ide_=
drive_t *drive)
 	ide_hwif_t *hwif =3D drive->hwif;
 	idetape_tape_t *tape =3D drive->driver_data;
 	idetape_pc_t *pc =3D tape->pc;
-	atapi_ireason_t ireason;
 	int retries =3D 100;
 	ide_startstop_t startstop;
+	u8 ireason;
=20
 	if (ide_wait_stat(&startstop,drive,DRQ_STAT,BUSY_STAT,WAIT_READY)) {
 		printk(KERN_ERR "ide-tape: Strange, packet command initiated yet DRQ=
 isn't asserted\n");
 		return startstop;
 	}
-	ireason.all =3D hwif->INB(IDE_IREASON_REG);
-	while (retries-- && (!ireason.b.cod || ireason.b.io)) {
+	ireason =3D hwif->INB(IDE_IREASON_REG);
+	while (retries-- && ((ireason & CD) =3D=3D 0 || (ireason & IO))) {
 		printk(KERN_ERR "ide-tape: (IO,CoD !=3D (0,1) while issuing "
 				"a packet command, retrying\n");
 		udelay(100);
-		ireason.all =3D hwif->INB(IDE_IREASON_REG);
+		ireason =3D hwif->INB(IDE_IREASON_REG);
 		if (retries =3D=3D 0) {
 			printk(KERN_ERR "ide-tape: (IO,CoD !=3D (0,1) while "
 					"issuing a packet command, ignoring\n");
-			ireason.b.cod =3D 1;
-			ireason.b.io =3D 0;
+			ireason |=3D CD;
+			ireason &=3D ~IO;
 		}
 	}
-	if (!ireason.b.cod || ireason.b.io) {
+	if ((ireason & CD) =3D=3D 0 || (ireason & IO)) {
 		printk(KERN_ERR "ide-tape: (IO,CoD) !=3D (0,1) while issuing "
 				"a packet command\n");
 		return ide_do_reset(drive);
@@ -2120,8 +2111,8 @@ static ide_startstop_t idetape_issue_packet_comma=
nd (ide_drive_t *drive, idetape
 {
 	ide_hwif_t *hwif =3D drive->hwif;
 	idetape_tape_t *tape =3D drive->driver_data;
-	atapi_bcount_t bcount;
 	int dma_ok =3D 0;
+	u16 bcount;
=20
 #if IDETAPE_DEBUG_BUGS
 	if (tape->pc->c[0] =3D=3D IDETAPE_REQUEST_SENSE_CMD &&
@@ -2170,7 +2161,7 @@ static ide_startstop_t idetape_issue_packet_comma=
nd (ide_drive_t *drive, idetape
 	pc->actually_transferred =3D 0;
 	pc->current_position =3D pc->buffer;
 	/* Request to transfer the entire buffer at once */
-	bcount.all =3D pc->request_transfer;
+	bcount =3D pc->request_transfer;
=20
 	if (test_and_clear_bit(PC_DMA_ERROR, &pc->flags)) {
 		printk(KERN_WARNING "ide-tape: DMA disabled, "
@@ -2180,12 +2171,9 @@ static ide_startstop_t idetape_issue_packet_comm=
and (ide_drive_t *drive, idetape
 	if (test_bit(PC_DMA_RECOMMENDED, &pc->flags) && drive->using_dma)
 		dma_ok =3D !hwif->dma_setup(drive);
=20
-	if (IDE_CONTROL_REG)
-		hwif->OUTB(drive->ctl, IDE_CONTROL_REG);
-	hwif->OUTB(dma_ok ? 1 : 0, IDE_FEATURE_REG);	/* Use PIO/DMA */
-	hwif->OUTB(bcount.b.high, IDE_BCOUNTH_REG);
-	hwif->OUTB(bcount.b.low, IDE_BCOUNTL_REG);
-	hwif->OUTB(drive->select.all, IDE_SELECT_REG);
+	ide_pktcmd_tf_load(drive, IDE_TFLAG_NO_SELECT_MASK |
+			   IDE_TFLAG_OUT_DEVICE, bcount, dma_ok);
+
 	if (dma_ok)			/* Will begin DMA later */
 		set_bit(PC_DMA_IN_PROGRESS, &pc->flags);
 	if (test_bit(IDETAPE_DRQ_INTERRUPT, &tape->flags)) {
@@ -2295,11 +2283,11 @@ static ide_startstop_t idetape_media_access_fin=
ished (ide_drive_t *drive)
 {
 	idetape_tape_t *tape =3D drive->driver_data;
 	idetape_pc_t *pc =3D tape->pc;
-	atapi_status_t status;
+	u8 stat;
=20
-	status.all =3D HWIF(drive)->INB(IDE_STATUS_REG);
-	if (status.b.dsc) {
-		if (status.b.check) {
+	stat =3D drive->hwif->INB(IDE_STATUS_REG);
+	if (stat & SEEK_STAT) {
+		if (stat & ERR_STAT) {
 			/* Error detected */
 			if (pc->c[0] !=3D IDETAPE_TEST_UNIT_READY_CMD)
 				printk(KERN_ERR "ide-tape: %s: I/O error, ",
@@ -2417,7 +2405,7 @@ static ide_startstop_t idetape_do_request(ide_dri=
ve_t *drive,
 	idetape_tape_t *tape =3D drive->driver_data;
 	idetape_pc_t *pc =3D NULL;
 	struct request *postponed_rq =3D tape->postponed_rq;
-	atapi_status_t status;
+	u8 stat;
=20
 #if IDETAPE_DEBUG_LOG
 #if 0
@@ -2465,7 +2453,7 @@ static ide_startstop_t idetape_do_request(ide_dri=
ve_t *drive,
 	 * If the tape is still busy, postpone our request and service
 	 * the other device meanwhile.
 	 */
-	status.all =3D HWIF(drive)->INB(IDE_STATUS_REG);
+	stat =3D drive->hwif->INB(IDE_STATUS_REG);
=20
 	if (!drive->dsc_overlap && !(rq->cmd[0] & REQ_IDETAPE_PC2))
 		set_bit(IDETAPE_IGNORE_DSC, &tape->flags);
@@ -2481,7 +2469,7 @@ static ide_startstop_t idetape_do_request(ide_dri=
ve_t *drive,
 		tape->insert_speed =3D tape->insert_size / 1024 * HZ / (jiffies - ta=
pe->insert_time);
 	calculate_speeds(drive);
 	if (!test_and_clear_bit(IDETAPE_IGNORE_DSC, &tape->flags) &&
-	    !status.b.dsc) {
+	    (stat & SEEK_STAT) =3D=3D 0) {
 		if (postponed_rq =3D=3D NULL) {
 			tape->dsc_polling_start =3D jiffies;
 			tape->dsc_polling_frequency =3D tape->best_dsc_rw_frequency;
@@ -2502,9 +2490,6 @@ static ide_startstop_t idetape_do_request(ide_dri=
ve_t *drive,
 	}
 	if (rq->cmd[0] & REQ_IDETAPE_READ) {
 		tape->buffer_head++;
-#if USE_IOTRACE
-		IO_trace(IO_IDETAPE_FIFO, tape->pipeline_head, tape->buffer_head, ta=
pe->tape_head, tape->minor);
-#endif
 		tape->postpone_cnt =3D 0;
 		pc =3D idetape_next_pc_storage(drive);
 		idetape_create_read_cmd(tape, pc, rq->current_nr_sectors, (struct id=
etape_bh *)rq->special);
@@ -2512,9 +2497,6 @@ static ide_startstop_t idetape_do_request(ide_dri=
ve_t *drive,
 	}
 	if (rq->cmd[0] & REQ_IDETAPE_WRITE) {
 		tape->buffer_head++;
-#if USE_IOTRACE
-		IO_trace(IO_IDETAPE_FIFO, tape->pipeline_head, tape->buffer_head, ta=
pe->tape_head, tape->minor);
-#endif
 		tape->postpone_cnt =3D 0;
 		pc =3D idetape_next_pc_storage(drive);
 		idetape_create_write_cmd(tape, pc, rq->current_nr_sectors, (struct i=
detape_bh *)rq->special);
@@ -3241,9 +3223,6 @@ static int idetape_add_chrdev_write_request (ide_=
drive_t *drive, int blocks)
 	idetape_switch_buffers(tape, new_stage);
 	idetape_add_stage_tail(drive, new_stage);
 	tape->pipeline_head++;
-#if USE_IOTRACE
-	IO_trace(IO_IDETAPE_FIFO, tape->pipeline_head, tape->buffer_head, tap=
e->tape_head, tape->minor);
-#endif
 	calculate_speeds(drive);
=20
 	/*
@@ -3493,9 +3472,6 @@ static int idetape_add_chrdev_read_request (ide_d=
rive_t *drive,int blocks)
 		idetape_remove_stage_head(drive);
 		spin_unlock_irqrestore(&tape->spinlock, flags);
 		tape->pipeline_head++;
-#if USE_IOTRACE
-		IO_trace(IO_IDETAPE_FIFO, tape->pipeline_head, tape->buffer_head, ta=
pe->tape_head, tape->minor);
-#endif
 		calculate_speeds(drive);
 	}
 #if IDETAPE_DEBUG_BUGS
diff --git a/drivers/ide/ide-taskfile.c b/drivers/ide/ide-taskfile.c
index 2b60f1b..2d63ea9 100644
--- a/drivers/ide/ide-taskfile.c
+++ b/drivers/ide/ide-taskfile.c
@@ -63,65 +63,78 @@ static void taskfile_output_data(ide_drive_t *drive=
, void *buffer, u32 wcount)
 	}
 }
=20
+void ide_tf_load(ide_drive_t *drive, ide_task_t *task)
+{
+	ide_hwif_t *hwif =3D drive->hwif;
+	struct ide_taskfile *tf =3D &task->tf;
+	u8 HIHI =3D (task->tf_flags & IDE_TFLAG_LBA48) ? 0xE0 : 0xEF;
+
+	if (task->tf_flags & IDE_TFLAG_FLAGGED)
+		HIHI =3D 0xFF;
+
+#ifdef DEBUG
+	printk("%s: tf: feat 0x%02x nsect 0x%02x lbal 0x%02x "
+		"lbam 0x%02x lbah 0x%02x dev 0x%02x cmd 0x%02x\n",
+		drive->name, tf->feature, tf->nsect, tf->lbal,
+		tf->lbam, tf->lbah, tf->device, tf->command);
+#endif
+
+	if (IDE_CONTROL_REG)
+		hwif->OUTB(drive->ctl, IDE_CONTROL_REG); /* clear nIEN */
+
+	if ((task->tf_flags & IDE_TFLAG_NO_SELECT_MASK) =3D=3D 0)
+		SELECT_MASK(drive, 0);
+
+	if (task->tf_flags & IDE_TFLAG_OUT_DATA)
+		hwif->OUTW((tf->hob_data << 8) | tf->data, IDE_DATA_REG);
+
+	if (task->tf_flags & IDE_TFLAG_OUT_HOB_FEATURE)
+		hwif->OUTB(tf->hob_feature, IDE_FEATURE_REG);
+	if (task->tf_flags & IDE_TFLAG_OUT_HOB_NSECT)
+		hwif->OUTB(tf->hob_nsect, IDE_NSECTOR_REG);
+	if (task->tf_flags & IDE_TFLAG_OUT_HOB_LBAL)
+		hwif->OUTB(tf->hob_lbal, IDE_SECTOR_REG);
+	if (task->tf_flags & IDE_TFLAG_OUT_HOB_LBAM)
+		hwif->OUTB(tf->hob_lbam, IDE_LCYL_REG);
+	if (task->tf_flags & IDE_TFLAG_OUT_HOB_LBAH)
+		hwif->OUTB(tf->hob_lbah, IDE_HCYL_REG);
+
+	if (task->tf_flags & IDE_TFLAG_OUT_FEATURE)
+		hwif->OUTB(tf->feature, IDE_FEATURE_REG);
+	if (task->tf_flags & IDE_TFLAG_OUT_NSECT)
+		hwif->OUTB(tf->nsect, IDE_NSECTOR_REG);
+	if (task->tf_flags & IDE_TFLAG_OUT_LBAL)
+		hwif->OUTB(tf->lbal, IDE_SECTOR_REG);
+	if (task->tf_flags & IDE_TFLAG_OUT_LBAM)
+		hwif->OUTB(tf->lbam, IDE_LCYL_REG);
+	if (task->tf_flags & IDE_TFLAG_OUT_LBAH)
+		hwif->OUTB(tf->lbah, IDE_HCYL_REG);
+
+	if (task->tf_flags & IDE_TFLAG_OUT_DEVICE)
+		hwif->OUTB((tf->device & HIHI) | drive->select.all, IDE_SELECT_REG);
+}
+
 int taskfile_lib_get_identify (ide_drive_t *drive, u8 *buf)
 {
 	ide_task_t args;
+
 	memset(&args, 0, sizeof(ide_task_t));
-	args.tfRegister[IDE_NSECTOR_OFFSET]	=3D 0x01;
+	args.tf.nsect =3D 0x01;
 	if (drive->media =3D=3D ide_disk)
-		args.tfRegister[IDE_COMMAND_OFFSET]	=3D WIN_IDENTIFY;
+		args.tf.command =3D WIN_IDENTIFY;
 	else
-		args.tfRegister[IDE_COMMAND_OFFSET]	=3D WIN_PIDENTIFY;
-	args.command_type =3D IDE_DRIVE_TASK_IN;
-	args.data_phase   =3D TASKFILE_IN;
-	args.handler	  =3D &task_in_intr;
-	return ide_raw_taskfile(drive, &args, buf);
+		args.tf.command =3D WIN_PIDENTIFY;
+	args.tf_flags	=3D IDE_TFLAG_OUT_TF | IDE_TFLAG_OUT_DEVICE;
+	args.data_phase	=3D TASKFILE_IN;
+	return ide_raw_taskfile(drive, &args, buf, 1);
 }
=20
-ide_startstop_t do_rw_taskfile (ide_drive_t *drive, ide_task_t *task)
+static int inline task_dma_ok(ide_task_t *task)
 {
-	ide_hwif_t *hwif	=3D HWIF(drive);
-	task_struct_t *taskfile	=3D (task_struct_t *) task->tfRegister;
-	hob_struct_t *hobfile	=3D (hob_struct_t *) task->hobRegister;
-	u8 HIHI			=3D (drive->addressing =3D=3D 1) ? 0xE0 : 0xEF;
-
-	/* ALL Command Block Executions SHALL clear nIEN, unless otherwise */
-	if (IDE_CONTROL_REG) {
-		/* clear nIEN */
-		hwif->OUTB(drive->ctl, IDE_CONTROL_REG);
-	}
-	SELECT_MASK(drive, 0);
-
-	if (drive->addressing =3D=3D 1) {
-		hwif->OUTB(hobfile->feature, IDE_FEATURE_REG);
-		hwif->OUTB(hobfile->sector_count, IDE_NSECTOR_REG);
-		hwif->OUTB(hobfile->sector_number, IDE_SECTOR_REG);
-		hwif->OUTB(hobfile->low_cylinder, IDE_LCYL_REG);
-		hwif->OUTB(hobfile->high_cylinder, IDE_HCYL_REG);
-	}
-
-	hwif->OUTB(taskfile->feature, IDE_FEATURE_REG);
-	hwif->OUTB(taskfile->sector_count, IDE_NSECTOR_REG);
-	hwif->OUTB(taskfile->sector_number, IDE_SECTOR_REG);
-	hwif->OUTB(taskfile->low_cylinder, IDE_LCYL_REG);
-	hwif->OUTB(taskfile->high_cylinder, IDE_HCYL_REG);
-
-	hwif->OUTB((taskfile->device_head & HIHI) | drive->select.all, IDE_SE=
LECT_REG);
-
-	if (task->handler !=3D NULL) {
-		if (task->prehandler !=3D NULL) {
-			hwif->OUTBSYNC(drive, taskfile->command, IDE_COMMAND_REG);
-			ndelay(400);	/* FIXME */
-			return task->prehandler(drive, task->rq);
-		}
-		ide_execute_command(drive, taskfile->command, task->handler, WAIT_WO=
RSTCASE, NULL);
-		return ide_started;
-	}
-
-	if (!drive->using_dma)
-		return ide_stopped;
+	if (blk_fs_request(task->rq) || (task->tf_flags & IDE_TFLAG_FLAGGED))
+		return 1;
=20
-	switch (taskfile->command) {
+	switch (task->tf.command) {
 		case WIN_WRITEDMA_ONCE:
 		case WIN_WRITEDMA:
 		case WIN_WRITEDMA_EXT:
@@ -129,24 +142,79 @@ ide_startstop_t do_rw_taskfile (ide_drive_t *driv=
e, ide_task_t *task)
 		case WIN_READDMA:
 		case WIN_READDMA_EXT:
 		case WIN_IDENTIFY_DMA:
-			if (!hwif->dma_setup(drive)) {
-				hwif->dma_exec_cmd(drive, taskfile->command);
-				hwif->dma_start(drive);
-				return ide_started;
-			}
-			break;
-		default:
-			if (task->handler =3D=3D NULL)
-				return ide_stopped;
+			return 1;
 	}
=20
-	return ide_stopped;
+	return 0;
+}
+
+static ide_startstop_t task_no_data_intr(ide_drive_t *);
+static ide_startstop_t set_geometry_intr(ide_drive_t *);
+static ide_startstop_t recal_intr(ide_drive_t *);
+static ide_startstop_t set_multmode_intr(ide_drive_t *);
+static ide_startstop_t pre_task_out_intr(ide_drive_t *, struct request=
 *);
+static ide_startstop_t task_in_intr(ide_drive_t *);
+
+ide_startstop_t do_rw_taskfile (ide_drive_t *drive, ide_task_t *task)
+{
+	ide_hwif_t *hwif	=3D HWIF(drive);
+	struct ide_taskfile *tf =3D &task->tf;
+	ide_handler_t *handler =3D NULL;
+
+	if (task->data_phase =3D=3D TASKFILE_MULTI_IN ||
+	    task->data_phase =3D=3D TASKFILE_MULTI_OUT) {
+		if (!drive->mult_count) {
+			printk(KERN_ERR "%s: multimode not set!\n",
+					drive->name);
+			return ide_stopped;
+		}
+	}
+
+	if (task->tf_flags & IDE_TFLAG_FLAGGED)
+		task->tf_flags |=3D IDE_TFLAG_FLAGGED_SET_IN_FLAGS;
+
+	if ((task->tf_flags & IDE_TFLAG_DMA_PIO_FALLBACK) =3D=3D 0)
+		ide_tf_load(drive, task);
+
+	switch (task->data_phase) {
+	case TASKFILE_MULTI_OUT:
+	case TASKFILE_OUT:
+		hwif->OUTBSYNC(drive, tf->command, IDE_COMMAND_REG);
+		ndelay(400);	/* FIXME */
+		return pre_task_out_intr(drive, task->rq);
+	case TASKFILE_MULTI_IN:
+	case TASKFILE_IN:
+		handler =3D task_in_intr;
+		/* fall-through */
+	case TASKFILE_NO_DATA:
+		if (handler =3D=3D NULL)
+			handler =3D task_no_data_intr;
+		/* WIN_{SPECIFY,RESTORE,SETMULT} use custom handlers */
+		if (task->tf_flags & IDE_TFLAG_CUSTOM_HANDLER) {
+			switch (tf->command) {
+			case WIN_SPECIFY: handler =3D set_geometry_intr;	break;
+			case WIN_RESTORE: handler =3D recal_intr;		break;
+			case WIN_SETMULT: handler =3D set_multmode_intr;	break;
+			}
+		}
+		ide_execute_command(drive, tf->command, handler,
+				    WAIT_WORSTCASE, NULL);
+		return ide_started;
+	default:
+		if (task_dma_ok(task) =3D=3D 0 || drive->using_dma =3D=3D 0 ||
+		    hwif->dma_setup(drive))
+			return ide_stopped;
+		hwif->dma_exec_cmd(drive, tf->command);
+		hwif->dma_start(drive);
+		return ide_started;
+	}
 }
+EXPORT_SYMBOL_GPL(do_rw_taskfile);
=20
 /*
  * set_multmode_intr() is invoked on completion of a WIN_SETMULT cmd.
  */
-ide_startstop_t set_multmode_intr (ide_drive_t *drive)
+static ide_startstop_t set_multmode_intr(ide_drive_t *drive)
 {
 	ide_hwif_t *hwif =3D HWIF(drive);
 	u8 stat;
@@ -164,7 +232,7 @@ ide_startstop_t set_multmode_intr (ide_drive_t *dri=
ve)
 /*
  * set_geometry_intr() is invoked on completion of a WIN_SPECIFY cmd.
  */
-ide_startstop_t set_geometry_intr (ide_drive_t *drive)
+static ide_startstop_t set_geometry_intr(ide_drive_t *drive)
 {
 	ide_hwif_t *hwif =3D HWIF(drive);
 	int retries =3D 5;
@@ -187,7 +255,7 @@ ide_startstop_t set_geometry_intr (ide_drive_t *dri=
ve)
 /*
  * recal_intr() is invoked on completion of a WIN_RESTORE (recalibrate=
) cmd.
  */
-ide_startstop_t recal_intr (ide_drive_t *drive)
+static ide_startstop_t recal_intr(ide_drive_t *drive)
 {
 	ide_hwif_t *hwif =3D HWIF(drive);
 	u8 stat;
@@ -200,7 +268,7 @@ ide_startstop_t recal_intr (ide_drive_t *drive)
 /*
  * Handler for commands without a data phase
  */
-ide_startstop_t task_no_data_intr (ide_drive_t *drive)
+static ide_startstop_t task_no_data_intr(ide_drive_t *drive)
 {
 	ide_task_t *args	=3D HWGROUP(drive)->rq->special;
 	ide_hwif_t *hwif	=3D HWIF(drive);
@@ -217,8 +285,6 @@ ide_startstop_t task_no_data_intr (ide_drive_t *dri=
ve)
 	return ide_stopped;
 }
=20
-EXPORT_SYMBOL(task_no_data_intr);
-
 static u8 wait_drive_not_busy(ide_drive_t *drive)
 {
 	ide_hwif_t *hwif =3D HWIF(drive);
@@ -363,7 +429,7 @@ static void task_end_request(ide_drive_t *drive, st=
ruct request *rq, u8 stat)
 	if (rq->cmd_type =3D=3D REQ_TYPE_ATA_TASKFILE) {
 		ide_task_t *task =3D rq->special;
=20
-		if (task->tf_out_flags.all) {
+		if (task->tf_flags & IDE_TFLAG_FLAGGED) {
 			u8 err =3D drive->hwif->INB(IDE_ERROR_REG);
 			ide_end_drive_cmd(drive, stat, err);
 			return;
@@ -382,7 +448,7 @@ static void task_end_request(ide_drive_t *drive, st=
ruct request *rq, u8 stat)
 /*
  * Handler for command with PIO data-in phase (Read/Read Multiple).
  */
-ide_startstop_t task_in_intr (ide_drive_t *drive)
+static ide_startstop_t task_in_intr(ide_drive_t *drive)
 {
 	ide_hwif_t *hwif =3D drive->hwif;
 	struct request *rq =3D HWGROUP(drive)->rq;
@@ -413,7 +479,6 @@ ide_startstop_t task_in_intr (ide_drive_t *drive)
=20
 	return ide_started;
 }
-EXPORT_SYMBOL(task_in_intr);
=20
 /*
  * Handler for command with PIO data-out phase (Write/Write Multiple).
@@ -443,7 +508,7 @@ static ide_startstop_t task_out_intr (ide_drive_t *=
drive)
 	return ide_started;
 }
=20
-ide_startstop_t pre_task_out_intr (ide_drive_t *drive, struct request =
*rq)
+static ide_startstop_t pre_task_out_intr(ide_drive_t *drive, struct re=
quest *rq)
 {
 	ide_startstop_t startstop;
=20
@@ -464,9 +529,8 @@ ide_startstop_t pre_task_out_intr (ide_drive_t *dri=
ve, struct request *rq)
=20
 	return ide_started;
 }
-EXPORT_SYMBOL(pre_task_out_intr);
=20
-static int ide_diag_taskfile(ide_drive_t *drive, ide_task_t *args, uns=
igned long data_size, u8 *buf)
+int ide_raw_taskfile(ide_drive_t *drive, ide_task_t *task, u8 *buf, u1=
6 nsect)
 {
 	struct request rq;
=20
@@ -481,36 +545,27 @@ static int ide_diag_taskfile(ide_drive_t *drive, =
ide_task_t *args, unsigned long
 	 * if we would find a solution to transfer any size.
 	 * To support special commands like READ LONG.
 	 */
-	if (args->command_type !=3D IDE_DRIVE_TASK_NO_DATA) {
-		if (data_size =3D=3D 0)
-			rq.nr_sectors =3D (args->hobRegister[IDE_NSECTOR_OFFSET] << 8) | ar=
gs->tfRegister[IDE_NSECTOR_OFFSET];
-		else
-			rq.nr_sectors =3D data_size / SECTOR_SIZE;
-
-		if (!rq.nr_sectors) {
-			printk(KERN_ERR "%s: in/out command without data\n",
-					drive->name);
-			return -EFAULT;
-		}
+	rq.hard_nr_sectors =3D rq.nr_sectors =3D nsect;
+	rq.hard_cur_sectors =3D rq.current_nr_sectors =3D nsect;
=20
-		rq.hard_nr_sectors =3D rq.nr_sectors;
-		rq.hard_cur_sectors =3D rq.current_nr_sectors =3D rq.nr_sectors;
+	if (task->tf_flags & IDE_TFLAG_WRITE)
+		rq.cmd_flags |=3D REQ_RW;
=20
-		if (args->command_type =3D=3D IDE_DRIVE_TASK_RAW_WRITE)
-			rq.cmd_flags |=3D REQ_RW;
-	}
+	rq.special =3D task;
+	task->rq =3D &rq;
=20
-	rq.special =3D args;
-	args->rq =3D &rq;
 	return ide_do_drive_cmd(drive, &rq, ide_wait);
 }
=20
-int ide_raw_taskfile (ide_drive_t *drive, ide_task_t *args, u8 *buf)
+EXPORT_SYMBOL(ide_raw_taskfile);
+
+int ide_no_data_taskfile(ide_drive_t *drive, ide_task_t *task)
 {
-	return ide_diag_taskfile(drive, args, 0, buf);
-}
+	task->data_phase =3D TASKFILE_NO_DATA;
=20
-EXPORT_SYMBOL(ide_raw_taskfile);
+	return ide_raw_taskfile(drive, task, NULL, 0);
+}
+EXPORT_SYMBOL_GPL(ide_no_data_taskfile);
=20
 #ifdef CONFIG_IDE_TASK_IOCTL
 int ide_taskfile_ioctl (ide_drive_t *drive, unsigned int cmd, unsigned=
 long arg)
@@ -519,12 +574,12 @@ int ide_taskfile_ioctl (ide_drive_t *drive, unsig=
ned int cmd, unsigned long arg)
 	ide_task_t		args;
 	u8 *outbuf		=3D NULL;
 	u8 *inbuf		=3D NULL;
-	task_ioreg_t *argsptr	=3D args.tfRegister;
-	task_ioreg_t *hobsptr	=3D args.hobRegister;
+	u8 *data_buf		=3D NULL;
 	int err			=3D 0;
 	int tasksize		=3D sizeof(struct ide_task_request_s);
 	unsigned int taskin	=3D 0;
 	unsigned int taskout	=3D 0;
+	u16 nsect		=3D 0;
 	u8 io_32bit		=3D drive->io_32bit;
 	char __user *buf =3D (char __user *)arg;
=20
@@ -572,24 +627,52 @@ int ide_taskfile_ioctl (ide_drive_t *drive, unsig=
ned int cmd, unsigned long arg)
 	}
=20
 	memset(&args, 0, sizeof(ide_task_t));
-	memcpy(argsptr, req_task->io_ports, HDIO_DRIVE_TASK_HDR_SIZE);
-	memcpy(hobsptr, req_task->hob_ports, HDIO_DRIVE_HOB_HDR_SIZE);
=20
-	args.tf_in_flags  =3D req_task->in_flags;
-	args.tf_out_flags =3D req_task->out_flags;
-	args.data_phase   =3D req_task->data_phase;
-	args.command_type =3D req_task->req_cmd;
+	memcpy(&args.tf_array[0], req_task->hob_ports, HDIO_DRIVE_HOB_HDR_SIZ=
E - 2);
+	memcpy(&args.tf_array[6], req_task->io_ports, HDIO_DRIVE_TASK_HDR_SIZ=
E);
+
+	args.data_phase =3D req_task->data_phase;
+
+	args.tf_flags =3D IDE_TFLAG_OUT_DEVICE;
+	if (drive->addressing =3D=3D 1)
+		args.tf_flags |=3D IDE_TFLAG_LBA48;
+
+	if (req_task->out_flags.all) {
+		args.tf_flags |=3D IDE_TFLAG_FLAGGED;
+
+		if (req_task->out_flags.b.data)
+			args.tf_flags |=3D IDE_TFLAG_OUT_DATA;
+
+		if (req_task->out_flags.b.nsector_hob)
+			args.tf_flags |=3D IDE_TFLAG_OUT_HOB_NSECT;
+		if (req_task->out_flags.b.sector_hob)
+			args.tf_flags |=3D IDE_TFLAG_OUT_HOB_LBAL;
+		if (req_task->out_flags.b.lcyl_hob)
+			args.tf_flags |=3D IDE_TFLAG_OUT_HOB_LBAM;
+		if (req_task->out_flags.b.hcyl_hob)
+			args.tf_flags |=3D IDE_TFLAG_OUT_HOB_LBAH;
+
+		if (req_task->out_flags.b.error_feature)
+			args.tf_flags |=3D IDE_TFLAG_OUT_FEATURE;
+		if (req_task->out_flags.b.nsector)
+			args.tf_flags |=3D IDE_TFLAG_OUT_NSECT;
+		if (req_task->out_flags.b.sector)
+			args.tf_flags |=3D IDE_TFLAG_OUT_LBAL;
+		if (req_task->out_flags.b.lcyl)
+			args.tf_flags |=3D IDE_TFLAG_OUT_LBAM;
+		if (req_task->out_flags.b.hcyl)
+			args.tf_flags |=3D IDE_TFLAG_OUT_LBAH;
+	} else {
+		args.tf_flags |=3D IDE_TFLAG_OUT_TF;
+		if (args.tf_flags & IDE_TFLAG_LBA48)
+			args.tf_flags |=3D IDE_TFLAG_OUT_HOB;
+	}
+
+	if (req_task->in_flags.b.data)
+		args.tf_flags |=3D IDE_TFLAG_IN_DATA;
=20
 	drive->io_32bit =3D 0;
 	switch(req_task->data_phase) {
-		case TASKFILE_OUT_DMAQ:
-		case TASKFILE_OUT_DMA:
-			err =3D ide_diag_taskfile(drive, &args, taskout, outbuf);
-			break;
-		case TASKFILE_IN_DMAQ:
-		case TASKFILE_IN_DMA:
-			err =3D ide_diag_taskfile(drive, &args, taskin, inbuf);
-			break;
 		case TASKFILE_MULTI_OUT:
 			if (!drive->mult_count) {
 				/* (hs): give up if multcount is not set */
@@ -601,9 +684,11 @@ int ide_taskfile_ioctl (ide_drive_t *drive, unsign=
ed int cmd, unsigned long arg)
 			}
 			/* fall through */
 		case TASKFILE_OUT:
-			args.prehandler =3D &pre_task_out_intr;
-			args.handler =3D &task_out_intr;
-			err =3D ide_diag_taskfile(drive, &args, taskout, outbuf);
+			/* fall through */
+		case TASKFILE_OUT_DMAQ:
+		case TASKFILE_OUT_DMA:
+			nsect =3D taskout / SECTOR_SIZE;
+			data_buf =3D outbuf;
 			break;
 		case TASKFILE_MULTI_IN:
 			if (!drive->mult_count) {
@@ -616,22 +701,46 @@ int ide_taskfile_ioctl (ide_drive_t *drive, unsig=
ned int cmd, unsigned long arg)
 			}
 			/* fall through */
 		case TASKFILE_IN:
-			args.handler =3D &task_in_intr;
-			err =3D ide_diag_taskfile(drive, &args, taskin, inbuf);
+			/* fall through */
+		case TASKFILE_IN_DMAQ:
+		case TASKFILE_IN_DMA:
+			nsect =3D taskin / SECTOR_SIZE;
+			data_buf =3D inbuf;
 			break;
 		case TASKFILE_NO_DATA:
-			args.handler =3D &task_no_data_intr;
-			err =3D ide_diag_taskfile(drive, &args, 0, NULL);
 			break;
 		default:
 			err =3D -EFAULT;
 			goto abort;
 	}
=20
-	memcpy(req_task->io_ports, &(args.tfRegister), HDIO_DRIVE_TASK_HDR_SI=
ZE);
-	memcpy(req_task->hob_ports, &(args.hobRegister), HDIO_DRIVE_HOB_HDR_S=
IZE);
-	req_task->in_flags  =3D args.tf_in_flags;
-	req_task->out_flags =3D args.tf_out_flags;
+	if (req_task->req_cmd =3D=3D IDE_DRIVE_TASK_NO_DATA)
+		nsect =3D 0;
+	else if (!nsect) {
+		nsect =3D (args.tf.hob_nsect << 8) | args.tf.nsect;
+
+		if (!nsect) {
+			printk(KERN_ERR "%s: in/out command without data\n",
+					drive->name);
+			err =3D -EFAULT;
+			goto abort;
+		}
+	}
+
+	if (req_task->req_cmd =3D=3D IDE_DRIVE_TASK_RAW_WRITE)
+		args.tf_flags |=3D IDE_TFLAG_WRITE;
+
+	err =3D ide_raw_taskfile(drive, &args, data_buf, nsect);
+
+	memcpy(req_task->hob_ports, &args.tf_array[0], HDIO_DRIVE_HOB_HDR_SIZ=
E - 2);
+	memcpy(req_task->io_ports, &args.tf_array[6], HDIO_DRIVE_TASK_HDR_SIZ=
E);
+
+	if ((args.tf_flags & IDE_TFLAG_FLAGGED_SET_IN_FLAGS) &&
+	    req_task->in_flags.all =3D=3D 0) {
+		req_task->in_flags.all =3D IDE_TASKFILE_STD_IN_FLAGS;
+		if (drive->addressing =3D=3D 1)
+			req_task->in_flags.all |=3D (IDE_HOB_STD_IN_FLAGS << 8);
+	}
=20
 	if (copy_to_user(buf, req_task, tasksize)) {
 		err =3D -EFAULT;
@@ -688,6 +797,7 @@ int ide_cmd_ioctl (ide_drive_t *drive, unsigned int=
 cmd, unsigned long arg)
 	u8 xfer_rate =3D 0;
 	int argsize =3D 4;
 	ide_task_t tfargs;
+	struct ide_taskfile *tf =3D &tfargs.tf;
=20
 	if (NULL =3D=3D (void *) arg) {
 		struct request rq;
@@ -699,13 +809,10 @@ int ide_cmd_ioctl (ide_drive_t *drive, unsigned i=
nt cmd, unsigned long arg)
 		return -EFAULT;
=20
 	memset(&tfargs, 0, sizeof(ide_task_t));
-	tfargs.tfRegister[IDE_FEATURE_OFFSET] =3D args[2];
-	tfargs.tfRegister[IDE_NSECTOR_OFFSET] =3D args[3];
-	tfargs.tfRegister[IDE_SECTOR_OFFSET]  =3D args[1];
-	tfargs.tfRegister[IDE_LCYL_OFFSET]    =3D 0x00;
-	tfargs.tfRegister[IDE_HCYL_OFFSET]    =3D 0x00;
-	tfargs.tfRegister[IDE_SELECT_OFFSET]  =3D 0x00;
-	tfargs.tfRegister[IDE_COMMAND_OFFSET] =3D args[0];
+	tf->feature =3D args[2];
+	tf->nsect   =3D args[3];
+	tf->lbal    =3D args[1];
+	tf->command =3D args[0];
=20
 	if (args[3]) {
 		argsize =3D 4 + (SECTOR_WORDS * 4 * args[3]);
@@ -734,135 +841,28 @@ abort:
 	return err;
 }
=20
-static int ide_wait_cmd_task(ide_drive_t *drive, u8 *buf)
-{
-	struct request rq;
-
-	ide_init_drive_cmd(&rq);
-	rq.cmd_type =3D REQ_TYPE_ATA_TASK;
-	rq.buffer =3D buf;
-	return ide_do_drive_cmd(drive, &rq, ide_wait);
-}
-
 int ide_task_ioctl (ide_drive_t *drive, unsigned int cmd, unsigned lon=
g arg)
 {
 	void __user *p =3D (void __user *)arg;
 	int err =3D 0;
-	u8 args[7], *argbuf =3D args;
-	int argsize =3D 7;
+	u8 args[7];
+	ide_task_t task;
=20
 	if (copy_from_user(args, p, 7))
 		return -EFAULT;
-	err =3D ide_wait_cmd_task(drive, argbuf);
-	if (copy_to_user(p, argbuf, argsize))
-		err =3D -EFAULT;
-	return err;
-}
-
-/*
- * NOTICE: This is additions from IBM to provide a discrete interface,
- * for selective taskregister access operations.  Nice JOB Klaus!!!
- * Glad to be able to work and co-develop this with you and IBM.
- */
-ide_startstop_t flagged_taskfile (ide_drive_t *drive, ide_task_t *task=
)
-{
-	ide_hwif_t *hwif	=3D HWIF(drive);
-	task_struct_t *taskfile	=3D (task_struct_t *) task->tfRegister;
-	hob_struct_t *hobfile	=3D (hob_struct_t *) task->hobRegister;
-
-	if (task->data_phase =3D=3D TASKFILE_MULTI_IN ||
-	    task->data_phase =3D=3D TASKFILE_MULTI_OUT) {
-		if (!drive->mult_count) {
-			printk(KERN_ERR "%s: multimode not set!\n", drive->name);
-			return ide_stopped;
-		}
-	}
-
-	/*
-	 * (ks) Check taskfile in flags.
-	 * If set, then execute as it is defined.
-	 * If not set, then define default settings.
-	 * The default values are:
-	 *	read all taskfile registers (except data)
-	 *	read the hob registers (sector, nsector, lcyl, hcyl)
-	 */
-	if (task->tf_in_flags.all =3D=3D 0) {
-		task->tf_in_flags.all =3D IDE_TASKFILE_STD_IN_FLAGS;
-		if (drive->addressing =3D=3D 1)
-			task->tf_in_flags.all |=3D (IDE_HOB_STD_IN_FLAGS  << 8);
-        }
-
-	/* ALL Command Block Executions SHALL clear nIEN, unless otherwise */
-	if (IDE_CONTROL_REG)
-		/* clear nIEN */
-		hwif->OUTB(drive->ctl, IDE_CONTROL_REG);
-	SELECT_MASK(drive, 0);
-
-	if (task->tf_out_flags.b.data) {
-		u16 data =3D  taskfile->data + (hobfile->data << 8);
-		hwif->OUTW(data, IDE_DATA_REG);
-	}
-
-	/* (ks) send hob registers first */
-	if (task->tf_out_flags.b.nsector_hob)
-		hwif->OUTB(hobfile->sector_count, IDE_NSECTOR_REG);
-	if (task->tf_out_flags.b.sector_hob)
-		hwif->OUTB(hobfile->sector_number, IDE_SECTOR_REG);
-	if (task->tf_out_flags.b.lcyl_hob)
-		hwif->OUTB(hobfile->low_cylinder, IDE_LCYL_REG);
-	if (task->tf_out_flags.b.hcyl_hob)
-		hwif->OUTB(hobfile->high_cylinder, IDE_HCYL_REG);
-
-	/* (ks) Send now the standard registers */
-	if (task->tf_out_flags.b.error_feature)
-		hwif->OUTB(taskfile->feature, IDE_FEATURE_REG);
-	/* refers to number of sectors to transfer */
-	if (task->tf_out_flags.b.nsector)
-		hwif->OUTB(taskfile->sector_count, IDE_NSECTOR_REG);
-	/* refers to sector offset or start sector */
-	if (task->tf_out_flags.b.sector)
-		hwif->OUTB(taskfile->sector_number, IDE_SECTOR_REG);
-	if (task->tf_out_flags.b.lcyl)
-		hwif->OUTB(taskfile->low_cylinder, IDE_LCYL_REG);
-	if (task->tf_out_flags.b.hcyl)
-		hwif->OUTB(taskfile->high_cylinder, IDE_HCYL_REG);
-
-        /*
-	 * (ks) In the flagged taskfile approch, we will use all specified
-	 * registers and the register value will not be changed, except the
-	 * select bit (master/slave) in the drive_head register. We must make
-	 * sure that the desired drive is selected.
-	 */
-	hwif->OUTB(taskfile->device_head | drive->select.all, IDE_SELECT_REG)=
;
-	switch(task->data_phase) {
=20
-   	        case TASKFILE_OUT_DMAQ:
-		case TASKFILE_OUT_DMA:
-		case TASKFILE_IN_DMAQ:
-		case TASKFILE_IN_DMA:
-			if (!drive->using_dma)
-				break;
+	memset(&task, 0, sizeof(task));
+	memcpy(&task.tf_array[7], &args[1], 6);
+	task.tf.command =3D args[0];
+	task.tf_flags =3D IDE_TFLAG_OUT_TF | IDE_TFLAG_OUT_DEVICE;
=20
-			if (!hwif->dma_setup(drive)) {
-				hwif->dma_exec_cmd(drive, taskfile->command);
-				hwif->dma_start(drive);
-				return ide_started;
-			}
-			break;
+	err =3D ide_no_data_taskfile(drive, &task);
=20
-	        default:
- 			if (task->handler =3D=3D NULL)
-				return ide_stopped;
+	args[0] =3D task.tf.command;
+	memcpy(&args[1], &task.tf_array[7], 6);
=20
-			/* Issue the command */
-			if (task->prehandler) {
-				hwif->OUTBSYNC(drive, taskfile->command, IDE_COMMAND_REG);
-				ndelay(400);	/* FIXME */
-				return task->prehandler(drive, task->rq);
-			}
-			ide_execute_command(drive, taskfile->command, task->handler, WAIT_W=
ORSTCASE, NULL);
-			return ide_started;
-	}
+	if (copy_to_user(p, args, 7))
+		err =3D -EFAULT;
=20
-	return ide_stopped;
+	return err;
 }
diff --git a/drivers/ide/ide.c b/drivers/ide/ide.c
index 54943da..c6d4f63 100644
--- a/drivers/ide/ide.c
+++ b/drivers/ide/ide.c
@@ -424,7 +424,6 @@ static void ide_hwif_restore(ide_hwif_t *hwif, ide_=
hwif_t *tmp_hwif)
 	hwif->reset_poll		=3D tmp_hwif->reset_poll;
 	hwif->pre_reset			=3D tmp_hwif->pre_reset;
 	hwif->resetproc			=3D tmp_hwif->resetproc;
-	hwif->intrproc			=3D tmp_hwif->intrproc;
 	hwif->maskproc			=3D tmp_hwif->maskproc;
 	hwif->quirkproc			=3D tmp_hwif->quirkproc;
 	hwif->busproc			=3D tmp_hwif->busproc;
@@ -468,7 +467,6 @@ static void ide_hwif_restore(ide_hwif_t *hwif, ide_=
hwif_t *tmp_hwif)
 #endif
=20
 	hwif->dma_base			=3D tmp_hwif->dma_base;
-	hwif->dma_master		=3D tmp_hwif->dma_master;
 	hwif->dma_command		=3D tmp_hwif->dma_command;
 	hwif->dma_vendor1		=3D tmp_hwif->dma_vendor1;
 	hwif->dma_status		=3D tmp_hwif->dma_status;
@@ -602,7 +600,6 @@ void ide_unregister(unsigned int index)
 		(void) ide_release_dma(hwif);
=20
 		hwif->dma_base =3D 0;
-		hwif->dma_master =3D 0;
 		hwif->dma_command =3D 0;
 		hwif->dma_vendor1 =3D 0;
 		hwif->dma_status =3D 0;
@@ -854,8 +851,7 @@ int set_using_dma(ide_drive_t *drive, int arg)
 	err =3D 0;
=20
 	if (arg) {
-		hwif->dma_off_quietly(drive);
-		if (ide_set_dma(drive) || hwif->ide_dma_on(drive))
+		if (ide_set_dma(drive))
 			err =3D -EIO;
 	} else
 		ide_dma_off(drive);
diff --git a/drivers/ide/mips/au1xxx-ide.c b/drivers/ide/mips/au1xxx-id=
e.c
index a4ce3ba..a4d0d4c 100644
--- a/drivers/ide/mips/au1xxx-ide.c
+++ b/drivers/ide/mips/au1xxx-ide.c
@@ -198,8 +198,6 @@ static void auide_set_dma_mode(ide_drive_t *drive, =
const u8 speed)
=20
 		break;
 #endif
-	default:
-		return;
 	}
=20
 	au_writel(mem_sttime,MEM_STTIME2);
diff --git a/drivers/ide/pci/aec62xx.c b/drivers/ide/pci/aec62xx.c
index 4426850..7f4d185 100644
--- a/drivers/ide/pci/aec62xx.c
+++ b/drivers/ide/pci/aec62xx.c
@@ -202,6 +202,7 @@ static const struct ide_port_info aec62xx_chipsets[=
] __devinitdata =3D {
 		.enablebits	=3D {{0x4a,0x02,0x02}, {0x4a,0x04,0x04}},
 		.host_flags	=3D IDE_HFLAG_SERIALIZE |
 				  IDE_HFLAG_NO_ATAPI_DMA |
+				  IDE_HFLAG_ABUSE_SET_DMA_MODE |
 				  IDE_HFLAG_OFF_BOARD,
 		.pio_mask	=3D ATA_PIO4,
 		.mwdma_mask	=3D ATA_MWDMA2,
@@ -211,6 +212,7 @@ static const struct ide_port_info aec62xx_chipsets[=
] __devinitdata =3D {
 		.init_chipset	=3D init_chipset_aec62xx,
 		.init_hwif	=3D init_hwif_aec62xx,
 		.host_flags	=3D IDE_HFLAG_NO_ATAPI_DMA | IDE_HFLAG_NO_AUTODMA |
+				  IDE_HFLAG_ABUSE_SET_DMA_MODE |
 				  IDE_HFLAG_OFF_BOARD,
 		.pio_mask	=3D ATA_PIO4,
 		.mwdma_mask	=3D ATA_MWDMA2,
@@ -220,7 +222,8 @@ static const struct ide_port_info aec62xx_chipsets[=
] __devinitdata =3D {
 		.init_chipset	=3D init_chipset_aec62xx,
 		.init_hwif	=3D init_hwif_aec62xx,
 		.enablebits	=3D {{0x4a,0x02,0x02}, {0x4a,0x04,0x04}},
-		.host_flags	=3D IDE_HFLAG_NO_ATAPI_DMA,
+		.host_flags	=3D IDE_HFLAG_NO_ATAPI_DMA |
+				  IDE_HFLAG_ABUSE_SET_DMA_MODE,
 		.pio_mask	=3D ATA_PIO4,
 		.mwdma_mask	=3D ATA_MWDMA2,
 		.udma_mask	=3D ATA_UDMA4,
@@ -228,7 +231,9 @@ static const struct ide_port_info aec62xx_chipsets[=
] __devinitdata =3D {
 		.name		=3D "AEC6280",
 		.init_chipset	=3D init_chipset_aec62xx,
 		.init_hwif	=3D init_hwif_aec62xx,
-		.host_flags	=3D IDE_HFLAG_NO_ATAPI_DMA | IDE_HFLAG_OFF_BOARD,
+		.host_flags	=3D IDE_HFLAG_NO_ATAPI_DMA |
+				  IDE_HFLAG_ABUSE_SET_DMA_MODE |
+				  IDE_HFLAG_OFF_BOARD,
 		.pio_mask	=3D ATA_PIO4,
 		.mwdma_mask	=3D ATA_MWDMA2,
 		.udma_mask	=3D ATA_UDMA5,
@@ -237,7 +242,9 @@ static const struct ide_port_info aec62xx_chipsets[=
] __devinitdata =3D {
 		.init_chipset	=3D init_chipset_aec62xx,
 		.init_hwif	=3D init_hwif_aec62xx,
 		.enablebits	=3D {{0x4a,0x02,0x02}, {0x4a,0x04,0x04}},
-		.host_flags	=3D IDE_HFLAG_NO_ATAPI_DMA | IDE_HFLAG_OFF_BOARD,
+		.host_flags	=3D IDE_HFLAG_NO_ATAPI_DMA |
+				  IDE_HFLAG_ABUSE_SET_DMA_MODE |
+				  IDE_HFLAG_OFF_BOARD,
 		.pio_mask	=3D ATA_PIO4,
 		.mwdma_mask	=3D ATA_MWDMA2,
 		.udma_mask	=3D ATA_UDMA5,
diff --git a/drivers/ide/pci/alim15x3.c b/drivers/ide/pci/alim15x3.c
index ce29393..49aa82e 100644
--- a/drivers/ide/pci/alim15x3.c
+++ b/drivers/ide/pci/alim15x3.c
@@ -402,9 +402,6 @@ static void ali_set_dma_mode(ide_drive_t *drive, co=
nst u8 speed)
 	u8 tmpbyte		=3D 0x00;
 	int m5229_udma		=3D (hwif->channel) ? 0x57 : 0x56;
=20
-	if (speed < XFER_PIO_0)
-		return;
-
 	if (speed =3D=3D XFER_UDMA_6)
 		speed1 =3D 0x47;
=20
diff --git a/drivers/ide/pci/amd74xx.c b/drivers/ide/pci/amd74xx.c
index 8d4125e..cee51fd 100644
--- a/drivers/ide/pci/amd74xx.c
+++ b/drivers/ide/pci/amd74xx.c
@@ -266,6 +266,7 @@ static void __devinit init_hwif_amd74xx(ide_hwif_t =
*hwif)
 #define IDE_HFLAGS_AMD \
 	(IDE_HFLAG_PIO_NO_BLACKLIST | \
 	 IDE_HFLAG_PIO_NO_DOWNGRADE | \
+	 IDE_HFLAG_ABUSE_SET_DMA_MODE | \
 	 IDE_HFLAG_POST_SET_MODE | \
 	 IDE_HFLAG_IO_32BIT | \
 	 IDE_HFLAG_UNMASK_IRQS | \
diff --git a/drivers/ide/pci/atiixp.c b/drivers/ide/pci/atiixp.c
index ef8e016..5ae2656 100644
--- a/drivers/ide/pci/atiixp.c
+++ b/drivers/ide/pci/atiixp.c
@@ -133,9 +133,6 @@ static void atiixp_set_dma_mode(ide_drive_t *drive,=
 const u8 speed)
 	u32 tmp32;
 	u16 tmp16;
=20
-	if (speed < XFER_MW_DMA_0)
-		return;
-
 	spin_lock_irqsave(&atiixp_lock, flags);
=20
 	save_mdma_mode[drive->dn] =3D 0;
diff --git a/drivers/ide/pci/cmd64x.c b/drivers/ide/pci/cmd64x.c
index bc55333..0b1e947 100644
--- a/drivers/ide/pci/cmd64x.c
+++ b/drivers/ide/pci/cmd64x.c
@@ -322,8 +322,6 @@ static void cmd64x_set_dma_mode(ide_drive_t *drive,=
 const u8 speed)
 	case XFER_MW_DMA_0:
 		program_cycle_times(drive, 480, 215);
 		break;
-	default:
-		return;
 	}
=20
 	if (speed >=3D XFER_SW_DMA_0)
@@ -333,14 +331,15 @@ static void cmd64x_set_dma_mode(ide_drive_t *driv=
e, const u8 speed)
 static int cmd648_ide_dma_end (ide_drive_t *drive)
 {
 	ide_hwif_t *hwif	=3D HWIF(drive);
+	unsigned long base	=3D hwif->dma_base - (hwif->channel * 8);
 	int err			=3D __ide_dma_end(drive);
 	u8  irq_mask		=3D hwif->channel ? MRDMODE_INTR_CH1 :
 						  MRDMODE_INTR_CH0;
-	u8  mrdmode		=3D inb(hwif->dma_master + 0x01);
+	u8  mrdmode		=3D inb(base + 1);
=20
 	/* clear the interrupt bit */
 	outb((mrdmode & ~(MRDMODE_INTR_CH0 | MRDMODE_INTR_CH1)) | irq_mask,
-	     hwif->dma_master + 0x01);
+	     base + 1);
=20
 	return err;
 }
@@ -365,10 +364,11 @@ static int cmd64x_ide_dma_end (ide_drive_t *drive=
)
 static int cmd648_ide_dma_test_irq (ide_drive_t *drive)
 {
 	ide_hwif_t *hwif	=3D HWIF(drive);
+	unsigned long base	=3D hwif->dma_base - (hwif->channel * 8);
 	u8 irq_mask		=3D hwif->channel ? MRDMODE_INTR_CH1 :
 						  MRDMODE_INTR_CH0;
 	u8 dma_stat		=3D inb(hwif->dma_status);
-	u8 mrdmode		=3D inb(hwif->dma_master + 0x01);
+	u8 mrdmode		=3D inb(base + 1);
=20
 #ifdef DEBUG
 	printk("%s: dma_stat: 0x%02x mrdmode: 0x%02x irq_mask: 0x%02x\n",
diff --git a/drivers/ide/pci/cs5520.c b/drivers/ide/pci/cs5520.c
index 0466462..d1a91bc 100644
--- a/drivers/ide/pci/cs5520.c
+++ b/drivers/ide/pci/cs5520.c
@@ -137,6 +137,7 @@ static void __devinit init_hwif_cs5520(ide_hwif_t *=
hwif)
 				  IDE_HFLAG_CS5520 |		\
 				  IDE_HFLAG_VDMA |		\
 				  IDE_HFLAG_NO_ATAPI_DMA |	\
+				  IDE_HFLAG_ABUSE_SET_DMA_MODE |\
 				  IDE_HFLAG_BOOTABLE,		\
 		.pio_mask	=3D ATA_PIO4,			\
 	}
diff --git a/drivers/ide/pci/cs5530.c b/drivers/ide/pci/cs5530.c
index 5476903..df5966b 100644
--- a/drivers/ide/pci/cs5530.c
+++ b/drivers/ide/pci/cs5530.c
@@ -116,8 +116,6 @@ static void cs5530_set_dma_mode(ide_drive_t *drive,=
 const u8 mode)
 		case XFER_MW_DMA_0:	timings =3D 0x00077771; break;
 		case XFER_MW_DMA_1:	timings =3D 0x00012121; break;
 		case XFER_MW_DMA_2:	timings =3D 0x00002020; break;
-		default:
-			return;
 	}
 	basereg =3D CS5530_BASEREG(drive->hwif);
 	reg =3D inl(basereg + 4);			/* get drive0 config register */
diff --git a/drivers/ide/pci/cs5535.c b/drivers/ide/pci/cs5535.c
index ddcbeba..50b3d77 100644
--- a/drivers/ide/pci/cs5535.c
+++ b/drivers/ide/pci/cs5535.c
@@ -190,7 +190,7 @@ static const struct ide_port_info cs5535_chipset __=
devinitdata =3D {
 	.name		=3D "CS5535",
 	.init_hwif	=3D init_hwif_cs5535,
 	.host_flags	=3D IDE_HFLAG_SINGLE | IDE_HFLAG_POST_SET_MODE |
-			  IDE_HFLAG_BOOTABLE,
+			  IDE_HFLAG_ABUSE_SET_DMA_MODE | IDE_HFLAG_BOOTABLE,
 	.pio_mask	=3D ATA_PIO4,
 	.mwdma_mask	=3D ATA_MWDMA2,
 	.udma_mask	=3D ATA_UDMA4,
diff --git a/drivers/ide/pci/hpt34x.c b/drivers/ide/pci/hpt34x.c
index ae6307f..dfba0d1 100644
--- a/drivers/ide/pci/hpt34x.c
+++ b/drivers/ide/pci/hpt34x.c
@@ -129,14 +129,18 @@ static void __devinit init_hwif_hpt34x(ide_hwif_t=
 *hwif)
 	hwif->set_dma_mode =3D &hpt34x_set_mode;
 }
=20
+#define IDE_HFLAGS_HPT34X \
+	(IDE_HFLAG_NO_ATAPI_DMA | \
+	 IDE_HFLAG_ABUSE_SET_DMA_MODE | \
+	 IDE_HFLAG_NO_AUTODMA)
+
 static const struct ide_port_info hpt34x_chipsets[] __devinitdata =3D =
{
 	{ /* 0 */
 		.name		=3D "HPT343",
 		.init_chipset	=3D init_chipset_hpt34x,
 		.init_hwif	=3D init_hwif_hpt34x,
 		.extra		=3D 16,
-		.host_flags	=3D IDE_HFLAG_NO_ATAPI_DMA |
-				  IDE_HFLAG_NO_AUTODMA,
+		.host_flags	=3D IDE_HFLAGS_HPT34X,
 		.pio_mask	=3D ATA_PIO5,
 	},
 	{ /* 1 */
@@ -144,9 +148,7 @@ static const struct ide_port_info hpt34x_chipsets[]=
 __devinitdata =3D {
 		.init_chipset	=3D init_chipset_hpt34x,
 		.init_hwif	=3D init_hwif_hpt34x,
 		.extra		=3D 16,
-		.host_flags	=3D IDE_HFLAG_NO_ATAPI_DMA |
-				  IDE_HFLAG_NO_AUTODMA |
-				  IDE_HFLAG_OFF_BOARD,
+		.host_flags	=3D IDE_HFLAGS_HPT34X | IDE_HFLAG_OFF_BOARD,
 		.pio_mask	=3D ATA_PIO5,
 #ifdef CONFIG_HPT34X_AUTODMA
 		.swdma_mask	=3D ATA_SWDMA2,
diff --git a/drivers/ide/pci/hpt366.c b/drivers/ide/pci/hpt366.c
index 9fce25b..3777fb8 100644
--- a/drivers/ide/pci/hpt366.c
+++ b/drivers/ide/pci/hpt366.c
@@ -1,5 +1,5 @@
 /*
- * linux/drivers/ide/pci/hpt366.c		Version 1.22	Dec 4, 2007
+ * linux/drivers/ide/pci/hpt366.c		Version 1.30	Dec 12, 2007
  *
  * Copyright (C) 1999-2003		Andre Hedrick <andre@linux-ide.org>
  * Portions Copyright (C) 2001	        Sun Microsystems, Inc.
@@ -88,7 +88,7 @@
  * - rename all the register related variables consistently
  * - move all the interrupt twiddling code from the speedproc handlers=
 into
  *   init_hwif_hpt366(), also grouping all the DMA related code togeth=
er there
- * - merge two HPT37x speedproc handlers, fix the PIO timing register =
mask and
+ * - merge HPT36x/HPT37x speedproc handlers, fix PIO timing register m=
ask and
  *   separate the UltraDMA and MWDMA masks there to avoid changing PIO=
 timings
  *   when setting an UltraDMA mode
  * - fix hpt3xx_tune_drive() to set the PIO mode requested, not always=
 select
@@ -458,6 +458,13 @@ enum ata_clock {
 	NUM_ATA_CLOCKS
 };
=20
+struct hpt_timings {
+	u32 pio_mask;
+	u32 dma_mask;
+	u32 ultra_mask;
+	u32 *clock_table[NUM_ATA_CLOCKS];
+};
+
 /*
  *	Hold all the HighPoint chip information in one place.
  */
@@ -468,7 +475,8 @@ struct hpt_info {
 	u8 udma_mask;		/* Allowed UltraDMA modes mask. */
 	u8 dpll_clk;		/* DPLL clock in MHz */
 	u8 pci_clk;		/* PCI  clock in MHz */
-	u32 **settings; 	/* Chipset settings table */
+	struct hpt_timings *timings; /* Chipset timing data */
+	u8 clock;		/* ATA clock selected */
 };
=20
 /* Supported HighPoint chips */
@@ -486,20 +494,30 @@ enum {
 	HPT371N
 };
=20
-static u32 *hpt36x_settings[NUM_ATA_CLOCKS] =3D {
-	twenty_five_base_hpt36x,
-	thirty_three_base_hpt36x,
-	forty_base_hpt36x,
-	NULL,
-	NULL
+static struct hpt_timings hpt36x_timings =3D {
+	.pio_mask	=3D 0xc1f8ffff,
+	.dma_mask	=3D 0x303800ff,
+	.ultra_mask	=3D 0x30070000,
+	.clock_table	=3D {
+		[ATA_CLOCK_25MHZ] =3D twenty_five_base_hpt36x,
+		[ATA_CLOCK_33MHZ] =3D thirty_three_base_hpt36x,
+		[ATA_CLOCK_40MHZ] =3D forty_base_hpt36x,
+		[ATA_CLOCK_50MHZ] =3D NULL,
+		[ATA_CLOCK_66MHZ] =3D NULL
+	}
 };
=20
-static u32 *hpt37x_settings[NUM_ATA_CLOCKS] =3D {
-	NULL,
-	thirty_three_base_hpt37x,
-	NULL,
-	fifty_base_hpt37x,
-	sixty_six_base_hpt37x
+static struct hpt_timings hpt37x_timings =3D {
+	.pio_mask	=3D 0xcfc3ffff,
+	.dma_mask	=3D 0x31c001ff,
+	.ultra_mask	=3D 0x303c0000,
+	.clock_table	=3D {
+		[ATA_CLOCK_25MHZ] =3D NULL,
+		[ATA_CLOCK_33MHZ] =3D thirty_three_base_hpt37x,
+		[ATA_CLOCK_40MHZ] =3D NULL,
+		[ATA_CLOCK_50MHZ] =3D fifty_base_hpt37x,
+		[ATA_CLOCK_66MHZ] =3D sixty_six_base_hpt37x
+	}
 };
=20
 static const struct hpt_info hpt36x __devinitdata =3D {
@@ -507,7 +525,7 @@ static const struct hpt_info hpt36x __devinitdata =3D=
 {
 	.chip_type	=3D HPT36x,
 	.udma_mask	=3D HPT366_ALLOW_ATA66_3 ? (HPT366_ALLOW_ATA66_4 ? ATA_UDM=
A4 : ATA_UDMA3) : ATA_UDMA2,
 	.dpll_clk	=3D 0,	/* no DPLL */
-	.settings	=3D hpt36x_settings
+	.timings	=3D &hpt36x_timings
 };
=20
 static const struct hpt_info hpt370 __devinitdata =3D {
@@ -515,7 +533,7 @@ static const struct hpt_info hpt370 __devinitdata =3D=
 {
 	.chip_type	=3D HPT370,
 	.udma_mask	=3D HPT370_ALLOW_ATA100_5 ? ATA_UDMA5 : ATA_UDMA4,
 	.dpll_clk	=3D 48,
-	.settings	=3D hpt37x_settings
+	.timings	=3D &hpt37x_timings
 };
=20
 static const struct hpt_info hpt370a __devinitdata =3D {
@@ -523,7 +541,7 @@ static const struct hpt_info hpt370a __devinitdata =
=3D {
 	.chip_type	=3D HPT370A,
 	.udma_mask	=3D HPT370_ALLOW_ATA100_5 ? ATA_UDMA5 : ATA_UDMA4,
 	.dpll_clk	=3D 48,
-	.settings	=3D hpt37x_settings
+	.timings	=3D &hpt37x_timings
 };
=20
 static const struct hpt_info hpt374 __devinitdata =3D {
@@ -531,7 +549,7 @@ static const struct hpt_info hpt374 __devinitdata =3D=
 {
 	.chip_type	=3D HPT374,
 	.udma_mask	=3D ATA_UDMA5,
 	.dpll_clk	=3D 48,
-	.settings	=3D hpt37x_settings
+	.timings	=3D &hpt37x_timings
 };
=20
 static const struct hpt_info hpt372 __devinitdata =3D {
@@ -539,7 +557,7 @@ static const struct hpt_info hpt372 __devinitdata =3D=
 {
 	.chip_type	=3D HPT372,
 	.udma_mask	=3D HPT372_ALLOW_ATA133_6 ? ATA_UDMA6 : ATA_UDMA5,
 	.dpll_clk	=3D 55,
-	.settings	=3D hpt37x_settings
+	.timings	=3D &hpt37x_timings
 };
=20
 static const struct hpt_info hpt372a __devinitdata =3D {
@@ -547,7 +565,7 @@ static const struct hpt_info hpt372a __devinitdata =
=3D {
 	.chip_type	=3D HPT372A,
 	.udma_mask	=3D HPT372_ALLOW_ATA133_6 ? ATA_UDMA6 : ATA_UDMA5,
 	.dpll_clk	=3D 66,
-	.settings	=3D hpt37x_settings
+	.timings	=3D &hpt37x_timings
 };
=20
 static const struct hpt_info hpt302 __devinitdata =3D {
@@ -555,7 +573,7 @@ static const struct hpt_info hpt302 __devinitdata =3D=
 {
 	.chip_type	=3D HPT302,
 	.udma_mask	=3D HPT302_ALLOW_ATA133_6 ? ATA_UDMA6 : ATA_UDMA5,
 	.dpll_clk	=3D 66,
-	.settings	=3D hpt37x_settings
+	.timings	=3D &hpt37x_timings
 };
=20
 static const struct hpt_info hpt371 __devinitdata =3D {
@@ -563,7 +581,7 @@ static const struct hpt_info hpt371 __devinitdata =3D=
 {
 	.chip_type	=3D HPT371,
 	.udma_mask	=3D HPT371_ALLOW_ATA133_6 ? ATA_UDMA6 : ATA_UDMA5,
 	.dpll_clk	=3D 66,
-	.settings	=3D hpt37x_settings
+	.timings	=3D &hpt37x_timings
 };
=20
 static const struct hpt_info hpt372n __devinitdata =3D {
@@ -571,7 +589,7 @@ static const struct hpt_info hpt372n __devinitdata =
=3D {
 	.chip_type	=3D HPT372N,
 	.udma_mask	=3D HPT372_ALLOW_ATA133_6 ? ATA_UDMA6 : ATA_UDMA5,
 	.dpll_clk	=3D 77,
-	.settings	=3D hpt37x_settings
+	.timings	=3D &hpt37x_timings
 };
=20
 static const struct hpt_info hpt302n __devinitdata =3D {
@@ -579,7 +597,7 @@ static const struct hpt_info hpt302n __devinitdata =
=3D {
 	.chip_type	=3D HPT302N,
 	.udma_mask	=3D HPT302_ALLOW_ATA133_6 ? ATA_UDMA6 : ATA_UDMA5,
 	.dpll_clk	=3D 77,
-	.settings	=3D hpt37x_settings
+	.timings	=3D &hpt37x_timings
 };
=20
 static const struct hpt_info hpt371n __devinitdata =3D {
@@ -587,7 +605,7 @@ static const struct hpt_info hpt371n __devinitdata =
=3D {
 	.chip_type	=3D HPT371N,
 	.udma_mask	=3D HPT371_ALLOW_ATA133_6 ? ATA_UDMA6 : ATA_UDMA5,
 	.dpll_clk	=3D 77,
-	.settings	=3D hpt37x_settings
+	.timings	=3D &hpt37x_timings
 };
=20
 static int check_in_drive_list(ide_drive_t *drive, const char **list)
@@ -675,71 +693,33 @@ static u32 get_speed_setting(u8 speed, struct hpt=
_info *info)
 	for (i =3D 0; i < ARRAY_SIZE(xfer_speeds) - 1; i++)
 		if (xfer_speeds[i] =3D=3D speed)
 			break;
-	/*
-	 * NOTE: info->settings only points to the pointer
-	 * to the list of the actual register values
-	 */
-	return (*info->settings)[i];
+
+	return info->timings->clock_table[info->clock][i];
 }
=20
-static void hpt36x_set_mode(ide_drive_t *drive, const u8 speed)
+static void hpt3xx_set_mode(ide_drive_t *drive, const u8 speed)
 {
-	ide_hwif_t *hwif	=3D HWIF(drive);
-	struct pci_dev  *dev	=3D hwif->pci_dev;
+	struct pci_dev  *dev	=3D HWIF(drive)->pci_dev;
 	struct hpt_info	*info	=3D pci_get_drvdata(dev);
-	u8  itr_addr		=3D drive->dn ? 0x44 : 0x40;
+	struct hpt_timings *t	=3D info->timings;
+	u8  itr_addr		=3D 0x40 + (drive->dn * 4);
 	u32 old_itr		=3D 0;
-	u32 itr_mask, new_itr;
-
-	itr_mask =3D speed < XFER_MW_DMA_0 ? 0x30070000 :
-		  (speed < XFER_UDMA_0   ? 0xc0070000 : 0xc03800ff);
-
-	new_itr =3D get_speed_setting(speed, info);
+	u32 new_itr		=3D get_speed_setting(speed, info);
+	u32 itr_mask		=3D speed < XFER_MW_DMA_0 ? t->pio_mask :
+				 (speed < XFER_UDMA_0   ? t->dma_mask :
+							  t->ultra_mask);
=20
+	pci_read_config_dword(dev, itr_addr, &old_itr);
+	new_itr =3D (old_itr & ~itr_mask) | (new_itr & itr_mask);
 	/*
 	 * Disable on-chip PIO FIFO/buffer (and PIO MST mode as well)
 	 * to avoid problems handling I/O errors later
 	 */
-	pci_read_config_dword(dev, itr_addr, &old_itr);
-	new_itr  =3D (new_itr & ~itr_mask) | (old_itr & itr_mask);
 	new_itr &=3D ~0xc0000000;
=20
 	pci_write_config_dword(dev, itr_addr, new_itr);
 }
=20
-static void hpt37x_set_mode(ide_drive_t *drive, const u8 speed)
-{
-	ide_hwif_t *hwif	=3D HWIF(drive);
-	struct pci_dev  *dev	=3D hwif->pci_dev;
-	struct hpt_info	*info	=3D pci_get_drvdata(dev);
-	u8  itr_addr		=3D 0x40 + (drive->dn * 4);
-	u32 old_itr		=3D 0;
-	u32 itr_mask, new_itr;
-
-	itr_mask =3D speed < XFER_MW_DMA_0 ? 0x303c0000 :
-		  (speed < XFER_UDMA_0   ? 0xc03c0000 : 0xc1c001ff);
-
-	new_itr =3D get_speed_setting(speed, info);
-
-	pci_read_config_dword(dev, itr_addr, &old_itr);
-	new_itr =3D (new_itr & ~itr_mask) | (old_itr & itr_mask);
-=09
-	if (speed < XFER_MW_DMA_0)
-		new_itr &=3D ~0x80000000; /* Disable on-chip PIO FIFO/buffer */
-	pci_write_config_dword(dev, itr_addr, new_itr);
-}
-
-static void hpt3xx_set_mode(ide_drive_t *drive, const u8 speed)
-{
-	ide_hwif_t *hwif	=3D HWIF(drive);
-	struct hpt_info	*info	=3D pci_get_drvdata(hwif->pci_dev);
-
-	if (info->chip_type >=3D HPT370)
-		hpt37x_set_mode(drive, speed);
-	else	/* hpt368: hpt_minimum_revision(dev, 2) */
-		hpt36x_set_mode(drive, speed);
-}
-
 static void hpt3xx_set_pio_mode(ide_drive_t *drive, const u8 pio)
 {
 	hpt3xx_set_mode(drive, XFER_PIO_0 + pio);
@@ -756,15 +736,6 @@ static int hpt3xx_quirkproc(ide_drive_t *drive)
 	return 0;
 }
=20
-static void hpt3xx_intrproc(ide_drive_t *drive)
-{
-	if (drive->quirk_list)
-		return;
-
-	/* drives in the quirk_list may not like intr setups/cleanups */
-	outb(drive->ctl | 2, IDE_CONTROL_REG);
-}
-
 static void hpt3xx_maskproc(ide_drive_t *drive, int mask)
 {
 	ide_hwif_t *hwif	=3D HWIF(drive);
@@ -914,32 +885,33 @@ static int hpt374_ide_dma_end(ide_drive_t *drive)
=20
 static void hpt3xxn_set_clock(ide_hwif_t *hwif, u8 mode)
 {
-	u8 scr2 =3D inb(hwif->dma_master + 0x7b);
+	unsigned long base =3D hwif->extra_base;
+	u8 scr2 =3D inb(base + 0x6b);
=20
 	if ((scr2 & 0x7f) =3D=3D mode)
 		return;
=20
 	/* Tristate the bus */
-	outb(0x80, hwif->dma_master + 0x73);
-	outb(0x80, hwif->dma_master + 0x77);
+	outb(0x80, base + 0x63);
+	outb(0x80, base + 0x67);
=20
 	/* Switch clock and reset channels */
-	outb(mode, hwif->dma_master + 0x7b);
-	outb(0xc0, hwif->dma_master + 0x79);
+	outb(mode, base + 0x6b);
+	outb(0xc0, base + 0x69);
=20
 	/*
 	 * Reset the state machines.
 	 * NOTE: avoid accidentally enabling the disabled channels.
 	 */
-	outb(inb(hwif->dma_master + 0x70) | 0x32, hwif->dma_master + 0x70);
-	outb(inb(hwif->dma_master + 0x74) | 0x32, hwif->dma_master + 0x74);
+	outb(inb(base + 0x60) | 0x32, base + 0x60);
+	outb(inb(base + 0x64) | 0x32, base + 0x64);
=20
 	/* Complete reset */
-	outb(0x00, hwif->dma_master + 0x79);
+	outb(0x00, base + 0x69);
=20
 	/* Reconnect channels to bus */
-	outb(0x00, hwif->dma_master + 0x73);
-	outb(0x00, hwif->dma_master + 0x77);
+	outb(0x00, base + 0x63);
+	outb(0x00, base + 0x67);
 }
=20
 /**
@@ -1210,7 +1182,7 @@ static unsigned int __devinit init_chipset_hpt366=
(struct pci_dev *dev, const cha
 	 * We also  don't like using  the DPLL because this causes glitches
 	 * on PRST-/SRST- when the state engine gets reset...
 	 */
-	if (chip_type >=3D HPT374 || info->settings[clock] =3D=3D NULL) {
+	if (chip_type >=3D HPT374 || info->timings->clock_table[clock] =3D=3D=
 NULL) {
 		u16 f_low, delta =3D pci_clk < 50 ? 2 : 4;
 		int adjust;
=20
@@ -1226,7 +1198,7 @@ static unsigned int __devinit init_chipset_hpt366=
(struct pci_dev *dev, const cha
 			clock =3D ATA_CLOCK_50MHZ;
 		}
=20
-		if (info->settings[clock] =3D=3D NULL) {
+		if (info->timings->clock_table[clock] =3D=3D NULL) {
 			printk(KERN_ERR "%s: unknown bus timing!\n", name);
 			kfree(info);
 			return -EIO;
@@ -1267,15 +1239,10 @@ static unsigned int __devinit init_chipset_hpt3=
66(struct pci_dev *dev, const cha
 		printk("%s: using %d MHz PCI clock\n", name, pci_clk);
 	}
=20
-	/*
-	 * Advance the table pointer to a slot which points to the list
-	 * of the register values settings matching the clock being used.
-	 */
-	info->settings +=3D clock;
-
 	/* Store the clock frequencies. */
 	info->dpll_clk	=3D dpll_clk;
 	info->pci_clk	=3D pci_clk;
+	info->clock	=3D clock;
=20
 	/* Point to this chip's own instance of the hpt_info structure. */
 	pci_set_drvdata(dev, info);
@@ -1320,8 +1287,8 @@ static void __devinit init_hwif_hpt366(ide_hwif_t=
 *hwif)
=20
 	hwif->set_pio_mode	=3D &hpt3xx_set_pio_mode;
 	hwif->set_dma_mode	=3D &hpt3xx_set_mode;
+
 	hwif->quirkproc		=3D &hpt3xx_quirkproc;
-	hwif->intrproc		=3D &hpt3xx_intrproc;
 	hwif->maskproc		=3D &hpt3xx_maskproc;
 	hwif->busproc		=3D &hpt3xx_busproc;
=20
@@ -1494,6 +1461,11 @@ static int __devinit hpt36x_init(struct pci_dev =
*dev, struct pci_dev *dev2)
 	return 0;
 }
=20
+#define IDE_HFLAGS_HPT3XX \
+	(IDE_HFLAG_NO_ATAPI_DMA | \
+	 IDE_HFLAG_ABUSE_SET_DMA_MODE | \
+	 IDE_HFLAG_OFF_BOARD)
+
 static const struct ide_port_info hpt366_chipsets[] __devinitdata =3D =
{
 	{	/* 0 */
 		.name		=3D "HPT36x",
@@ -1508,9 +1480,7 @@ static const struct ide_port_info hpt366_chipsets=
[] __devinitdata =3D {
 		 */
 		.enablebits	=3D {{0x50,0x10,0x10}, {0x54,0x04,0x04}},
 		.extra		=3D 240,
-		.host_flags	=3D IDE_HFLAG_SINGLE |
-				  IDE_HFLAG_NO_ATAPI_DMA |
-				  IDE_HFLAG_OFF_BOARD,
+		.host_flags	=3D IDE_HFLAGS_HPT3XX | IDE_HFLAG_SINGLE,
 		.pio_mask	=3D ATA_PIO4,
 		.mwdma_mask	=3D ATA_MWDMA2,
 	},{	/* 1 */
@@ -1520,7 +1490,7 @@ static const struct ide_port_info hpt366_chipsets=
[] __devinitdata =3D {
 		.init_dma	=3D init_dma_hpt366,
 		.enablebits	=3D {{0x50,0x04,0x04}, {0x54,0x04,0x04}},
 		.extra		=3D 240,
-		.host_flags	=3D IDE_HFLAG_NO_ATAPI_DMA | IDE_HFLAG_OFF_BOARD,
+		.host_flags	=3D IDE_HFLAGS_HPT3XX,
 		.pio_mask	=3D ATA_PIO4,
 		.mwdma_mask	=3D ATA_MWDMA2,
 	},{	/* 2 */
@@ -1530,7 +1500,7 @@ static const struct ide_port_info hpt366_chipsets=
[] __devinitdata =3D {
 		.init_dma	=3D init_dma_hpt366,
 		.enablebits	=3D {{0x50,0x04,0x04}, {0x54,0x04,0x04}},
 		.extra		=3D 240,
-		.host_flags	=3D IDE_HFLAG_NO_ATAPI_DMA | IDE_HFLAG_OFF_BOARD,
+		.host_flags	=3D IDE_HFLAGS_HPT3XX,
 		.pio_mask	=3D ATA_PIO4,
 		.mwdma_mask	=3D ATA_MWDMA2,
 	},{	/* 3 */
@@ -1540,7 +1510,7 @@ static const struct ide_port_info hpt366_chipsets=
[] __devinitdata =3D {
 		.init_dma	=3D init_dma_hpt366,
 		.enablebits	=3D {{0x50,0x04,0x04}, {0x54,0x04,0x04}},
 		.extra		=3D 240,
-		.host_flags	=3D IDE_HFLAG_NO_ATAPI_DMA | IDE_HFLAG_OFF_BOARD,
+		.host_flags	=3D IDE_HFLAGS_HPT3XX,
 		.pio_mask	=3D ATA_PIO4,
 		.mwdma_mask	=3D ATA_MWDMA2,
 	},{	/* 4 */
@@ -1551,7 +1521,7 @@ static const struct ide_port_info hpt366_chipsets=
[] __devinitdata =3D {
 		.enablebits	=3D {{0x50,0x04,0x04}, {0x54,0x04,0x04}},
 		.udma_mask	=3D ATA_UDMA5,
 		.extra		=3D 240,
-		.host_flags	=3D IDE_HFLAG_NO_ATAPI_DMA | IDE_HFLAG_OFF_BOARD,
+		.host_flags	=3D IDE_HFLAGS_HPT3XX,
 		.pio_mask	=3D ATA_PIO4,
 		.mwdma_mask	=3D ATA_MWDMA2,
 	},{	/* 5 */
@@ -1561,7 +1531,7 @@ static const struct ide_port_info hpt366_chipsets=
[] __devinitdata =3D {
 		.init_dma	=3D init_dma_hpt366,
 		.enablebits	=3D {{0x50,0x04,0x04}, {0x54,0x04,0x04}},
 		.extra		=3D 240,
-		.host_flags	=3D IDE_HFLAG_NO_ATAPI_DMA | IDE_HFLAG_OFF_BOARD,
+		.host_flags	=3D IDE_HFLAGS_HPT3XX,
 		.pio_mask	=3D ATA_PIO4,
 		.mwdma_mask	=3D ATA_MWDMA2,
 	}
diff --git a/drivers/ide/pci/it8213.c b/drivers/ide/pci/it8213.c
index 90b52ed..2a0f45c 100644
--- a/drivers/ide/pci/it8213.c
+++ b/drivers/ide/pci/it8213.c
@@ -101,24 +101,11 @@ static void it8213_set_dma_mode(ide_drive_t *driv=
e, const u8 speed)
 	pci_read_config_byte(dev, 0x54, &reg54);
 	pci_read_config_byte(dev, 0x55, &reg55);
=20
-	switch(speed) {
-		case XFER_UDMA_6:
-		case XFER_UDMA_4:
-		case XFER_UDMA_2:	u_speed =3D 2 << (drive->dn * 4); break;
-		case XFER_UDMA_5:
-		case XFER_UDMA_3:
-		case XFER_UDMA_1:	u_speed =3D 1 << (drive->dn * 4); break;
-		case XFER_UDMA_0:	u_speed =3D 0 << (drive->dn * 4); break;
-			break;
-		case XFER_MW_DMA_2:
-		case XFER_MW_DMA_1:
-		case XFER_SW_DMA_2:
-			break;
-		default:
-			return;
-	}
-
 	if (speed >=3D XFER_UDMA_0) {
+		u8 udma =3D speed - XFER_UDMA_0;
+
+		u_speed =3D min_t(u8, 2 - (udma & 1), udma) << (drive->dn * 4);
+
 		if (!(reg48 & u_flag))
 			pci_write_config_byte(dev, 0x48, reg48 | u_flag);
 		if (speed >=3D XFER_UDMA_5) {
diff --git a/drivers/ide/pci/pdc202xx_new.c b/drivers/ide/pci/pdc202xx_=
new.c
index 2b4f44e..ef4a99b 100644
--- a/drivers/ide/pci/pdc202xx_new.c
+++ b/drivers/ide/pci/pdc202xx_new.c
@@ -146,7 +146,7 @@ static struct udma_timing {
 	{ 0x1a, 0x01, 0xcb },	/* UDMA mode 6 */
 };
=20
-static void pdcnew_set_mode(ide_drive_t *drive, const u8 speed)
+static void pdcnew_set_dma_mode(ide_drive_t *drive, const u8 speed)
 {
 	ide_hwif_t *hwif	=3D HWIF(drive);
 	u8 adj			=3D (drive->dn & 1) ? 0x08 : 0x00;
@@ -162,45 +162,18 @@ static void pdcnew_set_mode(ide_drive_t *drive, c=
onst u8 speed)
 	if (max_dma_rate(hwif->pci_dev) =3D=3D 4) {
 		u8 mode =3D speed & 0x07;
=20
-		switch (speed) {
-			case XFER_UDMA_6:
-			case XFER_UDMA_5:
-			case XFER_UDMA_4:
-			case XFER_UDMA_3:
-			case XFER_UDMA_2:
-			case XFER_UDMA_1:
-			case XFER_UDMA_0:
-				set_indexed_reg(hwif, 0x10 + adj,
-						udma_timings[mode].reg10);
-				set_indexed_reg(hwif, 0x11 + adj,
-						udma_timings[mode].reg11);
-				set_indexed_reg(hwif, 0x12 + adj,
-						udma_timings[mode].reg12);
-				break;
-
-			case XFER_MW_DMA_2:
-			case XFER_MW_DMA_1:
-			case XFER_MW_DMA_0:
-				set_indexed_reg(hwif, 0x0e + adj,
-						mwdma_timings[mode].reg0e);
-				set_indexed_reg(hwif, 0x0f + adj,
-						mwdma_timings[mode].reg0f);
-				break;
-			case XFER_PIO_4:
-			case XFER_PIO_3:
-			case XFER_PIO_2:
-			case XFER_PIO_1:
-			case XFER_PIO_0:
-				set_indexed_reg(hwif, 0x0c + adj,
-						pio_timings[mode].reg0c);
-				set_indexed_reg(hwif, 0x0d + adj,
-						pio_timings[mode].reg0d);
-				set_indexed_reg(hwif, 0x13 + adj,
-						pio_timings[mode].reg13);
-				break;
-			default:
-				printk(KERN_ERR "pdc202xx_new: "
-				       "Unknown speed %d ignored\n", speed);
+		if (speed >=3D XFER_UDMA_0) {
+			set_indexed_reg(hwif, 0x10 + adj,
+					udma_timings[mode].reg10);
+			set_indexed_reg(hwif, 0x11 + adj,
+					udma_timings[mode].reg11);
+			set_indexed_reg(hwif, 0x12 + adj,
+					udma_timings[mode].reg12);
+		} else {
+			set_indexed_reg(hwif, 0x0e + adj,
+					mwdma_timings[mode].reg0e);
+			set_indexed_reg(hwif, 0x0f + adj,
+					mwdma_timings[mode].reg0f);
 		}
 	} else if (speed =3D=3D XFER_UDMA_2) {
 		/* Set tHOLD bit to 0 if using UDMA mode 2 */
@@ -212,7 +185,14 @@ static void pdcnew_set_mode(ide_drive_t *drive, co=
nst u8 speed)
=20
 static void pdcnew_set_pio_mode(ide_drive_t *drive, const u8 pio)
 {
-	pdcnew_set_mode(drive, XFER_PIO_0 + pio);
+	ide_hwif_t *hwif =3D drive->hwif;
+	u8 adj =3D (drive->dn & 1) ? 0x08 : 0x00;
+
+	if (max_dma_rate(hwif->pci_dev) =3D=3D 4) {
+		set_indexed_reg(hwif, 0x0c + adj, pio_timings[pio].reg0c);
+		set_indexed_reg(hwif, 0x0d + adj, pio_timings[pio].reg0d);
+		set_indexed_reg(hwif, 0x13 + adj, pio_timings[pio].reg13);
+	}
 }
=20
 static u8 pdcnew_cable_detect(ide_hwif_t *hwif)
@@ -466,7 +446,7 @@ static unsigned int __devinit init_chipset_pdcnew(s=
truct pci_dev *dev, const cha
 static void __devinit init_hwif_pdc202new(ide_hwif_t *hwif)
 {
 	hwif->set_pio_mode =3D &pdcnew_set_pio_mode;
-	hwif->set_dma_mode =3D &pdcnew_set_mode;
+	hwif->set_dma_mode =3D &pdcnew_set_dma_mode;
=20
 	hwif->quirkproc =3D &pdcnew_quirkproc;
 	hwif->resetproc =3D &pdcnew_reset;
diff --git a/drivers/ide/pci/pdc202xx_old.c b/drivers/ide/pci/pdc202xx_=
old.c
index e09742e..67b2781 100644
--- a/drivers/ide/pci/pdc202xx_old.c
+++ b/drivers/ide/pci/pdc202xx_old.c
@@ -162,7 +162,7 @@ static u8 pdc202xx_old_cable_detect (ide_hwif_t *hw=
if)
  */
 static void pdc_old_enable_66MHz_clock(ide_hwif_t *hwif)
 {
-	unsigned long clock_reg =3D hwif->dma_master + 0x11;
+	unsigned long clock_reg =3D hwif->extra_base + 0x01;
 	u8 clock =3D inb(clock_reg);
=20
 	outb(clock | (hwif->channel ? 0x08 : 0x02), clock_reg);
@@ -170,7 +170,7 @@ static void pdc_old_enable_66MHz_clock(ide_hwif_t *=
hwif)
=20
 static void pdc_old_disable_66MHz_clock(ide_hwif_t *hwif)
 {
-	unsigned long clock_reg =3D hwif->dma_master + 0x11;
+	unsigned long clock_reg =3D hwif->extra_base + 0x01;
 	u8 clock =3D inb(clock_reg);
=20
 	outb(clock & ~(hwif->channel ? 0x08 : 0x02), clock_reg);
@@ -193,7 +193,7 @@ static void pdc202xx_old_ide_dma_start(ide_drive_t =
*drive)
 	if (drive->media !=3D ide_disk || drive->addressing =3D=3D 1) {
 		struct request *rq	=3D HWGROUP(drive)->rq;
 		ide_hwif_t *hwif	=3D HWIF(drive);
-		unsigned long high_16   =3D hwif->dma_master;
+		unsigned long high_16	=3D hwif->extra_base - 16;
 		unsigned long atapi_reg	=3D high_16 + (hwif->channel ? 0x24 : 0x20);
 		u32 word_count	=3D 0;
 		u8 clock =3D inb(high_16 + 0x11);
@@ -212,7 +212,7 @@ static int pdc202xx_old_ide_dma_end(ide_drive_t *dr=
ive)
 {
 	if (drive->media !=3D ide_disk || drive->addressing =3D=3D 1) {
 		ide_hwif_t *hwif	=3D HWIF(drive);
-		unsigned long high_16	=3D hwif->dma_master;
+		unsigned long high_16	=3D hwif->extra_base - 16;
 		unsigned long atapi_reg	=3D high_16 + (hwif->channel ? 0x24 : 0x20);
 		u8 clock		=3D 0;
=20
@@ -228,7 +228,7 @@ static int pdc202xx_old_ide_dma_end(ide_drive_t *dr=
ive)
 static int pdc202xx_old_ide_dma_test_irq(ide_drive_t *drive)
 {
 	ide_hwif_t *hwif	=3D HWIF(drive);
-	unsigned long high_16	=3D hwif->dma_master;
+	unsigned long high_16	=3D hwif->extra_base - 16;
 	u8 dma_stat		=3D inb(hwif->dma_status);
 	u8 sc1d			=3D inb(high_16 + 0x001d);
=20
@@ -271,7 +271,7 @@ static void pdc202xx_dma_timeout(ide_drive_t *drive=
)
=20
 static void pdc202xx_reset_host (ide_hwif_t *hwif)
 {
-	unsigned long high_16	=3D hwif->dma_master;
+	unsigned long high_16	=3D hwif->extra_base - 16;
 	u8 udma_speed_flag	=3D inb(high_16 | 0x001f);
=20
 	outb(udma_speed_flag | 0x10, high_16 | 0x001f);
@@ -375,6 +375,11 @@ static void __devinit pdc202ata4_fixup_irq(struct =
pci_dev *dev,
 	}
 }
=20
+#define IDE_HFLAGS_PDC202XX \
+	(IDE_HFLAG_ERROR_STOPS_FIFO | \
+	 IDE_HFLAG_ABUSE_SET_DMA_MODE | \
+	 IDE_HFLAG_OFF_BOARD)
+
 #define DECLARE_PDC2026X_DEV(name_str, udma, extra_flags) \
 	{ \
 		.name		=3D name_str, \
@@ -382,9 +387,7 @@ static void __devinit pdc202ata4_fixup_irq(struct p=
ci_dev *dev,
 		.init_hwif	=3D init_hwif_pdc202xx, \
 		.init_dma	=3D init_dma_pdc202xx, \
 		.extra		=3D 48, \
-		.host_flags	=3D IDE_HFLAG_ERROR_STOPS_FIFO | \
-				  extra_flags | \
-				  IDE_HFLAG_OFF_BOARD, \
+		.host_flags	=3D IDE_HFLAGS_PDC202XX | extra_flags, \
 		.pio_mask	=3D ATA_PIO4, \
 		.mwdma_mask	=3D ATA_MWDMA2, \
 		.udma_mask	=3D udma, \
@@ -397,8 +400,7 @@ static const struct ide_port_info pdc202xx_chipsets=
[] __devinitdata =3D {
 		.init_hwif	=3D init_hwif_pdc202xx,
 		.init_dma	=3D init_dma_pdc202xx,
 		.extra		=3D 16,
-		.host_flags	=3D IDE_HFLAG_ERROR_STOPS_FIFO |
-				  IDE_HFLAG_OFF_BOARD,
+		.host_flags	=3D IDE_HFLAGS_PDC202XX,
 		.pio_mask	=3D ATA_PIO4,
 		.mwdma_mask	=3D ATA_MWDMA2,
 		.udma_mask	=3D ATA_UDMA2,
diff --git a/drivers/ide/pci/piix.c b/drivers/ide/pci/piix.c
index 27781d2..bd6d3f7 100644
--- a/drivers/ide/pci/piix.c
+++ b/drivers/ide/pci/piix.c
@@ -203,20 +203,11 @@ static void piix_set_dma_mode(ide_drive_t *drive,=
 const u8 speed)
 	pci_read_config_byte(dev, 0x54, &reg54);
 	pci_read_config_byte(dev, 0x55, &reg55);
=20
-	switch(speed) {
-		case XFER_UDMA_4:
-		case XFER_UDMA_2:	u_speed =3D 2 << (drive->dn * 4); break;
-		case XFER_UDMA_5:
-		case XFER_UDMA_3:
-		case XFER_UDMA_1:	u_speed =3D 1 << (drive->dn * 4); break;
-		case XFER_UDMA_0:	u_speed =3D 0 << (drive->dn * 4); break;
-		case XFER_MW_DMA_2:
-		case XFER_MW_DMA_1:
-		case XFER_SW_DMA_2:	break;
-		default:		return;
-	}
-
 	if (speed >=3D XFER_UDMA_0) {
+		u8 udma =3D speed - XFER_UDMA_0;
+
+		u_speed =3D min_t(u8, 2 - (udma & 1), udma) << (drive->dn * 4);
+
 		if (!(reg48 & u_flag))
 			pci_write_config_byte(dev, 0x48, reg48 | u_flag);
 		if (speed =3D=3D XFER_UDMA_5) {
diff --git a/drivers/ide/pci/sc1200.c b/drivers/ide/pci/sc1200.c
index 707d5ff..fef20bd 100644
--- a/drivers/ide/pci/sc1200.c
+++ b/drivers/ide/pci/sc1200.c
@@ -135,59 +135,29 @@ static void sc1200_set_dma_mode(ide_drive_t *driv=
e, const u8 mode)
 	unsigned short		pci_clock;
 	unsigned int		basereg =3D hwif->channel ? 0x50 : 0x40;
=20
+	static const u32 udma_timing[3][3] =3D {
+		{ 0x00921250, 0x00911140, 0x00911030 },
+		{ 0x00932470, 0x00922260, 0x00922140 },
+		{ 0x009436a1, 0x00933481, 0x00923261 },
+	};
+
+	static const u32 mwdma_timing[3][3] =3D {
+		{ 0x00077771, 0x00012121, 0x00002020 },
+		{ 0x000bbbb2, 0x00024241, 0x00013131 },
+		{ 0x000ffff3, 0x00035352, 0x00015151 },
+	};
+
 	pci_clock =3D sc1200_get_pci_clock();
=20
 	/*
 	 * Note that each DMA mode has several timings associated with it.
 	 * The correct timing depends on the fast PCI clock freq.
 	 */
-	timings =3D 0;
-	switch (mode) {
-		case XFER_UDMA_0:
-			switch (pci_clock) {
-				case PCI_CLK_33:	timings =3D 0x00921250;	break;
-				case PCI_CLK_48:	timings =3D 0x00932470;	break;
-				case PCI_CLK_66:	timings =3D 0x009436a1;	break;
-			}
-			break;
-		case XFER_UDMA_1:
-			switch (pci_clock) {
-				case PCI_CLK_33:	timings =3D 0x00911140;	break;
-				case PCI_CLK_48:	timings =3D 0x00922260;	break;
-				case PCI_CLK_66:	timings =3D 0x00933481;	break;
-			}
-			break;
-		case XFER_UDMA_2:
-			switch (pci_clock) {
-				case PCI_CLK_33:	timings =3D 0x00911030;	break;
-				case PCI_CLK_48:	timings =3D 0x00922140;	break;
-				case PCI_CLK_66:	timings =3D 0x00923261;	break;
-			}
-			break;
-		case XFER_MW_DMA_0:
-			switch (pci_clock) {
-				case PCI_CLK_33:	timings =3D 0x00077771;	break;
-				case PCI_CLK_48:	timings =3D 0x000bbbb2;	break;
-				case PCI_CLK_66:	timings =3D 0x000ffff3;	break;
-			}
-			break;
-		case XFER_MW_DMA_1:
-			switch (pci_clock) {
-				case PCI_CLK_33:	timings =3D 0x00012121;	break;
-				case PCI_CLK_48:	timings =3D 0x00024241;	break;
-				case PCI_CLK_66:	timings =3D 0x00035352;	break;
-			}
-			break;
-		case XFER_MW_DMA_2:
-			switch (pci_clock) {
-				case PCI_CLK_33:	timings =3D 0x00002020;	break;
-				case PCI_CLK_48:	timings =3D 0x00013131;	break;
-				case PCI_CLK_66:	timings =3D 0x00015151;	break;
-			}
-			break;
-		default:
-			return;
-	}
+
+	if (mode >=3D XFER_UDMA_0)
+		timings =3D  udma_timing[pci_clock][mode - XFER_UDMA_0];
+	else
+		timings =3D mwdma_timing[pci_clock][mode - XFER_MW_DMA_0];
=20
 	if (unit =3D=3D 0) {			/* are we configuring drive0? */
 		pci_read_config_dword(hwif->pci_dev, basereg+4, &reg);
@@ -260,66 +230,39 @@ static void sc1200_set_pio_mode(ide_drive_t *driv=
e, const u8 pio)
 }
=20
 #ifdef CONFIG_PM
-static ide_hwif_t *lookup_pci_dev (ide_hwif_t *prev, struct pci_dev *d=
ev)
-{
-	int	h;
-
-	for (h =3D 0; h < MAX_HWIFS; h++) {
-		ide_hwif_t *hwif =3D &ide_hwifs[h];
-		if (prev) {
-			if (hwif =3D=3D prev)
-				prev =3D NULL;	// found previous, now look for next match
-		} else {
-			if (hwif && hwif->pci_dev =3D=3D dev)
-				return hwif;	// found next match
-		}
-	}
-	return NULL;	// not found
-}
-
-typedef struct sc1200_saved_state_s {
-	__u32		regs[4];
-} sc1200_saved_state_t;
-
+struct sc1200_saved_state {
+	u32 regs[8];
+};
=20
 static int sc1200_suspend (struct pci_dev *dev, pm_message_t state)
 {
-	ide_hwif_t		*hwif =3D NULL;
-
 	printk("SC1200: suspend(%u)\n", state.event);
=20
+	/*
+	 * we only save state when going from full power to less
+	 */
 	if (state.event =3D=3D PM_EVENT_ON) {
-		// we only save state when going from full power to less
-
-		//
-		// Loop over all interfaces that are part of this PCI device:
-		//
-		while ((hwif =3D lookup_pci_dev(hwif, dev)) !=3D NULL) {
-			sc1200_saved_state_t	*ss;
-			unsigned int		basereg, r;
-			//
-			// allocate a permanent save area, if not already allocated
-			//
-			ss =3D (sc1200_saved_state_t *)hwif->config_data;
-			if (ss =3D=3D NULL) {
-				ss =3D kmalloc(sizeof(sc1200_saved_state_t), GFP_KERNEL);
-				if (ss =3D=3D NULL)
-					return -ENOMEM;
-				hwif->config_data =3D (unsigned long)ss;
-			}
-			ss =3D (sc1200_saved_state_t *)hwif->config_data;
-			//
-			// Save timing registers:  this may be unnecessary if=20
-			// BIOS also does it
-			//
-			basereg =3D hwif->channel ? 0x50 : 0x40;
-			for (r =3D 0; r < 4; ++r) {
-				pci_read_config_dword (hwif->pci_dev, basereg + (r<<2), &ss->regs[=
r]);
-			}
+		struct sc1200_saved_state *ss;
+		unsigned int r;
+
+		/*
+		 * allocate a permanent save area, if not already allocated
+		 */
+		ss =3D (struct sc1200_saved_state *)pci_get_drvdata(dev);
+		if (ss =3D=3D NULL) {
+			ss =3D kmalloc(sizeof(*ss), GFP_KERNEL);
+			if (ss =3D=3D NULL)
+				return -ENOMEM;
+			pci_set_drvdata(dev, ss);
 		}
-	}
=20
-	/* You don't need to iterate over disks -- sysfs should have done tha=
t for you already */=20
+		/*
+		 * save timing registers
+		 * (this may be unnecessary if BIOS also does it)
+		 */
+		for (r =3D 0; r < 8; r++)
+			pci_read_config_dword(dev, 0x40 + r * 4, &ss->regs[r]);
+	}
=20
 	pci_disable_device(dev);
 	pci_set_power_state(dev, pci_choose_state(dev, state));
@@ -328,30 +271,25 @@ static int sc1200_suspend (struct pci_dev *dev, p=
m_message_t state)
=20
 static int sc1200_resume (struct pci_dev *dev)
 {
-	ide_hwif_t	*hwif =3D NULL;
-	int		i;
+	struct sc1200_saved_state *ss;
+	unsigned int r;
+	int i;
=20
 	i =3D pci_enable_device(dev);
 	if (i)
 		return i;
=20
-	//
-	// loop over all interfaces that are part of this pci device:
-	//
-	while ((hwif =3D lookup_pci_dev(hwif, dev)) !=3D NULL) {
-		unsigned int		basereg, r;
-		sc1200_saved_state_t	*ss =3D (sc1200_saved_state_t *)hwif->config_da=
ta;
-
-		//
-		// Restore timing registers:  this may be unnecessary if BIOS also d=
oes it
-		//
-		basereg =3D hwif->channel ? 0x50 : 0x40;
-		if (ss !=3D NULL) {
-			for (r =3D 0; r < 4; ++r) {
-				pci_write_config_dword(hwif->pci_dev, basereg + (r<<2), ss->regs[r=
]);
-			}
-		}
+	ss =3D (struct sc1200_saved_state *)pci_get_drvdata(dev);
+
+	/*
+	 * restore timing registers
+	 * (this may be unnecessary if BIOS also does it)
+	 */
+	if (ss) {
+		for (r =3D 0; r < 8; r++)
+			pci_write_config_dword(dev, 0x40 + r * 4, ss->regs[r]);
 	}
+
 	return 0;
 }
 #endif
diff --git a/drivers/ide/pci/scc_pata.c b/drivers/ide/pci/scc_pata.c
index ebb7132..24a85bb 100644
--- a/drivers/ide/pci/scc_pata.c
+++ b/drivers/ide/pci/scc_pata.c
@@ -254,19 +254,7 @@ static void scc_set_dma_mode(ide_drive_t *drive, c=
onst u8 speed)
 		offset =3D 0; /* 100MHz */
 	}
=20
-	switch (speed) {
-	case XFER_UDMA_6:
-	case XFER_UDMA_5:
-	case XFER_UDMA_4:
-	case XFER_UDMA_3:
-	case XFER_UDMA_2:
-	case XFER_UDMA_1:
-	case XFER_UDMA_0:
-		idx =3D speed - XFER_UDMA_0;
-		break;
-	default:
-		return;
-	}
+	idx =3D speed - XFER_UDMA_0;
=20
 	jcactsel =3D JCACTSELtbl[offset][idx];
 	if (is_slave) {
diff --git a/drivers/ide/pci/serverworks.c b/drivers/ide/pci/serverwork=
s.c
index a728031..e9bd269 100644
--- a/drivers/ide/pci/serverworks.c
+++ b/drivers/ide/pci/serverworks.c
@@ -366,12 +366,17 @@ static void __devinit init_hwif_svwks (ide_hwif_t=
 *hwif)
 	}
 }
=20
+#define IDE_HFLAGS_SVWKS \
+	(IDE_HFLAG_LEGACY_IRQS | \
+	 IDE_HFLAG_ABUSE_SET_DMA_MODE | \
+	 IDE_HFLAG_BOOTABLE)
+
 static const struct ide_port_info serverworks_chipsets[] __devinitdata=
 =3D {
 	{	/* 0 */
 		.name		=3D "SvrWks OSB4",
 		.init_chipset	=3D init_chipset_svwks,
 		.init_hwif	=3D init_hwif_svwks,
-		.host_flags	=3D IDE_HFLAG_LEGACY_IRQS | IDE_HFLAG_BOOTABLE,
+		.host_flags	=3D IDE_HFLAGS_SVWKS,
 		.pio_mask	=3D ATA_PIO4,
 		.mwdma_mask	=3D ATA_MWDMA2,
 		.udma_mask	=3D 0x00, /* UDMA is problematic on OSB4 */
@@ -379,7 +384,7 @@ static const struct ide_port_info serverworks_chips=
ets[] __devinitdata =3D {
 		.name		=3D "SvrWks CSB5",
 		.init_chipset	=3D init_chipset_svwks,
 		.init_hwif	=3D init_hwif_svwks,
-		.host_flags	=3D IDE_HFLAG_LEGACY_IRQS | IDE_HFLAG_BOOTABLE,
+		.host_flags	=3D IDE_HFLAGS_SVWKS,
 		.pio_mask	=3D ATA_PIO4,
 		.mwdma_mask	=3D ATA_MWDMA2,
 		.udma_mask	=3D ATA_UDMA5,
@@ -387,7 +392,7 @@ static const struct ide_port_info serverworks_chips=
ets[] __devinitdata =3D {
 		.name		=3D "SvrWks CSB6",
 		.init_chipset	=3D init_chipset_svwks,
 		.init_hwif	=3D init_hwif_svwks,
-		.host_flags	=3D IDE_HFLAG_LEGACY_IRQS | IDE_HFLAG_BOOTABLE,
+		.host_flags	=3D IDE_HFLAGS_SVWKS,
 		.pio_mask	=3D ATA_PIO4,
 		.mwdma_mask	=3D ATA_MWDMA2,
 		.udma_mask	=3D ATA_UDMA5,
@@ -395,8 +400,7 @@ static const struct ide_port_info serverworks_chips=
ets[] __devinitdata =3D {
 		.name		=3D "SvrWks CSB6",
 		.init_chipset	=3D init_chipset_svwks,
 		.init_hwif	=3D init_hwif_svwks,
-		.host_flags	=3D IDE_HFLAG_LEGACY_IRQS | IDE_HFLAG_SINGLE |
-				  IDE_HFLAG_BOOTABLE,
+		.host_flags	=3D IDE_HFLAGS_SVWKS | IDE_HFLAG_SINGLE,
 		.pio_mask	=3D ATA_PIO4,
 		.mwdma_mask	=3D ATA_MWDMA2,
 		.udma_mask	=3D ATA_UDMA5,
@@ -404,8 +408,7 @@ static const struct ide_port_info serverworks_chips=
ets[] __devinitdata =3D {
 		.name		=3D "SvrWks HT1000",
 		.init_chipset	=3D init_chipset_svwks,
 		.init_hwif	=3D init_hwif_svwks,
-		.host_flags	=3D IDE_HFLAG_LEGACY_IRQS | IDE_HFLAG_SINGLE |
-				  IDE_HFLAG_BOOTABLE,
+		.host_flags	=3D IDE_HFLAGS_SVWKS | IDE_HFLAG_SINGLE,
 		.pio_mask	=3D ATA_PIO4,
 		.mwdma_mask	=3D ATA_MWDMA2,
 		.udma_mask	=3D ATA_UDMA5,
diff --git a/drivers/ide/pci/sgiioc4.c b/drivers/ide/pci/sgiioc4.c
index de820aa..7e9dade 100644
--- a/drivers/ide/pci/sgiioc4.c
+++ b/drivers/ide/pci/sgiioc4.c
@@ -582,7 +582,6 @@ ide_init_sgiioc4(ide_hwif_t * hwif)
 	hwif->pre_reset =3D NULL;	/* No HBA specific pre_set needed */
 	hwif->resetproc =3D &sgiioc4_resetproc;/* Reset DMA engine,
 						clear interrupts */
-	hwif->intrproc =3D NULL;	/* Enable or Disable interrupt from drive */
 	hwif->maskproc =3D &sgiioc4_maskproc;	/* Mask on/off NIEN register */
 	hwif->quirkproc =3D NULL;
 	hwif->busproc =3D NULL;
diff --git a/drivers/ide/pci/siimage.c b/drivers/ide/pci/siimage.c
index 5709c25..7b45eaf 100644
--- a/drivers/ide/pci/siimage.c
+++ b/drivers/ide/pci/siimage.c
@@ -278,27 +278,14 @@ static void sil_set_dma_mode(ide_drive_t *drive, =
const u8 speed)
=20
 	scsc =3D is_sata(hwif) ? 1 : scsc;
=20
-	switch(speed) {
-		case XFER_MW_DMA_2:
-		case XFER_MW_DMA_1:
-		case XFER_MW_DMA_0:
-			multi =3D dma[speed - XFER_MW_DMA_0];
-			mode |=3D ((unit) ? 0x20 : 0x02);
-			break;
-		case XFER_UDMA_6:
-		case XFER_UDMA_5:
-		case XFER_UDMA_4:
-		case XFER_UDMA_3:
-		case XFER_UDMA_2:
-		case XFER_UDMA_1:
-		case XFER_UDMA_0:
-			multi =3D dma[2];
-			ultra |=3D ((scsc) ? (ultra6[speed - XFER_UDMA_0]) :
-					   (ultra5[speed - XFER_UDMA_0]));
-			mode |=3D ((unit) ? 0x30 : 0x03);
-			break;
-		default:
-			return;
+	if (speed >=3D XFER_UDMA_0) {
+		multi =3D dma[2];
+		ultra |=3D (scsc ? ultra6[speed - XFER_UDMA_0] :
+				 ultra5[speed - XFER_UDMA_0]);
+		mode |=3D (unit ? 0x30 : 0x03);
+	} else {
+		multi =3D dma[speed - XFER_MW_DMA_0];
+		mode |=3D (unit ? 0x20 : 0x02);
 	}
=20
 	if (hwif->mmio) {
diff --git a/drivers/ide/pci/sis5513.c b/drivers/ide/pci/sis5513.c
index d90b429..85d3699 100644
--- a/drivers/ide/pci/sis5513.c
+++ b/drivers/ide/pci/sis5513.c
@@ -305,59 +305,56 @@ static void sis_set_pio_mode(ide_drive_t *drive, =
const u8 pio)
 	sis_program_timings(drive, XFER_PIO_0 + pio);
 }
=20
-static void sis_set_dma_mode(ide_drive_t *drive, const u8 speed)
+static void sis_ata133_program_udma_timings(ide_drive_t *drive, const =
u8 mode)
 {
-	ide_hwif_t *hwif	=3D HWIF(drive);
-	struct pci_dev *dev	=3D hwif->pci_dev;
+	struct pci_dev *dev =3D drive->hwif->pci_dev;
+	u32 regdw =3D 0;
+	u8 drive_pci =3D sis_ata133_get_base(drive), clk, idx;
=20
-	/* Config chip for mode */
-	switch(speed) {
-		case XFER_UDMA_6:
-		case XFER_UDMA_5:
-		case XFER_UDMA_4:
-		case XFER_UDMA_3:
-		case XFER_UDMA_2:
-		case XFER_UDMA_1:
-		case XFER_UDMA_0:
-			if (chipset_family >=3D ATA_133) {
-				u32 regdw =3D 0;
-				u8 drive_pci =3D sis_ata133_get_base(drive);
-
-				pci_read_config_dword(dev, drive_pci, &regdw);
-				regdw |=3D 0x04;
-				regdw &=3D 0xfffff00f;
-				/* check if ATA133 enable */
-				if (regdw & 0x08) {
-					regdw |=3D (unsigned long)cycle_time_value[ATA_133][speed-XFER_UD=
MA_0] << 4;
-					regdw |=3D (unsigned long)cvs_time_value[ATA_133][speed-XFER_UDMA=
_0] << 8;
-				} else {
-					regdw |=3D (unsigned long)cycle_time_value[ATA_100][speed-XFER_UD=
MA_0] << 4;
-					regdw |=3D (unsigned long)cvs_time_value[ATA_100][speed-XFER_UDMA=
_0] << 8;
-				}
-				pci_write_config_dword(dev, (unsigned long)drive_pci, regdw);
-			} else {
-				u8 drive_pci =3D 0x40 + drive->dn * 2, reg =3D 0;
-
-				pci_read_config_byte(dev, drive_pci+1, &reg);
-				/* Force the UDMA bit on if we want to use UDMA */
-				reg |=3D 0x80;
-				/* clean reg cycle time bits */
-				reg &=3D ~((0xFF >> (8 - cycle_time_range[chipset_family]))
-					 << cycle_time_offset[chipset_family]);
-				/* set reg cycle time bits */
-				reg |=3D cycle_time_value[chipset_family][speed-XFER_UDMA_0]
-					<< cycle_time_offset[chipset_family];
-				pci_write_config_byte(dev, drive_pci+1, reg);
-			}
-			break;
-		case XFER_MW_DMA_2:
-		case XFER_MW_DMA_1:
-		case XFER_MW_DMA_0:
-			sis_program_timings(drive, speed);
-			break;
-		default:
-			break;
-	}
+	pci_read_config_dword(dev, drive_pci, &regdw);
+
+	regdw |=3D 0x04;
+	regdw &=3D 0xfffff00f;
+	/* check if ATA133 enable */
+	clk =3D (regdw & 0x08) ? ATA_133 : ATA_100;
+	idx =3D mode - XFER_UDMA_0;
+	regdw |=3D cycle_time_value[clk][idx] << 4;
+	regdw |=3D cvs_time_value[clk][idx] << 8;
+
+	pci_write_config_dword(dev, drive_pci, regdw);
+}
+
+static void sis_ata33_program_udma_timings(ide_drive_t *drive, const u=
8 mode)
+{
+	struct pci_dev *dev =3D drive->hwif->pci_dev;
+	u8 drive_pci =3D 0x40 + drive->dn * 2, reg =3D 0, i =3D chipset_famil=
y;
+
+	pci_read_config_byte(dev, drive_pci + 1, &reg);
+
+	/* force the UDMA bit on if we want to use UDMA */
+	reg |=3D 0x80;
+	/* clean reg cycle time bits */
+	reg &=3D ~((0xff >> (8 - cycle_time_range[i])) << cycle_time_offset[i=
]);
+	/* set reg cycle time bits */
+	reg |=3D cycle_time_value[i][mode - XFER_UDMA_0] << cycle_time_offset=
[i];
+
+	pci_write_config_byte(dev, drive_pci + 1, reg);
+}
+
+static void sis_program_udma_timings(ide_drive_t *drive, const u8 mode=
)
+{
+	if (chipset_family >=3D ATA_133)	/* ATA_133 */
+		sis_ata133_program_udma_timings(drive, mode);
+	else				/* ATA_33/66/100a/100/133a */
+		sis_ata33_program_udma_timings(drive, mode);
+}
+
+static void sis_set_dma_mode(ide_drive_t *drive, const u8 speed)
+{
+	if (speed >=3D XFER_UDMA_0)
+		sis_program_udma_timings(drive, speed);
+	else
+		sis_program_timings(drive, speed);
 }
=20
 static u8 sis5513_ata133_udma_filter(ide_drive_t *drive)
diff --git a/drivers/ide/pci/sl82c105.c b/drivers/ide/pci/sl82c105.c
index 147d783..069f104 100644
--- a/drivers/ide/pci/sl82c105.c
+++ b/drivers/ide/pci/sl82c105.c
@@ -115,32 +115,24 @@ static void sl82c105_set_dma_mode(ide_drive_t *dr=
ive, const u8 speed)
  	DBG(("sl82c105_tune_chipset(drive:%s, speed:%s)\n",
 	     drive->name, ide_xfer_verbose(speed)));
=20
-	switch (speed) {
-	case XFER_MW_DMA_2:
-	case XFER_MW_DMA_1:
-	case XFER_MW_DMA_0:
-		drv_ctrl =3D mwdma_timings[speed - XFER_MW_DMA_0];
+	drv_ctrl =3D mwdma_timings[speed - XFER_MW_DMA_0];
=20
-		/*
-		 * Store the DMA timings so that we can actually program
-		 * them when DMA will be turned on...
-		 */
-		drive->drive_data &=3D 0x0000ffff;
-		drive->drive_data |=3D (unsigned long)drv_ctrl << 16;
+	/*
+	 * Store the DMA timings so that we can actually program
+	 * them when DMA will be turned on...
+	 */
+	drive->drive_data &=3D 0x0000ffff;
+	drive->drive_data |=3D (unsigned long)drv_ctrl << 16;
=20
-		/*
-		 * If we are already using DMA, we just reprogram
-		 * the drive control register.
-		 */
-		if (drive->using_dma) {
-			struct pci_dev *dev	=3D HWIF(drive)->pci_dev;
-			int reg 		=3D 0x44 + drive->dn * 4;
-
-			pci_write_config_word(dev, reg, drv_ctrl);
-		}
-		break;
-	default:
-		return;
+	/*
+	 * If we are already using DMA, we just reprogram
+	 * the drive control register.
+	 */
+	if (drive->using_dma) {
+		struct pci_dev *dev	=3D HWIF(drive)->pci_dev;
+		int reg 		=3D 0x44 + drive->dn * 4;
+
+		pci_write_config_word(dev, reg, drv_ctrl);
 	}
 }
=20
diff --git a/drivers/ide/pci/slc90e66.c b/drivers/ide/pci/slc90e66.c
index eb4445b..dbbb468 100644
--- a/drivers/ide/pci/slc90e66.c
+++ b/drivers/ide/pci/slc90e66.c
@@ -91,19 +91,9 @@ static void slc90e66_set_dma_mode(ide_drive_t *drive=
, const u8 speed)
 	pci_read_config_word(dev, 0x48, &reg48);
 	pci_read_config_word(dev, 0x4a, &reg4a);
=20
-	switch(speed) {
-		case XFER_UDMA_4:	u_speed =3D 4 << (drive->dn * 4); break;
-		case XFER_UDMA_3:	u_speed =3D 3 << (drive->dn * 4); break;
-		case XFER_UDMA_2:	u_speed =3D 2 << (drive->dn * 4); break;
-		case XFER_UDMA_1:	u_speed =3D 1 << (drive->dn * 4); break;
-		case XFER_UDMA_0:	u_speed =3D 0 << (drive->dn * 4); break;
-		case XFER_MW_DMA_2:
-		case XFER_MW_DMA_1:
-		case XFER_SW_DMA_2:	break;
-		default:		return;
-	}
-
 	if (speed >=3D XFER_UDMA_0) {
+		u_speed =3D (speed - XFER_UDMA_0) << (drive->dn * 4);
+
 		if (!(reg48 & u_flag))
 			pci_write_config_word(dev, 0x48, reg48|u_flag);
 		/* FIXME: (reg4a & a_speed) ? */
diff --git a/drivers/ide/pci/tc86c001.c b/drivers/ide/pci/tc86c001.c
index a66ebd1..e1faf6c 100644
--- a/drivers/ide/pci/tc86c001.c
+++ b/drivers/ide/pci/tc86c001.c
@@ -222,7 +222,8 @@ static const struct ide_port_info tc86c001_chipset =
__devinitdata =3D {
 	.name		=3D "TC86C001",
 	.init_chipset	=3D init_chipset_tc86c001,
 	.init_hwif	=3D init_hwif_tc86c001,
-	.host_flags	=3D IDE_HFLAG_SINGLE | IDE_HFLAG_OFF_BOARD,
+	.host_flags	=3D IDE_HFLAG_SINGLE | IDE_HFLAG_OFF_BOARD |
+			  IDE_HFLAG_ABUSE_SET_DMA_MODE,
 	.pio_mask	=3D ATA_PIO4,
 	.mwdma_mask	=3D ATA_MWDMA2,
 	.udma_mask	=3D ATA_UDMA4,
diff --git a/drivers/ide/pci/triflex.c b/drivers/ide/pci/triflex.c
index a227c41..ae52a96 100644
--- a/drivers/ide/pci/triflex.c
+++ b/drivers/ide/pci/triflex.c
@@ -81,8 +81,6 @@ static void triflex_set_mode(ide_drive_t *drive, cons=
t u8 speed)
 		case XFER_PIO_0:
 			timing =3D 0x0808;
 			break;
-		default:
-			return;
 	}
=20
 	triflex_timings &=3D ~(0xFFFF << (16 * unit));
diff --git a/drivers/ide/pci/via82cxxx.c b/drivers/ide/pci/via82cxxx.c
index a0d3c16..4b32c90 100644
--- a/drivers/ide/pci/via82cxxx.c
+++ b/drivers/ide/pci/via82cxxx.c
@@ -439,6 +439,7 @@ static const struct ide_port_info via82cxxx_chipset=
 __devinitdata =3D {
 	.enablebits	=3D { { 0x40, 0x02, 0x02 }, { 0x40, 0x01, 0x01 } },
 	.host_flags	=3D IDE_HFLAG_PIO_NO_BLACKLIST |
 			  IDE_HFLAG_PIO_NO_DOWNGRADE |
+			  IDE_HFLAG_ABUSE_SET_DMA_MODE |
 			  IDE_HFLAG_POST_SET_MODE |
 			  IDE_HFLAG_IO_32BIT |
 			  IDE_HFLAG_BOOTABLE,
diff --git a/drivers/ide/ppc/pmac.c b/drivers/ide/ppc/pmac.c
index 7f7a598..3dce800 100644
--- a/drivers/ide/ppc/pmac.c
+++ b/drivers/ide/ppc/pmac.c
@@ -438,13 +438,8 @@ pmac_ide_init_hwif_ports(hw_regs_t *hw,
 		if (data_port =3D=3D pmac_ide[ix].regbase)
 			break;
=20
-	if (ix >=3D MAX_HWIFS) {
-		/* Probably a PCI interface... */
-		for (i =3D IDE_DATA_OFFSET; i <=3D IDE_STATUS_OFFSET; ++i)
-			hw->io_ports[i] =3D data_port + i - IDE_DATA_OFFSET;
-		hw->io_ports[IDE_CONTROL_OFFSET] =3D ctrl_port;
-		return;
-	}
+	if (ix >=3D MAX_HWIFS)
+		return;		/* not an IDE PMAC interface */
=20
 	for (i =3D 0; i < 8; ++i)
 		hw->io_ports[i] =3D data_port + i * 0x10;
@@ -833,38 +828,20 @@ static void pmac_ide_set_dma_mode(ide_drive_t *dr=
ive, const u8 speed)
 	tl[0] =3D *timings;
 	tl[1] =3D *timings2;
=20
-	switch(speed) {
 #ifdef CONFIG_BLK_DEV_IDEDMA_PMAC
-		case XFER_UDMA_6:
-		case XFER_UDMA_5:
-		case XFER_UDMA_4:
-		case XFER_UDMA_3:
-		case XFER_UDMA_2:
-		case XFER_UDMA_1:
-		case XFER_UDMA_0:
-			if (pmif->kind =3D=3D controller_kl_ata4)
-				ret =3D set_timings_udma_ata4(&tl[0], speed);
-			else if (pmif->kind =3D=3D controller_un_ata6
-				 || pmif->kind =3D=3D controller_k2_ata6)
-				ret =3D set_timings_udma_ata6(&tl[0], &tl[1], speed);
-			else if (pmif->kind =3D=3D controller_sh_ata6)
-				ret =3D set_timings_udma_shasta(&tl[0], &tl[1], speed);
-			else
-				ret =3D 1;
-			break;
-		case XFER_MW_DMA_2:
-		case XFER_MW_DMA_1:
-		case XFER_MW_DMA_0:
-			set_timings_mdma(drive, pmif->kind, &tl[0], &tl[1], speed);
-			break;
-		case XFER_SW_DMA_2:
-		case XFER_SW_DMA_1:
-		case XFER_SW_DMA_0:
-			return;
+	if (speed >=3D XFER_UDMA_0) {
+		if (pmif->kind =3D=3D controller_kl_ata4)
+			ret =3D set_timings_udma_ata4(&tl[0], speed);
+		else if (pmif->kind =3D=3D controller_un_ata6
+			 || pmif->kind =3D=3D controller_k2_ata6)
+			ret =3D set_timings_udma_ata6(&tl[0], &tl[1], speed);
+		else if (pmif->kind =3D=3D controller_sh_ata6)
+			ret =3D set_timings_udma_shasta(&tl[0], &tl[1], speed);
+		else
+			ret =3D -1;
+	} else
+		set_timings_mdma(drive, pmif->kind, &tl[0], &tl[1], speed);
 #endif /* CONFIG_BLK_DEV_IDEDMA_PMAC */
-		default:
-			ret =3D 1;
-	}
 	if (ret)
 		return;
=20
diff --git a/drivers/scsi/ide-scsi.c b/drivers/scsi/ide-scsi.c
index 9706de9..02e9189 100644
--- a/drivers/scsi/ide-scsi.c
+++ b/drivers/scsi/ide-scsi.c
@@ -395,14 +395,12 @@ static int idescsi_expiry(ide_drive_t *drive)
 static ide_startstop_t idescsi_pc_intr (ide_drive_t *drive)
 {
 	idescsi_scsi_t *scsi =3D drive_to_idescsi(drive);
-	idescsi_pc_t *pc=3Dscsi->pc;
+	ide_hwif_t *hwif =3D drive->hwif;
+	idescsi_pc_t *pc =3D scsi->pc;
 	struct request *rq =3D pc->rq;
-	atapi_bcount_t bcount;
-	atapi_status_t status;
-	atapi_ireason_t ireason;
-	atapi_feature_t feature;
-
 	unsigned int temp;
+	u16 bcount;
+	u8 stat, ireason;
=20
 #if IDESCSI_DEBUG_LOG
 	printk (KERN_INFO "ide-scsi: Reached idescsi_pc_intr interrupt handle=
r\n");
@@ -425,30 +423,29 @@ static ide_startstop_t idescsi_pc_intr (ide_drive=
_t *drive)
 		(void) HWIF(drive)->ide_dma_end(drive);
 	}
=20
-	feature.all =3D 0;
 	/* Clear the interrupt */
-	status.all =3D HWIF(drive)->INB(IDE_STATUS_REG);
+	stat =3D drive->hwif->INB(IDE_STATUS_REG);
=20
-	if (!status.b.drq) {
+	if ((stat & DRQ_STAT) =3D=3D 0) {
 		/* No more interrupts */
 		if (test_bit(IDESCSI_LOG_CMD, &scsi->log))
 			printk (KERN_INFO "Packet command completed, %d bytes transferred\n=
", pc->actually_transferred);
 		local_irq_enable_in_hardirq();
-		if (status.b.check)
+		if (stat & ERR_STAT)
 			rq->errors++;
 		idescsi_end_request (drive, 1, 0);
 		return ide_stopped;
 	}
-	bcount.b.low	=3D HWIF(drive)->INB(IDE_BCOUNTL_REG);
-	bcount.b.high	=3D HWIF(drive)->INB(IDE_BCOUNTH_REG);
-	ireason.all	=3D HWIF(drive)->INB(IDE_IREASON_REG);
+	bcount =3D (hwif->INB(IDE_BCOUNTH_REG) << 8) |
+		  hwif->INB(IDE_BCOUNTL_REG);
+	ireason =3D hwif->INB(IDE_IREASON_REG);
=20
-	if (ireason.b.cod) {
+	if (ireason & CD) {
 		printk(KERN_ERR "ide-scsi: CoD !=3D 0 in idescsi_pc_intr\n");
 		return ide_do_reset (drive);
 	}
-	if (ireason.b.io) {
-		temp =3D pc->actually_transferred + bcount.all;
+	if (ireason & IO) {
+		temp =3D pc->actually_transferred + bcount;
 		if (temp > pc->request_transfer) {
 			if (temp > pc->buffer_size) {
 				printk(KERN_ERR "ide-scsi: The scsi wants to "
@@ -461,11 +458,13 @@ static ide_startstop_t idescsi_pc_intr (ide_drive=
_t *drive)
 						idescsi_input_buffers(drive, pc, temp);
 					else
 						drive->hwif->atapi_input_bytes(drive, pc->current_position, temp=
);
-					printk(KERN_ERR "ide-scsi: transferred %d of %d bytes\n", temp, b=
count.all);
+					printk(KERN_ERR "ide-scsi: transferred"
+							" %d of %d bytes\n",
+							temp, bcount);
 				}
 				pc->actually_transferred +=3D temp;
 				pc->current_position +=3D temp;
-				idescsi_discard_data(drive, bcount.all - temp);
+				idescsi_discard_data(drive, bcount - temp);
 				ide_set_handler(drive, &idescsi_pc_intr, get_timeout(pc), idescsi_=
expiry);
 				return ide_started;
 			}
@@ -474,22 +473,24 @@ static ide_startstop_t idescsi_pc_intr (ide_drive=
_t *drive)
 #endif /* IDESCSI_DEBUG_LOG */
 		}
 	}
-	if (ireason.b.io) {
+	if (ireason & IO) {
 		clear_bit(PC_WRITING, &pc->flags);
 		if (pc->sg)
-			idescsi_input_buffers(drive, pc, bcount.all);
+			idescsi_input_buffers(drive, pc, bcount);
 		else
-			HWIF(drive)->atapi_input_bytes(drive, pc->current_position, bcount.=
all);
+			hwif->atapi_input_bytes(drive, pc->current_position,
+						bcount);
 	} else {
 		set_bit(PC_WRITING, &pc->flags);
 		if (pc->sg)
-			idescsi_output_buffers (drive, pc, bcount.all);
+			idescsi_output_buffers(drive, pc, bcount);
 		else
-			HWIF(drive)->atapi_output_bytes(drive, pc->current_position, bcount=
=2Eall);
+			hwif->atapi_output_bytes(drive, pc->current_position,
+						 bcount);
 	}
 	/* Update the current position */
-	pc->actually_transferred +=3D bcount.all;
-	pc->current_position +=3D bcount.all;
+	pc->actually_transferred +=3D bcount;
+	pc->current_position +=3D bcount;
=20
 	/* And set the interrupt handler again */
 	ide_set_handler(drive, &idescsi_pc_intr, get_timeout(pc), idescsi_exp=
iry);
@@ -501,16 +502,16 @@ static ide_startstop_t idescsi_transfer_pc(ide_dr=
ive_t *drive)
 	ide_hwif_t *hwif =3D drive->hwif;
 	idescsi_scsi_t *scsi =3D drive_to_idescsi(drive);
 	idescsi_pc_t *pc =3D scsi->pc;
-	atapi_ireason_t ireason;
 	ide_startstop_t startstop;
+	u8 ireason;
=20
 	if (ide_wait_stat(&startstop,drive,DRQ_STAT,BUSY_STAT,WAIT_READY)) {
 		printk(KERN_ERR "ide-scsi: Strange, packet command "
 			"initiated yet DRQ isn't asserted\n");
 		return startstop;
 	}
-	ireason.all	=3D HWIF(drive)->INB(IDE_IREASON_REG);
-	if (!ireason.b.cod || ireason.b.io) {
+	ireason =3D hwif->INB(IDE_IREASON_REG);
+	if ((ireason & CD) =3D=3D 0 || (ireason & IO)) {
 		printk(KERN_ERR "ide-scsi: (IO,CoD) !=3D (0,1) while "
 				"issuing a packet command\n");
 		return ide_do_reset (drive);
@@ -573,30 +574,26 @@ static ide_startstop_t idescsi_issue_pc (ide_driv=
e_t *drive, idescsi_pc_t *pc)
 {
 	idescsi_scsi_t *scsi =3D drive_to_idescsi(drive);
 	ide_hwif_t *hwif =3D drive->hwif;
-	atapi_feature_t feature;
-	atapi_bcount_t bcount;
+	u16 bcount;
+	u8 dma =3D 0;
=20
 	scsi->pc=3Dpc;							/* Set the current packet command */
 	pc->actually_transferred=3D0;					/* We haven't transferred any data =
yet */
 	pc->current_position=3Dpc->buffer;
-	bcount.all =3D min(pc->request_transfer, 63 * 1024);		/* Request to t=
ransfer the entire buffer at once */
+	/* Request to transfer the entire buffer at once */
+	bcount =3D min(pc->request_transfer, 63 * 1024);
=20
-	feature.all =3D 0;
 	if (drive->using_dma && !idescsi_map_sg(drive, pc)) {
 		hwif->sg_mapped =3D 1;
-		feature.b.dma =3D !hwif->dma_setup(drive);
+		dma =3D !hwif->dma_setup(drive);
 		hwif->sg_mapped =3D 0;
 	}
=20
 	SELECT_DRIVE(drive);
-	if (IDE_CONTROL_REG)
-		HWIF(drive)->OUTB(drive->ctl, IDE_CONTROL_REG);
=20
-	HWIF(drive)->OUTB(feature.all, IDE_FEATURE_REG);
-	HWIF(drive)->OUTB(bcount.b.high, IDE_BCOUNTH_REG);
-	HWIF(drive)->OUTB(bcount.b.low, IDE_BCOUNTL_REG);
+	ide_pktcmd_tf_load(drive, IDE_TFLAG_NO_SELECT_MASK, bcount, dma);
=20
-	if (feature.b.dma)
+	if (dma)
 		set_bit(PC_DMA_OK, &pc->flags);
=20
 	if (test_bit(IDESCSI_DRQ_INTERRUPT, &scsi->flags)) {
diff --git a/include/asm-cris/arch-v10/ide.h b/include/asm-cris/arch-v1=
0/ide.h
index 78b301e..ea34e0d 100644
--- a/include/asm-cris/arch-v10/ide.h
+++ b/include/asm-cris/arch-v10/ide.h
@@ -89,11 +89,6 @@ static inline void ide_init_default_hwifs(void)
 	}
 }
=20
-/* some configuration options we don't need */
-
-#undef SUPPORT_VLB_SYNC
-#define SUPPORT_VLB_SYNC 0
-
 #endif /* __KERNEL__ */
=20
 #endif /* __ASMCRIS_IDE_H */
diff --git a/include/asm-cris/arch-v32/ide.h b/include/asm-cris/arch-v3=
2/ide.h
index 1129617..fb9c362 100644
--- a/include/asm-cris/arch-v32/ide.h
+++ b/include/asm-cris/arch-v32/ide.h
@@ -48,11 +48,6 @@ static inline unsigned long ide_default_io_base(int =
index)
 	return REG_TYPE_CONV(unsigned long, reg_ata_rw_ctrl2, ctrl2);
 }
=20
-/* some configuration options we don't need */
-
-#undef SUPPORT_VLB_SYNC
-#define SUPPORT_VLB_SYNC 0
-
 #define IDE_ARCH_ACK_INTR
 #define ide_ack_intr(hwif)	((hwif)->ack_intr(hwif))
=20
diff --git a/include/asm-frv/ide.h b/include/asm-frv/ide.h
index f0bd2cb..8c9a540 100644
--- a/include/asm-frv/ide.h
+++ b/include/asm-frv/ide.h
@@ -18,12 +18,6 @@
 #include <asm/io.h>
 #include <asm/irq.h>
=20
-#undef SUPPORT_SLOW_DATA_PORTS
-#define SUPPORT_SLOW_DATA_PORTS 0
-
-#undef SUPPORT_VLB_SYNC
-#define SUPPORT_VLB_SYNC 0
-
 #ifndef MAX_HWIFS
 #define MAX_HWIFS 8
 #endif
diff --git a/include/asm-powerpc/ide.h b/include/asm-powerpc/ide.h
index fd7f5a4..6d50310 100644
--- a/include/asm-powerpc/ide.h
+++ b/include/asm-powerpc/ide.h
@@ -42,9 +42,6 @@ struct ide_machdep_calls {
=20
 extern struct ide_machdep_calls ppc_ide_md;
=20
-#undef	SUPPORT_SLOW_DATA_PORTS
-#define	SUPPORT_SLOW_DATA_PORTS	0
-
 #define IDE_ARCH_OBSOLETE_DEFAULTS
=20
 static __inline__ int ide_default_irq(unsigned long base)
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index d18ee67..40ee170 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -144,7 +144,6 @@ enum rq_cmd_type_bits {
 	 * private REQ_LB opcodes to differentiate what type of request this =
is
 	 */
 	REQ_TYPE_ATA_CMD,
-	REQ_TYPE_ATA_TASK,
 	REQ_TYPE_ATA_TASKFILE,
 	REQ_TYPE_ATA_PC,
 };
diff --git a/include/linux/hdreg.h b/include/linux/hdreg.h
index 818c6af..ff43f8d 100644
--- a/include/linux/hdreg.h
+++ b/include/linux/hdreg.h
@@ -44,7 +44,9 @@
=20
 /* Bits for HD_ERROR */
 #define MARK_ERR		0x01	/* Bad address mark */
+#define ILI_ERR			0x01	/* Illegal Length Indication (ATAPI) */
 #define TRK0_ERR		0x02	/* couldn't find track 0 */
+#define EOM_ERR			0x02	/* End Of Media (ATAPI) */
 #define ABRT_ERR		0x04	/* Command aborted */
 #define MCR_ERR			0x08	/* media change request */
 #define ID_ERR			0x10	/* ID field not found */
@@ -52,6 +54,7 @@
 #define ECC_ERR			0x40	/* Uncorrectable ECC error */
 #define BBD_ERR			0x80	/* pre-EIDE meaning:  block marked bad */
 #define ICRC_ERR		0x80	/* new meaning:  CRC error during transfer */
+#define LFS_ERR			0xf0	/* Last Failed Sense (ATAPI) */
=20
 /* Bits of HD_NSECTOR */
 #define CD			0x01
@@ -70,13 +73,13 @@
 #define HDIO_DRIVE_HOB_HDR_SIZE		(8 * sizeof(__u8))
 #define HDIO_DRIVE_TASK_HDR_SIZE	(8 * sizeof(__u8))
=20
-#define IDE_DRIVE_TASK_INVALID		-1
 #define IDE_DRIVE_TASK_NO_DATA		0
+#ifndef __KERNEL__
+#define IDE_DRIVE_TASK_INVALID		-1
 #define IDE_DRIVE_TASK_SET_XFER		1
-
 #define IDE_DRIVE_TASK_IN		2
-
 #define IDE_DRIVE_TASK_OUT		3
+#endif
 #define IDE_DRIVE_TASK_RAW_WRITE	4
=20
 /*
@@ -87,10 +90,10 @@
 #ifndef __KERNEL__
 #define IDE_TASKFILE_STD_OUT_FLAGS	0xFE
 #define IDE_HOB_STD_OUT_FLAGS		0x3C
-#endif
=20
 typedef unsigned char task_ioreg_t;
 typedef unsigned long sata_ioreg_t;
+#endif
=20
 typedef union ide_reg_valid_s {
 	unsigned all				: 16;
@@ -116,8 +119,8 @@ typedef union ide_reg_valid_s {
 } ide_reg_valid_t;
=20
 typedef struct ide_task_request_s {
-	task_ioreg_t	io_ports[8];
-	task_ioreg_t	hob_ports[8];
+	__u8		io_ports[8];
+	__u8		hob_ports[8]; /* bytes 6 and 7 are unused */
 	ide_reg_valid_t	out_flags;
 	ide_reg_valid_t	in_flags;
 	int		data_phase;
@@ -133,36 +136,35 @@ typedef struct ide_ioctl_request_s {
 } ide_ioctl_request_t;
=20
 struct hd_drive_cmd_hdr {
-	task_ioreg_t command;
-	task_ioreg_t sector_number;
-	task_ioreg_t feature;
-	task_ioreg_t sector_count;
+	__u8 command;
+	__u8 sector_number;
+	__u8 feature;
+	__u8 sector_count;
 };
=20
+#ifndef __KERNEL__
 typedef struct hd_drive_task_hdr {
-	task_ioreg_t data;
-	task_ioreg_t feature;
-	task_ioreg_t sector_count;
-	task_ioreg_t sector_number;
-	task_ioreg_t low_cylinder;
-	task_ioreg_t high_cylinder;
-	task_ioreg_t device_head;
-	task_ioreg_t command;
+	__u8 data;
+	__u8 feature;
+	__u8 sector_count;
+	__u8 sector_number;
+	__u8 low_cylinder;
+	__u8 high_cylinder;
+	__u8 device_head;
+	__u8 command;
 } task_struct_t;
=20
 typedef struct hd_drive_hob_hdr {
-	task_ioreg_t data;
-	task_ioreg_t feature;
-	task_ioreg_t sector_count;
-	task_ioreg_t sector_number;
-	task_ioreg_t low_cylinder;
-	task_ioreg_t high_cylinder;
-	task_ioreg_t device_head;
-	task_ioreg_t control;
+	__u8 data;
+	__u8 feature;
+	__u8 sector_count;
+	__u8 sector_number;
+	__u8 low_cylinder;
+	__u8 high_cylinder;
+	__u8 device_head;
+	__u8 control;
 } hob_struct_t;
-
-#define TASKFILE_INVALID		0x7fff
-#define TASKFILE_48			0x8000
+#endif
=20
 #define TASKFILE_NO_DATA		0x0000
=20
@@ -178,12 +180,16 @@ typedef struct hd_drive_hob_hdr {
 #define TASKFILE_IN_DMAQ		0x0080
 #define TASKFILE_OUT_DMAQ		0x0100
=20
+#ifndef __KERNEL__
 #define TASKFILE_P_IN			0x0200
 #define TASKFILE_P_OUT			0x0400
 #define TASKFILE_P_IN_DMA		0x0800
 #define TASKFILE_P_OUT_DMA		0x1000
 #define TASKFILE_P_IN_DMAQ		0x2000
 #define TASKFILE_P_OUT_DMAQ		0x4000
+#define TASKFILE_48			0x8000
+#define TASKFILE_INVALID		0x7fff
+#endif
=20
 /* ATA/ATAPI Commands pre T13 Spec */
 #define WIN_NOP				0x00
diff --git a/include/linux/ide.h b/include/linux/ide.h
index 9a6a41e..1e44099 100644
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -27,25 +27,10 @@
 #include <asm/semaphore.h>
 #include <asm/mutex.h>
=20
-/*********************************************************************=
*********
- * IDE driver configuration options (play with these as desired):
- *
- * REALLY_SLOW_IO can be defined in ide.c and ide-cd.c, if necessary
- */
-#define INITIAL_MULT_COUNT	0	/* off=3D0; on=3D2,4,8,16,32, etc.. */
-
-#ifndef SUPPORT_SLOW_DATA_PORTS		/* 1 to support slow data ports */
-#define SUPPORT_SLOW_DATA_PORTS	1	/* 0 to reduce kernel size */
-#endif
-#ifndef SUPPORT_VLB_SYNC		/* 1 to support weird 32-bit chips */
-#define SUPPORT_VLB_SYNC	1	/* 0 to reduce kernel size */
-#endif
-#ifndef OK_TO_RESET_CONTROLLER		/* 1 needed for good error recovery */
-#define OK_TO_RESET_CONTROLLER	1	/* 0 for use with AH2372A/B interface=
 */
-#endif
-
-#ifndef DISABLE_IRQ_NOSYNC
-#define DISABLE_IRQ_NOSYNC	0
+#if defined(CRIS) || defined(FRV)
+# define SUPPORT_VLB_SYNC 0
+#else
+# define SUPPORT_VLB_SYNC 1
 #endif
=20
 /*
@@ -55,10 +40,6 @@
 =20
 #define IDE_NO_IRQ		(-1)
=20
-/*
- *  "No user-serviceable parts" beyond this point  :)
- *********************************************************************=
********/
-
 typedef unsigned char	byte;	/* used everywhere */
=20
 /*
@@ -103,8 +84,6 @@ typedef unsigned char	byte;	/* used everywhere */
 #define IDE_FEATURE_OFFSET	IDE_ERROR_OFFSET
 #define IDE_COMMAND_OFFSET	IDE_STATUS_OFFSET
=20
-#define IDE_CONTROL_OFFSET_HOB	(7)
-
 #define IDE_DATA_REG		(HWIF(drive)->io_ports[IDE_DATA_OFFSET])
 #define IDE_ERROR_REG		(HWIF(drive)->io_ports[IDE_ERROR_OFFSET])
 #define IDE_NSECTOR_REG		(HWIF(drive)->io_ports[IDE_NSECTOR_OFFSET])
@@ -327,47 +306,16 @@ static inline void ide_init_hwif_ports(hw_regs_t =
*hw,
 typedef union {
 	unsigned all			: 8;
 	struct {
-#if defined(__LITTLE_ENDIAN_BITFIELD)
 		unsigned set_geometry	: 1;
 		unsigned recalibrate	: 1;
 		unsigned set_multmode	: 1;
 		unsigned set_tune	: 1;
 		unsigned serviced	: 1;
 		unsigned reserved	: 3;
-#elif defined(__BIG_ENDIAN_BITFIELD)
-		unsigned reserved	: 3;
-		unsigned serviced	: 1;
-		unsigned set_tune	: 1;
-		unsigned set_multmode	: 1;
-		unsigned recalibrate	: 1;
-		unsigned set_geometry	: 1;
-#else
-#error "Please fix <asm/byteorder.h>"
-#endif
 	} b;
 } special_t;
=20
 /*
- * ATA DATA Register Special.
- * ATA NSECTOR Count Register().
- * ATAPI Byte Count Register.
- */
-typedef union {
-	unsigned all			:16;
-	struct {
-#if defined(__LITTLE_ENDIAN_BITFIELD)
-		unsigned low		:8;	/* LSB */
-		unsigned high		:8;	/* MSB */
-#elif defined(__BIG_ENDIAN_BITFIELD)
-		unsigned high		:8;	/* MSB */
-		unsigned low		:8;	/* LSB */
-#else
-#error "Please fix <asm/byteorder.h>"
-#endif
-	} b;
-} ata_nsector_t, ata_data_t, atapi_bcount_t;
-
-/*
  * ATA-IDE Select Register, aka Device-Head
  *
  * head		: always zeros here
@@ -398,131 +346,6 @@ typedef union {
 } select_t, ata_select_t;
=20
 /*
- * The ATA-IDE Status Register.
- * The ATAPI Status Register.
- *
- * check	: Error occurred
- * idx		: Index Error
- * corr		: Correctable error occurred
- * drq		: Data is request by the device
- * dsc		: Disk Seek Complete			: ata
- *		: Media access command finished		: atapi
- * df		: Device Fault				: ata
- *		: Reserved				: atapi
- * drdy		: Ready, Command Mode Capable		: ata
- *		: Ignored for ATAPI commands		: atapi
- * bsy		: Disk is Busy
- *		: The device has access to the command block
- */
-typedef union {
-	unsigned all			:8;
-	struct {
-#if defined(__LITTLE_ENDIAN_BITFIELD)
-		unsigned check		:1;
-		unsigned idx		:1;
-		unsigned corr		:1;
-		unsigned drq		:1;
-		unsigned dsc		:1;
-		unsigned df		:1;
-		unsigned drdy		:1;
-		unsigned bsy		:1;
-#elif defined(__BIG_ENDIAN_BITFIELD)
-		unsigned bsy		:1;
-		unsigned drdy		:1;
-		unsigned df		:1;
-		unsigned dsc		:1;
-		unsigned drq		:1;
-		unsigned corr           :1;
-		unsigned idx		:1;
-		unsigned check		:1;
-#else
-#error "Please fix <asm/byteorder.h>"
-#endif
-	} b;
-} ata_status_t, atapi_status_t;
-
-/*
- * ATAPI Feature Register
- *
- * dma		: Using DMA or PIO
- * reserved321	: Reserved
- * reserved654	: Reserved (Tag Type)
- * reserved7	: Reserved
- */
-typedef union {
-	unsigned all			:8;
-	struct {
-#if defined(__LITTLE_ENDIAN_BITFIELD)
-		unsigned dma		:1;
-		unsigned reserved321	:3;
-		unsigned reserved654	:3;
-		unsigned reserved7	:1;
-#elif defined(__BIG_ENDIAN_BITFIELD)
-		unsigned reserved7	:1;
-		unsigned reserved654	:3;
-		unsigned reserved321	:3;
-		unsigned dma		:1;
-#else
-#error "Please fix <asm/byteorder.h>"
-#endif
-	} b;
-} atapi_feature_t;
-
-/*
- * ATAPI Interrupt Reason Register.
- *
- * cod		: Information transferred is command (1) or data (0)
- * io		: The device requests us to read (1) or write (0)
- * reserved	: Reserved
- */
-typedef union {
-	unsigned all			:8;
-	struct {
-#if defined(__LITTLE_ENDIAN_BITFIELD)
-		unsigned cod		:1;
-		unsigned io		:1;
-		unsigned reserved	:6;
-#elif defined(__BIG_ENDIAN_BITFIELD)
-		unsigned reserved	:6;
-		unsigned io		:1;
-		unsigned cod		:1;
-#else
-#error "Please fix <asm/byteorder.h>"
-#endif
-	} b;
-} atapi_ireason_t;
-
-/*
- * The ATAPI error register.
- *
- * ili		: Illegal Length Indication
- * eom		: End Of Media Detected
- * abrt		: Aborted command - As defined by ATA
- * mcr		: Media Change Requested - As defined by ATA
- * sense_key	: Sense key of the last failed packet command
- */
-typedef union {
-	unsigned all			:8;
-	struct {
-#if defined(__LITTLE_ENDIAN_BITFIELD)
-		unsigned ili		:1;
-		unsigned eom		:1;
-		unsigned abrt		:1;
-		unsigned mcr		:1;
-		unsigned sense_key	:4;
-#elif defined(__BIG_ENDIAN_BITFIELD)
-		unsigned sense_key	:4;
-		unsigned mcr		:1;
-		unsigned abrt		:1;
-		unsigned eom		:1;
-		unsigned ili		:1;
-#else
-#error "Please fix <asm/byteorder.h>"
-#endif
-	} b;
-} atapi_error_t;
-
-/*
  * Status returned from various ide_ functions
  */
 typedef enum {
@@ -701,8 +524,6 @@ typedef struct hwif_s {
 	void	(*pre_reset)(ide_drive_t *);
 	/* routine to reset controller after a disk reset */
 	void	(*resetproc)(ide_drive_t *);
-	/* special interrupt handling for shared pci interrupts */
-	void	(*intrproc)(ide_drive_t *);
 	/* special host masking for drive selection */
 	void	(*maskproc)(ide_drive_t *, int);
 	/* check host's drive quirk list */
@@ -766,7 +587,6 @@ typedef struct hwif_s {
 	int		rqsize;		/* max sectors per request */
 	int		irq;		/* our irq number */
=20
-	unsigned long	dma_master;	/* reference base addr dmabase */
 	unsigned long	dma_base;	/* base addr for dma ports */
 	unsigned long	dma_command;	/* dma command register */
 	unsigned long	dma_vendor1;	/* dma vendor 1 register */
@@ -806,7 +626,6 @@ typedef struct hwif_s {
 /*
  *  internal ide interrupt handler type
  */
-typedef ide_startstop_t (ide_pre_handler_t)(ide_drive_t *, struct requ=
est *);
 typedef ide_startstop_t (ide_handler_t)(ide_drive_t *);
 typedef int (ide_expiry_t)(ide_drive_t *);
=20
@@ -1020,7 +839,8 @@ int ide_end_dequeued_request(ide_drive_t *drive, s=
truct request *rq,
=20
 extern void ide_set_handler (ide_drive_t *drive, ide_handler_t *handle=
r, unsigned int timeout, ide_expiry_t *expiry);
=20
-extern void ide_execute_command(ide_drive_t *, task_ioreg_t cmd, ide_h=
andler_t *, unsigned int, ide_expiry_t *);
+void ide_execute_command(ide_drive_t *, u8, ide_handler_t *, unsigned =
int,
+			 ide_expiry_t *);
=20
 ide_startstop_t __ide_error(ide_drive_t *, struct request *, u8, u8);
=20
@@ -1062,52 +882,114 @@ extern void ide_end_drive_cmd(ide_drive_t *, u8=
, u8);
  */
 extern int ide_wait_cmd(ide_drive_t *, u8, u8, u8, u8, u8 *);
=20
+enum {
+	IDE_TFLAG_LBA48			=3D (1 << 0),
+	IDE_TFLAG_NO_SELECT_MASK	=3D (1 << 1),
+	IDE_TFLAG_FLAGGED		=3D (1 << 2),
+	IDE_TFLAG_OUT_DATA		=3D (1 << 3),
+	IDE_TFLAG_OUT_HOB_FEATURE	=3D (1 << 4),
+	IDE_TFLAG_OUT_HOB_NSECT		=3D (1 << 5),
+	IDE_TFLAG_OUT_HOB_LBAL		=3D (1 << 6),
+	IDE_TFLAG_OUT_HOB_LBAM		=3D (1 << 7),
+	IDE_TFLAG_OUT_HOB_LBAH		=3D (1 << 8),
+	IDE_TFLAG_OUT_HOB		=3D IDE_TFLAG_OUT_HOB_FEATURE |
+					  IDE_TFLAG_OUT_HOB_NSECT |
+					  IDE_TFLAG_OUT_HOB_LBAL |
+					  IDE_TFLAG_OUT_HOB_LBAM |
+					  IDE_TFLAG_OUT_HOB_LBAH,
+	IDE_TFLAG_OUT_FEATURE		=3D (1 << 9),
+	IDE_TFLAG_OUT_NSECT		=3D (1 << 10),
+	IDE_TFLAG_OUT_LBAL		=3D (1 << 11),
+	IDE_TFLAG_OUT_LBAM		=3D (1 << 12),
+	IDE_TFLAG_OUT_LBAH		=3D (1 << 13),
+	IDE_TFLAG_OUT_TF		=3D IDE_TFLAG_OUT_FEATURE |
+					  IDE_TFLAG_OUT_NSECT |
+					  IDE_TFLAG_OUT_LBAL |
+					  IDE_TFLAG_OUT_LBAM |
+					  IDE_TFLAG_OUT_LBAH,
+	IDE_TFLAG_OUT_DEVICE		=3D (1 << 14),
+	IDE_TFLAG_WRITE			=3D (1 << 15),
+	IDE_TFLAG_FLAGGED_SET_IN_FLAGS	=3D (1 << 16),
+	IDE_TFLAG_IN_DATA		=3D (1 << 17),
+	IDE_TFLAG_CUSTOM_HANDLER	=3D (1 << 18),
+	IDE_TFLAG_DMA_PIO_FALLBACK	=3D (1 << 19),
+	IDE_TFLAG_IN_HOB_FEATURE	=3D (1 << 20),
+	IDE_TFLAG_IN_HOB_NSECT		=3D (1 << 21),
+	IDE_TFLAG_IN_HOB_LBAL		=3D (1 << 22),
+	IDE_TFLAG_IN_HOB_LBAM		=3D (1 << 23),
+	IDE_TFLAG_IN_HOB_LBAH		=3D (1 << 24),
+	IDE_TFLAG_IN_HOB_LBA		=3D IDE_TFLAG_IN_HOB_LBAL |
+					  IDE_TFLAG_IN_HOB_LBAM |
+					  IDE_TFLAG_IN_HOB_LBAH,
+	IDE_TFLAG_IN_HOB		=3D IDE_TFLAG_IN_HOB_FEATURE |
+					  IDE_TFLAG_IN_HOB_NSECT |
+					  IDE_TFLAG_IN_HOB_LBA,
+	IDE_TFLAG_IN_NSECT		=3D (1 << 25),
+	IDE_TFLAG_IN_LBAL		=3D (1 << 26),
+	IDE_TFLAG_IN_LBAM		=3D (1 << 27),
+	IDE_TFLAG_IN_LBAH		=3D (1 << 28),
+	IDE_TFLAG_IN_LBA		=3D IDE_TFLAG_IN_LBAL |
+					  IDE_TFLAG_IN_LBAM |
+					  IDE_TFLAG_IN_LBAH,
+	IDE_TFLAG_IN_TF			=3D IDE_TFLAG_IN_NSECT |
+					  IDE_TFLAG_IN_LBA,
+	IDE_TFLAG_IN_DEVICE		=3D (1 << 29),
+};
+
+struct ide_taskfile {
+	u8	hob_data;	/*  0: high data byte (for TASKFILE IOCTL) */
+
+	u8	hob_feature;	/*  1-5: additional data to support LBA48 */
+	u8	hob_nsect;
+	u8	hob_lbal;
+	u8	hob_lbam;
+	u8	hob_lbah;
+
+	u8	data;		/*  6: low data byte (for TASKFILE IOCTL) */
+
+	union {			/* =A07: */
+		u8 error;	/*   read:  error */
+		u8 feature;	/*  write: feature */
+	};
+
+	u8	nsect;		/*  8: number of sectors */
+	u8	lbal;		/*  9: LBA low */
+	u8	lbam;		/* 10: LBA mid */
+	u8	lbah;		/* 11: LBA high */
+
+	u8	device;		/* 12: device select */
+
+	union {			/* 13: */
+		u8 status;	/* =A0read: status =A0*/
+		u8 command;	/* write: command */
+	};
+};
+
 typedef struct ide_task_s {
-/*
- *	struct hd_drive_task_hdr	tf;
- *	task_struct_t		tf;
- *	struct hd_drive_hob_hdr		hobf;
- *	hob_struct_t		hobf;
- */
-	task_ioreg_t		tfRegister[8];
-	task_ioreg_t		hobRegister[8];
-	ide_reg_valid_t		tf_out_flags;
-	ide_reg_valid_t		tf_in_flags;
+	union {
+		struct ide_taskfile	tf;
+		u8			tf_array[14];
+	};
+	u32			tf_flags;
 	int			data_phase;
-	int			command_type;
-	ide_pre_handler_t	*prehandler;
-	ide_handler_t		*handler;
 	struct request		*rq;		/* copy of request */
 	void			*special;	/* valid_t generally */
 } ide_task_t;
=20
-extern u32 ide_read_24(ide_drive_t *);
+void ide_tf_load(ide_drive_t *, ide_task_t *);
+void ide_tf_read(ide_drive_t *, ide_task_t *);
=20
 extern void SELECT_DRIVE(ide_drive_t *);
-extern void SELECT_INTERRUPT(ide_drive_t *);
 extern void SELECT_MASK(ide_drive_t *, int);
-extern void QUIRK_LIST(ide_drive_t *);
=20
 extern int drive_is_ready(ide_drive_t *);
=20
-/*
- * taskfile io for disks for now...and builds request from ide_ioctl
- */
-extern ide_startstop_t do_rw_taskfile(ide_drive_t *, ide_task_t *);
-
-/*
- * Special Flagged Register Validation Caller
- */
-extern ide_startstop_t flagged_taskfile(ide_drive_t *, ide_task_t *);
+void ide_pktcmd_tf_load(ide_drive_t *, u32, u16, u8);
=20
-extern ide_startstop_t set_multmode_intr(ide_drive_t *);
-extern ide_startstop_t set_geometry_intr(ide_drive_t *);
-extern ide_startstop_t recal_intr(ide_drive_t *);
-extern ide_startstop_t task_no_data_intr(ide_drive_t *);
-extern ide_startstop_t task_in_intr(ide_drive_t *);
-extern ide_startstop_t pre_task_out_intr(ide_drive_t *, struct request=
 *);
+ide_startstop_t do_rw_taskfile(ide_drive_t *, ide_task_t *);
=20
-extern int ide_raw_taskfile(ide_drive_t *, ide_task_t *, u8 *);
+int ide_raw_taskfile(ide_drive_t *, ide_task_t *, u8 *, u16);
+int ide_no_data_taskfile(ide_drive_t *, ide_task_t *);
=20
 int ide_taskfile_ioctl(ide_drive_t *, unsigned int, unsigned long);
 int ide_cmd_ioctl(ide_drive_t *, unsigned int, unsigned long);
@@ -1212,6 +1094,7 @@ enum {
 	IDE_HFLAG_IO_32BIT		=3D (1 << 24),
 	/* unmask IRQs */
 	IDE_HFLAG_UNMASK_IRQS		=3D (1 << 25),
+	IDE_HFLAG_ABUSE_SET_DMA_MODE	=3D (1 << 26),
 };
=20
 #ifdef CONFIG_BLK_DEV_OFFBOARD
@@ -1229,7 +1112,7 @@ struct ide_port_info {
 	void			(*fixup)(ide_hwif_t *);
 	ide_pci_enablebit_t	enablebits[2];
 	hwif_chipset_t		chipset;
-	unsigned int		extra;
+	u8			extra;
 	u32			host_flags;
 	u8			pio_mask;
 	u8			swdma_mask;
@@ -1356,6 +1239,7 @@ static inline int ide_dev_is_sata(struct hd_drive=
id *id)
 	return 0;
 }
=20
+u64 ide_get_lba_addr(struct ide_taskfile *, int);
 u8 ide_dump_status(ide_drive_t *, const char *, u8);
=20
 typedef struct ide_pio_timings_s {
