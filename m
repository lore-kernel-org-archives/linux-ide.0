From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH] ide: turn selectproc() method into dev_select() method (take 4)
Date: Tue, 24 Mar 2009 22:06:59 +0400
Message-ID: <200903242106.59175.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:58220 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753976AbZCXSj3 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 24 Mar 2009 14:39:29 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org, benh@kernel.crashing.org, petkovbb@gmail.com

Turn selectproc() method into dev_select() method by teaching it to write to the
device register and moving it from 'struct ide_port_ops' to 'struct ide_tp_ops'.

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

---
Changes since the 3rd take:
- added dev_select() method reference to 'superio_tp_ops' in ns87415.c...

 drivers/ide/au1xxx-ide.c |    1 
 drivers/ide/falconide.c  |    1 
 drivers/ide/ht6560b.c    |   20 ++++++++++++++--
 drivers/ide/ide-h8300.c  |    1 
 drivers/ide/ide-io-std.c |   13 ++++++++++
 drivers/ide/ide-iops.c   |   12 ---------
 drivers/ide/ns87415.c    |   25 ++++++++++++++++----
 drivers/ide/pmac.c       |   58 +++++++++++++++++++++++++++++++----------------
 drivers/ide/q40ide.c     |    1 
 drivers/ide/qd65xx.c     |   21 ++++++++++++++---
 drivers/ide/scc_pata.c   |    1 
 drivers/ide/sgiioc4.c    |    1 
 drivers/ide/trm290.c     |   20 ++++++++++++----
 drivers/ide/tx4938ide.c  |    1 
 drivers/ide/tx4939ide.c  |    3 +-
 include/linux/ide.h      |    5 +---
 16 files changed, 136 insertions(+), 48 deletions(-)

Index: linux-2.6/drivers/ide/au1xxx-ide.c
===================================================================
--- linux-2.6.orig/drivers/ide/au1xxx-ide.c
+++ linux-2.6/drivers/ide/au1xxx-ide.c
@@ -469,6 +469,7 @@ static const struct ide_tp_ops au1xxx_tp
 	.read_altstatus		= ide_read_altstatus,
 	.write_devctl		= ide_write_devctl,
 
+	.dev_select		= ide_dev_select,
 	.tf_load		= ide_tf_load,
 	.tf_read		= ide_tf_read,
 
Index: linux-2.6/drivers/ide/falconide.c
===================================================================
--- linux-2.6.orig/drivers/ide/falconide.c
+++ linux-2.6/drivers/ide/falconide.c
@@ -91,6 +91,7 @@ static const struct ide_tp_ops falconide
 	.read_altstatus		= ide_read_altstatus,
 	.write_devctl		= ide_write_devctl,
 
+	.dev_select		= ide_dev_select,
 	.tf_load		= ide_tf_load,
 	.tf_read		= ide_tf_read,
 
Index: linux-2.6/drivers/ide/ht6560b.c
===================================================================
--- linux-2.6.orig/drivers/ide/ht6560b.c
+++ linux-2.6/drivers/ide/ht6560b.c
@@ -103,7 +103,7 @@
 /*
  * This routine is invoked from ide.c to prepare for access to a given drive.
  */
