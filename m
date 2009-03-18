From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH] ide: turn set_irq() method into write_devctl() method
Date: Wed, 18 Mar 2009 21:33:55 +0400
Message-ID: <200903182033.55699.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:37993 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751361AbZCRRdO (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 18 Mar 2009 13:33:14 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org

Turn set_irq() method with its software reset hack into write_devctl() method
(for just writing a value into the device control register) at last...

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

---
This patch is atop of the latest pata-2.6 series...

 drivers/ide/at91_ide.c     |    2 +-
 drivers/ide/au1xxx-ide.c   |    3 +--
 drivers/ide/falconide.c    |    3 +--
 drivers/ide/ide-eh.c       |    7 +++----
 drivers/ide/ide-h8300.c    |    3 +--
 drivers/ide/ide-io-std.c   |   16 +++-------------
 drivers/ide/ide-io.c       |    4 +++-
 drivers/ide/ide-iops.c     |    4 ++--
 drivers/ide/ide-pm.c       |    2 +-
 drivers/ide/ide-probe.c    |    6 +++---
 drivers/ide/ide-taskfile.c |    2 +-
 drivers/ide/ns87415.c      |    3 +--
 drivers/ide/pmac.c         |   14 ++------------
 drivers/ide/q40ide.c       |    3 +--
 drivers/ide/scc_pata.c     |   14 ++------------
 drivers/ide/sgiioc4.c      |    3 +--
 drivers/ide/tx4938ide.c    |    3 +--
 drivers/ide/tx4939ide.c    |    6 ++----
 include/linux/ide.h        |    6 ++----
 19 files changed, 32 insertions(+), 72 deletions(-)

Index: linux-2.6/drivers/ide/at91_ide.c
===================================================================
--- linux-2.6.orig/drivers/ide/at91_ide.c
+++ linux-2.6/drivers/ide/at91_ide.c
@@ -295,7 +295,7 @@ static const struct ide_tp_ops at91_ide_
 	.exec_command	= ide_exec_command,
 	.read_status	= ide_read_status,
 	.read_altstatus	= ide_read_altstatus,
-	.set_irq	= ide_set_irq,
+	.write_devctl	= ide_write_devctl,
 
 	.tf_load	= at91_ide_tf_load,
 	.tf_read	= at91_ide_tf_read,
Index: linux-2.6/drivers/ide/au1xxx-ide.c
===================================================================
--- linux-2.6.orig/drivers/ide/au1xxx-ide.c
+++ linux-2.6/drivers/ide/au1xxx-ide.c
@@ -467,8 +467,7 @@ static const struct ide_tp_ops au1xxx_tp
 	.exec_command		= ide_exec_command,
 	.read_status		= ide_read_status,
 	.read_altstatus		= ide_read_altstatus,
-
-	.set_irq		= ide_set_irq,
+	.write_devctl		= ide_write_devctl,
 
 	.tf_load		= ide_tf_load,
 	.tf_read		= ide_tf_read,
Index: linux-2.6/drivers/ide/falconide.c
===================================================================
--- linux-2.6.orig/drivers/ide/falconide.c
+++ linux-2.6/drivers/ide/falconide.c
@@ -89,8 +89,7 @@ static const struct ide_tp_ops falconide
 	.exec_command		= ide_exec_command,
 	.read_status		= ide_read_status,
 	.read_altstatus		= ide_read_altstatus,
-
-	.set_irq		= ide_set_irq,
+	.write_devctl		= ide_write_devctl,
 
 	.tf_load		= ide_tf_load,
 	.tf_read		= ide_tf_read,
Index: linux-2.6/drivers/ide/ide-eh.c
===================================================================
--- linux-2.6.orig/drivers/ide/ide-eh.c
+++ linux-2.6/drivers/ide/ide-eh.c
@@ -401,15 +401,14 @@ static ide_startstop_t do_reset1(ide_dri
 	 * immediate interrupt due to the edge transition it produces.
 	 * This single interrupt gives us a "fast poll" for drives that
 	 * recover from reset very quickly, saving us the first 50ms wait time.
-	 *
-	 * TODO: add ->softreset method and stop abusing ->set_irq
 	 */
 	/* set SRST and nIEN */
-	tp_ops->set_irq(hwif, 4);
+	tp_ops->write_devctl(hwif, ATA_SRST | ATA_NIEN | ATA_DEVCTL_OBS);
 	/* more than enough time */
 	udelay(10);
 	/* clear SRST, leave nIEN (unless device is on the quirk list) */
-	tp_ops->set_irq(hwif, drive->quirk_list == 2);
+	tp_ops->write_devctl(hwif, (drive->quirk_list == 2 ? 0 : ATA_NIEN) |
+			     ATA_DEVCTL_OBS);
 	/* more than enough time */
 	udelay(10);
 	hwif->poll_timeout = jiffies + WAIT_WORSTCASE;
Index: linux-2.6/drivers/ide/ide-h8300.c
===================================================================
--- linux-2.6.orig/drivers/ide/ide-h8300.c
+++ linux-2.6/drivers/ide/ide-h8300.c
@@ -159,8 +159,7 @@ static const struct ide_tp_ops h8300_tp_
 	.exec_command		= ide_exec_command,
 	.read_status		= ide_read_status,
 	.read_altstatus		= ide_read_altstatus,
-
-	.set_irq		= ide_set_irq,
+	.write_devctl		= ide_write_devctl,
 
 	.tf_load		= h8300_tf_load,
 	.tf_read		= h8300_tf_read,
Index: linux-2.6/drivers/ide/ide-io-std.c
===================================================================
--- linux-2.6.orig/drivers/ide/ide-io-std.c
+++ linux-2.6/drivers/ide/ide-io-std.c
@@ -64,23 +64,14 @@ u8 ide_read_altstatus(ide_hwif_t *hwif)
 }
 EXPORT_SYMBOL_GPL(ide_read_altstatus);
 
-void ide_set_irq(ide_hwif_t *hwif, int on)
+void ide_write_devctl(ide_hwif_t *hwif, u8 ctl)
 {
-	u8 ctl = ATA_DEVCTL_OBS;
-
-	if (on == 4) { /* hack for SRST */
-		ctl |= 4;
-		on &= ~4;
-	}
-
-	ctl |= on ? 0 : 2;
-
 	if (hwif->host_flags & IDE_HFLAG_MMIO)
 		writeb(ctl, (void __iomem *)hwif->io_ports.ctl_addr);
 	else
 		outb(ctl, hwif->io_ports.ctl_addr);
 }
-EXPORT_SYMBOL_GPL(ide_set_irq);
+EXPORT_SYMBOL_GPL(ide_write_devctl);
 
 void ide_tf_load(ide_drive_t *drive, struct ide_cmd *cmd)
 {
@@ -312,8 +303,7 @@ const struct ide_tp_ops default_tp_ops =
 	.exec_command		= ide_exec_command,
 	.read_status		= ide_read_status,
 	.read_altstatus		= ide_read_altstatus,
-
-	.set_irq		= ide_set_irq,
+	.write_devctl		= ide_write_devctl,
 
 	.tf_load		= ide_tf_load,
 	.tf_read		= ide_tf_read,
Index: linux-2.6/drivers/ide/ide-io.c
===================================================================
--- linux-2.6.orig/drivers/ide/ide-io.c
+++ linux-2.6/drivers/ide/ide-io.c
@@ -495,7 +495,9 @@ repeat:
 			 * quirk_list may not like intr setups/cleanups
 			 */
 			if (prev_port && prev_port->cur_dev->quirk_list == 0)
-				prev_port->tp_ops->set_irq(prev_port, 0);
+				prev_port->tp_ops->write_devctl(prev_port,
+								ATA_NIEN |
+								ATA_DEVCTL_OBS);
 
 			hwif->host->cur_port = hwif;
 		}
Index: linux-2.6/drivers/ide/ide-iops.c
===================================================================
--- linux-2.6.orig/drivers/ide/ide-iops.c
+++ linux-2.6/drivers/ide/ide-iops.c
@@ -360,7 +360,7 @@ int ide_config_drive_speed(ide_drive_t *
 	SELECT_DRIVE(drive);
 	SELECT_MASK(drive, 1);
 	udelay(1);
-	tp_ops->set_irq(hwif, 0);
+	tp_ops->write_devctl(hwif, ATA_NIEN | ATA_DEVCTL_OBS);
 
 	memset(&cmd, 0, sizeof(cmd));
 	cmd.tf_flags = IDE_TFLAG_OUT_FEATURE | IDE_TFLAG_OUT_NSECT;
@@ -372,7 +372,7 @@ int ide_config_drive_speed(ide_drive_t *
 	tp_ops->exec_command(hwif, ATA_CMD_SET_FEATURES);
 
 	if (drive->quirk_list == 2)
-		tp_ops->set_irq(hwif, 1);
+		tp_ops->write_devctl(hwif, ATA_DEVCTL_OBS);
 
 	error = __ide_wait_stat(drive, drive->ready_stat,
 				ATA_BUSY | ATA_DRQ | ATA_ERR,
Index: linux-2.6/drivers/ide/ide-pm.c
===================================================================
--- linux-2.6.orig/drivers/ide/ide-pm.c
+++ linux-2.6/drivers/ide/ide-pm.c
@@ -233,7 +233,7 @@ void ide_check_pm_state(ide_drive_t *dri
 		if (rc)
 			printk(KERN_WARNING "%s: bus not ready on wakeup\n", drive->name);
 		SELECT_DRIVE(drive);
-		hwif->tp_ops->set_irq(hwif, 1);
+		hwif->tp_ops->write_devctl(hwif, ATA_DEVCTL_OBS);
 		rc = ide_wait_not_busy(hwif, 100000);
 		if (rc)
 			printk(KERN_WARNING "%s: drive not ready on wakeup\n", drive->name);
Index: linux-2.6/drivers/ide/ide-probe.c
===================================================================
--- linux-2.6.orig/drivers/ide/ide-probe.c
+++ linux-2.6/drivers/ide/ide-probe.c
@@ -260,7 +260,7 @@ int ide_dev_read_id(ide_drive_t *drive, 
 	 * during the identify phase that the IRQ handler isn't expecting.
 	 */
 	if (io_ports->ctl_addr)
-		tp_ops->set_irq(hwif, 0);
+		tp_ops->write_devctl(hwif, ATA_NIEN | ATA_DEVCTL_OBS);
 
 	/* take a deep breath */
 	msleep(50);
@@ -628,7 +628,7 @@ static int ide_port_wait_ready(ide_hwif_
 		if ((drive->dev_flags & IDE_DFLAG_NOPROBE) == 0 ||
 		    (drive->dev_flags & IDE_DFLAG_PRESENT)) {
 			SELECT_DRIVE(drive);
-			hwif->tp_ops->set_irq(hwif, 1);
+			hwif->tp_ops->write_devctl(hwif, ATA_DEVCTL_OBS);
 			mdelay(2);
 			rc = ide_wait_not_busy(hwif, 35000);
 			if (rc)
@@ -845,7 +845,7 @@ static int init_irq (ide_hwif_t *hwif)
 		irq_handler = ide_intr;
 
 	if (io_ports->ctl_addr)
-		hwif->tp_ops->set_irq(hwif, 1);
+		hwif->tp_ops->write_devctl(hwif, ATA_DEVCTL_OBS);
 
 	if (request_irq(hwif->irq, irq_handler, sa, hwif->name, hwif))
 		goto out_up;
Index: linux-2.6/drivers/ide/ide-taskfile.c
===================================================================
--- linux-2.6.orig/drivers/ide/ide-taskfile.c
+++ linux-2.6/drivers/ide/ide-taskfile.c
@@ -80,7 +80,7 @@ ide_startstop_t do_rw_taskfile(ide_drive
 
 	if ((cmd->tf_flags & IDE_TFLAG_DMA_PIO_FALLBACK) == 0) {
 		ide_tf_dump(drive->name, tf);
-		tp_ops->set_irq(hwif, 1);
+		tp_ops->write_devctl(hwif, ATA_DEVCTL_OBS);
 		SELECT_MASK(drive, 0);
 		tp_ops->tf_load(drive, cmd);
 	}
Index: linux-2.6/drivers/ide/ns87415.c
===================================================================
--- linux-2.6.orig/drivers/ide/ns87415.c
+++ linux-2.6/drivers/ide/ns87415.c
@@ -109,8 +109,7 @@ static const struct ide_tp_ops superio_t
 	.exec_command		= ide_exec_command,
 	.read_status		= superio_read_status,
 	.read_altstatus		= ide_read_altstatus,
-
-	.set_irq		= ide_set_irq,
+	.write_devctl		= ide_write_devctl,
 
 	.tf_load		= ide_tf_load,
 	.tf_read		= superio_tf_read,
Index: linux-2.6/drivers/ide/pmac.c
===================================================================
--- linux-2.6.orig/drivers/ide/pmac.c
+++ linux-2.6/drivers/ide/pmac.c
@@ -476,17 +476,8 @@ static void pmac_exec_command(ide_hwif_t
 				     + IDE_TIMING_CONFIG));
 }
 
-static void pmac_set_irq(ide_hwif_t *hwif, int on)
+static void pmac_write_devctl(ide_hwif_t *hwif, u8 ctl)
 {
-	u8 ctl = ATA_DEVCTL_OBS;
-
-	if (on == 4) { /* hack for SRST */
-		ctl |= 4;
-		on &= ~4;
-	}
-
-	ctl |= on ? 0 : 2;
-
 	writeb(ctl, (void __iomem *)hwif->io_ports.ctl_addr);
 	(void)readl((void __iomem *)(hwif->io_ports.data_addr
 				     + IDE_TIMING_CONFIG));
@@ -954,8 +945,7 @@ static const struct ide_tp_ops pmac_tp_o
 	.exec_command		= pmac_exec_command,
 	.read_status		= ide_read_status,
 	.read_altstatus		= ide_read_altstatus,
-
-	.set_irq		= pmac_set_irq,
+	.write_devctl		= pmac_write_devctl,
 
 	.tf_load		= ide_tf_load,
 	.tf_read		= ide_tf_read,
Index: linux-2.6/drivers/ide/q40ide.c
===================================================================
--- linux-2.6.orig/drivers/ide/q40ide.c
+++ linux-2.6/drivers/ide/q40ide.c
@@ -99,8 +99,7 @@ static const struct ide_tp_ops q40ide_tp
 	.exec_command		= ide_exec_command,
 	.read_status		= ide_read_status,
 	.read_altstatus		= ide_read_altstatus,
-
-	.set_irq		= ide_set_irq,
+	.write_devctl		= ide_write_devctl,
 
 	.tf_load		= ide_tf_load,
 	.tf_read		= ide_tf_read,
Index: linux-2.6/drivers/ide/scc_pata.c
===================================================================
--- linux-2.6.orig/drivers/ide/scc_pata.c
+++ linux-2.6/drivers/ide/scc_pata.c
@@ -148,17 +148,8 @@ static u8 scc_dma_sff_read_status(ide_hw
 	return (u8)in_be32((void *)(hwif->dma_base + 4));
 }
 
-static void scc_set_irq(ide_hwif_t *hwif, int on)
+static void scc_write_devctl(ide_hwif_t *hwif, u8 ctl)
 {
-	u8 ctl = ATA_DEVCTL_OBS;
-
-	if (on == 4) { /* hack for SRST */
-		ctl |= 4;
-		on &= ~4;
-	}
-
-	ctl |= on ? 0 : 2;
-
 	out_be32((void *)hwif->io_ports.ctl_addr, ctl);
 	eieio();
 	in_be32((void *)(hwif->dma_base + 0x01c));
@@ -843,8 +834,7 @@ static const struct ide_tp_ops scc_tp_op
 	.exec_command		= scc_exec_command,
 	.read_status		= scc_read_status,
 	.read_altstatus		= scc_read_altstatus,
-
-	.set_irq		= scc_set_irq,
+	.write_devctl		= scc_write_devctl,
 
 	.tf_load		= scc_tf_load,
 	.tf_read		= scc_tf_read,
Index: linux-2.6/drivers/ide/sgiioc4.c
===================================================================
--- linux-2.6.orig/drivers/ide/sgiioc4.c
+++ linux-2.6/drivers/ide/sgiioc4.c
@@ -503,8 +503,7 @@ static const struct ide_tp_ops sgiioc4_t
 	.exec_command		= ide_exec_command,
 	.read_status		= sgiioc4_read_status,
 	.read_altstatus		= ide_read_altstatus,
-
-	.set_irq		= ide_set_irq,
+	.write_devctl		= ide_write_devctl,
 
 	.tf_load		= ide_tf_load,
 	.tf_read		= ide_tf_read,
Index: linux-2.6/drivers/ide/tx4938ide.c
===================================================================
--- linux-2.6.orig/drivers/ide/tx4938ide.c
+++ linux-2.6/drivers/ide/tx4938ide.c
@@ -204,8 +204,7 @@ static const struct ide_tp_ops tx4938ide
 	.exec_command		= ide_exec_command,
 	.read_status		= ide_read_status,
 	.read_altstatus		= ide_read_altstatus,
-
-	.set_irq		= ide_set_irq,
+	.write_devctl		= ide_write_devctl,
 
 	.tf_load		= tx4938ide_tf_load,
 	.tf_read		= tx4938ide_tf_read,
Index: linux-2.6/drivers/ide/tx4939ide.c
===================================================================
--- linux-2.6.orig/drivers/ide/tx4939ide.c
+++ linux-2.6/drivers/ide/tx4939ide.c
@@ -571,8 +571,7 @@ static const struct ide_tp_ops tx4939ide
 	.exec_command		= ide_exec_command,
 	.read_status		= ide_read_status,
 	.read_altstatus		= ide_read_altstatus,
-
-	.set_irq		= ide_set_irq,
+	.write_devctl		= ide_write_devctl,
 
 	.tf_load		= tx4939ide_tf_load,
 	.tf_read		= tx4939ide_tf_read,
@@ -595,8 +594,7 @@ static const struct ide_tp_ops tx4939ide
 	.exec_command		= ide_exec_command,
 	.read_status		= ide_read_status,
 	.read_altstatus		= ide_read_altstatus,
-
-	.set_irq		= ide_set_irq,
+	.write_devctl		= ide_write_devctl,
 
 	.tf_load		= tx4939ide_tf_load,
 	.tf_read		= ide_tf_read,
Index: linux-2.6/include/linux/ide.h
===================================================================
--- linux-2.6.orig/include/linux/ide.h
+++ linux-2.6/include/linux/ide.h
@@ -655,8 +655,7 @@ struct ide_tp_ops {
 	void	(*exec_command)(struct hwif_s *, u8);
 	u8	(*read_status)(struct hwif_s *);
 	u8	(*read_altstatus)(struct hwif_s *);
-
-	void	(*set_irq)(struct hwif_s *, int);
+	void	(*write_devctl)(struct hwif_s *, u8);
 
 	void	(*tf_load)(ide_drive_t *, struct ide_cmd *);
 	void	(*tf_read)(ide_drive_t *, struct ide_cmd *);
@@ -1165,8 +1164,7 @@ void ide_tf_dump(const char *, struct id
 void ide_exec_command(ide_hwif_t *, u8);
 u8 ide_read_status(ide_hwif_t *);
 u8 ide_read_altstatus(ide_hwif_t *);
-
-void ide_set_irq(ide_hwif_t *, int);
+void ide_write_devctl(ide_hwif_t *, u8);
 
 void ide_tf_load(ide_drive_t *, struct ide_cmd *);
 void ide_tf_read(ide_drive_t *, struct ide_cmd *);

