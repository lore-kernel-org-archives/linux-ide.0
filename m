From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [BK PATCHES] ide-2.6 update
Date: Sat, 15 Jan 2005 12:40:17 +0100
Message-ID: <58cb370e050115034034a00d12@mail.gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_20_13303600.1105789217248"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.203]:18749 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262260AbVAOLkR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 15 Jan 2005 06:40:17 -0500
Received: by wproxy.gmail.com with SMTP id 67so736717wri
        for <linux-ide@vger.kernel.org>; Sat, 15 Jan 2005 03:40:17 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linus Torvalds <torvalds@osdl.org>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

------=_Part_20_13303600.1105789217248
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

Please do a

	bk pull bk://bart.bkbits.net/ide-2.6

This will update the following files:

 drivers/ide/arm/icside.c   |   31 +------------------------------
 drivers/ide/cris/ide-v10.c |   19 +------------------
 drivers/ide/ide-cd.c       |   15 +--------------
 drivers/ide/ide-default.c  |    1 +
 drivers/ide/ide-dma.c      |    2 +-
 drivers/ide/ide-io.c       |   11 +----------
 drivers/ide/ide-lib.c      |   14 ++++++--------
 drivers/ide/ide-probe.c    |    2 +-
 drivers/ide/ide.c          |   36 +++---------------------------------
 drivers/ide/pci/atiixp.c   |    5 +++--
 drivers/ide/pci/piix.c     |    3 +++
 drivers/ide/pci/piix.h     |    1 +
 drivers/pci/pci.ids        |    1 +
 include/linux/ide.h        |    5 +----
 include/linux/pci_ids.h    |    6 ++++--
 15 files changed, 29 insertions(+), 123 deletions(-)

through these ChangeSets:

<bzolnier@trik.(none)> (05/01/15 1.2339)
   [ide] kill default_{attach,cleanup}()
   
   Device drivers are supposed to provide their own ->attach and ->cleanup.
   
   Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

<bzolnier@trik.(none)> (05/01/15 1.2338)
   [ide] ide-v10: use ide_dma_intr()
   
   Use now available ide_dma_intr() in etrax_dma_intr().
   
   Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

<bzolnier@trik.(none)> (05/01/15 1.2337)
   [ide] icside: use ide_dma_intr()
   
   Make ide_dma_intr() always available if CONFIG_BLK_DEV_IDEDMA=y
   and use it instead of icside_dmaintr().  Acked by Russell.
   
   Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

<bzolnier@trik.(none)> (05/01/15 1.2336)
   [ide] kill ide_drive_t->suspend_reset
   
   This cruft pre-dates benh's PowerManagement code.
   Moreover ->suspend_reset is always equal to zero.
   
   Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

<bzolnier@trik.(none)> (05/01/15 1.2335)
   [ide] atiixp: add IXP400 support
   
   From: Enrico Scholz <enrico.scholz@informatik.tu-chemnitz.de>
   
   add IXP400 ID
   
   From: Frederick Li <fli@ati.com>
   
   update PCI IDs
   
   Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

<bzolnier@trik.(none)> (05/01/15 1.2334)
   [ide] piix: add Intel 82801DBL IDE Controller support
   
   From: Zhongjun, Wang <wangzhongjun@ccoss.com.cn>
   Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

<bzolnier@trik.(none)> (05/01/15 1.2333)
   [ide] suppress output of error messages for non-existant interfaces
   
   From: Prarit Bhargava <prarit@sgi.com>
   
   Suppress output of "Wait for ready failed before probe !" messages for 
   non-existant interfaces.
   
   Please see 
   http://marc.theaimsgroup.com/?l=linux-ide&m=110553792013649&w=2 for 
   further context on this patch.
   
   Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

<bzolnier@trik.(none)> (05/01/15 1.2332)
   [ide] make try_to_flush_leftover_data() static
   
   Hi,
   
   now that you cleaned up the ide-io.c code to be all in the right file,
   try_to_flush_leftover_data can become static since all users are in this
   file now.
   
   bart: also remove declaration from <linux/ide.h>
   
   Signed-off-by: Arjan van de Ven <arjan@infradead.org>
   Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

<bzolnier@trik.(none)> (05/01/15 1.2331)
   [ide] ide_dump_atapi_status() printk readability fix
   
   From: Gunther Mayer <gunther.mayer@gmx.net>
   
   this improves logic and readability:
   - remove blank from: AbortedCommand (as other flags)
   - add blank and {} to error= line
   - clean up: remove 2 lines and extra printk
   
   before:
     hdd: status error: status=0x7f { DriveReady DeviceFault SeekComplete 
   DataRequest CorrectedError Index Error }
     hdd: status error: error=0x7fIllegalLengthIndication EndOfMedia 
   Aborted Command MediaChangeRequested LastFailedSense 0x07
   
   after:
     hdd: status error: status=0x7f { DriveReady DeviceFault SeekComplete 
   DataRequest CorrectedError Index Error }
     hdd: status error: error=0x7f { IllegalLengthIndication EndOfMedia 
   AbortedCommand MediaChangeRequested LastFailedSense=0x07 }
   
   Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

<bzolnier@trik.(none)> (05/01/15 1.2330)
   [ide] ide-cd: use ssleep() instead of schedule_timeout()
   
   Description: Uses ssleep() in place of cdrom_sleep() to guarantee the task
   delays as expected. Remove cdrom_sleep() definition, as this is the
only place
   where it is called.
   
   Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
   Acked-by: Jens Axboe <axboe@suse.de>
   Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

diff -Nru a/drivers/ide/arm/icside.c b/drivers/ide/arm/icside.c
--- a/drivers/ide/arm/icside.c	2005-01-15 03:42:09 +01:00
+++ b/drivers/ide/arm/icside.c	2005-01-15 03:42:09 +01:00
@@ -397,35 +397,6 @@
 	enable_dma(hwif->hw.dma);
 }
 