-static void ht6560b_selectproc (ide_drive_t *drive)
+static void ht6560b_dev_select(ide_drive_t *drive)
 {
 	ide_hwif_t *hwif = drive->hwif;
 	unsigned long flags;
@@ -143,6 +143,8 @@ static void ht6560b_selectproc (ide_driv
 #endif
 	}
 	local_irq_restore(flags);
+
+	outb(drive->select | ATA_DEVICE_OBS, hwif->io_ports.device_addr);
 }
 
 /*
@@ -305,15 +307,29 @@ static int probe_ht6560b;
 module_param_named(probe, probe_ht6560b, bool, 0);
 MODULE_PARM_DESC(probe, "probe for HT6560B chipset");
 
+static const struct ide_tp_ops ht6560b_tp_ops = {
+	.exec_command		= ide_exec_command,
+	.read_status		= ide_read_status,
+	.read_altstatus		= ide_read_altstatus,
+	.write_devctl		= ide_write_devctl,
+
+	.dev_select		= ht6560b_dev_select,
+	.tf_load		= ide_tf_load,
+	.tf_read		= ide_tf_read,
+
+	.input_data		= ide_input_data,
+	.output_data		= ide_output_data,
+};
+
 static const struct ide_port_ops ht6560b_port_ops = {
 	.init_dev		= ht6560b_init_dev,
 	.set_pio_mode		= ht6560b_set_pio_mode,
-	.selectproc		= ht6560b_selectproc,
 };
 
 static const struct ide_port_info ht6560b_port_info __initdata = {
 	.name			= DRV_NAME,
 	.chipset		= ide_ht6560b,
+	.tp_ops 		= &ht6560b_tp_ops,
 	.port_ops		= &ht6560b_port_ops,
 	.host_flags		= IDE_HFLAG_SERIALIZE | /* is this needed? */
 				  IDE_HFLAG_NO_DMA |
Index: linux-2.6/drivers/ide/ide-h8300.c
===================================================================
--- linux-2.6.orig/drivers/ide/ide-h8300.c
+++ linux-2.6/drivers/ide/ide-h8300.c
@@ -151,6 +151,7 @@ static const struct ide_tp_ops h8300_tp_
 	.read_altstatus		= ide_read_altstatus,
 	.write_devctl		= ide_write_devctl,
 
+	.dev_select		= ide_dev_select,
 	.tf_load		= h8300_tf_load,
 	.tf_read		= h8300_tf_read,
 
Index: linux-2.6/drivers/ide/ide-io-std.c
===================================================================
--- linux-2.6.orig/drivers/ide/ide-io-std.c
+++ linux-2.6/drivers/ide/ide-io-std.c
@@ -73,6 +73,18 @@ void ide_write_devctl(ide_hwif_t *hwif, 
 }
 EXPORT_SYMBOL_GPL(ide_write_devctl);
 
+void ide_dev_select(ide_drive_t *drive)
+{
+	ide_hwif_t *hwif = drive->hwif;
+	u8 select = drive->select | ATA_DEVICE_OBS;
+
+	if (hwif->host_flags & IDE_HFLAG_MMIO)
+		writeb(select, (void __iomem *)hwif->io_ports.device_addr);
+	else
+		outb(select, hwif->io_ports.device_addr);
+}
+EXPORT_SYMBOL_GPL(ide_dev_select);
+
 void ide_tf_load(ide_drive_t *drive, struct ide_cmd *cmd)
 {
 	ide_hwif_t *hwif = drive->hwif;
@@ -280,6 +292,7 @@ const struct ide_tp_ops default_tp_ops =
 	.read_altstatus		= ide_read_altstatus,
 	.write_devctl		= ide_write_devctl,
 
+	.dev_select		= ide_dev_select,
 	.tf_load		= ide_tf_load,
 	.tf_read		= ide_tf_read,
 
Index: linux-2.6/drivers/ide/ide-iops.c
===================================================================
--- linux-2.6.orig/drivers/ide/ide-iops.c
+++ linux-2.6/drivers/ide/ide-iops.c
@@ -29,17 +29,7 @@
 
 void SELECT_DRIVE(ide_drive_t *drive)
 {
-	ide_hwif_t *hwif = drive->hwif;
-	const struct ide_port_ops *port_ops = hwif->port_ops;
-	struct ide_cmd cmd;
-
-	if (port_ops && port_ops->selectproc)
-		port_ops->selectproc(drive);
-
-	memset(&cmd, 0, sizeof(cmd));
-	cmd.tf_flags = IDE_TFLAG_OUT_DEVICE;
-
-	drive->hwif->tp_ops->tf_load(drive, &cmd);
+	drive->hwif->tp_ops->dev_select(drive);
 }
 
 void SELECT_MASK(ide_drive_t *drive, int mask)
Index: linux-2.6/drivers/ide/ns87415.c
===================================================================
--- linux-2.6.orig/drivers/ide/ns87415.c
+++ linux-2.6/drivers/ide/ns87415.c
@@ -98,12 +98,15 @@ static void superio_tf_read(ide_drive_t 
 	}
 }
 
