From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH 1/6] ide: replace IDE_TFLAG_* flags by IDE_VALID_*
Date: Thu, 2 Apr 2009 22:55:33 +0400
Message-ID: <200904022255.33862.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:12381 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753767AbZDBSzE (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 2 Apr 2009 14:55:04 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org

Replace IDE_TFLAG_{IN|OUT}_* flags meaning to the taskfile register validity on
input/output by the IDE_VALID_* flags and introduce 4 symmetric 8-bit register
validity indicator subfields, 'valid.{input/output}.{tf|hob}', into the 'struct
ide_cmd' instead of using the 'tf_flags' field for that purpose (this field can
then be turned from 32-bit into 8-bit one).

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

---
The patch is against the current Linus' tree...

 drivers/ide/ide-acpi.c      |    3 -
 drivers/ide/ide-atapi.c     |   21 ++++-----
 drivers/ide/ide-disk.c      |   40 ++++++++++++------
 drivers/ide/ide-disk_proc.c |    6 +-
 drivers/ide/ide-io-std.c    |   50 ++++++++++++-----------
 drivers/ide/ide-io.c        |    5 +-
 drivers/ide/ide-ioctls.c    |   10 ++--
 drivers/ide/ide-iops.c      |    4 -
 drivers/ide/ide-lib.c       |   11 ++---
 drivers/ide/ide-park.c      |    3 -
 drivers/ide/ide-pm.c        |    3 -
 drivers/ide/ide-probe.c     |    4 -
 drivers/ide/ide-proc.c      |    4 -
 drivers/ide/ide-taskfile.c  |   38 +++++++++--------
 drivers/ide/ns87415.c       |   25 ++++++-----
 drivers/ide/scc_pata.c      |   50 ++++++++++++-----------
 drivers/ide/tx4938ide.c     |   50 ++++++++++++-----------
 drivers/ide/tx4939ide.c     |   52 +++++++++++++-----------
 include/linux/ide.h         |   95 +++++++++++++++++---------------------------
 19 files changed, 254 insertions(+), 220 deletions(-)