-/*
- * dma_intr() is the handler for disk read/write DMA interrupts
- */
-static ide_startstop_t icside_dmaintr(ide_drive_t *drive)
-{
-	unsigned int stat;
-	int dma_stat;
-
-	dma_stat = icside_dma_end(drive);
-	stat = HWIF(drive)->INB(IDE_STATUS_REG);
-	if (OK_STAT(stat, DRIVE_READY, drive->bad_wstat | DRQ_STAT)) {
-		if (!dma_stat) {
-			struct request *rq = HWGROUP(drive)->rq;
-			int i;
-
-			for (i = rq->nr_sectors; i > 0; ) {
-				i -= rq->current_nr_sectors;
-				DRIVER(drive)->end_request(drive, 1, rq->nr_sectors);
-			}
-
-			return ide_stopped;
-		}
-		printk(KERN_ERR "%s: bad DMA status (dma_stat=%x)\n",
-		       drive->name, dma_stat);
-	}
-
-	return ide_error(drive, __FUNCTION__, stat);
-}
-
 static int icside_dma_setup(ide_drive_t *drive)
 {
 	ide_hwif_t *hwif = HWIF(drive);
@@ -474,7 +445,7 @@
 static void icside_dma_exec_cmd(ide_drive_t *drive, u8 cmd)
 {
 	/* issue cmd to drive */
-	ide_execute_command(drive, cmd, icside_dmaintr, 2*WAIT_CMD, NULL);
+	ide_execute_command(drive, cmd, ide_dma_intr, 2 * WAIT_CMD, NULL);
 }
 
 static int icside_dma_test_irq(ide_drive_t *drive)
diff -Nru a/drivers/ide/cris/ide-v10.c b/drivers/ide/cris/ide-v10.c
--- a/drivers/ide/cris/ide-v10.c	2005-01-15 03:42:09 +01:00
+++ b/drivers/ide/cris/ide-v10.c	2005-01-15 03:42:09 +01:00
@@ -753,27 +753,10 @@
  */
 static ide_startstop_t etrax_dma_intr (ide_drive_t *drive)
 {
-	int i, dma_stat;
-	byte stat;
-
 	LED_DISK_READ(0);
 	LED_DISK_WRITE(0);
 
-	dma_stat = HWIF(drive)->ide_dma_end(drive);
-	stat = HWIF(drive)->INB(IDE_STATUS_REG);		/* get drive status */
-	if (OK_STAT(stat,DRIVE_READY,drive->bad_wstat|DRQ_STAT)) {
-		if (!dma_stat) {
-			struct request *rq;
-			rq = HWGROUP(drive)->rq;
-			for (i = rq->nr_sectors; i > 0;) {
-				i -= rq->current_nr_sectors;
-				DRIVER(drive)->end_request(drive, 1, rq->nr_sectors);
-			}
-			return ide_stopped;
-		}
-		printk("%s: bad DMA status\n", drive->name);
-	}
-	return ide_error(drive, "dma_intr", stat);
+	return ide_dma_intr(drive);
 }
 
 /*
diff -Nru a/drivers/ide/ide-cd.c b/drivers/ide/ide-cd.c
--- a/drivers/ide/ide-cd.c	2005-01-15 03:42:09 +01:00
+++ b/drivers/ide/ide-cd.c	2005-01-15 03:42:09 +01:00
@@ -1464,19 +1464,6 @@
 }
 
 
-/* Sleep for TIME jiffies.
-   Not to be called from an interrupt handler. */
-static
-void cdrom_sleep (int time)
-{
-	int sleep = time;
-
-	do {
-		set_current_state(TASK_INTERRUPTIBLE);
-		sleep = schedule_timeout(sleep);
-	} while (sleep);
-}
-
 static
 int cdrom_queue_packet_command(ide_drive_t *drive, struct request *rq)
 {
@@ -1511,7 +1498,7 @@
 				/* The drive is in the process of loading
 				   a disk.  Retry, but wait a little to give
 				   the drive time to complete the load. */
-				cdrom_sleep(2 * HZ);
+				ssleep(2);
 			} else {
 				/* Otherwise, don't retry. */
 				retries = 0;
diff -Nru a/drivers/ide/ide-default.c b/drivers/ide/ide-default.c
--- a/drivers/ide/ide-default.c	2005-01-15 03:42:09 +01:00
+++ b/drivers/ide/ide-default.c	2005-01-15 03:42:09 +01:00
@@ -46,6 +46,7 @@
 	.name		=	"ide-default",
 	.version	=	IDEDEFAULT_VERSION,
 	.attach		=	idedefault_attach,
+	.cleanup	=	ide_unregister_subdriver,
 	.drives		=	LIST_HEAD_INIT(idedefault_driver.drives)
 };
 
diff -Nru a/drivers/ide/ide-dma.c b/drivers/ide/ide-dma.c
--- a/drivers/ide/ide-dma.c	2005-01-15 03:42:09 +01:00
+++ b/drivers/ide/ide-dma.c	2005-01-15 03:42:09 +01:00
@@ -158,7 +158,6 @@
 	return 0;
 }
 
-#ifdef CONFIG_BLK_DEV_IDEDMA_PCI
 /**
  *	ide_dma_intr	-	IDE DMA interrupt handler
  *	@drive: the drive the interrupt is for
@@ -188,6 +187,7 @@
 
 EXPORT_SYMBOL_GPL(ide_dma_intr);
 
+#ifdef CONFIG_BLK_DEV_IDEDMA_PCI
 /**
  *	ide_build_sglist	-	map IDE scatter gather for DMA I/O
  *	@drive: the drive to build the DMA table for
diff -Nru a/drivers/ide/ide-io.c b/drivers/ide/ide-io.c
--- a/drivers/ide/ide-io.c	2005-01-15 03:42:09 +01:00
+++ b/drivers/ide/ide-io.c	2005-01-15 03:42:09 +01:00
@@ -437,7 +437,7 @@
  *	by read a sector's worth of data from the drive.  Of course,
  *	this may not help if the drive is *waiting* for data from *us*.
  */
-void try_to_flush_leftover_data (ide_drive_t *drive)
+static void try_to_flush_leftover_data (ide_drive_t *drive)
 {
 	int i = (drive->mult_count ? drive->mult_count : 1) * SECTOR_WORDS;
 
@@ -452,8 +452,6 @@
 	}
 }
 
