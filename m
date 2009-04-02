From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH 6/6] ide: refactor tf_read() method
Date: Thu, 2 Apr 2009 23:11:51 +0400
Message-ID: <200904022311.51065.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:12612 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753149AbZDBTLU (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 2 Apr 2009 15:11:20 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org

Simplify tf_read() method, making it deal only with 'struct ide_taskfile' and
the validity flags that the upper layer passes, and factoring out the code that
deals with the high order bytes into ide_tf_readback() to be called from the
only two functions interested, ide_complete_cmd() and ide_dump_sector().

This should stop the needless code duplication in this method and so make
it about twice smaller than it was; along with simplifying the setup for
the method call, this should save both time and space...

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

---
The patch is against the current Linus' tree...

 drivers/ide/ide-atapi.c    |   21 ++++++++-------------
 drivers/ide/ide-io-std.c   |   25 +------------------------
 drivers/ide/ide-io.c       |    2 +-
 drivers/ide/ide-iops.c     |    9 +++------
 drivers/ide/ide-lib.c      |    2 +-
 drivers/ide/ide-probe.c    |    9 +++------
 drivers/ide/ide-taskfile.c |   17 +++++++++++++++++
 drivers/ide/ns87415.c      |   26 ++------------------------
 drivers/ide/scc_pata.c     |   25 +------------------------
 drivers/ide/tx4938ide.c    |   26 ++------------------------
 drivers/ide/tx4939ide.c    |   26 ++------------------------
 include/linux/ide.h        |    5 +++--
 12 files changed, 44 insertions(+), 149 deletions(-)

Index: linux-2.6/drivers/ide/ide-atapi.c
===================================================================
--- linux-2.6.orig/drivers/ide/ide-atapi.c
+++ linux-2.6/drivers/ide/ide-atapi.c
@@ -254,15 +254,13 @@ EXPORT_SYMBOL_GPL(ide_cd_get_xferlen);
 
 void ide_read_bcount_and_ireason(ide_drive_t *drive, u16 *bcount, u8 *ireason)
 {
-	struct ide_cmd cmd;
+	struct ide_taskfile tf;
 
-	memset(&cmd, 0, sizeof(cmd));
-	cmd.valid.in.tf = IDE_VALID_LBAH | IDE_VALID_LBAM | IDE_VALID_NSECT;
+	drive->hwif->tp_ops->tf_read(drive, &tf, IDE_VALID_NSECT |
+				     IDE_VALID_LBAM | IDE_VALID_LBAH);
 
-	drive->hwif->tp_ops->tf_read(drive, &cmd);
-
-	*bcount = (cmd.tf.lbah << 8) | cmd.tf.lbam;
-	*ireason = cmd.tf.nsect & 3;
+	*bcount = (tf.lbah << 8) | tf.lbam;
+	*ireason = tf.nsect & 3;
 }
 EXPORT_SYMBOL_GPL(ide_read_bcount_and_ireason);
 
@@ -452,14 +450,11 @@ static void ide_init_packet_cmd(struct i
 
 static u8 ide_read_ireason(ide_drive_t *drive)
 {
-	struct ide_cmd cmd;
-
-	memset(&cmd, 0, sizeof(cmd));
-	cmd.valid.in.tf = IDE_VALID_NSECT;
+	struct ide_taskfile tf;
 
-	drive->hwif->tp_ops->tf_read(drive, &cmd);
+	drive->hwif->tp_ops->tf_read(drive, &tf, IDE_VALID_NSECT);
 
-	return cmd.tf.nsect & 3;
+	return tf.nsect & 3;
 }
 
 static u8 ide_wait_ireason(ide_drive_t *drive, u8 ireason)
Index: linux-2.6/drivers/ide/ide-io-std.c
===================================================================
--- linux-2.6.orig/drivers/ide/ide-io-std.c
+++ linux-2.6/drivers/ide/ide-io-std.c
@@ -112,13 +112,11 @@ void ide_tf_load(ide_drive_t *drive, str
 }
 EXPORT_SYMBOL_GPL(ide_tf_load);
 
-void ide_tf_read(ide_drive_t *drive, struct ide_cmd *cmd)
+void ide_tf_read(ide_drive_t *drive, struct ide_taskfile *tf, u8 valid)
 {
 	ide_hwif_t *hwif = drive->hwif;
 	struct ide_io_ports *io_ports = &hwif->io_ports;
-	struct ide_taskfile *tf = &cmd->tf;
 	u8 (*tf_inb)(unsigned long port);
-	u8 valid = cmd->valid.in.tf;
 	u8 mmio = (hwif->host_flags & IDE_HFLAG_MMIO) ? 1 : 0;
 
 	if (mmio)
@@ -126,9 +124,6 @@ void ide_tf_read(ide_drive_t *drive, str
 	else
 		tf_inb  = ide_inb;
 
-	/* be sure we're looking at the low order bits */
-	hwif->tp_ops->write_devctl(hwif, ATA_DEVCTL_OBS);
-
 	if (valid & IDE_VALID_ERROR)
 		tf->error  = tf_inb(io_ports->feature_addr);
 	if (valid & IDE_VALID_NSECT)
@@ -141,24 +136,6 @@ void ide_tf_read(ide_drive_t *drive, str
 		tf->lbah   = tf_inb(io_ports->lbah_addr);
 	if (valid & IDE_VALID_DEVICE)
 		tf->device = tf_inb(io_ports->device_addr);
-
-	if (cmd->tf_flags & IDE_TFLAG_LBA48) {
-		hwif->tp_ops->write_devctl(hwif, ATA_HOB | ATA_DEVCTL_OBS);
-
-		tf = &cmd->hob;
-		valid = cmd->valid.in.hob;
-
-		if (valid & IDE_VALID_ERROR)
-			tf->error = tf_inb(io_ports->feature_addr);
-		if (valid & IDE_VALID_NSECT)
-			tf->nsect = tf_inb(io_ports->nsect_addr);
-		if (valid & IDE_VALID_LBAL)
-			tf->lbal  = tf_inb(io_ports->lbal_addr);
-		if (valid & IDE_VALID_LBAM)
-			tf->lbam  = tf_inb(io_ports->lbam_addr);
-		if (valid & IDE_VALID_LBAH)
-			tf->lbah  = tf_inb(io_ports->lbah_addr);
-	}
 }
 EXPORT_SYMBOL_GPL(ide_tf_read);
 
Index: linux-2.6/drivers/ide/ide-io.c
===================================================================
--- linux-2.6.orig/drivers/ide/ide-io.c
+++ linux-2.6/drivers/ide/ide-io.c
@@ -90,7 +90,7 @@ void ide_complete_cmd(ide_drive_t *drive
 		cmd->hob.data = data[1];
 	}
 
-	tp_ops->tf_read(drive, cmd);
+	ide_tf_readback(drive, cmd);
 
 	if ((cmd->tf_flags & IDE_TFLAG_CUSTOM_HANDLER) &&
 	    tf_cmd == ATA_CMD_IDLEIMMEDIATE) {
Index: linux-2.6/drivers/ide/ide-iops.c
===================================================================
--- linux-2.6.orig/drivers/ide/ide-iops.c
+++ linux-2.6/drivers/ide/ide-iops.c
@@ -37,14 +37,11 @@ void SELECT_MASK(ide_drive_t *drive, int
 
 u8 ide_read_error(ide_drive_t *drive)
 {
-	struct ide_cmd cmd;
-
-	memset(&cmd, 0, sizeof(cmd));
-	cmd.valid.in.tf = IDE_VALID_ERROR;
+	struct ide_taskfile tf;
 
-	drive->hwif->tp_ops->tf_read(drive, &cmd);
+	drive->hwif->tp_ops->tf_read(drive, &tf, IDE_VALID_ERROR);
 
-	return cmd.tf.error;
+	return tf.error;
 }
 EXPORT_SYMBOL_GPL(ide_read_error);
 
Index: linux-2.6/drivers/ide/ide-lib.c
===================================================================
--- linux-2.6.orig/drivers/ide/ide-lib.c
+++ linux-2.6/drivers/ide/ide-lib.c
@@ -79,7 +79,7 @@ static void ide_dump_sector(ide_drive_t 
 	} else
 		cmd.valid.in.tf  = IDE_VALID_LBA | IDE_VALID_DEVICE;
 
-	drive->hwif->tp_ops->tf_read(drive, &cmd);
+	ide_tf_readback(drive, &cmd);
 
 	if (lba48 || (tf->device & ATA_LBA))
 		printk(KERN_CONT ", LBAsect=%llu",
Index: linux-2.6/drivers/ide/ide-probe.c
===================================================================
--- linux-2.6.orig/drivers/ide/ide-probe.c
+++ linux-2.6/drivers/ide/ide-probe.c
@@ -335,14 +335,11 @@ int ide_busy_sleep(ide_hwif_t *hwif, uns
 
 static u8 ide_read_device(ide_drive_t *drive)
 {
-	struct ide_cmd cmd;
+	struct ide_taskfile tf;
 
-	memset(&cmd, 0, sizeof(cmd));
-	cmd.valid.in.tf = IDE_VALID_DEVICE;
+	drive->hwif->tp_ops->tf_read(drive, &tf, IDE_VALID_DEVICE);
 
-	drive->hwif->tp_ops->tf_read(drive, &cmd);
-
-	return cmd.tf.device;
+	return tf.device;
 }
 
 /**
Index: linux-2.6/drivers/ide/ide-taskfile.c
===================================================================
--- linux-2.6.orig/drivers/ide/ide-taskfile.c
+++ linux-2.6/drivers/ide/ide-taskfile.c
@@ -23,6 +23,23 @@
 #include <asm/uaccess.h>
 #include <asm/io.h>
 
+void ide_tf_readback(ide_drive_t *drive, struct ide_cmd *cmd)
+{
+	ide_hwif_t *hwif = drive->hwif;
+	const struct ide_tp_ops *tp_ops = hwif->tp_ops;
+
+	/* Be sure we're looking at the low order bytes */
+	tp_ops->write_devctl(hwif, ATA_DEVCTL_OBS);
+
+	tp_ops->tf_read(drive, &cmd->tf, cmd->valid.in.tf);
+
+	if (cmd->tf_flags & IDE_TFLAG_LBA48) {
+		tp_ops->write_devctl(hwif, ATA_HOB | ATA_DEVCTL_OBS);
+
+		tp_ops->tf_read(drive, &cmd->hob, cmd->valid.in.hob);
+	}
+}
+
 void ide_tf_dump(const char *s, struct ide_cmd *cmd)
 {
 #ifdef DEBUG
Index: linux-2.6/drivers/ide/ns87415.c
===================================================================
--- linux-2.6.orig/drivers/ide/ns87415.c
+++ linux-2.6/drivers/ide/ns87415.c
@@ -61,14 +61,10 @@ static u8 superio_dma_sff_read_status(id
 	return superio_ide_inb(hwif->dma_base + ATA_DMA_STATUS);
 }
 
-static void superio_tf_read(ide_drive_t *drive, struct ide_cmd *cmd)
+static void superio_tf_read(ide_drive_t *drive, struct ide_taskfile *tf,
+			    u8 valid)
 {
 	struct ide_io_ports *io_ports = &drive->hwif->io_ports;
-	struct ide_taskfile *tf = &cmd->tf;
-	u8 valid = cmd->valid.in.tf;
-
-	/* be sure we're looking at the low order bits */
-	ide_write_devctl(hwif, ATA_DEVCTL_OBS);
 
 	if (valid & IDE_VALID_ERROR)
 		tf->error  = inb(io_ports->feature_addr);
@@ -82,24 +78,6 @@ static void superio_tf_read(ide_drive_t 
 		tf->lbah   = inb(io_ports->lbah_addr);
 	if (valid & IDE_VALID_DEVICE)
 		tf->device = superio_ide_inb(io_ports->device_addr);
-
-	if (cmd->tf_flags & IDE_TFLAG_LBA48) {
-		ide_write_devctl(hwif, ATA_HOB | ATA_DEVCTL_OBS);
-
-		tf = &cmd->hob;
-		valid = cmd->valid.in.hob;
-
-		if (valid & IDE_VALID_ERROR)
-			tf->error = inb(io_ports->feature_addr);
-		if (valid & IDE_VALID_NSECT)
-			tf->nsect = inb(io_ports->nsect_addr);
-		if (valid & IDE_VALID_LBAL)
-			tf->lbal  = inb(io_ports->lbal_addr);
-		if (valid & IDE_VALID_LBAM)
-			tf->lbam  = inb(io_ports->lbam_addr);
-		if (valid & IDE_VALID_LBAH)
-			tf->lbah  = inb(io_ports->lbah_addr);
-	}
 }
 
 static void ns87415_dev_select(ide_drive_t *drive);
Index: linux-2.6/drivers/ide/scc_pata.c
===================================================================
--- linux-2.6.orig/drivers/ide/scc_pata.c
+++ linux-2.6/drivers/ide/scc_pata.c
@@ -665,14 +665,9 @@ static void scc_tf_load(ide_drive_t *dri
 		scc_ide_outb(tf->device, io_ports->device_addr);
 }
 
-static void scc_tf_read(ide_drive_t *drive, struct ide_cmd *cmd)
+static void scc_tf_read(ide_drive_t *drive, struct ide_taskfile *tf, u8 valid)
 {
 	struct ide_io_ports *io_ports = &drive->hwif->io_ports;
-	struct ide_taskfile *tf = &cmd->tf;
-	u8 valid = cmd->valid.in.tf;
-
-	/* be sure we're looking at the low order bits */
-	scc_write_devctl(hwif, ATA_DEVCTL_OBS);
 
 	if (valid & IDE_VALID_ERROR)
 		tf->error  = scc_ide_inb(io_ports->feature_addr);
@@ -686,24 +681,6 @@ static void scc_tf_read(ide_drive_t *dri
 		tf->lbah   = scc_ide_inb(io_ports->lbah_addr);
 	if (valid & IDE_VALID_DEVICE)
 		tf->device = scc_ide_inb(io_ports->device_addr);
-
-	if (cmd->tf_flags & IDE_TFLAG_LBA48) {
-		scc_write_devctl(hwif, ATA_HOB | ATA_DEVCTL_OBS);
-
-		tf = &cmd->hob;
-		valid = cmd->valid.in.hob;
-
-		if (valid & IDE_VALID_ERROR)
-			tf->error = scc_ide_inb(io_ports->feature_addr);
-		if (valid & IDE_VALID_NSECT)
-			tf->nsect = scc_ide_inb(io_ports->nsect_addr);
-		if (valid & IDE_VALID_LBAL)
-			tf->lbal  = scc_ide_inb(io_ports->lbal_addr);
-		if (valid & IDE_VALID_LBAM)
-			tf->lbam  = scc_ide_inb(io_ports->lbam_addr);
-		if (valid & IDE_VALID_LBAH)
-			tf->lbah  = scc_ide_inb(io_ports->lbah_addr);
-	}
 }
 
 static void scc_input_data(ide_drive_t *drive, struct ide_cmd *cmd,
Index: linux-2.6/drivers/ide/tx4938ide.c
===================================================================
--- linux-2.6.orig/drivers/ide/tx4938ide.c
+++ linux-2.6/drivers/ide/tx4938ide.c
@@ -102,15 +102,11 @@ static void tx4938ide_tf_load(ide_drive_
 		tx4938ide_outb(tf->device, io_ports->device_addr);
 }
 
-static void tx4938ide_tf_read(ide_drive_t *drive, struct ide_cmd *cmd)
+static void tx4938ide_tf_read(ide_drive_t *drive, struct ide_taskfile *tf,
+			      u8 valid)
 {
 	ide_hwif_t *hwif = drive->hwif;
 	struct ide_io_ports *io_ports = &hwif->io_ports;
-	struct ide_taskfile *tf = &cmd->tf;
-	u8 valid = cmd->valid.in.tf;
-
-	/* be sure we're looking at the low order bits */
-	ide_write_devctl(hwif, ATA_DEVCTL_OBS);
 
 	if (valid & IDE_VALID_ERROR)
 		tf->error  = tx4938ide_inb(io_ports->feature_addr);
@@ -124,24 +120,6 @@ static void tx4938ide_tf_read(ide_drive_
 		tf->lbah   = tx4938ide_inb(io_ports->lbah_addr);
 	if (valid & IDE_VALID_DEVICE)
 		tf->device = tx4938ide_inb(io_ports->device_addr);
-
-	if (cmd->tf_flags & IDE_TFLAG_LBA48) {
-		ide_write_devctl(hwif, ATA_HOB | ATA_DEVCTL_OBS);
-
-		tf = &cmd->hob;
-		valid = cmd->valid.in.hob;
-
-		if (valid & IDE_VALID_ERROR)
-			tf->error = tx4938ide_inb(io_ports->feature_addr);
-		if (valid & IDE_VALID_NSECT)
-			tf->nsect = tx4938ide_inb(io_ports->nsect_addr);
-		if (valid & IDE_VALID_LBAL)
-			tf->lbal  = tx4938ide_inb(io_ports->lbal_addr);
-		if (valid & IDE_VALID_LBAM)
-			tf->lbam  = tx4938ide_inb(io_ports->lbam_addr);
-		if (valid & IDE_VALID_LBAH)
-			tf->lbah  = tx4938ide_inb(io_ports->lbah_addr);
-	}
 }
 
 static void tx4938ide_input_data_swap(ide_drive_t *drive, struct ide_cmd *cmd,
Index: linux-2.6/drivers/ide/tx4939ide.c
===================================================================
--- linux-2.6.orig/drivers/ide/tx4939ide.c
+++ linux-2.6/drivers/ide/tx4939ide.c
@@ -469,15 +469,11 @@ static void tx4939ide_tf_load(ide_drive_
 	}
 }
 
-static void tx4939ide_tf_read(ide_drive_t *drive, struct ide_cmd *cmd)
+static void tx4939ide_tf_read(ide_drive_t *drive, struct ide_taskfile *tf,
+			      u8 valid)
 {
 	ide_hwif_t *hwif = drive->hwif;
 	struct ide_io_ports *io_ports = &hwif->io_ports;
-	struct ide_taskfile *tf = &cmd->tf;
-	u8 valid = cmd->valid.in.tf;
-
-	/* be sure we're looking at the low order bits */
-	ide_write_devctl(hwif, ATA_DEVCTL_OBS);
 
 	if (valid & IDE_VALID_ERROR)
 		tf->error  = tx4939ide_inb(io_ports->feature_addr);
@@ -491,24 +487,6 @@ static void tx4939ide_tf_read(ide_drive_
 		tf->lbah   = tx4939ide_inb(io_ports->lbah_addr);
 	if (valid & IDE_VALID_DEVICE)
 		tf->device = tx4939ide_inb(io_ports->device_addr);
-
-	if (cmd->tf_flags & IDE_TFLAG_LBA48) {
-		ide_write_devctl(hwif, ATA_HOB | ATA_DEVCTL_OBS);
-
-		tf = &cmd->hob;
-		valid = cmd->valid.in.hob;
-
-		if (valid & IDE_VALID_ERROR)
-			tf->error = tx4939ide_inb(io_ports->feature_addr);
-		if (valid & IDE_VALID_NSECT)
-			tf->nsect = tx4939ide_inb(io_ports->nsect_addr);
-		if (valid & IDE_VALID_LBAL)
-			tf->lbal  = tx4939ide_inb(io_ports->lbal_addr);
-		if (valid & IDE_VALID_LBAM)
-			tf->lbam  = tx4939ide_inb(io_ports->lbam_addr);
-		if (valid & IDE_VALID_LBAH)
-			tf->lbah  = tx4939ide_inb(io_ports->lbah_addr);
-	}
 }
 
 static void tx4939ide_input_data_swap(ide_drive_t *drive, struct request *rq,
Index: linux-2.6/include/linux/ide.h
===================================================================
--- linux-2.6.orig/include/linux/ide.h
+++ linux-2.6/include/linux/ide.h
@@ -625,7 +625,7 @@ struct ide_tp_ops {
 
 	void	(*dev_select)(ide_drive_t *);
 	void	(*tf_load)(ide_drive_t *, struct ide_taskfile *, u8);
-	void	(*tf_read)(ide_drive_t *, struct ide_cmd *);
+	void	(*tf_read)(ide_drive_t *, struct ide_taskfile *, u8);
 
 	void	(*input_data)(ide_drive_t *, struct ide_cmd *,
 			      void *, unsigned int);
@@ -1124,6 +1124,7 @@ extern int ide_devset_execute(ide_drive_
 void ide_complete_cmd(ide_drive_t *, struct ide_cmd *, u8, u8);
 int ide_complete_rq(ide_drive_t *, int, unsigned int);
 
+void ide_tf_readback(ide_drive_t *drive, struct ide_cmd *cmd);
 void ide_tf_dump(const char *, struct ide_cmd *);
 
 void ide_exec_command(ide_hwif_t *, u8);
@@ -1133,7 +1134,7 @@ void ide_write_devctl(ide_hwif_t *, u8);
 
 void ide_dev_select(ide_drive_t *);
 void ide_tf_load(ide_drive_t *, struct ide_taskfile *, u8);
-void ide_tf_read(ide_drive_t *, struct ide_cmd *);
+void ide_tf_read(ide_drive_t *, struct ide_taskfile *, u8);
 
 void ide_input_data(ide_drive_t *, struct ide_cmd *, void *, unsigned int);
 void ide_output_data(ide_drive_t *, struct ide_cmd *, void *, unsigned int);

