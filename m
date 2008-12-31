From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH 2/4] ide: move read_sff_dma_status() method to  'struct ide_dma_ops'
Date: Wed, 31 Dec 2008 22:55:30 +0400
Message-ID: <200812312155.30109.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtsoft3.corbina.net ([85.21.88.6]:12304 "EHLO
	buildserver.ru.mvista.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1756143AbYLaSzF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 31 Dec 2008 13:55:05 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org

Move apparently misplaced read_sff_dma_status() method from 'struct ide_tp_ops'
to 'struct ide_dma_ops', renaming it to dma_sff_read_status() and making only
required for SFF-8038i compatible IDE controller drivers (greatly cutting down
the number of initializers) as its only user (outside ide-dma-sff.c and such
drivers) appears to be ide_pci_check_simplex() which is only called for such
controllers...

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

---
The patch is atop of the current pata-2.6 series...

 drivers/ide/alim15x3.c     |    1 +
 drivers/ide/au1xxx-ide.c   |    1 -
 drivers/ide/cmd64x.c       |    3 +++
 drivers/ide/falconide.c    |    1 -
 drivers/ide/hpt366.c       |    3 +++
 drivers/ide/ide-dma-sff.c  |   22 +++++++++++++++++-----
 drivers/ide/ide-h8300.c    |    1 -
 drivers/ide/ide-iops.c     |   10 ----------
 drivers/ide/ide-probe.c    |    7 +++++--
 drivers/ide/it821x.c       |    1 +
 drivers/ide/ns87415.c      |    8 +++++---
 drivers/ide/pdc202xx_old.c |    2 ++
 drivers/ide/pmac.c         |    1 -
 drivers/ide/q40ide.c       |    1 -
 drivers/ide/sc1200.c       |    1 +
 drivers/ide/scc_pata.c     |    4 ++--
 drivers/ide/setup-pci.c    |    7 ++++---
 drivers/ide/sgiioc4.c      |    1 -
 drivers/ide/siimage.c      |    1 +
 drivers/ide/sl82c105.c     |    1 +
 drivers/ide/tc86c001.c     |    1 +
 drivers/ide/tx4939ide.c    |   21 ++++++++++++---------
 include/linux/ide.h        |    8 ++++++--
 23 files changed, 65 insertions(+), 42 deletions(-)

Index: linux-2.6/drivers/ide/alim15x3.c
===================================================================
--- linux-2.6.orig/drivers/ide/alim15x3.c
+++ linux-2.6/drivers/ide/alim15x3.c
@@ -509,6 +509,7 @@ static const struct ide_dma_ops ali_dma_
 	.dma_test_irq		= ide_dma_test_irq,
 	.dma_lost_irq		= ide_dma_lost_irq,
 	.dma_timeout		= ide_dma_timeout,
+	.dma_sff_read_status	= ide_dma_sff_read_status,
 };
 
 static const struct ide_port_info ali15x3_chipset __devinitdata = {
Index: linux-2.6/drivers/ide/au1xxx-ide.c
===================================================================
--- linux-2.6.orig/drivers/ide/au1xxx-ide.c
+++ linux-2.6/drivers/ide/au1xxx-ide.c
@@ -502,7 +502,6 @@ static const struct ide_tp_ops au1xxx_tp
 	.exec_command		= ide_exec_command,
 	.read_status		= ide_read_status,
 	.read_altstatus		= ide_read_altstatus,
-	.read_sff_dma_status	= ide_read_sff_dma_status,
 
 	.set_irq		= ide_set_irq,
 
Index: linux-2.6/drivers/ide/cmd64x.c
===================================================================
--- linux-2.6.orig/drivers/ide/cmd64x.c
+++ linux-2.6/drivers/ide/cmd64x.c
@@ -385,6 +385,7 @@ static const struct ide_dma_ops cmd64x_d
 	.dma_test_irq		= cmd64x_dma_test_irq,
 	.dma_lost_irq		= ide_dma_lost_irq,
 	.dma_timeout		= ide_dma_timeout,
+	.dma_sff_read_status	= ide_dma_sff_read_status,
 };
 
 static const struct ide_dma_ops cmd646_rev1_dma_ops = {
@@ -396,6 +397,7 @@ static const struct ide_dma_ops cmd646_r
 	.dma_test_irq		= ide_dma_test_irq,
 	.dma_lost_irq		= ide_dma_lost_irq,
 	.dma_timeout		= ide_dma_timeout,
+	.dma_sff_read_status	= ide_dma_sff_read_status,
 };
 
 static const struct ide_dma_ops cmd648_dma_ops = {
@@ -407,6 +409,7 @@ static const struct ide_dma_ops cmd648_d
 	.dma_test_irq		= cmd648_dma_test_irq,
 	.dma_lost_irq		= ide_dma_lost_irq,
 	.dma_timeout		= ide_dma_timeout,
+	.dma_sff_read_status	= ide_dma_sff_read_status,
 };
 
 static const struct ide_port_info cmd64x_chipsets[] __devinitdata = {
Index: linux-2.6/drivers/ide/falconide.c
===================================================================
--- linux-2.6.orig/drivers/ide/falconide.c
+++ linux-2.6/drivers/ide/falconide.c
@@ -70,7 +70,6 @@ static const struct ide_tp_ops falconide
 	.exec_command		= ide_exec_command,
 	.read_status		= ide_read_status,
 	.read_altstatus		= ide_read_altstatus,
-	.read_sff_dma_status	= ide_read_sff_dma_status,
 
 	.set_irq		= ide_set_irq,
 
Index: linux-2.6/drivers/ide/hpt366.c
===================================================================
--- linux-2.6.orig/drivers/ide/hpt366.c
+++ linux-2.6/drivers/ide/hpt366.c
@@ -1424,6 +1424,7 @@ static const struct ide_dma_ops hpt37x_d
 	.dma_test_irq		= hpt374_dma_test_irq,
 	.dma_lost_irq		= ide_dma_lost_irq,
 	.dma_timeout		= ide_dma_timeout,
+	.dma_sff_read_status	= ide_dma_sff_read_status,
 };
 
 static const struct ide_dma_ops hpt370_dma_ops = {
@@ -1435,6 +1436,7 @@ static const struct ide_dma_ops hpt370_d
 	.dma_test_irq		= ide_dma_test_irq,
 	.dma_lost_irq		= ide_dma_lost_irq,
 	.dma_timeout		= hpt370_dma_timeout,
+	.dma_sff_read_status	= ide_dma_sff_read_status,
 };
 
 static const struct ide_dma_ops hpt36x_dma_ops = {
@@ -1446,6 +1448,7 @@ static const struct ide_dma_ops hpt36x_d
 	.dma_test_irq		= ide_dma_test_irq,
 	.dma_lost_irq		= hpt366_dma_lost_irq,
 	.dma_timeout		= ide_dma_timeout,
+	.dma_sff_read_status	= ide_dma_sff_read_status,
 };
 
 static const struct ide_port_info hpt366_chipsets[] __devinitdata = {
Index: linux-2.6/drivers/ide/ide-dma-sff.c
===================================================================
--- linux-2.6.orig/drivers/ide/ide-dma-sff.c
+++ linux-2.6/drivers/ide/ide-dma-sff.c
@@ -50,6 +50,17 @@ int config_drive_for_dma(ide_drive_t *dr
 	return 0;
 }
 
+u8 ide_dma_sff_read_status(ide_hwif_t *hwif)
+{
+	unsigned long addr = hwif->dma_base + ATA_DMA_STATUS;
+
+	if (hwif->host_flags & IDE_HFLAG_MMIO)
+		return readb((void __iomem *)addr);
+	else
+		return inb(addr);
+}
+EXPORT_SYMBOL_GPL(ide_dma_sff_read_status);
+
 /**
  *	ide_dma_host_set	-	Enable/disable DMA on a host
  *	@drive: drive to control
@@ -62,7 +73,7 @@ void ide_dma_host_set(ide_drive_t *drive
 {
 	ide_hwif_t *hwif = drive->hwif;
 	u8 unit = drive->dn & 1;
-	u8 dma_stat = hwif->tp_ops->read_sff_dma_status(hwif);
+	u8 dma_stat = hwif->dma_ops->dma_sff_read_status(hwif);
 
 	if (on)
 		dma_stat |= (1 << (5 + unit));
@@ -200,7 +211,7 @@ int ide_dma_setup(ide_drive_t *drive)
 		outb(reading, hwif->dma_base + ATA_DMA_CMD);
 
 	/* read DMA status for INTR & ERROR flags */
-	dma_stat = hwif->tp_ops->read_sff_dma_status(hwif);
+	dma_stat = hwif->dma_ops->dma_sff_read_status(hwif);
 
 	/* clear INTR & ERROR flags */
 	if (mmio)
@@ -232,7 +243,7 @@ EXPORT_SYMBOL_GPL(ide_dma_setup);
 static int dma_timer_expiry(ide_drive_t *drive)
 {
 	ide_hwif_t *hwif = drive->hwif;
-	u8 dma_stat = hwif->tp_ops->read_sff_dma_status(hwif);
+	u8 dma_stat = hwif->dma_ops->dma_sff_read_status(hwif);
 
 	printk(KERN_WARNING "%s: %s: DMA status (0x%02x)\n",
 		drive->name, __func__, dma_stat);
@@ -305,7 +316,7 @@ int ide_dma_end(ide_drive_t *drive)
 	}
 
 	/* get DMA status */
-	dma_stat = hwif->tp_ops->read_sff_dma_status(hwif);
+	dma_stat = hwif->dma_ops->dma_sff_read_status(hwif);
 
 	if (mmio)
 		/* clear the INTR & ERROR bits */
@@ -331,7 +342,7 @@ EXPORT_SYMBOL_GPL(ide_dma_end);
 int ide_dma_test_irq(ide_drive_t *drive)
 {
 	ide_hwif_t *hwif = drive->hwif;
-	u8 dma_stat = hwif->tp_ops->read_sff_dma_status(hwif);
+	u8 dma_stat = hwif->dma_ops->dma_sff_read_status(hwif);
 
 	return (dma_stat & ATA_DMA_INTR) ? 1 : 0;
 }
@@ -346,5 +357,6 @@ const struct ide_dma_ops sff_dma_ops = {
 	.dma_test_irq		= ide_dma_test_irq,
 	.dma_timeout		= ide_dma_timeout,
 	.dma_lost_irq		= ide_dma_lost_irq,
+	.dma_sff_read_status	= ide_dma_sff_read_status,
 };
 EXPORT_SYMBOL_GPL(sff_dma_ops);
Index: linux-2.6/drivers/ide/ide-h8300.c
===================================================================
--- linux-2.6.orig/drivers/ide/ide-h8300.c
+++ linux-2.6/drivers/ide/ide-h8300.c
@@ -159,7 +159,6 @@ static const struct ide_tp_ops h8300_tp_
 	.exec_command		= ide_exec_command,
 	.read_status		= ide_read_status,
 	.read_altstatus		= ide_read_altstatus,
-	.read_sff_dma_status	= ide_read_sff_dma_status,
 
 	.set_irq		= ide_set_irq,
 
Index: linux-2.6/drivers/ide/ide-iops.c
===================================================================
--- linux-2.6.orig/drivers/ide/ide-iops.c
+++ linux-2.6/drivers/ide/ide-iops.c
@@ -105,15 +105,6 @@ u8 ide_read_altstatus(ide_hwif_t *hwif)
 }
 EXPORT_SYMBOL_GPL(ide_read_altstatus);
 
