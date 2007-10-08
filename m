From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 5/12] ide: remove task_ioreg_t typedef
Date: Mon, 8 Oct 2007 23:10:04 +0200
Message-ID: <200710082310.04079.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.191]:59004 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753290AbXJHVjy (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 8 Oct 2007 17:39:54 -0400
Received: by nf-out-0910.google.com with SMTP id g13so1370186nfb
        for <linux-ide@vger.kernel.org>; Mon, 08 Oct 2007 14:39:53 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


Remove task_ioreg_t typedef from the kernel code (but leave it
in <linux/hdreg.h> for #ifndef/#endif __KERNEL__ case).

While at it also move sata_ioreg_t typedef under #ifndef/#endif __KERNEL__.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-disk.c     |   20 +++++++++----------
 drivers/ide/ide-iops.c     |    5 ++--
 drivers/ide/ide-taskfile.c |    4 +--
 include/linux/hdreg.h      |   46 ++++++++++++++++++++++-----------------------
 include/linux/ide.h        |    7 +++---
 5 files changed, 42 insertions(+), 40 deletions(-)

Index: b/drivers/ide/ide-disk.c
===================================================================
--- a/drivers/ide/ide-disk.c
+++ b/drivers/ide/ide-disk.c
@@ -164,7 +164,7 @@ static ide_startstop_t __ide_do_rw_disk(
 	ide_hwif_t *hwif	= HWIF(drive);
 	unsigned int dma	= drive->using_dma;
 	u8 lba48		= (drive->addressing == 1) ? 1 : 0;
-	task_ioreg_t command	= WIN_NOP;
+	u8 command		= WIN_NOP;
 	ata_nsector_t		nsectors;
 
 	nsectors.all		= (u16) rq->nr_sectors;
@@ -188,7 +188,7 @@ static ide_startstop_t __ide_do_rw_disk(
 
 	if (drive->select.b.lba) {
 		if (lba48) {
-			task_ioreg_t tasklets[10];
+			u8 tasklets[10];
 
 			pr_debug("%s: LBA=0x%012llx\n", drive->name,
 					(unsigned long long)block);
@@ -197,16 +197,16 @@ static ide_startstop_t __ide_do_rw_disk(
 			tasklets[1] = 0;
 			tasklets[2] = nsectors.b.low;
 			tasklets[3] = nsectors.b.high;
-			tasklets[4] = (task_ioreg_t) block;
-			tasklets[5] = (task_ioreg_t) (block>>8);
-			tasklets[6] = (task_ioreg_t) (block>>16);
-			tasklets[7] = (task_ioreg_t) (block>>24);
+			tasklets[4] = (u8) block;
+			tasklets[5] = (u8)(block >>  8);
+			tasklets[6] = (u8)(block >> 16);
+			tasklets[7] = (u8)(block >> 24);
 			if (sizeof(block) == 4) {
-				tasklets[8] = (task_ioreg_t) 0;
-				tasklets[9] = (task_ioreg_t) 0;
+				tasklets[8] = 0;
+				tasklets[9] = 0;
 			} else {
-				tasklets[8] = (task_ioreg_t)((u64)block >> 32);
-				tasklets[9] = (task_ioreg_t)((u64)block >> 40);
+				tasklets[8] = (u8)((u64)block >> 32);
+				tasklets[9] = (u8)((u64)block >> 40);
 			}
 #ifdef DEBUG
 			printk("%s: 0x%02x%02x 0x%02x%02x%02x%02x%02x%02x\n",
Index: b/drivers/ide/ide-iops.c
===================================================================
--- a/drivers/ide/ide-iops.c
+++ b/drivers/ide/ide-iops.c
@@ -887,8 +887,9 @@ EXPORT_SYMBOL(ide_set_handler);
  *	handler and IRQ setup do not race. All IDE command kick off
  *	should go via this function or do equivalent locking.
  */
- 
-void ide_execute_command(ide_drive_t *drive, task_ioreg_t cmd, ide_handler_t *handler, unsigned timeout, ide_expiry_t *expiry)
+
+void ide_execute_command(ide_drive_t *drive, u8 cmd, ide_handler_t *handler,
+			 unsigned timeout, ide_expiry_t *expiry)
 {
 	unsigned long flags;
 	ide_hwgroup_t *hwgroup = HWGROUP(drive);
Index: b/drivers/ide/ide-taskfile.c
===================================================================
--- a/drivers/ide/ide-taskfile.c
+++ b/drivers/ide/ide-taskfile.c
@@ -507,8 +507,8 @@ int ide_taskfile_ioctl (ide_drive_t *dri
 	ide_task_t		args;
 	u8 *outbuf		= NULL;
 	u8 *inbuf		= NULL;
-	task_ioreg_t *argsptr	= args.tfRegister;
-	task_ioreg_t *hobsptr	= args.hobRegister;
+	u8 *argsptr		= args.tfRegister;
+	u8 *hobsptr		= args.hobRegister;
 	int err			= 0;
 	int tasksize		= sizeof(struct ide_task_request_s);
 	unsigned int taskin	= 0;
Index: b/include/linux/hdreg.h
===================================================================
--- a/include/linux/hdreg.h
+++ b/include/linux/hdreg.h
@@ -87,10 +87,10 @@
 #ifndef __KERNEL__
 #define IDE_TASKFILE_STD_OUT_FLAGS	0xFE
 #define IDE_HOB_STD_OUT_FLAGS		0x3C
-#endif
 
 typedef unsigned char task_ioreg_t;
 typedef unsigned long sata_ioreg_t;
+#endif
 
 typedef union ide_reg_valid_s {
 	unsigned all				: 16;
@@ -116,8 +116,8 @@ typedef union ide_reg_valid_s {
 } ide_reg_valid_t;
 
 typedef struct ide_task_request_s {
-	task_ioreg_t	io_ports[8];
-	task_ioreg_t	hob_ports[8];
+	__u8		io_ports[8];
+	__u8		hob_ports[8];
 	ide_reg_valid_t	out_flags;
 	ide_reg_valid_t	in_flags;
 	int		data_phase;
@@ -133,32 +133,32 @@ typedef struct ide_ioctl_request_s {
 } ide_ioctl_request_t;
 
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
 
 #define TASKFILE_INVALID		0x7fff
Index: b/include/linux/ide.h
===================================================================
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -1017,7 +1017,8 @@ int ide_end_dequeued_request(ide_drive_t
 
 extern void ide_set_handler (ide_drive_t *drive, ide_handler_t *handler, unsigned int timeout, ide_expiry_t *expiry);
 
-extern void ide_execute_command(ide_drive_t *, task_ioreg_t cmd, ide_handler_t *, unsigned int, ide_expiry_t *);
+void ide_execute_command(ide_drive_t *, u8 cmd, ide_handler_t *,
+			 unsigned int, ide_expiry_t *);
 
 ide_startstop_t __ide_error(ide_drive_t *, struct request *, u8, u8);
 
@@ -1078,8 +1079,8 @@ typedef struct ide_task_s {
  *	struct hd_drive_hob_hdr		hobf;
  *	hob_struct_t		hobf;
  */
-	task_ioreg_t		tfRegister[8];
-	task_ioreg_t		hobRegister[8];
+	u8			tfRegister[8];
+	u8			hobRegister[8];
 	ide_reg_valid_t		tf_out_flags;
 	ide_reg_valid_t		tf_in_flags;
 	int			data_phase;
