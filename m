From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH 5/6] ide: refactor tf_load() method
Date: Thu, 2 Apr 2009 23:07:34 +0400
Message-ID: <200904022307.34987.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:12584 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751096AbZDBTHE (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 2 Apr 2009 15:07:04 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org

Simplify tf_load() method, making it deal only with 'struct ide_taskfile' and
the validity flags that the upper layer passes, and moving the code that deals
with the high order bytes into the only function interested, do_rw_taskfile().

This should stop the needless code duplication in this method and so make
it about twice smaller than it was; along with simplifying the setup for the
method call, this should save both time and space...

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

---
The patch is against the current Linus' tree...

 drivers/ide/ide-io-std.c   |   18 +-----------------
 drivers/ide/ide-iops.c     |   11 +++++------
 drivers/ide/ide-probe.c    |    8 +++-----
 drivers/ide/ide-taskfile.c |    3 ++-
 drivers/ide/scc_pata.c     |   18 +-----------------
 drivers/ide/tx4938ide.c    |   19 ++-----------------
 drivers/ide/tx4939ide.c    |   26 ++++++--------------------
 include/linux/ide.h        |    4 ++--
 8 files changed, 22 insertions(+), 85 deletions(-)

Index: linux-2.6/drivers/ide/ide-io-std.c
===================================================================
--- linux-2.6.orig/drivers/ide/ide-io-std.c
+++ linux-2.6/drivers/ide/ide-io-std.c
@@ -85,13 +85,11 @@ void ide_dev_select(ide_drive_t *drive)
 }
 EXPORT_SYMBOL_GPL(ide_dev_select);
 