-u8 ide_read_sff_dma_status(ide_hwif_t *hwif)
-{
-	if (hwif->host_flags & IDE_HFLAG_MMIO)
-		return readb((void __iomem *)(hwif->dma_base + ATA_DMA_STATUS));
-	else
-		return inb(hwif->dma_base + ATA_DMA_STATUS);
-}
-EXPORT_SYMBOL_GPL(ide_read_sff_dma_status);
-
 void ide_set_irq(ide_hwif_t *hwif, int on)
 {
 	u8 ctl = ATA_DEVCTL_OBS;
@@ -388,7 +379,6 @@ const struct ide_tp_ops default_tp_ops =
 	.exec_command		= ide_exec_command,
 	.read_status		= ide_read_status,
 	.read_altstatus		= ide_read_altstatus,
-	.read_sff_dma_status	= ide_read_sff_dma_status,
 
 	.set_irq		= ide_set_irq,
 
Index: linux-2.6/drivers/ide/ide-probe.c
===================================================================
--- linux-2.6.orig/drivers/ide/ide-probe.c
+++ linux-2.6/drivers/ide/ide-probe.c
@@ -1229,6 +1229,8 @@ static void ide_init_port(ide_hwif_t *hw
 	if ((d->host_flags & IDE_HFLAG_NO_DMA) == 0) {
 		int rc;
 
+		hwif->dma_ops = d->dma_ops;
+
 		if (d->init_dma)
 			rc = d->init_dma(hwif, d);
 		else
@@ -1236,12 +1238,13 @@ static void ide_init_port(ide_hwif_t *hw
 
 		if (rc < 0) {
 			printk(KERN_INFO "%s: DMA disabled\n", hwif->name);
+
+			hwif->dma_ops = NULL;
 			hwif->dma_base = 0;
 			hwif->swdma_mask = 0;
 			hwif->mwdma_mask = 0;
 			hwif->ultra_mask = 0;
-		} else if (d->dma_ops)
-			hwif->dma_ops = d->dma_ops;
+		}
 	}
 
 	if ((d->host_flags & IDE_HFLAG_SERIALIZE) ||
Index: linux-2.6/drivers/ide/it821x.c
===================================================================
--- linux-2.6.orig/drivers/ide/it821x.c
+++ linux-2.6/drivers/ide/it821x.c
@@ -512,6 +512,7 @@ static struct ide_dma_ops it821x_pass_th
 	.dma_test_irq		= ide_dma_test_irq,
 	.dma_timeout		= ide_dma_timeout,
 	.dma_lost_irq		= ide_dma_lost_irq,
+	.dma_sff_read_status	= ide_dma_sff_read_status,
 };
 
 /**
Index: linux-2.6/drivers/ide/ns87415.c
===================================================================
--- linux-2.6.orig/drivers/ide/ns87415.c
+++ linux-2.6/drivers/ide/ns87415.c
@@ -56,7 +56,7 @@ static u8 superio_read_status(ide_hwif_t
 	return superio_ide_inb(hwif->io_ports.status_addr);
 }
 
-static u8 superio_read_sff_dma_status(ide_hwif_t *hwif)
+static u8 superio_dma_sff_read_status(ide_hwif_t *hwif)
 {
 	return superio_ide_inb(hwif->dma_base + ATA_DMA_STATUS);
 }
@@ -109,7 +109,6 @@ static const struct ide_tp_ops superio_t
 	.exec_command		= ide_exec_command,
 	.read_status		= superio_read_status,
 	.read_altstatus		= ide_read_altstatus,
-	.read_sff_dma_status	= superio_read_sff_dma_status,
 
 	.set_irq		= ide_set_irq,
 
@@ -132,6 +131,8 @@ static void __devinit superio_init_iops(
 	tmp = superio_ide_inb(dma_stat);
 	outb(tmp | 0x66, dma_stat);
 }
+#else
+#define superio_dma_sff_read_status ide_dma_sff_read_status
 #endif
 
 static unsigned int ns87415_count = 0, ns87415_control[MAX_HWIFS] = { 0 };
@@ -201,7 +202,7 @@ static int ns87415_dma_end(ide_drive_t *
 	u8 dma_stat = 0, dma_cmd = 0;
 
 	drive->waiting_for_dma = 0;
-	dma_stat = hwif->tp_ops->read_sff_dma_status(hwif);
+	dma_stat = hwif->dma_ops->dma_sff_read_status(hwif);
 	/* get DMA command mode */
 	dma_cmd = inb(hwif->dma_base + ATA_DMA_CMD);
 	/* stop DMA */
@@ -308,6 +309,7 @@ static const struct ide_dma_ops ns87415_
 	.dma_test_irq		= ide_dma_test_irq,
 	.dma_lost_irq		= ide_dma_lost_irq,
 	.dma_timeout		= ide_dma_timeout,
+	.dma_sff_read_status	= superio_dma_sff_read_status,
 };
 
 static const struct ide_port_info ns87415_chipset __devinitdata = {
Index: linux-2.6/drivers/ide/pdc202xx_old.c
===================================================================
--- linux-2.6.orig/drivers/ide/pdc202xx_old.c
+++ linux-2.6/drivers/ide/pdc202xx_old.c
@@ -337,6 +337,7 @@ static const struct ide_dma_ops pdc20246
 	.dma_test_irq		= pdc202xx_dma_test_irq,
 	.dma_lost_irq		= pdc202xx_dma_lost_irq,
 	.dma_timeout		= pdc202xx_dma_timeout,
+	.dma_sff_read_status	= ide_dma_sff_read_status,
 };
 
 static const struct ide_dma_ops pdc2026x_dma_ops = {
@@ -348,6 +349,7 @@ static const struct ide_dma_ops pdc2026x
 	.dma_test_irq		= pdc202xx_dma_test_irq,
 	.dma_lost_irq		= pdc202xx_dma_lost_irq,
 	.dma_timeout		= pdc202xx_dma_timeout,
+	.dma_sff_read_status	= ide_dma_sff_read_status,
 };
 
 #define DECLARE_PDC2026X_DEV(udma, sectors) \
Index: linux-2.6/drivers/ide/pmac.c
===================================================================
--- linux-2.6.orig/drivers/ide/pmac.c
+++ linux-2.6/drivers/ide/pmac.c
@@ -955,7 +955,6 @@ static const struct ide_tp_ops pmac_tp_o
 	.exec_command		= pmac_exec_command,
 	.read_status		= ide_read_status,
 	.read_altstatus		= ide_read_altstatus,
-	.read_sff_dma_status	= ide_read_sff_dma_status,
 
 	.set_irq		= pmac_set_irq,
 
Index: linux-2.6/drivers/ide/q40ide.c
===================================================================
--- linux-2.6.orig/drivers/ide/q40ide.c
+++ linux-2.6/drivers/ide/q40ide.c
@@ -99,7 +99,6 @@ static const struct ide_tp_ops q40ide_tp
 	.exec_command		= ide_exec_command,
 	.read_status		= ide_read_status,
 	.read_altstatus		= ide_read_altstatus,
-	.read_sff_dma_status	= ide_read_sff_dma_status,
 
 	.set_irq		= ide_set_irq,
 
Index: linux-2.6/drivers/ide/sc1200.c
===================================================================
--- linux-2.6.orig/drivers/ide/sc1200.c
+++ linux-2.6/drivers/ide/sc1200.c
@@ -292,6 +292,7 @@ static const struct ide_dma_ops sc1200_d
 	.dma_test_irq		= ide_dma_test_irq,
 	.dma_lost_irq		= ide_dma_lost_irq,
 	.dma_timeout		= ide_dma_timeout,
+	.dma_sff_read_status	= ide_dma_sff_read_status,
 };
 
 static const struct ide_port_info sc1200_chipset __devinitdata = {
Index: linux-2.6/drivers/ide/scc_pata.c
===================================================================
--- linux-2.6.orig/drivers/ide/scc_pata.c
+++ linux-2.6/drivers/ide/scc_pata.c
@@ -143,7 +143,7 @@ static u8 scc_read_altstatus(ide_hwif_t 
 	return (u8)in_be32((void *)hwif->io_ports.ctl_addr);
 }
 
-static u8 scc_read_sff_dma_status(ide_hwif_t *hwif)
+static u8 scc_dma_sff_read_status(ide_hwif_t *hwif)
 {
 	return (u8)in_be32((void *)(hwif->dma_base + 4));
 }
@@ -853,7 +853,6 @@ static const struct ide_tp_ops scc_tp_op
 	.exec_command		= scc_exec_command,
 	.read_status		= scc_read_status,
 	.read_altstatus		= scc_read_altstatus,
-	.read_sff_dma_status	= scc_read_sff_dma_status,
 
 	.set_irq		= scc_set_irq,
 
@@ -880,6 +879,7 @@ static const struct ide_dma_ops scc_dma_
 	.dma_test_irq		= scc_dma_test_irq,
 	.dma_lost_irq		= ide_dma_lost_irq,
 	.dma_timeout		= ide_dma_timeout,
+	.dma_sff_read_status	= scc_dma_sff_read_status,
 };
 
 #define DECLARE_SCC_DEV(name_str)			\