Index: linux-2.6/drivers/ide/ide-acpi.c
===================================================================
--- linux-2.6.orig/drivers/ide/ide-acpi.c
+++ linux-2.6/drivers/ide/ide-acpi.c
@@ -319,7 +319,8 @@ static int do_drive_set_taskfiles(ide_dr
 		/* convert GTF to taskfile */
 		memset(&cmd, 0, sizeof(cmd));
 		memcpy(&cmd.tf_array[7], gtf, REGS_PER_GTF);
-		cmd.tf_flags = IDE_TFLAG_TF | IDE_TFLAG_DEVICE;
+		cmd.valid.out.tf = IDE_VALID_OUT_TF | IDE_VALID_DEVICE;
+		cmd.valid.in.tf  = IDE_VALID_IN_TF  | IDE_VALID_DEVICE;
 
 		err = ide_no_data_taskfile(drive, &cmd);
 		if (err) {
Index: linux-2.6/drivers/ide/ide-atapi.c
===================================================================
--- linux-2.6.orig/drivers/ide/ide-atapi.c
+++ linux-2.6/drivers/ide/ide-atapi.c
@@ -257,8 +257,7 @@ void ide_read_bcount_and_ireason(ide_dri
 	struct ide_cmd cmd;
 
 	memset(&cmd, 0, sizeof(cmd));
-	cmd.tf_flags = IDE_TFLAG_IN_LBAH | IDE_TFLAG_IN_LBAM |
-		       IDE_TFLAG_IN_NSECT;
+	cmd.valid.in.tf = IDE_VALID_LBAH | IDE_VALID_LBAM | IDE_VALID_NSECT;
 
 	drive->hwif->tp_ops->tf_read(drive, &cmd);
 
@@ -439,12 +438,12 @@ static ide_startstop_t ide_pc_intr(ide_d
 	return ide_started;
 }
 
-static void ide_init_packet_cmd(struct ide_cmd *cmd, u32 tf_flags,
+static void ide_init_packet_cmd(struct ide_cmd *cmd, u8 valid_tf,
 				u16 bcount, u8 dma)
 {
-	cmd->protocol  = dma ? ATAPI_PROT_DMA : ATAPI_PROT_PIO;
-	cmd->tf_flags |= IDE_TFLAG_OUT_LBAH | IDE_TFLAG_OUT_LBAM |
-			 IDE_TFLAG_OUT_FEATURE | tf_flags;
+	cmd->protocol = dma ? ATAPI_PROT_DMA : ATAPI_PROT_PIO;
+	cmd->valid.out.tf = IDE_VALID_LBAH | IDE_VALID_LBAM |
+			    IDE_VALID_FEATURE | valid_tf;
 	cmd->tf.command = ATA_CMD_PACKET;
 	cmd->tf.feature = dma;		/* Use PIO/DMA */
 	cmd->tf.lbam    = bcount & 0xff;
@@ -456,7 +455,7 @@ static u8 ide_read_ireason(ide_drive_t *
 	struct ide_cmd cmd;
 
 	memset(&cmd, 0, sizeof(cmd));
-	cmd.tf_flags = IDE_TFLAG_IN_NSECT;
+	cmd.valid.in.tf = IDE_VALID_NSECT;
 
 	drive->hwif->tp_ops->tf_read(drive, &cmd);
 
@@ -588,12 +587,12 @@ ide_startstop_t ide_issue_pc(ide_drive_t
 	ide_expiry_t *expiry = NULL;
 	struct request *rq = hwif->rq;
 	unsigned int timeout;
-	u32 tf_flags;
 	u16 bcount;
+	u8 valid_tf;
 	u8 drq_int = !!(drive->atapi_flags & IDE_AFLAG_DRQ_INTERRUPT);
 
 	if (dev_is_idecd(drive)) {
-		tf_flags = IDE_TFLAG_OUT_NSECT | IDE_TFLAG_OUT_LBAL;
+		valid_tf = IDE_VALID_NSECT | IDE_VALID_LBAL;
 		bcount = ide_cd_get_xferlen(rq);
 		expiry = ide_cd_expiry;
 		timeout = ATAPI_WAIT_PC;
@@ -607,7 +606,7 @@ ide_startstop_t ide_issue_pc(ide_drive_t
 		pc->xferred = 0;
 		pc->cur_pos = pc->buf;
 
-		tf_flags = IDE_TFLAG_OUT_DEVICE;
+		valid_tf = IDE_VALID_DEVICE;
 		bcount = ((drive->media == ide_tape) ?
 				pc->req_xfer :
 				min(pc->req_xfer, 63 * 1024));
@@ -627,7 +626,7 @@ ide_startstop_t ide_issue_pc(ide_drive_t
 						       : WAIT_TAPE_CMD;
 	}
 
-	ide_init_packet_cmd(cmd, tf_flags, bcount, drive->dma);
+	ide_init_packet_cmd(cmd, valid_tf, bcount, drive->dma);
 
 	(void)do_rw_taskfile(drive, cmd);
 
Index: linux-2.6/drivers/ide/ide-disk.c
===================================================================
--- linux-2.6.orig/drivers/ide/ide-disk.c
+++ linux-2.6/drivers/ide/ide-disk.c
@@ -97,7 +97,8 @@ static ide_startstop_t __ide_do_rw_disk(
 	}
 
 	memset(&cmd, 0, sizeof(cmd));
-	cmd.tf_flags = IDE_TFLAG_TF | IDE_TFLAG_DEVICE;
+	cmd.valid.out.tf = IDE_VALID_OUT_TF | IDE_VALID_DEVICE;
+	cmd.valid.in.tf  = IDE_VALID_IN_TF  | IDE_VALID_DEVICE;
 
 	if (drive->dev_flags & IDE_DFLAG_LBA) {
 		if (lba48) {
@@ -116,7 +117,9 @@ static ide_startstop_t __ide_do_rw_disk(
 			tf->lbam   = (u8)(block >>  8);
 			tf->lbah   = (u8)(block >> 16);
 
-			cmd.tf_flags |= (IDE_TFLAG_LBA48 | IDE_TFLAG_HOB);
+			cmd.valid.out.hob = IDE_VALID_OUT_HOB;
+			cmd.valid.in.hob  = IDE_VALID_IN_HOB;
+			cmd.tf_flags |= IDE_TFLAG_LBA48;
 		} else {
 			tf->nsect  = nsectors & 0xff;
 			tf->lbal   = block;
@@ -220,9 +223,13 @@ static u64 idedisk_read_native_max_addre
 		tf->command = ATA_CMD_READ_NATIVE_MAX;
 	tf->device  = ATA_LBA;
 
-	cmd.tf_flags = IDE_TFLAG_TF | IDE_TFLAG_DEVICE;
-	if (lba48)
-		cmd.tf_flags |= (IDE_TFLAG_LBA48 | IDE_TFLAG_HOB);
+	cmd.valid.out.tf = IDE_VALID_OUT_TF | IDE_VALID_DEVICE;
+	cmd.valid.in.tf  = IDE_VALID_IN_TF  | IDE_VALID_DEVICE;
+	if (lba48) {
+		cmd.valid.out.hob = IDE_VALID_OUT_HOB;
+		cmd.valid.in.hob  = IDE_VALID_IN_HOB;
+		cmd.tf_flags = IDE_TFLAG_LBA48;
+	}
 
 	ide_no_data_taskfile(drive, &cmd);
 
@@ -260,9 +267,13 @@ static u64 idedisk_set_max_address(ide_d
 	}
 	tf->device |= ATA_LBA;
 
-	cmd.tf_flags = IDE_TFLAG_TF | IDE_TFLAG_DEVICE;
-	if (lba48)
-		cmd.tf_flags |= (IDE_TFLAG_LBA48 | IDE_TFLAG_HOB);
+	cmd.valid.out.tf = IDE_VALID_OUT_TF | IDE_VALID_DEVICE;
+	cmd.valid.in.tf  = IDE_VALID_IN_TF  | IDE_VALID_DEVICE;
+	if (lba48) {
+		cmd.valid.out.hob = IDE_VALID_OUT_HOB;
+		cmd.valid.in.hob  = IDE_VALID_IN_HOB;
+		cmd.tf_flags = IDE_TFLAG_LBA48;
+	}
 
 	ide_no_data_taskfile(drive, &cmd);
 
@@ -395,8 +406,8 @@ static void idedisk_prepare_flush(struct
 		cmd->tf.command = ATA_CMD_FLUSH_EXT;
 	else
 		cmd->tf.command = ATA_CMD_FLUSH;
-	cmd->tf_flags = IDE_TFLAG_OUT_TF | IDE_TFLAG_OUT_DEVICE |
-			IDE_TFLAG_DYN;
+	cmd->valid.out.tf = IDE_VALID_OUT_TF | IDE_VALID_DEVICE;
+	cmd->tf_flags = IDE_TFLAG_DYN;
 	cmd->protocol = ATA_PROT_NODATA;
 
 	rq->cmd_type = REQ_TYPE_ATA_TASKFILE;
@@ -457,7 +468,8 @@ static int ide_do_setfeature(ide_drive_t
 	cmd.tf.feature = feature;
 	cmd.tf.nsect   = nsect;
 	cmd.tf.command = ATA_CMD_SET_FEATURES;
-	cmd.tf_flags   = IDE_TFLAG_TF | IDE_TFLAG_DEVICE;
+	cmd.valid.out.tf = IDE_VALID_OUT_TF | IDE_VALID_DEVICE;
+	cmd.valid.in.tf  = IDE_VALID_IN_TF  | IDE_VALID_DEVICE;
 
 	return ide_no_data_taskfile(drive, &cmd);
 }
@@ -533,7 +545,8 @@ static int do_idedisk_flushcache(ide_dri
 		cmd.tf.command = ATA_CMD_FLUSH_EXT;
 	else
 		cmd.tf.command = ATA_CMD_FLUSH;
-	cmd.tf_flags = IDE_TFLAG_TF | IDE_TFLAG_DEVICE;
+	cmd.valid.out.tf = IDE_VALID_OUT_TF | IDE_VALID_DEVICE;
+	cmd.valid.in.tf  = IDE_VALID_IN_TF  | IDE_VALID_DEVICE;
 
 	return ide_no_data_taskfile(drive, &cmd);
 }
@@ -715,7 +728,8 @@ static int ide_disk_set_doorlock(ide_dri
 
 	memset(&cmd, 0, sizeof(cmd));
 	cmd.tf.command = on ? ATA_CMD_MEDIA_LOCK : ATA_CMD_MEDIA_UNLOCK;
-	cmd.tf_flags   = IDE_TFLAG_TF | IDE_TFLAG_DEVICE;
+	cmd.valid.out.tf = IDE_VALID_OUT_TF | IDE_VALID_DEVICE;
+	cmd.valid.in.tf  = IDE_VALID_IN_TF  | IDE_VALID_DEVICE;
 
 	ret = ide_no_data_taskfile(drive, &cmd);
 
Index: linux-2.6/drivers/ide/ide-disk_proc.c
===================================================================
--- linux-2.6.orig/drivers/ide/ide-disk_proc.c
+++ linux-2.6/drivers/ide/ide-disk_proc.c
@@ -13,7 +13,8 @@ static int smart_enable(ide_drive_t *dri
 	tf->lbam    = ATA_SMART_LBAM_PASS;
 	tf->lbah    = ATA_SMART_LBAH_PASS;
 	tf->command = ATA_CMD_SMART;
-	cmd.tf_flags = IDE_TFLAG_TF | IDE_TFLAG_DEVICE;
+	cmd.valid.out.tf = IDE_VALID_OUT_TF | IDE_VALID_DEVICE;
+	cmd.valid.in.tf  = IDE_VALID_IN_TF  | IDE_VALID_DEVICE;
 
 	return ide_no_data_taskfile(drive, &cmd);
 }
@@ -29,7 +30,8 @@ static int get_smart_data(ide_drive_t *d
 	tf->lbam    = ATA_SMART_LBAM_PASS;
 	tf->lbah    = ATA_SMART_LBAH_PASS;
 	tf->command = ATA_CMD_SMART;
-	cmd.tf_flags = IDE_TFLAG_TF | IDE_TFLAG_DEVICE;
+	cmd.valid.out.tf = IDE_VALID_OUT_TF | IDE_VALID_DEVICE;
+	cmd.valid.in.tf  = IDE_VALID_IN_TF  | IDE_VALID_DEVICE;
 	cmd.protocol = ATA_PROT_PIO;
 
 	return ide_raw_taskfile(drive, &cmd, buf, 1);
Index: linux-2.6/drivers/ide/ide-io-std.c
===================================================================
--- linux-2.6.orig/drivers/ide/ide-io-std.c
+++ linux-2.6/drivers/ide/ide-io-std.c
@@ -91,6 +91,7 @@ void ide_tf_load(ide_drive_t *drive, str
 	struct ide_io_ports *io_ports = &hwif->io_ports;
 	struct ide_taskfile *tf = &cmd->tf;
 	void (*tf_outb)(u8 addr, unsigned long port);
+	u8 valid = cmd->valid.out.hob;
 	u8 mmio = (hwif->host_flags & IDE_HFLAG_MMIO) ? 1 : 0;
 	u8 HIHI = (cmd->tf_flags & IDE_TFLAG_LBA48) ? 0xE0 : 0xEF;
 
@@ -102,29 +103,31 @@ void ide_tf_load(ide_drive_t *drive, str
 	if (cmd->ftf_flags & IDE_FTFLAG_FLAGGED)
 		HIHI = 0xFF;
 
-	if (cmd->tf_flags & IDE_TFLAG_OUT_HOB_FEATURE)
+	if (valid & IDE_VALID_FEATURE)
 		tf_outb(tf->hob_feature, io_ports->feature_addr);
-	if (cmd->tf_flags & IDE_TFLAG_OUT_HOB_NSECT)
+	if (valid & IDE_VALID_NSECT)
 		tf_outb(tf->hob_nsect, io_ports->nsect_addr);
-	if (cmd->tf_flags & IDE_TFLAG_OUT_HOB_LBAL)
+	if (valid & IDE_VALID_LBAL)
 		tf_outb(tf->hob_lbal, io_ports->lbal_addr);
-	if (cmd->tf_flags & IDE_TFLAG_OUT_HOB_LBAM)
+	if (valid & IDE_VALID_LBAM)
 		tf_outb(tf->hob_lbam, io_ports->lbam_addr);
-	if (cmd->tf_flags & IDE_TFLAG_OUT_HOB_LBAH)
+	if (valid & IDE_VALID_LBAH)
 		tf_outb(tf->hob_lbah, io_ports->lbah_addr);
 
-	if (cmd->tf_flags & IDE_TFLAG_OUT_FEATURE)
+	valid = cmd->valid.out.tf;
+
+	if (valid & IDE_VALID_FEATURE)
 		tf_outb(tf->feature, io_ports->feature_addr);
-	if (cmd->tf_flags & IDE_TFLAG_OUT_NSECT)
+	if (valid & IDE_VALID_NSECT)
 		tf_outb(tf->nsect, io_ports->nsect_addr);
-	if (cmd->tf_flags & IDE_TFLAG_OUT_LBAL)
+	if (valid & IDE_VALID_LBAL)
 		tf_outb(tf->lbal, io_ports->lbal_addr);
-	if (cmd->tf_flags & IDE_TFLAG_OUT_LBAM)
+	if (valid & IDE_VALID_LBAM)
 		tf_outb(tf->lbam, io_ports->lbam_addr);
-	if (cmd->tf_flags & IDE_TFLAG_OUT_LBAH)
+	if (valid & IDE_VALID_LBAH)
 		tf_outb(tf->lbah, io_ports->lbah_addr);
 
-	if (cmd->tf_flags & IDE_TFLAG_OUT_DEVICE)
+	if (valid & IDE_VALID_DEVICE)
 		tf_outb((tf->device & HIHI) | drive->select,
 			 io_ports->device_addr);
 }
@@ -137,6 +140,7 @@ void ide_tf_read(ide_drive_t *drive, str
 	struct ide_taskfile *tf = &cmd->tf;
 	void (*tf_outb)(u8 addr, unsigned long port);
 	u8 (*tf_inb)(unsigned long port);
+	u8 valid = cmd->valid.in.tf;
 	u8 mmio = (hwif->host_flags & IDE_HFLAG_MMIO) ? 1 : 0;
 
 	if (mmio) {
@@ -150,31 +154,33 @@ void ide_tf_read(ide_drive_t *drive, str
 	/* be sure we're looking at the low order bits */
 	tf_outb(ATA_DEVCTL_OBS, io_ports->ctl_addr);
 
-	if (cmd->tf_flags & IDE_TFLAG_IN_ERROR)
+	if (valid & IDE_VALID_ERROR)
 		tf->error  = tf_inb(io_ports->feature_addr);
-	if (cmd->tf_flags & IDE_TFLAG_IN_NSECT)
+	if (valid & IDE_VALID_NSECT)
 		tf->nsect  = tf_inb(io_ports->nsect_addr);
-	if (cmd->tf_flags & IDE_TFLAG_IN_LBAL)
+	if (valid & IDE_VALID_LBAL)
 		tf->lbal   = tf_inb(io_ports->lbal_addr);
-	if (cmd->tf_flags & IDE_TFLAG_IN_LBAM)
+	if (valid & IDE_VALID_LBAM)
 		tf->lbam   = tf_inb(io_ports->lbam_addr);
-	if (cmd->tf_flags & IDE_TFLAG_IN_LBAH)
+	if (valid & IDE_VALID_LBAH)
 		tf->lbah   = tf_inb(io_ports->lbah_addr);
-	if (cmd->tf_flags & IDE_TFLAG_IN_DEVICE)
+	if (valid & IDE_VALID_DEVICE)
 		tf->device = tf_inb(io_ports->device_addr);
 
 	if (cmd->tf_flags & IDE_TFLAG_LBA48) {
 		tf_outb(ATA_HOB | ATA_DEVCTL_OBS, io_ports->ctl_addr);
 
-		if (cmd->tf_flags & IDE_TFLAG_IN_HOB_ERROR)
+		valid = cmd->valid.in.hob;
+
+		if (valid & IDE_VALID_ERROR)
 			tf->hob_error = tf_inb(io_ports->feature_addr);
-		if (cmd->tf_flags & IDE_TFLAG_IN_HOB_NSECT)
+		if (valid & IDE_VALID_NSECT)
 			tf->hob_nsect = tf_inb(io_ports->nsect_addr);
-		if (cmd->tf_flags & IDE_TFLAG_IN_HOB_LBAL)
+		if (valid & IDE_VALID_LBAL)
 			tf->hob_lbal  = tf_inb(io_ports->lbal_addr);
-		if (cmd->tf_flags & IDE_TFLAG_IN_HOB_LBAM)
+		if (valid & IDE_VALID_LBAM)
 			tf->hob_lbam  = tf_inb(io_ports->lbam_addr);
-		if (cmd->tf_flags & IDE_TFLAG_IN_HOB_LBAH)
+		if (valid & IDE_VALID_LBAH)
 			tf->hob_lbah  = tf_inb(io_ports->lbah_addr);
 	}
 }
Index: linux-2.6/drivers/ide/ide-io.c
===================================================================
--- linux-2.6.orig/drivers/ide/ide-io.c
+++ linux-2.6/drivers/ide/ide-io.c
@@ -205,8 +205,9 @@ static ide_startstop_t ide_disk_special(
 		return ide_stopped;
 	}
 
-	cmd.tf_flags = IDE_TFLAG_TF | IDE_TFLAG_DEVICE |
-		       IDE_TFLAG_CUSTOM_HANDLER;
+	cmd.valid.out.tf = IDE_VALID_OUT_TF | IDE_VALID_DEVICE;
+	cmd.valid.in.tf  = IDE_VALID_IN_TF  | IDE_VALID_DEVICE;
+	cmd.tf_flags = IDE_TFLAG_CUSTOM_HANDLER;
 
 	do_rw_taskfile(drive, &cmd);
 
Index: linux-2.6/drivers/ide/ide-ioctls.c
===================================================================
--- linux-2.6.orig/drivers/ide/ide-ioctls.c
+++ linux-2.6/drivers/ide/ide-ioctls.c
@@ -141,11 +141,12 @@ static int ide_cmd_ioctl(ide_drive_t *dr
 		tf->lbal  = args[1];
 		tf->lbam  = 0x4f;
 		tf->lbah  = 0xc2;
-		cmd.tf_flags = IDE_TFLAG_OUT_TF | IDE_TFLAG_IN_NSECT;
+		cmd.valid.out.tf = IDE_VALID_OUT_TF;
+		cmd.valid.in.tf  = IDE_VALID_NSECT;
 	} else {
 		tf->nsect = args[1];
-		cmd.tf_flags = IDE_TFLAG_OUT_FEATURE | IDE_TFLAG_OUT_NSECT |
-			       IDE_TFLAG_IN_NSECT;
+		cmd.valid.out.tf = IDE_VALID_FEATURE | IDE_VALID_NSECT;
+		cmd.valid.in.tf  = IDE_VALID_NSECT;
 	}
 	tf->command = args[0];
 	cmd.protocol = args[3] ? ATA_PROT_PIO : ATA_PROT_NODATA;
@@ -207,7 +208,8 @@ static int ide_task_ioctl(ide_drive_t *d
 	memset(&cmd, 0, sizeof(cmd));
 	memcpy(&cmd.tf_array[7], &args[1], 6);
 	cmd.tf.command = args[0];
-	cmd.tf_flags = IDE_TFLAG_TF | IDE_TFLAG_DEVICE;
+	cmd.valid.out.tf = IDE_VALID_OUT_TF | IDE_VALID_DEVICE;
+	cmd.valid.in.tf  = IDE_VALID_IN_TF  | IDE_VALID_DEVICE;
 
 	err = ide_no_data_taskfile(drive, &cmd);
 
Index: linux-2.6/drivers/ide/ide-iops.c
===================================================================
--- linux-2.6.orig/drivers/ide/ide-iops.c
+++ linux-2.6/drivers/ide/ide-iops.c
@@ -40,7 +40,7 @@ u8 ide_read_error(ide_drive_t *drive)
 	struct ide_cmd cmd;
 
 	memset(&cmd, 0, sizeof(cmd));
-	cmd.tf_flags = IDE_TFLAG_IN_ERROR;
+	cmd.valid.in.tf = IDE_VALID_ERROR;
 
 	drive->hwif->tp_ops->tf_read(drive, &cmd);
 
@@ -348,7 +348,7 @@ int ide_config_drive_speed(ide_drive_t *
 	tp_ops->write_devctl(hwif, ATA_NIEN | ATA_DEVCTL_OBS);
 
 	memset(&cmd, 0, sizeof(cmd));
-	cmd.tf_flags = IDE_TFLAG_OUT_FEATURE | IDE_TFLAG_OUT_NSECT;
+	cmd.valid.out.tf = IDE_VALID_FEATURE | IDE_VALID_NSECT;
 	cmd.tf.feature = SETFEATURES_XFER;
 	cmd.tf.nsect   = speed;
 
Index: linux-2.6/drivers/ide/ide-lib.c
===================================================================
--- linux-2.6.orig/drivers/ide/ide-lib.c
+++ linux-2.6/drivers/ide/ide-lib.c
@@ -71,11 +71,12 @@ static void ide_dump_sector(ide_drive_t 
 	u8 lba48 = !!(drive->dev_flags & IDE_DFLAG_LBA48);
 
 	memset(&cmd, 0, sizeof(cmd));
-	if (lba48)
-		cmd.tf_flags = IDE_TFLAG_IN_LBA | IDE_TFLAG_IN_HOB_LBA |
-				IDE_TFLAG_LBA48;
-	else
-		cmd.tf_flags = IDE_TFLAG_IN_LBA | IDE_TFLAG_IN_DEVICE;
+	if (lba48) {
+		cmd.valid.in.tf  = IDE_VALID_LBA;
+		cmd.valid.in.hob = IDE_VALID_LBA;
+		cmd.tf_flags = IDE_TFLAG_LBA48;
+	} else
+		cmd.valid.in.tf  = IDE_VALID_LBA | IDE_VALID_DEVICE;
 
 	drive->hwif->tp_ops->tf_read(drive, &cmd);
 
Index: linux-2.6/drivers/ide/ide-park.c
===================================================================
--- linux-2.6.orig/drivers/ide/ide-park.c
+++ linux-2.6/drivers/ide/ide-park.c
@@ -74,7 +74,8 @@ ide_startstop_t ide_do_park_unpark(ide_d
 		tf->lbal = 0x4c;
 		tf->lbam = 0x4e;
 		tf->lbah = 0x55;
-		cmd.tf_flags = IDE_TFLAG_TF | IDE_TFLAG_DEVICE;
+		cmd.valid.out.tf = IDE_VALID_OUT_TF | IDE_VALID_DEVICE;
+		cmd.valid.in.tf  = IDE_VALID_IN_TF  | IDE_VALID_DEVICE;
 	} else		/* cmd == REQ_UNPARK_HEADS */
 		tf->command = ATA_CMD_CHK_POWER;
 
Index: linux-2.6/drivers/ide/ide-pm.c
===================================================================
--- linux-2.6.orig/drivers/ide/ide-pm.c
+++ linux-2.6/drivers/ide/ide-pm.c
@@ -163,7 +163,8 @@ ide_startstop_t ide_start_power_step(ide
 	return ide_stopped;
 
 out_do_tf:
-	cmd->tf_flags = IDE_TFLAG_TF | IDE_TFLAG_DEVICE;
+	cmd->valid.out.tf = IDE_VALID_OUT_TF | IDE_VALID_DEVICE;
+	cmd->valid.in.tf  = IDE_VALID_IN_TF  | IDE_VALID_DEVICE;
 	cmd->protocol = ATA_PROT_NODATA;
 
 	return do_rw_taskfile(drive, cmd);
Index: linux-2.6/drivers/ide/ide-probe.c
===================================================================
--- linux-2.6.orig/drivers/ide/ide-probe.c
+++ linux-2.6/drivers/ide/ide-probe.c
@@ -287,7 +287,7 @@ int ide_dev_read_id(ide_drive_t *drive, 
 
 		memset(&cmd, 0, sizeof(cmd));
 		/* disable DMA & overlap */
-		cmd.tf_flags = IDE_TFLAG_OUT_FEATURE;
+		cmd.valid.out.tf = IDE_VALID_FEATURE;
 
 		tp_ops->tf_load(drive, &cmd);
 	}
@@ -340,7 +340,7 @@ static u8 ide_read_device(ide_drive_t *d
 	struct ide_cmd cmd;
 
 	memset(&cmd, 0, sizeof(cmd));
-	cmd.tf_flags = IDE_TFLAG_IN_DEVICE;
+	cmd.valid.in.tf = IDE_VALID_DEVICE;
 
 	drive->hwif->tp_ops->tf_read(drive, &cmd);
 
Index: linux-2.6/drivers/ide/ide-proc.c
===================================================================
--- linux-2.6.orig/drivers/ide/ide-proc.c
+++ linux-2.6/drivers/ide/ide-proc.c
@@ -204,8 +204,8 @@ static int set_xfer_rate (ide_drive_t *d
 	cmd.tf.command = ATA_CMD_SET_FEATURES;
 	cmd.tf.feature = SETFEATURES_XFER;
 	cmd.tf.nsect   = (u8)arg;
-	cmd.tf_flags   = IDE_TFLAG_OUT_FEATURE | IDE_TFLAG_OUT_NSECT |
-			 IDE_TFLAG_IN_NSECT;
+	cmd.valid.out.tf = IDE_VALID_FEATURE | IDE_VALID_NSECT;
+	cmd.valid.in.tf  = IDE_VALID_NSECT;
 
 	err = ide_no_data_taskfile(drive, &cmd);
 
Index: linux-2.6/drivers/ide/ide-taskfile.c
===================================================================
--- linux-2.6.orig/drivers/ide/ide-taskfile.c
+++ linux-2.6/drivers/ide/ide-taskfile.c
@@ -47,7 +47,8 @@ int taskfile_lib_get_identify (ide_drive
 		cmd.tf.command = ATA_CMD_ID_ATA;
 	else
 		cmd.tf.command = ATA_CMD_ID_ATAPI;
-	cmd.tf_flags = IDE_TFLAG_TF | IDE_TFLAG_DEVICE;
+	cmd.valid.out.tf = IDE_VALID_OUT_TF | IDE_VALID_DEVICE;
+	cmd.valid.in.tf  = IDE_VALID_IN_TF  | IDE_VALID_DEVICE;
 	cmd.protocol = ATA_PROT_PIO;
 
 	return ide_raw_taskfile(drive, &cmd, buf, 1);
@@ -494,11 +495,14 @@ int ide_taskfile_ioctl(ide_drive_t *driv
 	memcpy(&cmd.tf_array[6], req_task->io_ports,
 	       HDIO_DRIVE_TASK_HDR_SIZE);
 
-	cmd.tf_flags   = IDE_TFLAG_IO_16BIT | IDE_TFLAG_DEVICE |
-			 IDE_TFLAG_IN_TF;
-
-	if (drive->dev_flags & IDE_DFLAG_LBA48)
-		cmd.tf_flags |= (IDE_TFLAG_LBA48 | IDE_TFLAG_IN_HOB);
+	cmd.valid.out.tf = IDE_VALID_DEVICE;
+	cmd.valid.in.tf  = IDE_VALID_DEVICE | IDE_VALID_IN_TF;
+	cmd.tf_flags = IDE_TFLAG_IO_16BIT;
+
+	if (drive->dev_flags & IDE_DFLAG_LBA48) {
+		cmd.tf_flags |= IDE_TFLAG_LBA48;
+		cmd.valid.in.hob = IDE_VALID_IN_HOB;
+	}
 
 	if (req_task->out_flags.all) {
 		cmd.ftf_flags |= IDE_FTFLAG_FLAGGED;
@@ -507,28 +511,28 @@ int ide_taskfile_ioctl(ide_drive_t *driv
 			cmd.ftf_flags |= IDE_FTFLAG_OUT_DATA;
 
 		if (req_task->out_flags.b.nsector_hob)
-			cmd.tf_flags |= IDE_TFLAG_OUT_HOB_NSECT;
+			cmd.valid.out.hob |= IDE_VALID_NSECT;
 		if (req_task->out_flags.b.sector_hob)
-			cmd.tf_flags |= IDE_TFLAG_OUT_HOB_LBAL;
+			cmd.valid.out.hob |= IDE_VALID_LBAL;
 		if (req_task->out_flags.b.lcyl_hob)
-			cmd.tf_flags |= IDE_TFLAG_OUT_HOB_LBAM;
+			cmd.valid.out.hob |= IDE_VALID_LBAM;
 		if (req_task->out_flags.b.hcyl_hob)
-			cmd.tf_flags |= IDE_TFLAG_OUT_HOB_LBAH;
+			cmd.valid.out.hob |= IDE_VALID_LBAH;
 
 		if (req_task->out_flags.b.error_feature)
-			cmd.tf_flags |= IDE_TFLAG_OUT_FEATURE;
+			cmd.valid.out.tf  |= IDE_VALID_FEATURE;
 		if (req_task->out_flags.b.nsector)
-			cmd.tf_flags |= IDE_TFLAG_OUT_NSECT;
+			cmd.valid.out.tf  |= IDE_VALID_NSECT;
 		if (req_task->out_flags.b.sector)
-			cmd.tf_flags |= IDE_TFLAG_OUT_LBAL;
+			cmd.valid.out.tf  |= IDE_VALID_LBAL;
 		if (req_task->out_flags.b.lcyl)
-			cmd.tf_flags |= IDE_TFLAG_OUT_LBAM;
+			cmd.valid.out.tf  |= IDE_VALID_LBAM;
 		if (req_task->out_flags.b.hcyl)
-			cmd.tf_flags |= IDE_TFLAG_OUT_LBAH;
+			cmd.valid.out.tf  |= IDE_VALID_LBAH;
 	} else {
-		cmd.tf_flags |= IDE_TFLAG_OUT_TF;
+		cmd.valid.out.tf |= IDE_VALID_OUT_TF;
 		if (cmd.tf_flags & IDE_TFLAG_LBA48)
-			cmd.tf_flags |= IDE_TFLAG_OUT_HOB;
+			cmd.valid.out.hob |= IDE_VALID_OUT_HOB;
 	}
 
 	if (req_task->in_flags.b.data)
Index: linux-2.6/drivers/ide/ns87415.c
===================================================================
--- linux-2.6.orig/drivers/ide/ns87415.c
+++ linux-2.6/drivers/ide/ns87415.c
@@ -65,35 +65,38 @@ static void superio_tf_read(ide_drive_t 
 {
 	struct ide_io_ports *io_ports = &drive->hwif->io_ports;
 	struct ide_taskfile *tf = &cmd->tf;
+	u8 valid = cmd->valid.in.tf;
 
 	/* be sure we're looking at the low order bits */
 	outb(ATA_DEVCTL_OBS, io_ports->ctl_addr);
 
-	if (cmd->tf_flags & IDE_TFLAG_IN_ERROR)
+	if (valid & IDE_VALID_ERROR)
 		tf->error  = inb(io_ports->feature_addr);
-	if (cmd->tf_flags & IDE_TFLAG_IN_NSECT)
+	if (valid & IDE_VALID_NSECT)
 		tf->nsect  = inb(io_ports->nsect_addr);
-	if (cmd->tf_flags & IDE_TFLAG_IN_LBAL)
+	if (valid & IDE_VALID_LBAL)
 		tf->lbal   = inb(io_ports->lbal_addr);
-	if (cmd->tf_flags & IDE_TFLAG_IN_LBAM)
+	if (valid & IDE_VALID_LBAM)
 		tf->lbam   = inb(io_ports->lbam_addr);
-	if (cmd->tf_flags & IDE_TFLAG_IN_LBAH)
+	if (valid & IDE_VALID_LBAH)
 		tf->lbah   = inb(io_ports->lbah_addr);
-	if (cmd->tf_flags & IDE_TFLAG_IN_DEVICE)
+	if (valid & IDE_VALID_DEVICE)
 		tf->device = superio_ide_inb(io_ports->device_addr);
 
 	if (cmd->tf_flags & IDE_TFLAG_LBA48) {
 		outb(ATA_HOB | ATA_DEVCTL_OBS, io_ports->ctl_addr);
 
-		if (cmd->tf_flags & IDE_TFLAG_IN_HOB_ERROR)
+		valid = cmd->valid.in.hob;
+
+		if (valid & IDE_VALID_ERROR)
 			tf->hob_error = inb(io_ports->feature_addr);
-		if (cmd->tf_flags & IDE_TFLAG_IN_HOB_NSECT)
+		if (valid & IDE_VALID_NSECT)
 			tf->hob_nsect = inb(io_ports->nsect_addr);
-		if (cmd->tf_flags & IDE_TFLAG_IN_HOB_LBAL)
+		if (valid & IDE_VALID_LBAL)
 			tf->hob_lbal  = inb(io_ports->lbal_addr);
-		if (cmd->tf_flags & IDE_TFLAG_IN_HOB_LBAM)
+		if (valid & IDE_VALID_LBAM)
 			tf->hob_lbam  = inb(io_ports->lbam_addr);
-		if (cmd->tf_flags & IDE_TFLAG_IN_HOB_LBAH)
+		if (valid & IDE_VALID_LBAH)
 			tf->hob_lbah  = inb(io_ports->lbah_addr);
 	}
 }
Index: linux-2.6/drivers/ide/scc_pata.c
===================================================================
--- linux-2.6.orig/drivers/ide/scc_pata.c
+++ linux-2.6/drivers/ide/scc_pata.c
@@ -651,34 +651,37 @@ static void scc_tf_load(ide_drive_t *dri
 {
 	struct ide_io_ports *io_ports = &drive->hwif->io_ports;
 	struct ide_taskfile *tf = &cmd->tf;
+	u8 valid = cmd->valid.out.hob;
 	u8 HIHI = (cmd->tf_flags & IDE_TFLAG_LBA48) ? 0xE0 : 0xEF;
 
 	if (cmd->ftf_flags & IDE_FTFLAG_FLAGGED)
 		HIHI = 0xFF;
 
-	if (cmd->tf_flags & IDE_TFLAG_OUT_HOB_FEATURE)
+	if (valid & IDE_VALID_FEATURE)
 		scc_ide_outb(tf->hob_feature, io_ports->feature_addr);
-	if (cmd->tf_flags & IDE_TFLAG_OUT_HOB_NSECT)
+	if (valid & IDE_VALID_NSECT)
 		scc_ide_outb(tf->hob_nsect, io_ports->nsect_addr);
-	if (cmd->tf_flags & IDE_TFLAG_OUT_HOB_LBAL)
+	if (valid & IDE_VALID_LBAL)
 		scc_ide_outb(tf->hob_lbal, io_ports->lbal_addr);
-	if (cmd->tf_flags & IDE_TFLAG_OUT_HOB_LBAM)
+	if (valid & IDE_VALID_LBAM)
 		scc_ide_outb(tf->hob_lbam, io_ports->lbam_addr);
-	if (cmd->tf_flags & IDE_TFLAG_OUT_HOB_LBAH)
+	if (valid & IDE_VALID_LBAH)
 		scc_ide_outb(tf->hob_lbah, io_ports->lbah_addr);
 
-	if (cmd->tf_flags & IDE_TFLAG_OUT_FEATURE)
+	valid = cmd->valid.out.tf;
+
+	if (valid & IDE_VALID_FEATURE)
 		scc_ide_outb(tf->feature, io_ports->feature_addr);
-	if (cmd->tf_flags & IDE_TFLAG_OUT_NSECT)
+	if (valid & IDE_VALID_NSECT)
 		scc_ide_outb(tf->nsect, io_ports->nsect_addr);
-	if (cmd->tf_flags & IDE_TFLAG_OUT_LBAL)
+	if (valid & IDE_VALID_LBAL)
 		scc_ide_outb(tf->lbal, io_ports->lbal_addr);
-	if (cmd->tf_flags & IDE_TFLAG_OUT_LBAM)
+	if (valid & IDE_VALID_LBAM)
 		scc_ide_outb(tf->lbam, io_ports->lbam_addr);
-	if (cmd->tf_flags & IDE_TFLAG_OUT_LBAH)
+	if (valid & IDE_VALID_LBAH)
 		scc_ide_outb(tf->lbah, io_ports->lbah_addr);
 
-	if (cmd->tf_flags & IDE_TFLAG_OUT_DEVICE)
+	if (valid & IDE_VALID_DEVICE)
 		scc_ide_outb((tf->device & HIHI) | drive->select,
 			     io_ports->device_addr);
 }
@@ -687,35 +690,38 @@ static void scc_tf_read(ide_drive_t *dri
 {
 	struct ide_io_ports *io_ports = &drive->hwif->io_ports;
 	struct ide_taskfile *tf = &cmd->tf;
+	u8 valid = cmd->valid.in.tf;
 
 	/* be sure we're looking at the low order bits */
 	scc_ide_outb(ATA_DEVCTL_OBS, io_ports->ctl_addr);
 
-	if (cmd->tf_flags & IDE_TFLAG_IN_ERROR)
+	if (valid & IDE_VALID_ERROR)
 		tf->error  = scc_ide_inb(io_ports->feature_addr);
-	if (cmd->tf_flags & IDE_TFLAG_IN_NSECT)
+	if (valid & IDE_VALID_NSECT)
 		tf->nsect  = scc_ide_inb(io_ports->nsect_addr);
-	if (cmd->tf_flags & IDE_TFLAG_IN_LBAL)
+	if (valid & IDE_VALID_LBAL)
 		tf->lbal   = scc_ide_inb(io_ports->lbal_addr);
-	if (cmd->tf_flags & IDE_TFLAG_IN_LBAM)
+	if (valid & IDE_VALID_LBAM)
 		tf->lbam   = scc_ide_inb(io_ports->lbam_addr);
-	if (cmd->tf_flags & IDE_TFLAG_IN_LBAH)
+	if (valid & IDE_VALID_LBAH)
 		tf->lbah   = scc_ide_inb(io_ports->lbah_addr);
-	if (cmd->tf_flags & IDE_TFLAG_IN_DEVICE)
+	if (valid & IDE_VALID_DEVICE)
 		tf->device = scc_ide_inb(io_ports->device_addr);
 
 	if (cmd->tf_flags & IDE_TFLAG_LBA48) {
 		scc_ide_outb(ATA_HOB | ATA_DEVCTL_OBS, io_ports->ctl_addr);
 
-		if (cmd->tf_flags & IDE_TFLAG_IN_HOB_ERROR)
+		valid = cmd->valid.in.hob;
+
+		if (valid & IDE_VALID_ERROR)
 			tf->hob_error = scc_ide_inb(io_ports->feature_addr);
-		if (cmd->tf_flags & IDE_TFLAG_IN_HOB_NSECT)
+		if (valid & IDE_VALID_NSECT)
 			tf->hob_nsect = scc_ide_inb(io_ports->nsect_addr);
-		if (cmd->tf_flags & IDE_TFLAG_IN_HOB_LBAL)
+		if (valid & IDE_VALID_LBAL)
 			tf->hob_lbal  = scc_ide_inb(io_ports->lbal_addr);
-		if (cmd->tf_flags & IDE_TFLAG_IN_HOB_LBAM)
+		if (valid & IDE_VALID_LBAM)
 			tf->hob_lbam  = scc_ide_inb(io_ports->lbam_addr);
-		if (cmd->tf_flags & IDE_TFLAG_IN_HOB_LBAH)
+		if (valid & IDE_VALID_LBAH)
 			tf->hob_lbah  = scc_ide_inb(io_ports->lbah_addr);
 	}
 }
Index: linux-2.6/drivers/ide/tx4938ide.c
===================================================================
--- linux-2.6.orig/drivers/ide/tx4938ide.c
+++ linux-2.6/drivers/ide/tx4938ide.c
@@ -87,34 +87,37 @@ static void tx4938ide_tf_load(ide_drive_
 	ide_hwif_t *hwif = drive->hwif;
 	struct ide_io_ports *io_ports = &hwif->io_ports;
 	struct ide_taskfile *tf = &cmd->tf;
+	u8 valid = cmd->valid.out.hob;
 	u8 HIHI = cmd->tf_flags & IDE_TFLAG_LBA48 ? 0xE0 : 0xEF;
 
 	if (cmd->ftf_flags & IDE_FTFLAG_FLAGGED)
 		HIHI = 0xFF;
 
-	if (cmd->tf_flags & IDE_TFLAG_OUT_HOB_FEATURE)
+	if (valid & IDE_VALID_FEATURE)
 		tx4938ide_outb(tf->hob_feature, io_ports->feature_addr);
-	if (cmd->tf_flags & IDE_TFLAG_OUT_HOB_NSECT)
+	if (valid & IDE_VALID_NSECT)
 		tx4938ide_outb(tf->hob_nsect, io_ports->nsect_addr);
-	if (cmd->tf_flags & IDE_TFLAG_OUT_HOB_LBAL)
+	if (valid & IDE_VALID_LBAL)
 		tx4938ide_outb(tf->hob_lbal, io_ports->lbal_addr);
-	if (cmd->tf_flags & IDE_TFLAG_OUT_HOB_LBAM)
+	if (valid & IDE_VALID_LBAM)
 		tx4938ide_outb(tf->hob_lbam, io_ports->lbam_addr);
-	if (cmd->tf_flags & IDE_TFLAG_OUT_HOB_LBAH)
+	if (valid & IDE_VALID_LBAH)
 		tx4938ide_outb(tf->hob_lbah, io_ports->lbah_addr);
 
-	if (cmd->tf_flags & IDE_TFLAG_OUT_FEATURE)
+	valid = cmd->valid.out.tf;
+
+	if (valid & IDE_VALID_FEATURE)
 		tx4938ide_outb(tf->feature, io_ports->feature_addr);
-	if (cmd->tf_flags & IDE_TFLAG_OUT_NSECT)
+	if (valid & IDE_VALID_NSECT)
 		tx4938ide_outb(tf->nsect, io_ports->nsect_addr);
-	if (cmd->tf_flags & IDE_TFLAG_OUT_LBAL)
+	if (valid & IDE_VALID_LBAL)
 		tx4938ide_outb(tf->lbal, io_ports->lbal_addr);
-	if (cmd->tf_flags & IDE_TFLAG_OUT_LBAM)
+	if (valid & IDE_VALID_LBAM)
 		tx4938ide_outb(tf->lbam, io_ports->lbam_addr);
-	if (cmd->tf_flags & IDE_TFLAG_OUT_LBAH)
+	if (valid & IDE_VALID_LBAH)
 		tx4938ide_outb(tf->lbah, io_ports->lbah_addr);
 
-	if (cmd->tf_flags & IDE_TFLAG_OUT_DEVICE)
+	if (valid & IDE_VALID_DEVICE)
 		tx4938ide_outb((tf->device & HIHI) | drive->select,
 			       io_ports->device_addr);
 }
@@ -124,35 +127,38 @@ static void tx4938ide_tf_read(ide_drive_
 	ide_hwif_t *hwif = drive->hwif;
 	struct ide_io_ports *io_ports = &hwif->io_ports;
 	struct ide_taskfile *tf = &cmd->tf;
+	u8 valid = cmd->valid.in.tf;
 
 	/* be sure we're looking at the low order bits */
 	tx4938ide_outb(ATA_DEVCTL_OBS, io_ports->ctl_addr);
 
-	if (cmd->tf_flags & IDE_TFLAG_IN_ERROR)
+	if (valid & IDE_VALID_ERROR)
 		tf->error  = tx4938ide_inb(io_ports->feature_addr);
-	if (cmd->tf_flags & IDE_TFLAG_IN_NSECT)
+	if (valid & IDE_VALID_NSECT)
 		tf->nsect  = tx4938ide_inb(io_ports->nsect_addr);
-	if (cmd->tf_flags & IDE_TFLAG_IN_LBAL)
+	if (valid & IDE_VALID_LBAL)
 		tf->lbal   = tx4938ide_inb(io_ports->lbal_addr);
-	if (cmd->tf_flags & IDE_TFLAG_IN_LBAM)
+	if (valid & IDE_VALID_LBAM)
 		tf->lbam   = tx4938ide_inb(io_ports->lbam_addr);
-	if (cmd->tf_flags & IDE_TFLAG_IN_LBAH)
+	if (valid & IDE_VALID_LBAH)
 		tf->lbah   = tx4938ide_inb(io_ports->lbah_addr);
-	if (cmd->tf_flags & IDE_TFLAG_IN_DEVICE)
+	if (valid & IDE_VALID_DEVICE)
 		tf->device = tx4938ide_inb(io_ports->device_addr);
 
 	if (cmd->tf_flags & IDE_TFLAG_LBA48) {
 		tx4938ide_outb(ATA_HOB | ATA_DEVCTL_OBS, io_ports->ctl_addr);
 
-		if (cmd->tf_flags & IDE_TFLAG_IN_HOB_ERROR)
+		valid = cmd->valid.in.hob;
+
+		if (valid & IDE_VALID_ERROR)
 			tf->hob_error = tx4938ide_inb(io_ports->feature_addr);
-		if (cmd->tf_flags & IDE_TFLAG_IN_HOB_NSECT)
+		if (valid & IDE_VALID_NSECT)
 			tf->hob_nsect = tx4938ide_inb(io_ports->nsect_addr);
-		if (cmd->tf_flags & IDE_TFLAG_IN_HOB_LBAL)
+		if (valid & IDE_VALID_LBAL)
 			tf->hob_lbal  = tx4938ide_inb(io_ports->lbal_addr);
-		if (cmd->tf_flags & IDE_TFLAG_IN_HOB_LBAM)
+		if (valid & IDE_VALID_LBAM)
 			tf->hob_lbam  = tx4938ide_inb(io_ports->lbam_addr);
-		if (cmd->tf_flags & IDE_TFLAG_IN_HOB_LBAH)
+		if (valid & IDE_VALID_LBAH)
 			tf->hob_lbah  = tx4938ide_inb(io_ports->lbah_addr);
 	}
 }
Index: linux-2.6/drivers/ide/tx4939ide.c
===================================================================
--- linux-2.6.orig/drivers/ide/tx4939ide.c
+++ linux-2.6/drivers/ide/tx4939ide.c
@@ -452,34 +452,37 @@ static void tx4939ide_tf_load(ide_drive_
 	ide_hwif_t *hwif = drive->hwif;
 	struct ide_io_ports *io_ports = &hwif->io_ports;
 	struct ide_taskfile *tf = &cmd->tf;
+	u8 valid = cmd->valid.out.hob;
 	u8 HIHI = cmd->tf_flags & IDE_TFLAG_LBA48 ? 0xE0 : 0xEF;
 
 	if (cmd->ftf_flags & IDE_FTFLAG_FLAGGED)
 		HIHI = 0xFF;
 
-	if (cmd->tf_flags & IDE_TFLAG_OUT_HOB_FEATURE)
+	if (valid & IDE_VALID_FEATURE)
 		tx4939ide_outb(tf->hob_feature, io_ports->feature_addr);
-	if (cmd->tf_flags & IDE_TFLAG_OUT_HOB_NSECT)
+	if (valid & IDE_VALID_NSECT)
 		tx4939ide_outb(tf->hob_nsect, io_ports->nsect_addr);
-	if (cmd->tf_flags & IDE_TFLAG_OUT_HOB_LBAL)
+	if (valid & IDE_VALID_LBAL)
 		tx4939ide_outb(tf->hob_lbal, io_ports->lbal_addr);
-	if (cmd->tf_flags & IDE_TFLAG_OUT_HOB_LBAM)
+	if (valid & IDE_VALID_LBAM)
 		tx4939ide_outb(tf->hob_lbam, io_ports->lbam_addr);
-	if (cmd->tf_flags & IDE_TFLAG_OUT_HOB_LBAH)
+	if (valid & IDE_VALID_LBAH)
 		tx4939ide_outb(tf->hob_lbah, io_ports->lbah_addr);
 
-	if (cmd->tf_flags & IDE_TFLAG_OUT_FEATURE)
+	valid = cmd->valid.out.tf;
+
+	if (valid & IDE_VALID_FEATURE)
 		tx4939ide_outb(tf->feature, io_ports->feature_addr);
-	if (cmd->tf_flags & IDE_TFLAG_OUT_NSECT)
+	if (valid & IDE_VALID_NSECT)
 		tx4939ide_outb(tf->nsect, io_ports->nsect_addr);
-	if (cmd->tf_flags & IDE_TFLAG_OUT_LBAL)
+	if (valid & IDE_VALID_LBAL)
 		tx4939ide_outb(tf->lbal, io_ports->lbal_addr);
-	if (cmd->tf_flags & IDE_TFLAG_OUT_LBAM)
+	if (valid & IDE_VALID_LBAM)
 		tx4939ide_outb(tf->lbam, io_ports->lbam_addr);
-	if (cmd->tf_flags & IDE_TFLAG_OUT_LBAH)
+	if (valid & IDE_VALID_LBAH)
 		tx4939ide_outb(tf->lbah, io_ports->lbah_addr);
 
-	if (cmd->tf_flags & IDE_TFLAG_OUT_DEVICE) {
+	if (valid & IDE_VALID_DEVICE) {
 		tx4939ide_outb((tf->device & HIHI) | drive->select,
 			       io_ports->device_addr);
 		tx4939ide_tf_load_fixup(drive);
@@ -491,35 +494,38 @@ static void tx4939ide_tf_read(ide_drive_
 	ide_hwif_t *hwif = drive->hwif;
 	struct ide_io_ports *io_ports = &hwif->io_ports;
 	struct ide_taskfile *tf = &cmd->tf;
+	u8 valid = cmd->valid.in.tf;
 
 	/* be sure we're looking at the low order bits */
 	tx4939ide_outb(ATA_DEVCTL_OBS, io_ports->ctl_addr);
 
-	if (cmd->tf_flags & IDE_TFLAG_IN_ERROR)
+	if (valid & IDE_VALID_ERROR)
 		tf->error  = tx4939ide_inb(io_ports->feature_addr);
-	if (cmd->tf_flags & IDE_TFLAG_IN_NSECT)
+	if (valid & IDE_VALID_NSECT)
 		tf->nsect  = tx4939ide_inb(io_ports->nsect_addr);
-	if (cmd->tf_flags & IDE_TFLAG_IN_LBAL)
+	if (valid & IDE_VALID_LBAL)
 		tf->lbal   = tx4939ide_inb(io_ports->lbal_addr);
-	if (cmd->tf_flags & IDE_TFLAG_IN_LBAM)
+	if (valid & IDE_VALID_LBAM)
 		tf->lbam   = tx4939ide_inb(io_ports->lbam_addr);
-	if (cmd->tf_flags & IDE_TFLAG_IN_LBAH)
+	if (valid & IDE_VALID_LBAH)
 		tf->lbah   = tx4939ide_inb(io_ports->lbah_addr);
-	if (cmd->tf_flags & IDE_TFLAG_IN_DEVICE)
+	if (valid & IDE_VALID_DEVICE)
 		tf->device = tx4939ide_inb(io_ports->device_addr);
 
 	if (cmd->tf_flags & IDE_TFLAG_LBA48) {
 		tx4939ide_outb(ATA_HOB | ATA_DEVCTL_OBS, io_ports->ctl_addr);
 
-		if (cmd->tf_flags & IDE_TFLAG_IN_HOB_ERROR)
+		valid = cmd->valid.in.hob;
+
+		if (valid & IDE_VALID_ERROR)
 			tf->hob_error =	tx4939ide_inb(io_ports->feature_addr);
-		if (cmd->tf_flags & IDE_TFLAG_IN_HOB_NSECT)
+		if (valid & IDE_VALID_NSECT)
 			tf->hob_nsect = tx4939ide_inb(io_ports->nsect_addr);
-		if (cmd->tf_flags & IDE_TFLAG_IN_HOB_LBAL)
+		if (valid & IDE_VALID_LBAL)
 			tf->hob_lbal  = tx4939ide_inb(io_ports->lbal_addr);
-		if (cmd->tf_flags & IDE_TFLAG_IN_HOB_LBAM)
+		if (valid & IDE_VALID_LBAM)
 			tf->hob_lbam  = tx4939ide_inb(io_ports->lbam_addr);
-		if (cmd->tf_flags & IDE_TFLAG_IN_HOB_LBAH)
+		if (valid & IDE_VALID_LBAH)
 			tf->hob_lbah  = tx4939ide_inb(io_ports->lbah_addr);
 	}
 }
@@ -570,7 +576,7 @@ static void tx4939ide_tf_load(ide_drive_
 {
 	ide_tf_load(drive, cmd);
 
-	if (cmd->tf_flags & IDE_TFLAG_OUT_DEVICE)
+	if (cmd->valid.out.tf & IDE_VALID_DEVICE)
 		tx4939ide_tf_load_fixup(drive);
 }
 
Index: linux-2.6/include/linux/ide.h
===================================================================
--- linux-2.6.orig/include/linux/ide.h
+++ linux-2.6/include/linux/ide.h
@@ -240,65 +240,38 @@ typedef enum {
 } ide_startstop_t;
 
 enum {
+	IDE_VALID_ERROR 		= (1 << 1),
+	IDE_VALID_FEATURE		= IDE_VALID_ERROR,
+	IDE_VALID_NSECT 		= (1 << 2),
+	IDE_VALID_LBAL			= (1 << 3),
+	IDE_VALID_LBAM			= (1 << 4),
+	IDE_VALID_LBAH			= (1 << 5),
+	IDE_VALID_DEVICE		= (1 << 6),
+	IDE_VALID_LBA			= IDE_VALID_LBAL |
+					  IDE_VALID_LBAM |
+					  IDE_VALID_LBAH,
+	IDE_VALID_OUT_TF		= IDE_VALID_FEATURE |
+					  IDE_VALID_NSECT |
+					  IDE_VALID_LBA,
+	IDE_VALID_IN_TF 		= IDE_VALID_NSECT |
+					  IDE_VALID_LBA,
+	IDE_VALID_OUT_HOB		= IDE_VALID_OUT_TF,
+	IDE_VALID_IN_HOB		= IDE_VALID_ERROR |
+					  IDE_VALID_NSECT |
+					  IDE_VALID_LBA,
+};
+
+enum {
 	IDE_TFLAG_LBA48			= (1 << 0),
-	IDE_TFLAG_OUT_HOB_FEATURE	= (1 << 1),
-	IDE_TFLAG_OUT_HOB_NSECT		= (1 << 2),
-	IDE_TFLAG_OUT_HOB_LBAL		= (1 << 3),
-	IDE_TFLAG_OUT_HOB_LBAM		= (1 << 4),
-	IDE_TFLAG_OUT_HOB_LBAH		= (1 << 5),
-	IDE_TFLAG_OUT_HOB		= IDE_TFLAG_OUT_HOB_FEATURE |
-					  IDE_TFLAG_OUT_HOB_NSECT |
-					  IDE_TFLAG_OUT_HOB_LBAL |
-					  IDE_TFLAG_OUT_HOB_LBAM |
-					  IDE_TFLAG_OUT_HOB_LBAH,
-	IDE_TFLAG_OUT_FEATURE		= (1 << 6),
-	IDE_TFLAG_OUT_NSECT		= (1 << 7),
-	IDE_TFLAG_OUT_LBAL		= (1 << 8),
-	IDE_TFLAG_OUT_LBAM		= (1 << 9),
-	IDE_TFLAG_OUT_LBAH		= (1 << 10),
-	IDE_TFLAG_OUT_TF		= IDE_TFLAG_OUT_FEATURE |
-					  IDE_TFLAG_OUT_NSECT |
-					  IDE_TFLAG_OUT_LBAL |
-					  IDE_TFLAG_OUT_LBAM |
-					  IDE_TFLAG_OUT_LBAH,
-	IDE_TFLAG_OUT_DEVICE		= (1 << 11),
-	IDE_TFLAG_WRITE			= (1 << 12),
-	IDE_TFLAG_CUSTOM_HANDLER	= (1 << 13),
-	IDE_TFLAG_DMA_PIO_FALLBACK	= (1 << 14),
-	IDE_TFLAG_IN_HOB_ERROR		= (1 << 15),
-	IDE_TFLAG_IN_HOB_NSECT		= (1 << 16),
-	IDE_TFLAG_IN_HOB_LBAL		= (1 << 17),
-	IDE_TFLAG_IN_HOB_LBAM		= (1 << 18),
-	IDE_TFLAG_IN_HOB_LBAH		= (1 << 19),
-	IDE_TFLAG_IN_HOB_LBA		= IDE_TFLAG_IN_HOB_LBAL |
-					  IDE_TFLAG_IN_HOB_LBAM |
-					  IDE_TFLAG_IN_HOB_LBAH,
-	IDE_TFLAG_IN_HOB		= IDE_TFLAG_IN_HOB_ERROR |
-					  IDE_TFLAG_IN_HOB_NSECT |
-					  IDE_TFLAG_IN_HOB_LBA,
-	IDE_TFLAG_IN_ERROR		= (1 << 20),
-	IDE_TFLAG_IN_NSECT		= (1 << 21),
-	IDE_TFLAG_IN_LBAL		= (1 << 22),
-	IDE_TFLAG_IN_LBAM		= (1 << 23),
-	IDE_TFLAG_IN_LBAH		= (1 << 24),
-	IDE_TFLAG_IN_LBA		= IDE_TFLAG_IN_LBAL |
-					  IDE_TFLAG_IN_LBAM |
-					  IDE_TFLAG_IN_LBAH,
-	IDE_TFLAG_IN_TF			= IDE_TFLAG_IN_NSECT |
-					  IDE_TFLAG_IN_LBA,
-	IDE_TFLAG_IN_DEVICE		= (1 << 25),
-	IDE_TFLAG_HOB			= IDE_TFLAG_OUT_HOB |
-					  IDE_TFLAG_IN_HOB,
-	IDE_TFLAG_TF			= IDE_TFLAG_OUT_TF |
-					  IDE_TFLAG_IN_TF,
-	IDE_TFLAG_DEVICE		= IDE_TFLAG_OUT_DEVICE |
-					  IDE_TFLAG_IN_DEVICE,
+	IDE_TFLAG_WRITE			= (1 << 1),
+	IDE_TFLAG_CUSTOM_HANDLER	= (1 << 2),
+	IDE_TFLAG_DMA_PIO_FALLBACK	= (1 << 3),
 	/* force 16-bit I/O operations */
-	IDE_TFLAG_IO_16BIT		= (1 << 26),
+	IDE_TFLAG_IO_16BIT		= (1 << 4),
 	/* struct ide_cmd was allocated using kmalloc() */
-	IDE_TFLAG_DYN			= (1 << 27),
-	IDE_TFLAG_FS			= (1 << 28),
-	IDE_TFLAG_MULTI_PIO		= (1 << 29),
+	IDE_TFLAG_DYN			= (1 << 5),
+	IDE_TFLAG_FS			= (1 << 6),
+	IDE_TFLAG_MULTI_PIO		= (1 << 7),
 };
 
 enum {
@@ -346,8 +319,16 @@ struct ide_cmd {
 		struct ide_taskfile	tf;
 		u8			tf_array[14];
 	};
+
+	struct {
+		struct {
+			u8		tf;
+			u8		hob;
+		} out, in;
+	} valid;
+
+	u8			tf_flags;
 	u8			ftf_flags;	/* for TASKFILE ioctl */
-	u32			tf_flags;
 	int			protocol;
 
 	int			sg_nents;	  /* number of sg entries */