-void ide_tf_load(ide_drive_t *drive, struct ide_cmd *cmd)
+void ide_tf_load(ide_drive_t *drive, struct ide_taskfile *tf, u8 valid)
 {
 	ide_hwif_t *hwif = drive->hwif;
 	struct ide_io_ports *io_ports = &hwif->io_ports;
-	struct ide_taskfile *tf = &cmd->hob;
 	void (*tf_outb)(u8 addr, unsigned long port);
-	u8 valid = cmd->valid.out.hob;
 	u8 mmio = (hwif->host_flags & IDE_HFLAG_MMIO) ? 1 : 0;
 
 	if (mmio)
@@ -109,20 +107,6 @@ void ide_tf_load(ide_drive_t *drive, str
 		tf_outb(tf->lbam, io_ports->lbam_addr);
 	if (valid & IDE_VALID_LBAH)
 		tf_outb(tf->lbah, io_ports->lbah_addr);
-
-	tf = &cmd->tf;
-	valid = cmd->valid.out.tf;
-
-	if (valid & IDE_VALID_FEATURE)
-		tf_outb(tf->feature, io_ports->feature_addr);
-	if (valid & IDE_VALID_NSECT)
-		tf_outb(tf->nsect, io_ports->nsect_addr);
-	if (valid & IDE_VALID_LBAL)
-		tf_outb(tf->lbal, io_ports->lbal_addr);
-	if (valid & IDE_VALID_LBAM)
-		tf_outb(tf->lbam, io_ports->lbam_addr);
-	if (valid & IDE_VALID_LBAH)
-		tf_outb(tf->lbah, io_ports->lbah_addr);
 	if (valid & IDE_VALID_DEVICE)
 		tf_outb(tf->device, io_ports->device_addr);
 }
Index: linux-2.6/drivers/ide/ide-iops.c
===================================================================
--- linux-2.6.orig/drivers/ide/ide-iops.c
+++ linux-2.6/drivers/ide/ide-iops.c
@@ -312,10 +312,10 @@ int ide_config_drive_speed(ide_drive_t *
 {
 	ide_hwif_t *hwif = drive->hwif;
 	const struct ide_tp_ops *tp_ops = hwif->tp_ops;
+	struct ide_taskfile tf;
 	u16 *id = drive->id, i;
 	int error = 0;
 	u8 stat;
-	struct ide_cmd cmd;
 
 #ifdef CONFIG_BLK_DEV_IDEDMA
 	if (hwif->dma_ops)	/* check if host supports DMA */
@@ -347,12 +347,11 @@ int ide_config_drive_speed(ide_drive_t *
 	udelay(1);
 	tp_ops->write_devctl(hwif, ATA_NIEN | ATA_DEVCTL_OBS);
 
-	memset(&cmd, 0, sizeof(cmd));
-	cmd.valid.out.tf = IDE_VALID_FEATURE | IDE_VALID_NSECT;
-	cmd.tf.feature = SETFEATURES_XFER;
-	cmd.tf.nsect   = speed;
+	memset(&tf, 0, sizeof(tf));
+	tf.feature = SETFEATURES_XFER;
+	tf.nsect   = speed;
 
-	tp_ops->tf_load(drive, &cmd);
+	tp_ops->tf_load(drive, &tf, IDE_VALID_FEATURE | IDE_VALID_NSECT);
 
 	tp_ops->exec_command(hwif, ATA_CMD_SET_FEATURES);
 
Index: linux-2.6/drivers/ide/ide-probe.c
===================================================================
--- linux-2.6.orig/drivers/ide/ide-probe.c
+++ linux-2.6/drivers/ide/ide-probe.c
@@ -283,13 +283,11 @@ int ide_dev_read_id(ide_drive_t *drive, 
 	 * identify command to be sure of reply
 	 */
 	if (cmd == ATA_CMD_ID_ATAPI) {
-		struct ide_cmd cmd;
+		struct ide_taskfile tf;
 
-		memset(&cmd, 0, sizeof(cmd));
+		memset(&tf, 0, sizeof(tf));
 		/* disable DMA & overlap */
-		cmd.valid.out.tf = IDE_VALID_FEATURE;
-
-		tp_ops->tf_load(drive, &cmd);
+		tp_ops->tf_load(drive, &tf, IDE_VALID_FEATURE);
 	}
 
 	/* ask drive for ID */
Index: linux-2.6/drivers/ide/ide-taskfile.c
===================================================================
--- linux-2.6.orig/drivers/ide/ide-taskfile.c
+++ linux-2.6/drivers/ide/ide-taskfile.c
@@ -98,7 +98,8 @@ ide_startstop_t do_rw_taskfile(ide_drive
 			cmd->tf.device |= drive->select;
 		}
 
-		tp_ops->tf_load(drive, cmd);
+		tp_ops->tf_load(drive, &cmd->hob, cmd->valid.out.hob);
+		tp_ops->tf_load(drive, &cmd->tf,  cmd->valid.out.tf);
 	}
 
 	switch (cmd->protocol) {
Index: linux-2.6/drivers/ide/scc_pata.c
===================================================================
--- linux-2.6.orig/drivers/ide/scc_pata.c
+++ linux-2.6/drivers/ide/scc_pata.c
@@ -647,25 +647,9 @@ static int __devinit init_setup_scc(stru
 	return rc;
 }
 
-static void scc_tf_load(ide_drive_t *drive, struct ide_cmd *cmd)
+static void scc_tf_load(ide_drive_t *drive, struct ide_taskfile *tf, u8 valid)
 {
 	struct ide_io_ports *io_ports = &drive->hwif->io_ports;
-	struct ide_taskfile *tf = &cmd->hob;
-	u8 valid = cmd->valid.out.hob;
-
-	if (valid & IDE_VALID_FEATURE)
-		scc_ide_outb(tf->feature, io_ports->feature_addr);
-	if (valid & IDE_VALID_NSECT)
-		scc_ide_outb(tf->nsect, io_ports->nsect_addr);
-	if (valid & IDE_VALID_LBAL)
-		scc_ide_outb(tf->lbal, io_ports->lbal_addr);
-	if (valid & IDE_VALID_LBAM)
-		scc_ide_outb(tf->lbam, io_ports->lbam_addr);
-	if (valid & IDE_VALID_LBAH)
-		scc_ide_outb(tf->lbah, io_ports->lbah_addr);
-
-	tf = &cmd->tf;
-	valid = cmd->valid.out.tf;
 
 	if (valid & IDE_VALID_FEATURE)
 		scc_ide_outb(tf->feature, io_ports->feature_addr);
Index: linux-2.6/drivers/ide/tx4938ide.c
===================================================================
--- linux-2.6.orig/drivers/ide/tx4938ide.c
+++ linux-2.6/drivers/ide/tx4938ide.c
@@ -82,26 +82,11 @@ static void tx4938ide_outb(u8 value, uns
 	__raw_writeb(value, (void __iomem *)port);
 }
 
-static void tx4938ide_tf_load(ide_drive_t *drive, struct ide_cmd *cmd)
+static void tx4938ide_tf_load(ide_drive_t *drive, struct ide_taskfile *tf,
+			      u8 valid)
 {
 	ide_hwif_t *hwif = drive->hwif;
 	struct ide_io_ports *io_ports = &hwif->io_ports;
-	struct ide_taskfile *tf = &cmd->hob;
-	u8 valid = cmd->valid.out.hob;
-
-	if (valid & IDE_VALID_FEATURE)
-		tx4938ide_outb(tf->feature, io_ports->feature_addr);
-	if (valid & IDE_VALID_NSECT)
-		tx4938ide_outb(tf->nsect, io_ports->nsect_addr);
-	if (valid & IDE_VALID_LBAL)
-		tx4938ide_outb(tf->lbal, io_ports->lbal_addr);
-	if (valid & IDE_VALID_LBAM)
-		tx4938ide_outb(tf->lbam, io_ports->lbam_addr);
-	if (valid & IDE_VALID_LBAH)
-		tx4938ide_outb(tf->lbah, io_ports->lbah_addr);
-
-	tf = &cmd->tf;
-	valid = cmd->valid.out.tf;
 
 	if (valid & IDE_VALID_FEATURE)
 		tx4938ide_outb(tf->feature, io_ports->feature_addr);
Index: linux-2.6/drivers/ide/tx4939ide.c
===================================================================
--- linux-2.6.orig/drivers/ide/tx4939ide.c
+++ linux-2.6/drivers/ide/tx4939ide.c
@@ -447,26 +447,11 @@ static void tx4939ide_outb(u8 value, uns
 	__raw_writeb(value, (void __iomem *)port);
 }
 
-static void tx4939ide_tf_load(ide_drive_t *drive, struct ide_cmd *cmd)
+static void tx4939ide_tf_load(ide_drive_t *drive, struct ide_taskfile *tf,
+			      u8 valid)
 {
 	ide_hwif_t *hwif = drive->hwif;
 	struct ide_io_ports *io_ports = &hwif->io_ports;
-	struct ide_taskfile *tf = &cmd->hob;
-	u8 valid = cmd->valid.out.hob;
-
-	if (valid & IDE_VALID_FEATURE)
-		tx4939ide_outb(tf->feature, io_ports->feature_addr);
-	if (valid & IDE_VALID_NSECT)
-		tx4939ide_outb(tf->nsect, io_ports->nsect_addr);
-	if (valid & IDE_VALID_LBAL)
-		tx4939ide_outb(tf->lbal, io_ports->lbal_addr);
-	if (valid & IDE_VALID_LBAM)
-		tx4939ide_outb(tf->lbam, io_ports->lbam_addr);
-	if (valid & IDE_VALID_LBAH)
-		tx4939ide_outb(tf->lbah, io_ports->lbah_addr);
-
-	tf = &cmd->tf;
-	valid = cmd->valid.out.tf;
 
 	if (valid & IDE_VALID_FEATURE)
 		tx4939ide_outb(tf->feature, io_ports->feature_addr);
@@ -568,11 +553,12 @@ static const struct ide_tp_ops tx4939ide
 
 #else	/* __LITTLE_ENDIAN */
 
-static void tx4939ide_tf_load(ide_drive_t *drive, struct ide_cmd *cmd)
+static void tx4939ide_tf_load(ide_drive_t *drive, struct ide_taskfile *tf,
+			      u8 valid)
 {
-	ide_tf_load(drive, cmd);
+	ide_tf_load(drive, tf, valid);
 
-	if (cmd->valid.out.tf & IDE_VALID_DEVICE)
+	if (valid & IDE_VALID_DEVICE)
 		tx4939ide_tf_load_fixup(drive);
 }
 
Index: linux-2.6/include/linux/ide.h
===================================================================
--- linux-2.6.orig/include/linux/ide.h
+++ linux-2.6/include/linux/ide.h
@@ -624,7 +624,7 @@ struct ide_tp_ops {
 	void	(*write_devctl)(struct hwif_s *, u8);
 
 	void	(*dev_select)(ide_drive_t *);
-	void	(*tf_load)(ide_drive_t *, struct ide_cmd *);
+	void	(*tf_load)(ide_drive_t *, struct ide_taskfile *, u8);
 	void	(*tf_read)(ide_drive_t *, struct ide_cmd *);
 
 	void	(*input_data)(ide_drive_t *, struct ide_cmd *,
@@ -1132,7 +1132,7 @@ u8 ide_read_altstatus(ide_hwif_t *);
 void ide_write_devctl(ide_hwif_t *, u8);
 
 void ide_dev_select(ide_drive_t *);
-void ide_tf_load(ide_drive_t *, struct ide_cmd *);
+void ide_tf_load(ide_drive_t *, struct ide_taskfile *, u8);
 void ide_tf_read(ide_drive_t *, struct ide_cmd *);
 
 void ide_input_data(ide_drive_t *, struct ide_cmd *, void *, unsigned int);