+static void ns87415_dev_select(ide_drive_t *drive);
+
 static const struct ide_tp_ops superio_tp_ops = {
 	.exec_command		= ide_exec_command,
 	.read_status		= superio_read_status,
 	.read_altstatus		= ide_read_altstatus,
 	.write_devctl		= ide_write_devctl,
 
+	.dev_select		= ns87415_dev_select,
 	.tf_load		= ide_tf_load,
 	.tf_read		= superio_tf_read,
 
@@ -182,10 +185,12 @@ static void ns87415_prepare_drive (ide_d
 	local_irq_restore(flags);
 }
 
-static void ns87415_selectproc (ide_drive_t *drive)
+static void ns87415_dev_select(ide_drive_t *drive)
 {
 	ns87415_prepare_drive(drive,
 			      !!(drive->dev_flags & IDE_DFLAG_USING_DMA));
+
+	outb(drive->select | ATA_DEVICE_OBS, drive->hwif->io_ports.device_addr);
 }
 
 static void ns87415_dma_start(ide_drive_t *drive)
@@ -229,7 +234,7 @@ static void __devinit init_hwif_ns87415 
 	 * Also, leave IRQ masked during drive probing, to prevent infinite
 	 * interrupts from a potentially floating INTA..
 	 *
-	 * IRQs get unmasked in selectproc when drive is first used.
+	 * IRQs get unmasked in dev_select() when drive is first used.
 	 */
 	(void) pci_read_config_dword(dev, 0x40, &ctrl);
 	(void) pci_read_config_byte(dev, 0x09, &progif);
@@ -281,8 +286,18 @@ static void __devinit init_hwif_ns87415 
 	outb(0x60, hwif->dma_base + ATA_DMA_STATUS);
 }
 