Index: linux-2.6/drivers/ide/setup-pci.c
===================================================================
--- linux-2.6.orig/drivers/ide/setup-pci.c
+++ linux-2.6/drivers/ide/setup-pci.c
@@ -130,7 +130,7 @@ int ide_pci_check_simplex(ide_hwif_t *hw
 	 * we tune the drive then try to grab DMA ownership if we want to be
 	 * the DMA end.  This has to be become dynamic to handle hot-plug.
 	 */
-	dma_stat = hwif->tp_ops->read_sff_dma_status(hwif);
+	dma_stat = hwif->dma_ops->dma_sff_read_status(hwif);
 	if ((dma_stat & 0x80) && hwif->mate && hwif->mate->dma_base) {
 		printk(KERN_INFO "%s %s: simplex device: DMA disabled\n",
 			d->name, pci_name(dev));
@@ -377,6 +377,9 @@ int ide_hwif_setup_dma(ide_hwif_t *hwif,
 
 		hwif->dma_base = base;
 
+		if (hwif->dma_ops == NULL)
+			hwif->dma_ops = &sff_dma_ops;
+
 		if (ide_pci_check_simplex(hwif, d) < 0)
 			return -1;
 
@@ -393,8 +396,6 @@ int ide_hwif_setup_dma(ide_hwif_t *hwif,
 
 		if (ide_allocate_dma_engine(hwif))
 			return -1;
-
-		hwif->dma_ops = &sff_dma_ops;
 	}
 
 	return 0;
Index: linux-2.6/drivers/ide/sgiioc4.c
===================================================================
--- linux-2.6.orig/drivers/ide/sgiioc4.c
+++ linux-2.6/drivers/ide/sgiioc4.c
@@ -523,7 +523,6 @@ static const struct ide_tp_ops sgiioc4_t
 	.exec_command		= ide_exec_command,
 	.read_status		= sgiioc4_read_status,
 	.read_altstatus		= ide_read_altstatus,
-	.read_sff_dma_status	= ide_read_sff_dma_status,
 
 	.set_irq		= ide_set_irq,
 
Index: linux-2.6/drivers/ide/siimage.c
===================================================================
--- linux-2.6.orig/drivers/ide/siimage.c
+++ linux-2.6/drivers/ide/siimage.c
@@ -717,6 +717,7 @@ static const struct ide_dma_ops sil_dma_
 	.dma_test_irq		= siimage_dma_test_irq,
 	.dma_timeout		= ide_dma_timeout,
 	.dma_lost_irq		= ide_dma_lost_irq,
+	.dma_sff_read_status	= ide_dma_sff_read_status,
 };
 
 #define DECLARE_SII_DEV(p_ops)				\
Index: linux-2.6/drivers/ide/sl82c105.c
===================================================================
--- linux-2.6.orig/drivers/ide/sl82c105.c
+++ linux-2.6/drivers/ide/sl82c105.c
@@ -299,6 +299,7 @@ static const struct ide_dma_ops sl82c105
 	.dma_test_irq		= ide_dma_test_irq,
 	.dma_lost_irq		= sl82c105_dma_lost_irq,
 	.dma_timeout		= sl82c105_dma_timeout,
+	.dma_sff_read_status	= ide_dma_sff_read_status,
 };
 
 static const struct ide_port_info sl82c105_chipset __devinitdata = {
Index: linux-2.6/drivers/ide/tc86c001.c
===================================================================
--- linux-2.6.orig/drivers/ide/tc86c001.c
+++ linux-2.6/drivers/ide/tc86c001.c
@@ -188,6 +188,7 @@ static const struct ide_dma_ops tc86c001
 	.dma_test_irq		= ide_dma_test_irq,
 	.dma_lost_irq		= ide_dma_lost_irq,
 	.dma_timeout		= ide_dma_timeout,
+	.dma_sff_read_status	= ide_dma_sff_read_status,
 };
 
 static const struct ide_port_info tc86c001_chipset __devinitdata = {
Index: linux-2.6/drivers/ide/tx4939ide.c
===================================================================
--- linux-2.6.orig/drivers/ide/tx4939ide.c
+++ linux-2.6/drivers/ide/tx4939ide.c
@@ -397,6 +397,17 @@ static int tx4939ide_dma_test_irq(ide_dr
 	return found;
 }
 
+#ifdef __BIG_ENDIAN
+static u8 tx4939ide_dma_sff_read_status(ide_hwif_t *hwif)
+{
+	void __iomem *base = TX4939IDE_BASE(hwif);
+
+	return tx4939ide_readb(base, TX4939IDE_DMA_Stat);
+}
+#else
+#define tx4939ide_dma_sff_read_status ide_dma_sff_read_status
+#endif
+
 static void tx4939ide_init_hwif(ide_hwif_t *hwif)
 {
 	void __iomem *base = TX4939IDE_BASE(hwif);
@@ -443,13 +454,6 @@ static void tx4939ide_tf_load_fixup(ide_
 
 #ifdef __BIG_ENDIAN
 
-static u8 tx4939ide_read_sff_dma_status(ide_hwif_t *hwif)
-{
-	void __iomem *base = TX4939IDE_BASE(hwif);
-
-	return tx4939ide_readb(base, TX4939IDE_DMA_Stat);
-}
-
 /* custom iops (independent from SWAP_IO_SPACE) */
 static u8 tx4939ide_inb(unsigned long port)
 {
@@ -585,7 +589,6 @@ static const struct ide_tp_ops tx4939ide
 	.exec_command		= ide_exec_command,
 	.read_status		= ide_read_status,
 	.read_altstatus		= ide_read_altstatus,
-	.read_sff_dma_status	= tx4939ide_read_sff_dma_status,
 
 	.set_irq		= ide_set_irq,
 
@@ -609,7 +612,6 @@ static const struct ide_tp_ops tx4939ide
 	.exec_command		= ide_exec_command,
 	.read_status		= ide_read_status,
 	.read_altstatus		= ide_read_altstatus,
-	.read_sff_dma_status	= ide_read_sff_dma_status,
 
 	.set_irq		= ide_set_irq,
 
@@ -638,6 +640,7 @@ static const struct ide_dma_ops tx4939id
 	.dma_test_irq		= tx4939ide_dma_test_irq,
 	.dma_lost_irq		= ide_dma_lost_irq,
 	.dma_timeout		= ide_dma_timeout,
+	.dma_sff_read_status	= tx4939ide_dma_sff_read_status,
 };
 
 static const struct ide_port_info tx4939ide_port_info __initdata = {
Index: linux-2.6/include/linux/ide.h
===================================================================
--- linux-2.6.orig/include/linux/ide.h
+++ linux-2.6/include/linux/ide.h
@@ -678,7 +678,6 @@ struct ide_tp_ops {
 	void	(*exec_command)(struct hwif_s *, u8);
 	u8	(*read_status)(struct hwif_s *);
 	u8	(*read_altstatus)(struct hwif_s *);
-	u8	(*read_sff_dma_status)(struct hwif_s *);
 
 	void	(*set_irq)(struct hwif_s *, int);
 
@@ -739,6 +738,11 @@ struct ide_dma_ops {
 	int	(*dma_test_irq)(struct ide_drive_s *);
 	void	(*dma_lost_irq)(struct ide_drive_s *);
 	void	(*dma_timeout)(struct ide_drive_s *);
+	/*
+	 * The following method is optional and only required to be
+	 * implemented for the SFF-8038i compatible controllers.
+	 */
+	u8	(*dma_sff_read_status)(struct hwif_s *);
 };
 
 struct ide_host;
@@ -1182,7 +1186,6 @@ void ide_tf_dump(const char *, struct id
 void ide_exec_command(ide_hwif_t *, u8);
 u8 ide_read_status(ide_hwif_t *);
 u8 ide_read_altstatus(ide_hwif_t *);
-u8 ide_read_sff_dma_status(ide_hwif_t *);
 
 void ide_set_irq(ide_hwif_t *, int);
 
@@ -1463,6 +1466,7 @@ void ide_dma_exec_cmd(ide_drive_t *, u8)
 extern void ide_dma_start(ide_drive_t *);
 int ide_dma_end(ide_drive_t *);
 int ide_dma_test_irq(ide_drive_t *);
+u8 ide_dma_sff_read_status(ide_hwif_t *);
 extern const struct ide_dma_ops sff_dma_ops;
 #else
 static inline int config_drive_for_dma(ide_drive_t *drive) { return 0; }