-EXPORT_SYMBOL(try_to_flush_leftover_data);
-
 static ide_startstop_t ide_ata_error(ide_drive_t *drive, struct
request *rq, u8 stat, u8 err)
 {
 	ide_hwif_t *hwif = drive->hwif;
@@ -853,13 +851,6 @@
 	if (drive->max_failures && (drive->failures > drive->max_failures)) {
 		goto kill_rq;
 	}
-
-	/*
-	 * bail early if we've sent a device to sleep, however how to wake
-	 * this needs to be a masked flag.  FIXME for proper operations.
-	 */
-	if (drive->suspend_reset)
-		goto kill_rq;
 
 	block    = rq->sector;
 	if (blk_fs_request(rq) &&
diff -Nru a/drivers/ide/ide-lib.c b/drivers/ide/ide-lib.c
--- a/drivers/ide/ide-lib.c	2005-01-15 03:42:09 +01:00
+++ b/drivers/ide/ide-lib.c	2005-01-15 03:42:09 +01:00
@@ -571,8 +571,7 @@
 
 	status.all = stat;
 	local_irq_set(flags);
-	printk("%s: %s: status=0x%02x", drive->name, msg, stat);
-	printk(" { ");
+	printk("%s: %s: status=0x%02x { ", drive->name, msg, stat);
 	if (status.b.bsy)
 		printk("Busy ");
 	else {
@@ -584,18 +583,17 @@
 		if (status.b.idx)	printk("Index ");
 		if (status.b.check)	printk("Error ");
 	}
-	printk("}");
-	printk("\n");
+	printk("}\n");
 	if ((status.all & (status.b.bsy|status.b.check)) == status.b.check) {
 		error.all = HWIF(drive)->INB(IDE_ERROR_REG);
-		printk("%s: %s: error=0x%02x", drive->name, msg, error.all);
+		printk("%s: %s: error=0x%02x { ", drive->name, msg, error.all);
 		if (error.b.ili)	printk("IllegalLengthIndication ");
 		if (error.b.eom)	printk("EndOfMedia ");
-		if (error.b.abrt)	printk("Aborted Command ");
+		if (error.b.abrt)	printk("AbortedCommand ");
 		if (error.b.mcr)	printk("MediaChangeRequested ");
-		if (error.b.sense_key)	printk("LastFailedSense 0x%02x ",
+		if (error.b.sense_key)	printk("LastFailedSense=0x%02x ",
 						error.b.sense_key);
-		printk("\n");
+		printk("}\n");
 	}
 	ide_dump_opcode(drive);
 	local_irq_restore(flags);
diff -Nru a/drivers/ide/ide-probe.c b/drivers/ide/ide-probe.c
--- a/drivers/ide/ide-probe.c	2005-01-15 03:42:09 +01:00
+++ b/drivers/ide/ide-probe.c	2005-01-15 03:42:09 +01:00
@@ -749,7 +749,7 @@
 	 *  
 	 *  BenH.
 	 */
-	if (wait_hwif_ready(hwif))
+	if (wait_hwif_ready(hwif) == -EBUSY)
 		printk(KERN_DEBUG "%s: Wait for ready failed before probe !\n", hwif->name);
 
 	/*
diff -Nru a/drivers/ide/ide.c b/drivers/ide/ide.c
--- a/drivers/ide/ide.c	2005-01-15 03:42:09 +01:00
+++ b/drivers/ide/ide.c	2005-01-15 03:42:09 +01:00
@@ -1554,18 +1554,7 @@
 			HWGROUP(drive)->busy = 1;
 			spin_unlock_irqrestore(&ide_lock, flags);
 			(void) ide_do_reset(drive);
-			if (drive->suspend_reset) {
-/*
- *				APM WAKE UP todo !!
- *				int nogoodpower = 1;
- *				while(nogoodpower) {
- *					check_power1() or check_power2()
- *					nogoodpower = 0;
- *				} 
- *				HWIF(drive)->multiproc(drive);
- */
-				return ioctl_by_bdev(bdev, BLKRRPART, 0);
-			}
+
 			return 0;
 		}
 
@@ -2029,16 +2018,6 @@
 #endif
 }
 
-/*
- *	Actually unregister the subdriver. Called with the
- *	request lock dropped.
- */
- 
-static int default_cleanup (ide_drive_t *drive)
-{
-	return ide_unregister_subdriver(drive);
-}
-
 static ide_startstop_t default_do_request (ide_drive_t *drive, struct
request *rq, sector_t block)
 {
 	ide_end_request(drive, 0, 0);
@@ -2074,14 +2053,6 @@
 	return ide_stopped;
 }
 
-static int default_attach (ide_drive_t *drive)
-{
-	printk(KERN_ERR "%s: does not support hotswap of device class !\n",
-		drive->name);
-
-	return 0;
-}
-
 static ide_startstop_t default_abort(ide_drive_t *drive, struct request *rq)
 {
 	return __ide_abort(drive, rq);
@@ -2096,7 +2067,8 @@
 
 static void setup_driver_defaults (ide_driver_t *d)
 {
-	if (d->cleanup == NULL)		d->cleanup = default_cleanup;
+	BUG_ON(d->attach == NULL || d->cleanup == NULL);
+
 	if (d->do_request == NULL)	d->do_request = default_do_request;
 	if (d->end_request == NULL)	d->end_request = default_end_request;
 	if (d->error == NULL)		d->error = default_error;
@@ -2104,7 +2076,6 @@
 	if (d->pre_reset == NULL)	d->pre_reset = default_pre_reset;
 	if (d->capacity == NULL)	d->capacity = default_capacity;
 	if (d->special == NULL)		d->special = default_special;
-	if (d->attach == NULL)		d->attach = default_attach;
 	if (d->start_power_step == NULL)
 		d->start_power_step = default_start_power_step;
 }
@@ -2133,7 +2104,6 @@
 		drive->dsc_overlap = (drive->next != drive && driver->supports_dsc_overlap);
 		drive->nice1 = 1;
 	}
