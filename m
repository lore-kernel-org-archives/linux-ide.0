From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH 2/6] ide: simplify 'struct ide_taskfile'
Date: Thu, 2 Apr 2009 22:59:28 +0400
Message-ID: <200904022259.28077.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:12475 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751717AbZDBS66 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 2 Apr 2009 14:58:58 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org

Make 'struct ide_taskfile' cover only 8 register values and thus put two such
fields ('tf' and 'hob') into 'struct ide_cmd', dropping unnecessary 'tf_array'
field from it.

This required changing the prototype of ide_get_lba_addr() and ide_tf_dump().

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

---
The patch is against the current Linus' tree...

 drivers/ide/ide-acpi.c     |    2 -
 drivers/ide/ide-disk.c     |   25 +++++++++++-----------
 drivers/ide/ide-io-std.c   |   24 +++++++++++-----------
 drivers/ide/ide-io.c       |    6 ++---
 drivers/ide/ide-ioctls.c   |    4 +--
 drivers/ide/ide-lib.c      |   15 +++++++------
 drivers/ide/ide-taskfile.c |   31 +++++++++++-----------------
 drivers/ide/ns87415.c      |   11 +++++-----
 drivers/ide/scc_pata.c     |   24 +++++++++++-----------
 drivers/ide/tx4938ide.c    |   24 +++++++++++-----------
 drivers/ide/tx4939ide.c    |   24 +++++++++++-----------
 include/linux/ide.h        |   49 +++++++++++++--------------------------------
 12 files changed, 113 insertions(+), 126 deletions(-)