-static const struct ide_port_ops ns87415_port_ops = {
-	.selectproc		= ns87415_selectproc,
+static const struct ide_tp_ops ns87415_tp_ops = {
+	.exec_command		= ide_exec_command,
+	.read_status		= ide_read_status,
+	.read_altstatus		= ide_read_altstatus,
+	.write_devctl		= ide_write_devctl,
+
+	.dev_select		= ns87415_dev_select,
+	.tf_load		= ide_tf_load,
+	.tf_read		= ide_tf_read,
+
+	.input_data		= ide_input_data,
+	.output_data		= ide_output_data,
 };
 
 static const struct ide_dma_ops ns87415_dma_ops = {
@@ -299,7 +314,7 @@ static const struct ide_dma_ops ns87415_
 static const struct ide_port_info ns87415_chipset __devinitdata = {
 	.name		= DRV_NAME,
 	.init_hwif	= init_hwif_ns87415,
-	.port_ops	= &ns87415_port_ops,
+	.tp_ops 	= &ns87415_tp_ops,
 	.dma_ops	= &ns87415_dma_ops,
 	.host_flags	= IDE_HFLAG_TRUST_BIOS_FOR_DMA |
 			  IDE_HFLAG_NO_ATAPI_DMA,
Index: linux-2.6/drivers/ide/pmac.c
===================================================================
--- linux-2.6.orig/drivers/ide/pmac.c
+++ linux-2.6/drivers/ide/pmac.c
@@ -404,8 +404,6 @@ kauai_lookup_timing(struct kauai_timing*
 #define IDE_WAKEUP_DELAY	(1*HZ)
 
 static int pmac_ide_init_dma(ide_hwif_t *, const struct ide_port_info *);
-static void pmac_ide_selectproc(ide_drive_t *drive);
-static void pmac_ide_kauai_selectproc(ide_drive_t *drive);
 
 #define PMAC_IDE_REG(x) \
 	((void __iomem *)((drive)->hwif->io_ports.data_addr + (x)))
@@ -415,8 +413,7 @@ static void pmac_ide_kauai_selectproc(id
  * timing register when selecting that unit. This version is for
  * ASICs with a single timing register
  */
-static void
-pmac_ide_selectproc(ide_drive_t *drive)
+static void pmac_ide_apply_timings(ide_drive_t *drive)
 {
 	ide_hwif_t *hwif = drive->hwif;
 	pmac_ide_hwif_t *pmif =
@@ -434,8 +431,7 @@ pmac_ide_selectproc(ide_drive_t *drive)
  * timing register when selecting that unit. This version is for
  * ASICs with a dual timing register (Kauai)
  */
-static void
-pmac_ide_kauai_selectproc(ide_drive_t *drive)
+static void pmac_ide_kauai_apply_timings(ide_drive_t *drive)
 {
 	ide_hwif_t *hwif = drive->hwif;
 	pmac_ide_hwif_t *pmif =
@@ -464,9 +460,25 @@ pmac_ide_do_update_timings(ide_drive_t *
 	if (pmif->kind == controller_sh_ata6 ||
 	    pmif->kind == controller_un_ata6 ||
 	    pmif->kind == controller_k2_ata6)
-		pmac_ide_kauai_selectproc(drive);
+		pmac_ide_kauai_apply_timings(drive);
 	else
-		pmac_ide_selectproc(drive);
+		pmac_ide_apply_timings(drive);
+}
+
+static void pmac_dev_select(ide_drive_t *drive)
+{
+	pmac_ide_apply_timings(drive);
+
+	writeb(drive->select | ATA_DEVICE_OBS,
+	       (void __iomem *)drive->hwif->io_ports.device_addr);
+}
+
+static void pmac_kauai_dev_select(ide_drive_t *drive)
+{
+	pmac_ide_kauai_apply_timings(drive);
+
+	writeb(drive->select | ATA_DEVICE_OBS,
+	       (void __iomem *)drive->hwif->io_ports.device_addr);
 }
 
 static void pmac_exec_command(ide_hwif_t *hwif, u8 cmd)
@@ -947,6 +959,7 @@ static const struct ide_tp_ops pmac_tp_o
 	.read_altstatus		= ide_read_altstatus,
 	.write_devctl		= pmac_write_devctl,
 
+	.dev_select		= pmac_dev_select,
 	.tf_load		= ide_tf_load,
 	.tf_read		= ide_tf_read,
 
@@ -954,19 +967,24 @@ static const struct ide_tp_ops pmac_tp_o
 	.output_data		= ide_output_data,
 };
 
-static const struct ide_port_ops pmac_ide_ata6_port_ops = {
-	.init_dev		= pmac_ide_init_dev,
-	.set_pio_mode		= pmac_ide_set_pio_mode,
-	.set_dma_mode		= pmac_ide_set_dma_mode,
-	.selectproc		= pmac_ide_kauai_selectproc,
-	.cable_detect		= pmac_ide_cable_detect,
+static const struct ide_tp_ops pmac_ata6_tp_ops = {
+	.exec_command		= pmac_exec_command,
+	.read_status		= ide_read_status,
+	.read_altstatus		= ide_read_altstatus,
+	.write_devctl		= pmac_write_devctl,
+
+	.dev_select		= pmac_kauai_dev_select,
+	.tf_load		= ide_tf_load,
+	.tf_read		= ide_tf_read,
+
+	.input_data		= ide_input_data,
+	.output_data		= ide_output_data,
 };
 
 static const struct ide_port_ops pmac_ide_ata4_port_ops = {
 	.init_dev		= pmac_ide_init_dev,
 	.set_pio_mode		= pmac_ide_set_pio_mode,
 	.set_dma_mode		= pmac_ide_set_dma_mode,
-	.selectproc		= pmac_ide_selectproc,
 	.cable_detect		= pmac_ide_cable_detect,
 };
 
@@ -974,7 +992,6 @@ static const struct ide_port_ops pmac_id
 	.init_dev		= pmac_ide_init_dev,
 	.set_pio_mode		= pmac_ide_set_pio_mode,
 	.set_dma_mode		= pmac_ide_set_dma_mode,
-	.selectproc		= pmac_ide_selectproc,
 };
 
 static const struct ide_dma_ops pmac_dma_ops;
@@ -1011,15 +1028,18 @@ static int __devinit pmac_ide_setup_devi
 	pmif->broken_dma = pmif->broken_dma_warn = 0;
 	if (of_device_is_compatible(np, "shasta-ata")) {
 		pmif->kind = controller_sh_ata6;
-		d.port_ops = &pmac_ide_ata6_port_ops;
+		d.tp_ops = &pmac_ata6_tp_ops;
+		d.port_ops = &pmac_ide_ata4_port_ops;
 		d.udma_mask = ATA_UDMA6;
 	} else if (of_device_is_compatible(np, "kauai-ata")) {
 		pmif->kind = controller_un_ata6;
-		d.port_ops = &pmac_ide_ata6_port_ops;
+		d.tp_ops = &pmac_ata6_tp_ops;
+		d.port_ops = &pmac_ide_ata4_port_ops;
 		d.udma_mask = ATA_UDMA5;
 	} else if (of_device_is_compatible(np, "K2-UATA")) {
 		pmif->kind = controller_k2_ata6;
-		d.port_ops = &pmac_ide_ata6_port_ops;
+		d.tp_ops = &pmac_ata6_tp_ops;
+		d.port_ops = &pmac_ide_ata4_port_ops;
 		d.udma_mask = ATA_UDMA5;
 	} else if (of_device_is_compatible(np, "keylargo-ata")) {
 		if (strcmp(np->name, "ata-4") == 0) {
Index: linux-2.6/drivers/ide/q40ide.c
===================================================================
--- linux-2.6.orig/drivers/ide/q40ide.c
+++ linux-2.6/drivers/ide/q40ide.c
@@ -101,6 +101,7 @@ static const struct ide_tp_ops q40ide_tp
 	.read_altstatus		= ide_read_altstatus,
 	.write_devctl		= ide_write_devctl,
 
+	.dev_select		= ide_dev_select,
 	.tf_load		= ide_tf_load,
 	.tf_read		= ide_tf_read,
 
Index: linux-2.6/drivers/ide/qd65xx.c
===================================================================
--- linux-2.6.orig/drivers/ide/qd65xx.c
+++ linux-2.6/drivers/ide/qd65xx.c
@@ -90,13 +90,15 @@ static int timings[4]={-1,-1,-1,-1}; /* 
  * This routine is invoked to prepare for access to a given drive.
  */
 
-static void qd65xx_select(ide_drive_t *drive)
+static void qd65xx_dev_select(ide_drive_t *drive)
 {
 	u8 index = ((	(QD_TIMREG(drive)) & 0x80 ) >> 7) |
 			(QD_TIMREG(drive) & 0x02);
 
 	if (timings[index] != QD_TIMING(drive))
 		outb(timings[index] = QD_TIMING(drive), QD_TIMREG(drive));
+
+	outb(drive->select | ATA_DEVICE_OBS, drive->hwif->io_ports.device_addr);
 }
 
 /*
@@ -309,20 +311,33 @@ static void __init qd6580_init_dev(ide_d
 	drive->drive_data = (drive->dn & 1) ? t2 : t1;
 }
 
+static const struct ide_tp_ops qd65xx_tp_ops = {
+	.exec_command		= ide_exec_command,
+	.read_status		= ide_read_status,
+	.read_altstatus		= ide_read_altstatus,
+	.write_devctl		= ide_write_devctl,
+
+	.dev_select		= qd65xx_dev_select,
+	.tf_load		= ide_tf_load,
+	.tf_read		= ide_tf_read,
+
+	.input_data		= ide_input_data,
+	.output_data		= ide_output_data,
+};
+
 static const struct ide_port_ops qd6500_port_ops = {
 	.init_dev		= qd6500_init_dev,
 	.set_pio_mode		= qd6500_set_pio_mode,
-	.selectproc		= qd65xx_select,
 };
 
 static const struct ide_port_ops qd6580_port_ops = {
 	.init_dev		= qd6580_init_dev,
 	.set_pio_mode		= qd6580_set_pio_mode,
-	.selectproc		= qd65xx_select,
 };
 
 static const struct ide_port_info qd65xx_port_info __initdata = {
 	.name			= DRV_NAME,
+	.tp_ops 		= &qd65xx_tp_ops,
 	.chipset		= ide_qd65xx,
 	.host_flags		= IDE_HFLAG_IO_32BIT |
 				  IDE_HFLAG_NO_DMA,
Index: linux-2.6/drivers/ide/scc_pata.c
===================================================================
--- linux-2.6.orig/drivers/ide/scc_pata.c
+++ linux-2.6/drivers/ide/scc_pata.c
@@ -825,6 +825,7 @@ static const struct ide_tp_ops scc_tp_op
 	.read_altstatus		= scc_read_altstatus,
 	.write_devctl		= scc_write_devctl,
 
+	.dev_select		= ide_dev_select,
 	.tf_load		= scc_tf_load,
 	.tf_read		= scc_tf_read,
 
Index: linux-2.6/drivers/ide/sgiioc4.c
===================================================================
--- linux-2.6.orig/drivers/ide/sgiioc4.c
+++ linux-2.6/drivers/ide/sgiioc4.c
@@ -505,6 +505,7 @@ static const struct ide_tp_ops sgiioc4_t
 	.read_altstatus		= ide_read_altstatus,
 	.write_devctl		= ide_write_devctl,
 
+	.dev_select		= ide_dev_select,
 	.tf_load		= ide_tf_load,
 	.tf_read		= ide_tf_read,
 
Index: linux-2.6/drivers/ide/trm290.c
===================================================================
--- linux-2.6.orig/drivers/ide/trm290.c
+++ linux-2.6/drivers/ide/trm290.c
@@ -171,9 +171,11 @@ static void trm290_prepare_drive (ide_dr
 	local_irq_restore(flags);
 }
 
-static void trm290_selectproc (ide_drive_t *drive)
+static void trm290_dev_select(ide_drive_t *drive)
 {
 	trm290_prepare_drive(drive, !!(drive->dev_flags & IDE_DFLAG_USING_DMA));
+
+	outb(drive->select | ATA_DEVICE_OBS, drive->hwif->io_ports.device_addr);
 }
 
 static int trm290_dma_check(ide_drive_t *drive, struct ide_cmd *cmd)
@@ -298,8 +300,18 @@ static void __devinit init_hwif_trm290(i
 #endif
 }
 
-static const struct ide_port_ops trm290_port_ops = {
-	.selectproc		= trm290_selectproc,
+static const struct ide_tp_ops trm290_tp_ops = {
+	.exec_command		= ide_exec_command,
+	.read_status		= ide_read_status,
+	.read_altstatus		= ide_read_altstatus,
+	.write_devctl		= ide_write_devctl,
+
+	.dev_select		= trm290_dev_select,
+	.tf_load		= ide_tf_load,
+	.tf_read		= ide_tf_read,
+
+	.input_data		= ide_input_data,
+	.output_data		= ide_output_data,
 };
 
 static struct ide_dma_ops trm290_dma_ops = {
@@ -315,7 +327,7 @@ static struct ide_dma_ops trm290_dma_ops
 static const struct ide_port_info trm290_chipset __devinitdata = {
 	.name		= DRV_NAME,
 	.init_hwif	= init_hwif_trm290,
-	.port_ops	= &trm290_port_ops,
+	.tp_ops 	= &trm290_tp_ops,
 	.dma_ops	= &trm290_dma_ops,
 	.host_flags	= IDE_HFLAG_TRM290 |
 			  IDE_HFLAG_NO_ATAPI_DMA |
Index: linux-2.6/drivers/ide/tx4938ide.c
===================================================================
--- linux-2.6.orig/drivers/ide/tx4938ide.c
+++ linux-2.6/drivers/ide/tx4938ide.c
@@ -189,6 +189,7 @@ static const struct ide_tp_ops tx4938ide
 	.read_altstatus		= ide_read_altstatus,
 	.write_devctl		= ide_write_devctl,
 
+	.dev_select		= ide_dev_select,
 	.tf_load		= tx4938ide_tf_load,
 	.tf_read		= tx4938ide_tf_read,
 
Index: linux-2.6/drivers/ide/tx4939ide.c
===================================================================
--- linux-2.6.orig/drivers/ide/tx4939ide.c
+++ linux-2.6/drivers/ide/tx4939ide.c
@@ -429,7 +429,7 @@ static void tx4939ide_tf_load_fixup(ide_
 	 * Fix ATA100 CORE System Control Register. (The write to the
 	 * Device/Head register may write wrong data to the System
 	 * Control Register)
-	 * While Sys_Ctl is written here, selectproc is not needed.
+	 * While Sys_Ctl is written here, dev_select() is not needed.
 	 */
 	tx4939ide_writew(sysctl, base, TX4939IDE_Sys_Ctl);
 }
@@ -579,6 +579,7 @@ static const struct ide_tp_ops tx4939ide
 	.read_altstatus		= ide_read_altstatus,
 	.write_devctl		= ide_write_devctl,
 
+	.dev_select		= ide_dev_select,
 	.tf_load		= tx4939ide_tf_load,
 	.tf_read		= ide_tf_read,
 
Index: linux-2.6/include/linux/ide.h
===================================================================
--- linux-2.6.orig/include/linux/ide.h
+++ linux-2.6/include/linux/ide.h
@@ -603,7 +603,7 @@ struct ide_drive_s {
 
 	unsigned int	bios_cyl;	/* BIOS/fdisk/LILO number of cyls */
 	unsigned int	cyl;		/* "real" number of cyls */
-	unsigned int	drive_data;	/* used by set_pio_mode/selectproc */
+	unsigned int	drive_data;	/* used by set_pio_mode/dev_select() */
 	unsigned int	failures;	/* current failure count */
 	unsigned int	max_failures;	/* maximum allowed failure count */
 	u64		probed_capacity;/* initial reported media capacity (ide-cd only currently) */
@@ -661,6 +661,7 @@ struct ide_tp_ops {
 	u8	(*read_altstatus)(struct hwif_s *);
 	void	(*write_devctl)(struct hwif_s *, u8);
 
+	void	(*dev_select)(ide_drive_t *);
 	void	(*tf_load)(ide_drive_t *, struct ide_cmd *);
 	void	(*tf_read)(ide_drive_t *, struct ide_cmd *);
 
@@ -678,7 +679,6 @@ extern const struct ide_tp_ops default_t
  * @init_dev:		host specific initialization of a device
  * @set_pio_mode:	routine to program host for PIO mode
  * @set_dma_mode:	routine to program host for DMA mode
- * @selectproc:		tweaks hardware to select drive
  * @reset_poll:		chipset polling based on hba specifics
  * @pre_reset:		chipset specific changes to default for device-hba resets
  * @resetproc:		routine to reset controller after a disk reset
@@ -695,7 +695,6 @@ struct ide_port_ops {
 	void	(*init_dev)(ide_drive_t *);
 	void	(*set_pio_mode)(ide_drive_t *, const u8);
 	void	(*set_dma_mode)(ide_drive_t *, const u8);
-	void	(*selectproc)(ide_drive_t *);
 	int	(*reset_poll)(ide_drive_t *);
 	void	(*pre_reset)(ide_drive_t *);
 	void	(*resetproc)(ide_drive_t *);