-	drive->suspend_reset = 0;
 #ifdef CONFIG_PROC_FS
 	if (drive->driver != &idedefault_driver) {
 		ide_add_proc_entries(drive->proc, generic_subdriver_entries, drive);
diff -Nru a/drivers/ide/pci/atiixp.c b/drivers/ide/pci/atiixp.c
--- a/drivers/ide/pci/atiixp.c	2005-01-15 03:42:09 +01:00
+++ b/drivers/ide/pci/atiixp.c	2005-01-15 03:42:09 +01:00
@@ -345,8 +345,9 @@
 }
 
 static struct pci_device_id atiixp_pci_tbl[] = {
-	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_IXP_IDE, PCI_ANY_ID,
PCI_ANY_ID, 0, 0, 0},
-	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_IXP2_IDE, PCI_ANY_ID,
PCI_ANY_ID, 0, 0, 0},
+	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_IXP200_IDE, PCI_ANY_ID,
PCI_ANY_ID, 0, 0, 0},
+	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_IXP300_IDE, PCI_ANY_ID,
PCI_ANY_ID, 0, 0, 0},
+	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_IXP400_IDE, PCI_ANY_ID,
PCI_ANY_ID, 0, 0, 0},
 	{ 0, },
 };
 MODULE_DEVICE_TABLE(pci, atiixp_pci_tbl);
diff -Nru a/drivers/ide/pci/piix.c b/drivers/ide/pci/piix.c
--- a/drivers/ide/pci/piix.c	2005-01-15 03:42:09 +01:00
+++ b/drivers/ide/pci/piix.c	2005-01-15 03:42:09 +01:00
@@ -129,6 +129,7 @@
 		case PCI_DEVICE_ID_INTEL_82801CA_10:
 		case PCI_DEVICE_ID_INTEL_82801CA_11:
 		case PCI_DEVICE_ID_INTEL_82801E_11:
+		case PCI_DEVICE_ID_INTEL_82801DB_1:
 		case PCI_DEVICE_ID_INTEL_82801DB_10:
 		case PCI_DEVICE_ID_INTEL_82801DB_11:
 		case PCI_DEVICE_ID_INTEL_82801EB_11:
@@ -440,6 +441,7 @@
 		case PCI_DEVICE_ID_INTEL_82801BA_9:
 		case PCI_DEVICE_ID_INTEL_82801CA_10:
 		case PCI_DEVICE_ID_INTEL_82801CA_11:
+		case PCI_DEVICE_ID_INTEL_82801DB_1:
 		case PCI_DEVICE_ID_INTEL_82801DB_10:
 		case PCI_DEVICE_ID_INTEL_82801DB_11:
 		case PCI_DEVICE_ID_INTEL_82801EB_11:
@@ -614,6 +616,7 @@
 	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ESB_2, PCI_ANY_ID,
PCI_ANY_ID, 0, 0, 19},
 	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICH6_19, PCI_ANY_ID,
PCI_ANY_ID, 0, 0, 20},
 	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICH7_21, PCI_ANY_ID,
PCI_ANY_ID, 0, 0, 21},
+	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801DB_1, PCI_ANY_ID,
PCI_ANY_ID, 0, 0, 22},
 	{ 0, },
 };
 MODULE_DEVICE_TABLE(pci, piix_pci_tbl);
diff -Nru a/drivers/ide/pci/piix.h b/drivers/ide/pci/piix.h
--- a/drivers/ide/pci/piix.h	2005-01-15 03:42:09 +01:00
+++ b/drivers/ide/pci/piix.h	2005-01-15 03:42:09 +01:00
@@ -59,6 +59,7 @@
 	/* 19 */ DECLARE_PIIX_DEV("ICH5"),
 	/* 20 */ DECLARE_PIIX_DEV("ICH6"),
 	/* 21 */ DECLARE_PIIX_DEV("ICH7"),
+	/* 22 */ DECLARE_PIIX_DEV("ICH4"),
 };
 
 #endif /* PIIX_H */
diff -Nru a/drivers/pci/pci.ids b/drivers/pci/pci.ids
--- a/drivers/pci/pci.ids	2005-01-15 03:42:09 +01:00
+++ b/drivers/pci/pci.ids	2005-01-15 03:42:09 +01:00
@@ -8088,6 +8088,7 @@
 	24c0  82801DB/DBL (ICH4/ICH4-L) LPC Bridge
 		1014 0267  NetVista A30p
 		1462 5800  845PE Max (MS-6580)
+	24c1  82801DBL (ICH4-L) IDE Controller
 	24c2  82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #1
 		1014 0267  NetVista A30p
 		1071 8160  MIM2000
diff -Nru a/include/linux/ide.h b/include/linux/ide.h
--- a/include/linux/ide.h	2005-01-15 03:42:09 +01:00
+++ b/include/linux/ide.h	2005-01-15 03:42:09 +01:00
@@ -723,7 +723,6 @@
 	unsigned scsi		: 1;	/* 0=default, 1=ide-scsi emulation */
 
         u8	quirk_list;	/* considered quirky, set for a specific host */
-        u8	suspend_reset;	/* drive suspend mode flag, soft-reset recovers */
         u8	init_speed;	/* transfer rate set at boot */
         u8	pio_speed;      /* unused by core, used by some drivers
for fallback from DMA */
         u8	current_speed;	/* current transfer rate set */
@@ -1250,8 +1249,6 @@
  */
 extern void ide_end_drive_cmd(ide_drive_t *, u8, u8);
 
-extern void try_to_flush_leftover_data(ide_drive_t *);
-
 /*
  * Issue ATA command and wait for completion.
  * Use for implementing commands in kernel
@@ -1444,12 +1441,12 @@
 int ide_use_dma(ide_drive_t *);
 int __ide_dma_off(ide_drive_t *);
 void ide_dma_verbose(ide_drive_t *);
+ide_startstop_t ide_dma_intr(ide_drive_t *);
 
 #ifdef CONFIG_BLK_DEV_IDEDMA_PCI
 extern int ide_build_sglist(ide_drive_t *, struct request *);
 extern int ide_build_dmatable(ide_drive_t *, struct request *);
 extern void ide_destroy_dmatable(ide_drive_t *);
-extern ide_startstop_t ide_dma_intr(ide_drive_t *);
 extern int ide_release_dma(ide_hwif_t *);
 extern void ide_setup_dma(ide_hwif_t *, unsigned long, unsigned int);
 
diff -Nru a/include/linux/pci_ids.h b/include/linux/pci_ids.h
--- a/include/linux/pci_ids.h	2005-01-15 03:42:09 +01:00
+++ b/include/linux/pci_ids.h	2005-01-15 03:42:09 +01:00
@@ -353,8 +353,9 @@
 #define PCI_DEVICE_ID_ATI_RS300_166	0x5832
 #define PCI_DEVICE_ID_ATI_RS300_200	0x5833
 /* ATI IXP Chipset */