Index: linux-2.6/drivers/ide/ide-acpi.c
===================================================================
--- linux-2.6.orig/drivers/ide/ide-acpi.c
+++ linux-2.6/drivers/ide/ide-acpi.c
@@ -318,7 +318,7 @@ static int do_drive_set_taskfiles(ide_dr
 
 		/* convert GTF to taskfile */
 		memset(&cmd, 0, sizeof(cmd));
-		memcpy(&cmd.tf_array[7], gtf, REGS_PER_GTF);
+		memcpy(&cmd.tf.feature, gtf, REGS_PER_GTF);
 		cmd.valid.out.tf = IDE_VALID_OUT_TF | IDE_VALID_DEVICE;
 		cmd.valid.in.tf  = IDE_VALID_IN_TF  | IDE_VALID_DEVICE;
 
Index: linux-2.6/drivers/ide/ide-disk.c
===================================================================
--- linux-2.6.orig/drivers/ide/ide-disk.c
+++ linux-2.6/drivers/ide/ide-disk.c
@@ -105,18 +105,19 @@ static ide_startstop_t __ide_do_rw_disk(
 			pr_debug("%s: LBA=0x%012llx\n", drive->name,
 					(unsigned long long)block);
 
-			tf->hob_nsect = (nsectors >> 8) & 0xff;
-			tf->hob_lbal  = (u8)(block >> 24);
-			if (sizeof(block) != 4) {
-				tf->hob_lbam = (u8)((u64)block >> 32);
-				tf->hob_lbah = (u8)((u64)block >> 40);
-			}
-
 			tf->nsect  = nsectors & 0xff;
 			tf->lbal   = (u8) block;
 			tf->lbam   = (u8)(block >>  8);
 			tf->lbah   = (u8)(block >> 16);
 
+			tf = &cmd.hob;
+			tf->nsect = (nsectors >> 8) & 0xff;
+			tf->lbal  = (u8)(block >> 24);
+			if (sizeof(block) != 4) {
+				tf->lbam = (u8)((u64)block >> 32);
+				tf->lbah = (u8)((u64)block >> 40);
+			}
+
 			cmd.valid.out.hob = IDE_VALID_OUT_HOB;
 			cmd.valid.in.hob  = IDE_VALID_IN_HOB;
 			cmd.tf_flags |= IDE_TFLAG_LBA48;
@@ -235,7 +236,7 @@ static u64 idedisk_read_native_max_addre
 
 	/* if OK, compute maximum address value */
 	if (!(tf->status & ATA_ERR))
-		addr = ide_get_lba_addr(tf, lba48) + 1;
+		addr = ide_get_lba_addr(&cmd, lba48) + 1;
 
 	return addr;
 }
@@ -257,9 +258,9 @@ static u64 idedisk_set_max_address(ide_d
 	tf->lbam     = (addr_req >>= 8) & 0xff;
 	tf->lbah     = (addr_req >>= 8) & 0xff;
 	if (lba48) {
-		tf->hob_lbal = (addr_req >>= 8) & 0xff;
-		tf->hob_lbam = (addr_req >>= 8) & 0xff;
-		tf->hob_lbah = (addr_req >>= 8) & 0xff;
+		cmd.hob.lbal = (addr_req >>= 8) & 0xff;
+		cmd.hob.lbam = (addr_req >>= 8) & 0xff;
+		cmd.hob.lbah = (addr_req >>= 8) & 0xff;
 		tf->command  = ATA_CMD_SET_MAX_EXT;
 	} else {
 		tf->device   = (addr_req >>= 8) & 0x0f;
@@ -279,7 +280,7 @@ static u64 idedisk_set_max_address(ide_d
 
 	/* if OK, compute maximum address value */
 	if (!(tf->status & ATA_ERR))
-		addr_set = ide_get_lba_addr(tf, lba48) + 1;
+		addr_set = ide_get_lba_addr(&cmd, lba48) + 1;
 
 	return addr_set;
 }
Index: linux-2.6/drivers/ide/ide-io-std.c
===================================================================
--- linux-2.6.orig/drivers/ide/ide-io-std.c
+++ linux-2.6/drivers/ide/ide-io-std.c
@@ -89,7 +89,7 @@ void ide_tf_load(ide_drive_t *drive, str
 {
 	ide_hwif_t *hwif = drive->hwif;
 	struct ide_io_ports *io_ports = &hwif->io_ports;
-	struct ide_taskfile *tf = &cmd->tf;
+	struct ide_taskfile *tf = &cmd->hob;
 	void (*tf_outb)(u8 addr, unsigned long port);
 	u8 valid = cmd->valid.out.hob;
 	u8 mmio = (hwif->host_flags & IDE_HFLAG_MMIO) ? 1 : 0;
@@ -104,16 +104,17 @@ void ide_tf_load(ide_drive_t *drive, str
 		HIHI = 0xFF;
 
 	if (valid & IDE_VALID_FEATURE)
-		tf_outb(tf->hob_feature, io_ports->feature_addr);
+		tf_outb(tf->feature, io_ports->feature_addr);
 	if (valid & IDE_VALID_NSECT)
-		tf_outb(tf->hob_nsect, io_ports->nsect_addr);
+		tf_outb(tf->nsect, io_ports->nsect_addr);
 	if (valid & IDE_VALID_LBAL)
-		tf_outb(tf->hob_lbal, io_ports->lbal_addr);
+		tf_outb(tf->lbal, io_ports->lbal_addr);
 	if (valid & IDE_VALID_LBAM)
-		tf_outb(tf->hob_lbam, io_ports->lbam_addr);
+		tf_outb(tf->lbam, io_ports->lbam_addr);
 	if (valid & IDE_VALID_LBAH)
-		tf_outb(tf->hob_lbah, io_ports->lbah_addr);
+		tf_outb(tf->lbah, io_ports->lbah_addr);
 
+	tf = &cmd->tf;
 	valid = cmd->valid.out.tf;
 
 	if (valid & IDE_VALID_FEATURE)
@@ -170,18 +171,19 @@ void ide_tf_read(ide_drive_t *drive, str
 	if (cmd->tf_flags & IDE_TFLAG_LBA48) {
 		tf_outb(ATA_HOB | ATA_DEVCTL_OBS, io_ports->ctl_addr);
 
+		tf = &cmd->hob;
 		valid = cmd->valid.in.hob;
 
 		if (valid & IDE_VALID_ERROR)
-			tf->hob_error = tf_inb(io_ports->feature_addr);
+			tf->error = tf_inb(io_ports->feature_addr);
 		if (valid & IDE_VALID_NSECT)
-			tf->hob_nsect = tf_inb(io_ports->nsect_addr);
+			tf->nsect = tf_inb(io_ports->nsect_addr);
 		if (valid & IDE_VALID_LBAL)
-			tf->hob_lbal  = tf_inb(io_ports->lbal_addr);
+			tf->lbal  = tf_inb(io_ports->lbal_addr);
 		if (valid & IDE_VALID_LBAM)
-			tf->hob_lbam  = tf_inb(io_ports->lbam_addr);
+			tf->lbam  = tf_inb(io_ports->lbam_addr);
 		if (valid & IDE_VALID_LBAH)
-			tf->hob_lbah  = tf_inb(io_ports->lbah_addr);
+			tf->lbah  = tf_inb(io_ports->lbah_addr);
 	}
 }
 EXPORT_SYMBOL_GPL(ide_tf_read);
Index: linux-2.6/drivers/ide/ide-io.c
===================================================================
--- linux-2.6.orig/drivers/ide/ide-io.c
+++ linux-2.6/drivers/ide/ide-io.c
@@ -86,8 +86,8 @@ void ide_complete_cmd(ide_drive_t *drive
 
 		tp_ops->input_data(drive, cmd, data, 2);
 
-		tf->data = data[0];
-		tf->hob_data = data[1];
+		cmd->tf.data  = data[0];
+		cmd->hob.data = data[1];
 	}
 
 	tp_ops->tf_read(drive, cmd);
@@ -97,7 +97,7 @@ void ide_complete_cmd(ide_drive_t *drive
 		if (tf->lbal != 0xc4) {
 			printk(KERN_ERR "%s: head unload failed!\n",
 			       drive->name);
-			ide_tf_dump(drive->name, tf);
+			ide_tf_dump(drive->name, cmd);
 		} else
 			drive->dev_flags |= IDE_DFLAG_PARKED;
 	}
Index: linux-2.6/drivers/ide/ide-ioctls.c
===================================================================
--- linux-2.6.orig/drivers/ide/ide-ioctls.c
+++ linux-2.6/drivers/ide/ide-ioctls.c
@@ -206,7 +206,7 @@ static int ide_task_ioctl(ide_drive_t *d
 		return -EFAULT;
 
 	memset(&cmd, 0, sizeof(cmd));
-	memcpy(&cmd.tf_array[7], &args[1], 6);
+	memcpy(&cmd.tf.feature, &args[1], 6);
 	cmd.tf.command = args[0];
 	cmd.valid.out.tf = IDE_VALID_OUT_TF | IDE_VALID_DEVICE;
 	cmd.valid.in.tf  = IDE_VALID_IN_TF  | IDE_VALID_DEVICE;
@@ -214,7 +214,7 @@ static int ide_task_ioctl(ide_drive_t *d
 	err = ide_no_data_taskfile(drive, &cmd);
 
 	args[0] = cmd.tf.command;
-	memcpy(&args[1], &cmd.tf_array[7], 6);
+	memcpy(&args[1], &cmd.tf.feature, 6);
 
 	if (copy_to_user(p, args, 7))
 		err = -EFAULT;
Index: linux-2.6/drivers/ide/ide-lib.c
===================================================================
--- linux-2.6.orig/drivers/ide/ide-lib.c
+++ linux-2.6/drivers/ide/ide-lib.c
@@ -49,16 +49,17 @@ static void ide_dump_opcode(ide_drive_t 
 		printk(KERN_CONT "0x%02x\n", cmd->tf.command);
 }
 
-u64 ide_get_lba_addr(struct ide_taskfile *tf, int lba48)
+u64 ide_get_lba_addr(struct ide_cmd *cmd, int lba48)
 {
+	struct ide_taskfile *tf = &cmd->tf;
 	u32 high, low;
 
-	if (lba48)
-		high = (tf->hob_lbah << 16) | (tf->hob_lbam << 8) |
-			tf->hob_lbal;
-	else
-		high = tf->device & 0xf;
 	low  = (tf->lbah << 16) | (tf->lbam << 8) | tf->lbal;
+	if (lba48) {
+		tf = &cmd->hob;
+		high = (tf->lbah << 16) | (tf->lbam << 8) | tf->lbal;
+	} else
+		high = tf->device & 0xf;
 
 	return ((u64)high << 24) | low;
 }
@@ -82,7 +83,7 @@ static void ide_dump_sector(ide_drive_t 
 
 	if (lba48 || (tf->device & ATA_LBA))
 		printk(KERN_CONT ", LBAsect=%llu",
-			(unsigned long long)ide_get_lba_addr(tf, lba48));
+			(unsigned long long)ide_get_lba_addr(&cmd, lba48));
 	else
 		printk(KERN_CONT ", CHS=%d/%d/%d", (tf->lbah << 8) + tf->lbam,
 			tf->device & 0xf, tf->lbal);
Index: linux-2.6/drivers/ide/ide-taskfile.c
===================================================================
--- linux-2.6.orig/drivers/ide/ide-taskfile.c
+++ linux-2.6/drivers/ide/ide-taskfile.c
@@ -23,17 +23,16 @@
 #include <asm/uaccess.h>
 #include <asm/io.h>
 
-void ide_tf_dump(const char *s, struct ide_taskfile *tf)
+void ide_tf_dump(const char *s, struct ide_cmd *cmd)
 {
 #ifdef DEBUG
 	printk("%s: tf: feat 0x%02x nsect 0x%02x lbal 0x%02x "
 		"lbam 0x%02x lbah 0x%02x dev 0x%02x cmd 0x%02x\n",
-		s, tf->feature, tf->nsect, tf->lbal,
-		tf->lbam, tf->lbah, tf->device, tf->command);
-	printk("%s: hob: nsect 0x%02x lbal 0x%02x "
-		"lbam 0x%02x lbah 0x%02x\n",
-		s, tf->hob_nsect, tf->hob_lbal,
-		tf->hob_lbam, tf->hob_lbah);
+	       s, cmd->tf.feature, cmd->tf.nsect,
+	       cmd->tf.lbal, cmd->tf.lbam, cmd->tf.lbah,
+	       cmd->tf.device, cmd->tf.command);
+	printk("%s: hob: nsect 0x%02x lbal 0x%02x lbam 0x%02x lbah 0x%02x\n",
+	       s, cmd->hob.nsect, cmd->hob.lbal, cmd->hob.lbam, cmd->hob.lbah);
 #endif
 }
 
@@ -80,12 +79,12 @@ ide_startstop_t do_rw_taskfile(ide_drive
 	memcpy(cmd, orig_cmd, sizeof(*cmd));
 
 	if ((cmd->tf_flags & IDE_TFLAG_DMA_PIO_FALLBACK) == 0) {
-		ide_tf_dump(drive->name, tf);
+		ide_tf_dump(drive->name, cmd);
 		tp_ops->write_devctl(hwif, ATA_DEVCTL_OBS);
 		SELECT_MASK(drive, 0);
 
 		if (cmd->ftf_flags & IDE_FTFLAG_OUT_DATA) {
-			u8 data[2] = { tf->data, tf->hob_data };
+			u8 data[2] = { cmd->tf.data, cmd->hob.data };
 
 			tp_ops->output_data(drive, cmd, data, 2);
 		}
@@ -490,10 +489,8 @@ int ide_taskfile_ioctl(ide_drive_t *driv
 
 	memset(&cmd, 0, sizeof(cmd));
 
-	memcpy(&cmd.tf_array[0], req_task->hob_ports,
-	       HDIO_DRIVE_HOB_HDR_SIZE - 2);
-	memcpy(&cmd.tf_array[6], req_task->io_ports,
-	       HDIO_DRIVE_TASK_HDR_SIZE);
+	memcpy(&cmd.hob, req_task->hob_ports, HDIO_DRIVE_HOB_HDR_SIZE - 2);
+	memcpy(&cmd.tf,  req_task->io_ports,  HDIO_DRIVE_TASK_HDR_SIZE);
 
 	cmd.valid.out.tf = IDE_VALID_DEVICE;
 	cmd.valid.in.tf  = IDE_VALID_DEVICE | IDE_VALID_IN_TF;
@@ -598,7 +595,7 @@ int ide_taskfile_ioctl(ide_drive_t *driv
 	if (req_task->req_cmd == IDE_DRIVE_TASK_NO_DATA)
 		nsect = 0;
 	else if (!nsect) {
-		nsect = (cmd.tf.hob_nsect << 8) | cmd.tf.nsect;
+		nsect = (cmd.hob.nsect << 8) | cmd.tf.nsect;
 
 		if (!nsect) {
 			printk(KERN_ERR "%s: in/out command without data\n",
@@ -610,10 +607,8 @@ int ide_taskfile_ioctl(ide_drive_t *driv
 
 	err = ide_raw_taskfile(drive, &cmd, data_buf, nsect);
 
-	memcpy(req_task->hob_ports, &cmd.tf_array[0],
-	       HDIO_DRIVE_HOB_HDR_SIZE - 2);
-	memcpy(req_task->io_ports, &cmd.tf_array[6],
-	       HDIO_DRIVE_TASK_HDR_SIZE);
+	memcpy(req_task->hob_ports, &cmd.hob, HDIO_DRIVE_HOB_HDR_SIZE - 2);
+	memcpy(req_task->io_ports,  &cmd.tf,  HDIO_DRIVE_TASK_HDR_SIZE);
 
 	if ((cmd.ftf_flags & IDE_FTFLAG_SET_IN_FLAGS) &&
 	    req_task->in_flags.all == 0) {
Index: linux-2.6/drivers/ide/ns87415.c
===================================================================
--- linux-2.6.orig/drivers/ide/ns87415.c
+++ linux-2.6/drivers/ide/ns87415.c
@@ -86,18 +86,19 @@ static void superio_tf_read(ide_drive_t 
 	if (cmd->tf_flags & IDE_TFLAG_LBA48) {
 		outb(ATA_HOB | ATA_DEVCTL_OBS, io_ports->ctl_addr);
 
+		tf = &cmd->hob;
 		valid = cmd->valid.in.hob;
 
 		if (valid & IDE_VALID_ERROR)
-			tf->hob_error = inb(io_ports->feature_addr);
+			tf->error = inb(io_ports->feature_addr);
 		if (valid & IDE_VALID_NSECT)
-			tf->hob_nsect = inb(io_ports->nsect_addr);
+			tf->nsect = inb(io_ports->nsect_addr);
 		if (valid & IDE_VALID_LBAL)
-			tf->hob_lbal  = inb(io_ports->lbal_addr);
+			tf->lbal  = inb(io_ports->lbal_addr);
 		if (valid & IDE_VALID_LBAM)
-			tf->hob_lbam  = inb(io_ports->lbam_addr);
+			tf->lbam  = inb(io_ports->lbam_addr);
 		if (valid & IDE_VALID_LBAH)
-			tf->hob_lbah  = inb(io_ports->lbah_addr);
+			tf->lbah  = inb(io_ports->lbah_addr);
 	}
 }
 
Index: linux-2.6/drivers/ide/scc_pata.c
===================================================================
--- linux-2.6.orig/drivers/ide/scc_pata.c
+++ linux-2.6/drivers/ide/scc_pata.c
@@ -650,7 +650,7 @@ static int __devinit init_setup_scc(stru
 static void scc_tf_load(ide_drive_t *drive, struct ide_cmd *cmd)
 {
 	struct ide_io_ports *io_ports = &drive->hwif->io_ports;
-	struct ide_taskfile *tf = &cmd->tf;
+	struct ide_taskfile *tf = &cmd->hob;
 	u8 valid = cmd->valid.out.hob;
 	u8 HIHI = (cmd->tf_flags & IDE_TFLAG_LBA48) ? 0xE0 : 0xEF;
 
@@ -658,16 +658,17 @@ static void scc_tf_load(ide_drive_t *dri
 		HIHI = 0xFF;
 
 	if (valid & IDE_VALID_FEATURE)
-		scc_ide_outb(tf->hob_feature, io_ports->feature_addr);
+		scc_ide_outb(tf->feature, io_ports->feature_addr);
 	if (valid & IDE_VALID_NSECT)
-		scc_ide_outb(tf->hob_nsect, io_ports->nsect_addr);
+		scc_ide_outb(tf->nsect, io_ports->nsect_addr);
 	if (valid & IDE_VALID_LBAL)
-		scc_ide_outb(tf->hob_lbal, io_ports->lbal_addr);
+		scc_ide_outb(tf->lbal, io_ports->lbal_addr);
 	if (valid & IDE_VALID_LBAM)
-		scc_ide_outb(tf->hob_lbam, io_ports->lbam_addr);
+		scc_ide_outb(tf->lbam, io_ports->lbam_addr);
 	if (valid & IDE_VALID_LBAH)
-		scc_ide_outb(tf->hob_lbah, io_ports->lbah_addr);
+		scc_ide_outb(tf->lbah, io_ports->lbah_addr);
 
+	tf = &cmd->tf;
 	valid = cmd->valid.out.tf;
 
 	if (valid & IDE_VALID_FEATURE)
@@ -711,18 +712,19 @@ static void scc_tf_read(ide_drive_t *dri
 	if (cmd->tf_flags & IDE_TFLAG_LBA48) {
 		scc_ide_outb(ATA_HOB | ATA_DEVCTL_OBS, io_ports->ctl_addr);
 
+		tf = &cmd->hob;
 		valid = cmd->valid.in.hob;
 
 		if (valid & IDE_VALID_ERROR)
-			tf->hob_error = scc_ide_inb(io_ports->feature_addr);
+			tf->error = scc_ide_inb(io_ports->feature_addr);
 		if (valid & IDE_VALID_NSECT)
-			tf->hob_nsect = scc_ide_inb(io_ports->nsect_addr);
+			tf->nsect = scc_ide_inb(io_ports->nsect_addr);
 		if (valid & IDE_VALID_LBAL)
-			tf->hob_lbal  = scc_ide_inb(io_ports->lbal_addr);
+			tf->lbal  = scc_ide_inb(io_ports->lbal_addr);
 		if (valid & IDE_VALID_LBAM)
-			tf->hob_lbam  = scc_ide_inb(io_ports->lbam_addr);
+			tf->lbam  = scc_ide_inb(io_ports->lbam_addr);
 		if (valid & IDE_VALID_LBAH)
-			tf->hob_lbah  = scc_ide_inb(io_ports->lbah_addr);
+			tf->lbah  = scc_ide_inb(io_ports->lbah_addr);
 	}
 }
 
Index: linux-2.6/drivers/ide/tx4938ide.c
===================================================================
--- linux-2.6.orig/drivers/ide/tx4938ide.c
+++ linux-2.6/drivers/ide/tx4938ide.c
@@ -86,7 +86,7 @@ static void tx4938ide_tf_load(ide_drive_
 {
 	ide_hwif_t *hwif = drive->hwif;
 	struct ide_io_ports *io_ports = &hwif->io_ports;
-	struct ide_taskfile *tf = &cmd->tf;
+	struct ide_taskfile *tf = &cmd->hob;
 	u8 valid = cmd->valid.out.hob;
 	u8 HIHI = cmd->tf_flags & IDE_TFLAG_LBA48 ? 0xE0 : 0xEF;
 
@@ -94,16 +94,17 @@ static void tx4938ide_tf_load(ide_drive_
 		HIHI = 0xFF;
 
 	if (valid & IDE_VALID_FEATURE)
-		tx4938ide_outb(tf->hob_feature, io_ports->feature_addr);
+		tx4938ide_outb(tf->feature, io_ports->feature_addr);
 	if (valid & IDE_VALID_NSECT)
-		tx4938ide_outb(tf->hob_nsect, io_ports->nsect_addr);
+		tx4938ide_outb(tf->nsect, io_ports->nsect_addr);
 	if (valid & IDE_VALID_LBAL)
-		tx4938ide_outb(tf->hob_lbal, io_ports->lbal_addr);
+		tx4938ide_outb(tf->lbal, io_ports->lbal_addr);
 	if (valid & IDE_VALID_LBAM)
-		tx4938ide_outb(tf->hob_lbam, io_ports->lbam_addr);
+		tx4938ide_outb(tf->lbam, io_ports->lbam_addr);
 	if (valid & IDE_VALID_LBAH)
-		tx4938ide_outb(tf->hob_lbah, io_ports->lbah_addr);
+		tx4938ide_outb(tf->lbah, io_ports->lbah_addr);
 
+	tf = &cmd->tf;
 	valid = cmd->valid.out.tf;
 
 	if (valid & IDE_VALID_FEATURE)
@@ -148,18 +149,19 @@ static void tx4938ide_tf_read(ide_drive_
 	if (cmd->tf_flags & IDE_TFLAG_LBA48) {
 		tx4938ide_outb(ATA_HOB | ATA_DEVCTL_OBS, io_ports->ctl_addr);
 
+		tf = &cmd->hob;
 		valid = cmd->valid.in.hob;
 
 		if (valid & IDE_VALID_ERROR)
-			tf->hob_error = tx4938ide_inb(io_ports->feature_addr);
+			tf->error = tx4938ide_inb(io_ports->feature_addr);
 		if (valid & IDE_VALID_NSECT)
-			tf->hob_nsect = tx4938ide_inb(io_ports->nsect_addr);
+			tf->nsect = tx4938ide_inb(io_ports->nsect_addr);
 		if (valid & IDE_VALID_LBAL)
-			tf->hob_lbal  = tx4938ide_inb(io_ports->lbal_addr);
+			tf->lbal  = tx4938ide_inb(io_ports->lbal_addr);
 		if (valid & IDE_VALID_LBAM)
-			tf->hob_lbam  = tx4938ide_inb(io_ports->lbam_addr);
+			tf->lbam  = tx4938ide_inb(io_ports->lbam_addr);
 		if (valid & IDE_VALID_LBAH)
-			tf->hob_lbah  = tx4938ide_inb(io_ports->lbah_addr);
+			tf->lbah  = tx4938ide_inb(io_ports->lbah_addr);
 	}
 }
 
Index: linux-2.6/drivers/ide/tx4939ide.c
===================================================================
--- linux-2.6.orig/drivers/ide/tx4939ide.c
+++ linux-2.6/drivers/ide/tx4939ide.c
@@ -451,7 +451,7 @@ static void tx4939ide_tf_load(ide_drive_
 {
 	ide_hwif_t *hwif = drive->hwif;
 	struct ide_io_ports *io_ports = &hwif->io_ports;
-	struct ide_taskfile *tf = &cmd->tf;
+	struct ide_taskfile *tf = &cmd->hob;
 	u8 valid = cmd->valid.out.hob;
 	u8 HIHI = cmd->tf_flags & IDE_TFLAG_LBA48 ? 0xE0 : 0xEF;
 
@@ -459,16 +459,17 @@ static void tx4939ide_tf_load(ide_drive_
 		HIHI = 0xFF;
 
 	if (valid & IDE_VALID_FEATURE)
-		tx4939ide_outb(tf->hob_feature, io_ports->feature_addr);
+		tx4939ide_outb(tf->feature, io_ports->feature_addr);
 	if (valid & IDE_VALID_NSECT)
-		tx4939ide_outb(tf->hob_nsect, io_ports->nsect_addr);
+		tx4939ide_outb(tf->nsect, io_ports->nsect_addr);
 	if (valid & IDE_VALID_LBAL)
-		tx4939ide_outb(tf->hob_lbal, io_ports->lbal_addr);
+		tx4939ide_outb(tf->lbal, io_ports->lbal_addr);
 	if (valid & IDE_VALID_LBAM)
-		tx4939ide_outb(tf->hob_lbam, io_ports->lbam_addr);
+		tx4939ide_outb(tf->lbam, io_ports->lbam_addr);
 	if (valid & IDE_VALID_LBAH)
-		tx4939ide_outb(tf->hob_lbah, io_ports->lbah_addr);
+		tx4939ide_outb(tf->lbah, io_ports->lbah_addr);
 
+	tf = &cmd->tf;
 	valid = cmd->valid.out.tf;
 
 	if (valid & IDE_VALID_FEATURE)
@@ -515,18 +516,19 @@ static void tx4939ide_tf_read(ide_drive_
 	if (cmd->tf_flags & IDE_TFLAG_LBA48) {
 		tx4939ide_outb(ATA_HOB | ATA_DEVCTL_OBS, io_ports->ctl_addr);
 
+		tf = &cmd->hob;
 		valid = cmd->valid.in.hob;
 
 		if (valid & IDE_VALID_ERROR)
-			tf->hob_error =	tx4939ide_inb(io_ports->feature_addr);
+			tf->error = tx4939ide_inb(io_ports->feature_addr);
 		if (valid & IDE_VALID_NSECT)
-			tf->hob_nsect = tx4939ide_inb(io_ports->nsect_addr);
+			tf->nsect = tx4939ide_inb(io_ports->nsect_addr);
 		if (valid & IDE_VALID_LBAL)
-			tf->hob_lbal  = tx4939ide_inb(io_ports->lbal_addr);
+			tf->lbal  = tx4939ide_inb(io_ports->lbal_addr);
 		if (valid & IDE_VALID_LBAM)
-			tf->hob_lbam  = tx4939ide_inb(io_ports->lbam_addr);
+			tf->lbam  = tx4939ide_inb(io_ports->lbam_addr);
 		if (valid & IDE_VALID_LBAH)
-			tf->hob_lbah  = tx4939ide_inb(io_ports->lbah_addr);
+			tf->lbah  = tx4939ide_inb(io_ports->lbah_addr);
 	}
 }
 
Index: linux-2.6/include/linux/ide.h
===================================================================
--- linux-2.6.orig/include/linux/ide.h
+++ linux-2.6/include/linux/ide.h
@@ -282,44 +282,25 @@ enum {
 };
 
 struct ide_taskfile {
-	u8	hob_data;	/*  0: high data byte (for TASKFILE IOCTL) */
-				/*  1-5: additional data to support LBA48 */
-	union {
-		u8 hob_error;	/*   read: error */
-		u8 hob_feature;	/*  write: feature */
+	u8	data;		/* 0: data byte (for TASKFILE ioctl) */
+	union {			/* 1: */
+		u8 error;	/*  read: error */
+		u8 feature;	/* write: feature */
 	};
-
-	u8	hob_nsect;
-	u8	hob_lbal;
-	u8	hob_lbam;
-	u8	hob_lbah;
-
-	u8	data;		/*  6: low data byte (for TASKFILE IOCTL) */
-
-	union {			/*  7: */
-		u8 error;	/*   read:  error */
-		u8 feature;	/*  write: feature */
-	};
-
-	u8	nsect;		/*  8: number of sectors */
-	u8	lbal;		/*  9: LBA low */
-	u8	lbam;		/* 10: LBA mid */
-	u8	lbah;		/* 11: LBA high */
-
-	u8	device;		/* 12: device select */
-
-	union {			/* 13: */
-		u8 status;	/*  read: status  */
+	u8	nsect;		/* 2: number of sectors */
+	u8	lbal;		/* 3: LBA low */
+	u8	lbam;		/* 4: LBA mid */
+	u8	lbah;		/* 5: LBA high */
+	u8	device;		/* 6: device select */
+	union {			/* 7: */
+		u8 status;	/*  read: status */
 		u8 command;	/* write: command */
 	};
 };
 
 struct ide_cmd {
-	union {
-		struct ide_taskfile	tf;
-		u8			tf_array[14];
-	};
-
+	struct ide_taskfile	tf;
+	struct ide_taskfile	hob;
 	struct {
 		struct {
 			u8		tf;
@@ -1143,7 +1124,7 @@ extern int ide_devset_execute(ide_drive_
 void ide_complete_cmd(ide_drive_t *, struct ide_cmd *, u8, u8);
 int ide_complete_rq(ide_drive_t *, int, unsigned int);
 
-void ide_tf_dump(const char *, struct ide_taskfile *);
+void ide_tf_dump(const char *, struct ide_cmd *);
 
 void ide_exec_command(ide_hwif_t *, u8);
 u8 ide_read_status(ide_hwif_t *);
@@ -1510,7 +1491,7 @@ static inline void ide_set_hwifdata (ide
 
 extern void ide_toggle_bounce(ide_drive_t *drive, int on);
 
-u64 ide_get_lba_addr(struct ide_taskfile *, int);
+u64 ide_get_lba_addr(struct ide_cmd *, int);
 u8 ide_dump_status(ide_drive_t *, const char *, u8);
 
 struct ide_timing {