-#define PCI_DEVICE_ID_ATI_IXP_IDE	0x4349
-#define PCI_DEVICE_ID_ATI_IXP2_IDE	0x4369	/* True name not yet sure */
+#define PCI_DEVICE_ID_ATI_IXP200_IDE	0x4349
+#define PCI_DEVICE_ID_ATI_IXP300_IDE	0x4369
+#define PCI_DEVICE_ID_ATI_IXP400_IDE	0x4376
 
 #define PCI_VENDOR_ID_VLSI		0x1004
 #define PCI_DEVICE_ID_VLSI_82C592	0x0005
@@ -2178,6 +2179,7 @@
 #define PCI_DEVICE_ID_INTEL_82801CA_11	0x248b
 #define PCI_DEVICE_ID_INTEL_82801CA_12	0x248c
 #define PCI_DEVICE_ID_INTEL_82801DB_0	0x24c0
+#define PCI_DEVICE_ID_INTEL_82801DB_1	0x24c1
 #define PCI_DEVICE_ID_INTEL_82801DB_2	0x24c2
 #define PCI_DEVICE_ID_INTEL_82801DB_3	0x24c3
 #define PCI_DEVICE_ID_INTEL_82801DB_4	0x24c4

------=_Part_20_13303600.1105789217248
Content-Type: text/x-patch; name="ide.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="ide.patch"

diff -Nru a/drivers/ide/arm/icside.c b/drivers/ide/arm/icside.c
--- a/drivers/ide/arm/icside.c=092005-01-15 03:42:09 +01:00
+++ b/drivers/ide/arm/icside.c=092005-01-15 03:42:09 +01:00
@@ -397,35 +397,6 @@
 =09enable_dma(hwif->hw.dma);
 }
=20
-/*
- * dma_intr() is the handler for disk read/write DMA interrupts
- */
-static ide_startstop_t icside_dmaintr(ide_drive_t *drive)
-{
-=09unsigned int stat;
-=09int dma_stat;
-
-=09dma_stat =3D icside_dma_end(drive);
-=09stat =3D HWIF(drive)->INB(IDE_STATUS_REG);
-=09if (OK_STAT(stat, DRIVE_READY, drive->bad_wstat | DRQ_STAT)) {
-=09=09if (!dma_stat) {
-=09=09=09struct request *rq =3D HWGROUP(drive)->rq;
-=09=09=09int i;
-
-=09=09=09for (i =3D rq->nr_sectors; i > 0; ) {
-=09=09=09=09i -=3D rq->current_nr_sectors;
-=09=09=09=09DRIVER(drive)->end_request(drive, 1, rq->nr_sectors);
-=09=09=09}
-
-=09=09=09return ide_stopped;
-=09=09}
-=09=09printk(KERN_ERR "%s: bad DMA status (dma_stat=3D%x)\n",
-=09=09       drive->name, dma_stat);
-=09}
-
-=09return ide_error(drive, __FUNCTION__, stat);
-}
-
 static int icside_dma_setup(ide_drive_t *drive)
 {
 =09ide_hwif_t *hwif =3D HWIF(drive);
@@ -474,7 +445,7 @@
 static void icside_dma_exec_cmd(ide_drive_t *drive, u8 cmd)
 {
 =09/* issue cmd to drive */
-=09ide_execute_command(drive, cmd, icside_dmaintr, 2*WAIT_CMD, NULL);
+=09ide_execute_command(drive, cmd, ide_dma_intr, 2 * WAIT_CMD, NULL);
 }
=20
 static int icside_dma_test_irq(ide_drive_t *drive)
diff -Nru a/drivers/ide/cris/ide-v10.c b/drivers/ide/cris/ide-v10.c
--- a/drivers/ide/cris/ide-v10.c=092005-01-15 03:42:09 +01:00
+++ b/drivers/ide/cris/ide-v10.c=092005-01-15 03:42:09 +01:00
@@ -753,27 +753,10 @@
  */
 static ide_startstop_t etrax_dma_intr (ide_drive_t *drive)
 {
-=09int i, dma_stat;
-=09byte stat;
-
 =09LED_DISK_READ(0);
 =09LED_DISK_WRITE(0);
=20
-=09dma_stat =3D HWIF(drive)->ide_dma_end(drive);
-=09stat =3D HWIF(drive)->INB(IDE_STATUS_REG);=09=09/* get drive status */
-=09if (OK_STAT(stat,DRIVE_READY,drive->bad_wstat|DRQ_STAT)) {
-=09=09if (!dma_stat) {
-=09=09=09struct request *rq;
-=09=09=09rq =3D HWGROUP(drive)->rq;
-=09=09=09for (i =3D rq->nr_sectors; i > 0;) {
-=09=09=09=09i -=3D rq->current_nr_sectors;
-=09=09=09=09DRIVER(drive)->end_request(drive, 1, rq->nr_sectors);
-=09=09=09}
-=09=09=09return ide_stopped;
-=09=09}
-=09=09printk("%s: bad DMA status\n", drive->name);
-=09}
-=09return ide_error(drive, "dma_intr", stat);
+=09return ide_dma_intr(drive);
 }
=20
 /*
diff -Nru a/drivers/ide/ide-cd.c b/drivers/ide/ide-cd.c
--- a/drivers/ide/ide-cd.c=092005-01-15 03:42:09 +01:00
+++ b/drivers/ide/ide-cd.c=092005-01-15 03:42:09 +01:00
@@ -1464,19 +1464,6 @@
 }
=20
=20
-/* Sleep for TIME jiffies.
-   Not to be called from an interrupt handler. */
-static
-void cdrom_sleep (int time)
-{
-=09int sleep =3D time;
-
-=09do {
-=09=09set_current_state(TASK_INTERRUPTIBLE);
-=09=09sleep =3D schedule_timeout(sleep);
-=09} while (sleep);
-}
-
 static
 int cdrom_queue_packet_command(ide_drive_t *drive, struct request *rq)
 {
@@ -1511,7 +1498,7 @@
 =09=09=09=09/* The drive is in the process of loading
 =09=09=09=09   a disk.  Retry, but wait a little to give
 =09=09=09=09   the drive time to complete the load. */
-=09=09=09=09cdrom_sleep(2 * HZ);
+=09=09=09=09ssleep(2);
 =09=09=09} else {
 =09=09=09=09/* Otherwise, don't retry. */
 =09=09=09=09retries =3D 0;
diff -Nru a/drivers/ide/ide-default.c b/drivers/ide/ide-default.c
--- a/drivers/ide/ide-default.c=092005-01-15 03:42:09 +01:00
+++ b/drivers/ide/ide-default.c=092005-01-15 03:42:09 +01:00
@@ -46,6 +46,7 @@
 =09.name=09=09=3D=09"ide-default",
 =09.version=09=3D=09IDEDEFAULT_VERSION,
 =09.attach=09=09=3D=09idedefault_attach,
+=09.cleanup=09=3D=09ide_unregister_subdriver,
 =09.drives=09=09=3D=09LIST_HEAD_INIT(idedefault_driver.drives)
 };
=20
diff -Nru a/drivers/ide/ide-dma.c b/drivers/ide/ide-dma.c
--- a/drivers/ide/ide-dma.c=092005-01-15 03:42:09 +01:00
+++ b/drivers/ide/ide-dma.c=092005-01-15 03:42:09 +01:00
@@ -158,7 +158,6 @@
 =09return 0;
 }
=20
-#ifdef CONFIG_BLK_DEV_IDEDMA_PCI
 /**
  *=09ide_dma_intr=09-=09IDE DMA interrupt handler
  *=09@drive: the drive the interrupt is for
@@ -188,6 +187,7 @@
=20
 EXPORT_SYMBOL_GPL(ide_dma_intr);
=20
+#ifdef CONFIG_BLK_DEV_IDEDMA_PCI
 /**
  *=09ide_build_sglist=09-=09map IDE scatter gather for DMA I/O
  *=09@drive: the drive to build the DMA table for
diff -Nru a/drivers/ide/ide-io.c b/drivers/ide/ide-io.c
--- a/drivers/ide/ide-io.c=092005-01-15 03:42:09 +01:00
+++ b/drivers/ide/ide-io.c=092005-01-15 03:42:09 +01:00
@@ -437,7 +437,7 @@
  *=09by read a sector's worth of data from the drive.  Of course,
  *=09this may not help if the drive is *waiting* for data from *us*.
  */
-void try_to_flush_leftover_data (ide_drive_t *drive)
+static void try_to_flush_leftover_data (ide_drive_t *drive)
 {
 =09int i =3D (drive->mult_count ? drive->mult_count : 1) * SECTOR_WORDS;
=20
@@ -452,8 +452,6 @@
 =09}
 }
=20
-EXPORT_SYMBOL(try_to_flush_leftover_data);
-
 static ide_startstop_t ide_ata_error(ide_drive_t *drive, struct request *r=
q, u8 stat, u8 err)
 {
 =09ide_hwif_t *hwif =3D drive->hwif;
@@ -853,13 +851,6 @@
 =09if (drive->max_failures && (drive->failures > drive->max_failures)) {
 =09=09goto kill_rq;
 =09}
-
-=09/*
-=09 * bail early if we've sent a device to sleep, however how to wake
-=09 * this needs to be a masked flag.  FIXME for proper operations.
-=09 */
-=09if (drive->suspend_reset)
-=09=09goto kill_rq;
=20
 =09block    =3D rq->sector;
 =09if (blk_fs_request(rq) &&
diff -Nru a/drivers/ide/ide-lib.c b/drivers/ide/ide-lib.c
--- a/drivers/ide/ide-lib.c=092005-01-15 03:42:09 +01:00
+++ b/drivers/ide/ide-lib.c=092005-01-15 03:42:09 +01:00
@@ -571,8 +571,7 @@
=20
 =09status.all =3D stat;
 =09local_irq_set(flags);
-=09printk("%s: %s: status=3D0x%02x", drive->name, msg, stat);
-=09printk(" { ");
+=09printk("%s: %s: status=3D0x%02x { ", drive->name, msg, stat);
 =09if (status.b.bsy)
 =09=09printk("Busy ");
 =09else {
@@ -584,18 +583,17 @@
 =09=09if (status.b.idx)=09printk("Index ");
 =09=09if (status.b.check)=09printk("Error ");
 =09}
-=09printk("}");
-=09printk("\n");
+=09printk("}\n");
 =09if ((status.all & (status.b.bsy|status.b.check)) =3D=3D status.b.check)=
 {
 =09=09error.all =3D HWIF(drive)->INB(IDE_ERROR_REG);
-=09=09printk("%s: %s: error=3D0x%02x", drive->name, msg, error.all);
+=09=09printk("%s: %s: error=3D0x%02x { ", drive->name, msg, error.all);
 =09=09if (error.b.ili)=09printk("IllegalLengthIndication ");
 =09=09if (error.b.eom)=09printk("EndOfMedia ");
-=09=09if (error.b.abrt)=09printk("Aborted Command ");
+=09=09if (error.b.abrt)=09printk("AbortedCommand ");
 =09=09if (error.b.mcr)=09printk("MediaChangeRequested ");
-=09=09if (error.b.sense_key)=09printk("LastFailedSense 0x%02x ",
+=09=09if (error.b.sense_key)=09printk("LastFailedSense=3D0x%02x ",
 =09=09=09=09=09=09error.b.sense_key);
-=09=09printk("\n");
+=09=09printk("}\n");
 =09}
 =09ide_dump_opcode(drive);
 =09local_irq_restore(flags);
diff -Nru a/drivers/ide/ide-probe.c b/drivers/ide/ide-probe.c
--- a/drivers/ide/ide-probe.c=092005-01-15 03:42:09 +01:00
+++ b/drivers/ide/ide-probe.c=092005-01-15 03:42:09 +01:00
@@ -749,7 +749,7 @@
 =09 * =20
 =09 *  BenH.
 =09 */
-=09if (wait_hwif_ready(hwif))
+=09if (wait_hwif_ready(hwif) =3D=3D -EBUSY)
 =09=09printk(KERN_DEBUG "%s: Wait for ready failed before probe !\n", hwif=
->name);
=20
 =09/*
diff -Nru a/drivers/ide/ide.c b/drivers/ide/ide.c
--- a/drivers/ide/ide.c=092005-01-15 03:42:09 +01:00
+++ b/drivers/ide/ide.c=092005-01-15 03:42:09 +01:00
@@ -1554,18 +1554,7 @@
 =09=09=09HWGROUP(drive)->busy =3D 1;
 =09=09=09spin_unlock_irqrestore(&ide_lock, flags);
 =09=09=09(void) ide_do_reset(drive);
-=09=09=09if (drive->suspend_reset) {
-/*
- *=09=09=09=09APM WAKE UP todo !!
- *=09=09=09=09int nogoodpower =3D 1;
- *=09=09=09=09while(nogoodpower) {
- *=09=09=09=09=09check_power1() or check_power2()
- *=09=09=09=09=09nogoodpower =3D 0;
- *=09=09=09=09}=20
- *=09=09=09=09HWIF(drive)->multiproc(drive);
- */
-=09=09=09=09return ioctl_by_bdev(bdev, BLKRRPART, 0);
-=09=09=09}
+
 =09=09=09return 0;
 =09=09}
=20
@@ -2029,16 +2018,6 @@
 #endif
 }
=20
-/*
- *=09Actually unregister the subdriver. Called with the
- *=09request lock dropped.
- */
-=20
-static int default_cleanup (ide_drive_t *drive)
-{
-=09return ide_unregister_subdriver(drive);
-}
-
 static ide_startstop_t default_do_request (ide_drive_t *drive, struct requ=
est *rq, sector_t block)
 {
 =09ide_end_request(drive, 0, 0);
@@ -2074,14 +2053,6 @@
 =09return ide_stopped;
 }
=20
-static int default_attach (ide_drive_t *drive)
-{
-=09printk(KERN_ERR "%s: does not support hotswap of device class !\n",
-=09=09drive->name);
-
-=09return 0;
-}
-
 static ide_startstop_t default_abort(ide_drive_t *drive, struct request *r=
q)
 {
 =09return __ide_abort(drive, rq);
@@ -2096,7 +2067,8 @@
=20
 static void setup_driver_defaults (ide_driver_t *d)
 {
-=09if (d->cleanup =3D=3D NULL)=09=09d->cleanup =3D default_cleanup;
+=09BUG_ON(d->attach =3D=3D NULL || d->cleanup =3D=3D NULL);
+
 =09if (d->do_request =3D=3D NULL)=09d->do_request =3D default_do_request;
 =09if (d->end_request =3D=3D NULL)=09d->end_request =3D default_end_reques=
t;
 =09if (d->error =3D=3D NULL)=09=09d->error =3D default_error;
@@ -2104,7 +2076,6 @@
 =09if (d->pre_reset =3D=3D NULL)=09d->pre_reset =3D default_pre_reset;
 =09if (d->capacity =3D=3D NULL)=09d->capacity =3D default_capacity;
 =09if (d->special =3D=3D NULL)=09=09d->special =3D default_special;
-=09if (d->attach =3D=3D NULL)=09=09d->attach =3D default_attach;
 =09if (d->start_power_step =3D=3D NULL)
 =09=09d->start_power_step =3D default_start_power_step;
 }
@@ -2133,7 +2104,6 @@
 =09=09drive->dsc_overlap =3D (drive->next !=3D drive && driver->supports_d=
sc_overlap);
 =09=09drive->nice1 =3D 1;
 =09}
-=09drive->suspend_reset =3D 0;
 #ifdef CONFIG_PROC_FS
 =09if (drive->driver !=3D &idedefault_driver) {
 =09=09ide_add_proc_entries(drive->proc, generic_subdriver_entries, drive);
diff -Nru a/drivers/ide/pci/atiixp.c b/drivers/ide/pci/atiixp.c
--- a/drivers/ide/pci/atiixp.c=092005-01-15 03:42:09 +01:00
+++ b/drivers/ide/pci/atiixp.c=092005-01-15 03:42:09 +01:00
@@ -345,8 +345,9 @@
 }
=20
 static struct pci_device_id atiixp_pci_tbl[] =3D {
-=09{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_IXP_IDE, PCI_ANY_ID, PCI_ANY_ID,=
 0, 0, 0},
-=09{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_IXP2_IDE, PCI_ANY_ID, PCI_ANY_ID=
, 0, 0, 0},
+=09{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_IXP200_IDE, PCI_ANY_ID, PCI_ANY_=
ID, 0, 0, 0},
+=09{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_IXP300_IDE, PCI_ANY_ID, PCI_ANY_=
ID, 0, 0, 0},
+=09{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_IXP400_IDE, PCI_ANY_ID, PCI_ANY_=
ID, 0, 0, 0},
 =09{ 0, },
 };
 MODULE_DEVICE_TABLE(pci, atiixp_pci_tbl);
diff -Nru a/drivers/ide/pci/piix.c b/drivers/ide/pci/piix.c
--- a/drivers/ide/pci/piix.c=092005-01-15 03:42:09 +01:00
+++ b/drivers/ide/pci/piix.c=092005-01-15 03:42:09 +01:00
@@ -129,6 +129,7 @@
 =09=09case PCI_DEVICE_ID_INTEL_82801CA_10:
 =09=09case PCI_DEVICE_ID_INTEL_82801CA_11:
 =09=09case PCI_DEVICE_ID_INTEL_82801E_11:
+=09=09case PCI_DEVICE_ID_INTEL_82801DB_1:
 =09=09case PCI_DEVICE_ID_INTEL_82801DB_10:
 =09=09case PCI_DEVICE_ID_INTEL_82801DB_11:
 =09=09case PCI_DEVICE_ID_INTEL_82801EB_11:
@@ -440,6 +441,7 @@
 =09=09case PCI_DEVICE_ID_INTEL_82801BA_9:
 =09=09case PCI_DEVICE_ID_INTEL_82801CA_10:
 =09=09case PCI_DEVICE_ID_INTEL_82801CA_11:
+=09=09case PCI_DEVICE_ID_INTEL_82801DB_1:
 =09=09case PCI_DEVICE_ID_INTEL_82801DB_10:
 =09=09case PCI_DEVICE_ID_INTEL_82801DB_11:
 =09=09case PCI_DEVICE_ID_INTEL_82801EB_11:
@@ -614,6 +616,7 @@
 =09{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ESB_2, PCI_ANY_ID, PCI_ANY_I=
D, 0, 0, 19},
 =09{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICH6_19, PCI_ANY_ID, PCI_ANY=
_ID, 0, 0, 20},
 =09{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICH7_21, PCI_ANY_ID, PCI_ANY=
_ID, 0, 0, 21},
+=09{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801DB_1, PCI_ANY_ID, PCI_A=
NY_ID, 0, 0, 22},
 =09{ 0, },
 };
 MODULE_DEVICE_TABLE(pci, piix_pci_tbl);
diff -Nru a/drivers/ide/pci/piix.h b/drivers/ide/pci/piix.h
--- a/drivers/ide/pci/piix.h=092005-01-15 03:42:09 +01:00
+++ b/drivers/ide/pci/piix.h=092005-01-15 03:42:09 +01:00
@@ -59,6 +59,7 @@
 =09/* 19 */ DECLARE_PIIX_DEV("ICH5"),
 =09/* 20 */ DECLARE_PIIX_DEV("ICH6"),
 =09/* 21 */ DECLARE_PIIX_DEV("ICH7"),
+=09/* 22 */ DECLARE_PIIX_DEV("ICH4"),
 };
=20
 #endif /* PIIX_H */
diff -Nru a/drivers/pci/pci.ids b/drivers/pci/pci.ids
--- a/drivers/pci/pci.ids=092005-01-15 03:42:09 +01:00
+++ b/drivers/pci/pci.ids=092005-01-15 03:42:09 +01:00
@@ -8088,6 +8088,7 @@
 =0924c0  82801DB/DBL (ICH4/ICH4-L) LPC Bridge
 =09=091014 0267  NetVista A30p
 =09=091462 5800  845PE Max (MS-6580)
+=0924c1  82801DBL (ICH4-L) IDE Controller
 =0924c2  82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #1
 =09=091014 0267  NetVista A30p
 =09=091071 8160  MIM2000
diff -Nru a/include/linux/ide.h b/include/linux/ide.h
--- a/include/linux/ide.h=092005-01-15 03:42:09 +01:00
+++ b/include/linux/ide.h=092005-01-15 03:42:09 +01:00
@@ -723,7 +723,6 @@
 =09unsigned scsi=09=09: 1;=09/* 0=3Ddefault, 1=3Dide-scsi emulation */
=20
         u8=09quirk_list;=09/* considered quirky, set for a specific host *=
/
-        u8=09suspend_reset;=09/* drive suspend mode flag, soft-reset recov=
ers */
         u8=09init_speed;=09/* transfer rate set at boot */
         u8=09pio_speed;      /* unused by core, used by some drivers for f=
allback from DMA */
         u8=09current_speed;=09/* current transfer rate set */
@@ -1250,8 +1249,6 @@
  */
 extern void ide_end_drive_cmd(ide_drive_t *, u8, u8);
=20
-extern void try_to_flush_leftover_data(ide_drive_t *);
-
 /*
  * Issue ATA command and wait for completion.
  * Use for implementing commands in kernel
@@ -1444,12 +1441,12 @@
 int ide_use_dma(ide_drive_t *);
 int __ide_dma_off(ide_drive_t *);
 void ide_dma_verbose(ide_drive_t *);
+ide_startstop_t ide_dma_intr(ide_drive_t *);
=20
 #ifdef CONFIG_BLK_DEV_IDEDMA_PCI
 extern int ide_build_sglist(ide_drive_t *, struct request *);
 extern int ide_build_dmatable(ide_drive_t *, struct request *);
 extern void ide_destroy_dmatable(ide_drive_t *);
-extern ide_startstop_t ide_dma_intr(ide_drive_t *);
 extern int ide_release_dma(ide_hwif_t *);
 extern void ide_setup_dma(ide_hwif_t *, unsigned long, unsigned int);
=20
diff -Nru a/include/linux/pci_ids.h b/include/linux/pci_ids.h
--- a/include/linux/pci_ids.h=092005-01-15 03:42:09 +01:00
+++ b/include/linux/pci_ids.h=092005-01-15 03:42:09 +01:00
@@ -353,8 +353,9 @@
 #define PCI_DEVICE_ID_ATI_RS300_166=090x5832
 #define PCI_DEVICE_ID_ATI_RS300_200=090x5833
 /* ATI IXP Chipset */
-#define PCI_DEVICE_ID_ATI_IXP_IDE=090x4349
-#define PCI_DEVICE_ID_ATI_IXP2_IDE=090x4369=09/* True name not yet sure */
+#define PCI_DEVICE_ID_ATI_IXP200_IDE=090x4349
+#define PCI_DEVICE_ID_ATI_IXP300_IDE=090x4369
+#define PCI_DEVICE_ID_ATI_IXP400_IDE=090x4376
=20
 #define PCI_VENDOR_ID_VLSI=09=090x1004
 #define PCI_DEVICE_ID_VLSI_82C592=090x0005
@@ -2178,6 +2179,7 @@
 #define PCI_DEVICE_ID_INTEL_82801CA_11=090x248b
 #define PCI_DEVICE_ID_INTEL_82801CA_12=090x248c
 #define PCI_DEVICE_ID_INTEL_82801DB_0=090x24c0
+#define PCI_DEVICE_ID_INTEL_82801DB_1=090x24c1
 #define PCI_DEVICE_ID_INTEL_82801DB_2=090x24c2
 #define PCI_DEVICE_ID_INTEL_82801DB_3=090x24c3
 #define PCI_DEVICE_ID_INTEL_82801DB_4=090x24c4

------=_Part_20_13303600.1105789217248--
