From: Petr Vandrovec <petr@vandrovec.name>
Subject: [PATCH] sata_sil and PMP...
Date: Thu, 23 Aug 2007 08:27:40 +0200
Message-ID: <20070823062740.GA16458@vana.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from vana.vc.cvut.cz ([147.32.240.58]:49300 "EHLO vana.vc.cvut.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759324AbXHWGrt (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 23 Aug 2007 02:47:49 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hello,
  maybe I should have trusted SiliconImage...  But, well, it is not true that
you cannot use PMP with Sil 3512 and 3114.  You can, if you try hard enough.
Patch below tries hard enough ;-)  Unfortunately it has few drawbacks:

(1) Hardware ignores PMP field in received frames, so when D2H FIS arrives
from device not selected, you have last chance to record what's current
device state.

(2) When NIEN bit is set on device, every interrupt source seems to be
disabled.  Not good when interlocked FIS arrives while bus is resetted,
which happens almost always...

(3) And due to all this interrupts are always left enabled on the device,
and driver just tries to provide some more compatible view to remaining
parts of libata.

Driver as is below works with Sil 3726 port multiplier with couple devices
attached.  I did not test it without port multiplier (I think it will
break) as card I have has only eSATA ports and I currently do not
have eSATA non-PMP enclosure around.

So patch is definitely not intended for merge, and most probably it would
have to be separate driver anyway as I have some doubts about compatibility
between interrupts being always enabled and various ATI clones.  So this
is more or less just FYI, unless you believe that it is possible to get
this patch to some mergeable shape.  I have some doubts, so I've ordered
3124 based card.  Maybe I should have done that week ago... 

On other side driver works with PMP as well as AHCI driver (i.e. full
SDB_NOTIFY support, but command based switching and no NCQ - I think I
could implement NCQ if I would try hard enough via interlocked FIS, but 
it does not look like worth of effort).

Anyway, here it goes.  Good night.
							Petr



diff --git a/drivers/ata/sata_sil.c b/drivers/ata/sata_sil.c
index 78f01aa..8ef6d70 100644
--- a/drivers/ata/sata_sil.c
+++ b/drivers/ata/sata_sil.c
@@ -58,6 +58,12 @@ enum {
 	SIL_FLAG_RERR_ON_DMA_ACT = (1 << 29),
 	SIL_FLAG_MOD15WRITE	= (1 << 30),
 
+	/*
+	 * port flags
+	 */
+	SIL_FLAG_IRQ_DISABLED	= (1 << 29),
+	SIL_FLAG_POLLING	= (1 << 30),
+
 	SIL_DFL_PORT_FLAGS	= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
 				  ATA_FLAG_MMIO,
 	SIL_DFL_LINK_FLAGS	= ATA_LFLAG_HRST_TO_RESUME,
@@ -103,6 +109,13 @@ enum {
 
 	/* SIEN */
 	SIL_SIEN_N		= (1 << 16), /* triggered by SError.N */
+	SIL_SIEN_IFIS		= (1 << 27), /* triggered by SMisc.IFIS */
+
+	/* SMisc */
+	SIL_SMISC_IFIS_ACCEPT	= (1 << 25), /* accept InterlockedFIS */
+	SIL_SMISC_IFIS_REJECT	= (1 << 26), /* reject InterlockedFIS */
+	SIL_SMISC_IFIS		= (1 << 27), /* InterlockedFIS received */
+	SIL_SMISC_IFIS_OK	= (1 << 28), /* InterlockedFIS received OK */
 
 	/*
 	 * Others
@@ -119,9 +132,17 @@ static void sil_dev_config(struct ata_device *dev);
 static int sil_scr_read(struct ata_port *ap, unsigned int sc_reg, u32 *val);
 static int sil_scr_write(struct ata_port *ap, unsigned int sc_reg, u32 val);
 static int sil_set_mode(struct ata_link *link, struct ata_device **r_failed);
+static int sil_port_start(struct ata_port *ap);
+static void sil_port_stop(struct ata_port *ap);
 static void sil_freeze(struct ata_port *ap);
 static void sil_thaw(struct ata_port *ap);
-
+static int sil_pmp_read(struct ata_device *dev, int pmp, int reg, u32 *r_val);
+static int sil_pmp_write(struct ata_device *dev, int pmp, int reg, u32 val);
+static unsigned int sil_qc_issue(struct ata_queued_cmd *qc);
+static void sil_error_handler(struct ata_port *ap);
+static void sil_tf_load(struct ata_port *ap, const struct ata_taskfile *tf);
+static void sil_tf_read(struct ata_port *ap, struct ata_taskfile *tf);
+static u8 sil_check_status(struct ata_port *ap);
 
 static const struct pci_device_id sil_pci_tbl[] = {
 	{ PCI_VDEVICE(CMD, 0x3112), sil_3112 },
@@ -188,9 +209,9 @@ static struct scsi_host_template sil_sht = {
 static const struct ata_port_operations sil_ops = {
 	.port_disable		= ata_port_disable,
 	.dev_config		= sil_dev_config,
-	.tf_load		= ata_tf_load,
-	.tf_read		= ata_tf_read,
-	.check_status		= ata_check_status,
+	.tf_load		= sil_tf_load,
+	.tf_read		= sil_tf_read,
+	.check_status		= sil_check_status,
 	.exec_command		= ata_exec_command,
 	.dev_select		= ata_std_dev_select,
 	.set_mode		= sil_set_mode,
@@ -198,19 +219,23 @@ static const struct ata_port_operations sil_ops = {
 	.bmdma_start            = ata_bmdma_start,
 	.bmdma_stop		= ata_bmdma_stop,
 	.bmdma_status		= ata_bmdma_status,
+	.qc_defer		= sata_pmp_qc_defer_cmd_switch,
 	.qc_prep		= ata_qc_prep,
-	.qc_issue		= ata_qc_issue_prot,
+	.qc_issue		= sil_qc_issue,
 	.data_xfer		= ata_data_xfer,
 	.freeze			= sil_freeze,
 	.thaw			= sil_thaw,
-	.error_handler		= ata_bmdma_error_handler,
+	.error_handler		= sil_error_handler,
 	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
 	.irq_clear		= ata_bmdma_irq_clear,
 	.irq_on			= ata_irq_on,
 	.irq_ack		= ata_irq_ack,
 	.scr_read		= sil_scr_read,
 	.scr_write		= sil_scr_write,
-	.port_start		= ata_port_start,
+	.port_start		= sil_port_start,
+	.port_stop		= sil_port_stop,
+	.pmp_read		= sil_pmp_read,
+	.pmp_write		= sil_pmp_write,
 };
 
 static const struct ata_port_info sil_port_info[] = {
@@ -235,7 +260,7 @@ static const struct ata_port_info sil_port_info[] = {
 	},
 	/* sil_3512 */
 	{
-		.flags		= SIL_DFL_PORT_FLAGS | SIL_FLAG_RERR_ON_DMA_ACT,
+		.flags		= SIL_DFL_PORT_FLAGS | SIL_FLAG_RERR_ON_DMA_ACT | ATA_FLAG_PMP | ATA_FLAG_ACPI_SATA | ATA_FLAG_SDB_NOTIFY,
 		.link_flags	= SIL_DFL_LINK_FLAGS,
 		.pio_mask	= 0x1f,			/* pio0-4 */
 		.mwdma_mask	= 0x07,			/* mwdma0-2 */
@@ -244,7 +269,7 @@ static const struct ata_port_info sil_port_info[] = {
 	},
 	/* sil_3114 */
 	{
-		.flags		= SIL_DFL_PORT_FLAGS | SIL_FLAG_RERR_ON_DMA_ACT,
+		.flags		= SIL_DFL_PORT_FLAGS | SIL_FLAG_RERR_ON_DMA_ACT | ATA_FLAG_PMP | ATA_FLAG_ACPI_SATA | ATA_FLAG_SDB_NOTIFY,
 		.link_flags	= SIL_DFL_LINK_FLAGS,
 		.pio_mask	= 0x1f,			/* pio0-4 */
 		.mwdma_mask	= 0x07,			/* mwdma0-2 */
@@ -265,16 +290,26 @@ static const struct {
 	unsigned long sien;	/* SATA Interrupt Enable register */
 	unsigned long xfer_mode;/* data transfer mode register */
 	unsigned long sfis_cfg;	/* SATA FIS reception config register */
+        unsigned long rxfis;    /* Received FIS */
+        unsigned long smisc;    /* SATA Misc configuration register */
 } sil_port[] = {
 	/* port 0 ... */
-	/*   tf    ctl  bmdma  bmdma2  fifo    scr   sien   mode   sfis */
-	{  0x80,  0x8A,   0x0,  0x10,  0x40, 0x100, 0x148,  0xb4, 0x14c },
-	{  0xC0,  0xCA,   0x8,  0x18,  0x44, 0x180, 0x1c8,  0xf4, 0x1cc },
-	{ 0x280, 0x28A, 0x200, 0x210, 0x240, 0x300, 0x348, 0x2b4, 0x34c },
-	{ 0x2C0, 0x2CA, 0x208, 0x218, 0x244, 0x380, 0x3c8, 0x2f4, 0x3cc },
+	/*   tf    ctl  bmdma  bmdma2  fifo    scr   sien   mode   sfis  rxfis  smisc */
+	{  0x80,  0x8A,   0x0,  0x10,  0x40, 0x100, 0x148,  0xb4, 0x14c, 0x160, 0x140 },
+	{  0xC0,  0xCA,   0x8,  0x18,  0x44, 0x180, 0x1c8,  0xf4, 0x1cc, 0x1e0, 0x1c0 },
+	{ 0x280, 0x28A, 0x200, 0x210, 0x240, 0x300, 0x348, 0x2b4, 0x34c, 0x360, 0x340 },
+	{ 0x2C0, 0x2CA, 0x208, 0x218, 0x244, 0x380, 0x3c8, 0x2f4, 0x3cc, 0x3e0, 0x3c0 },
 	/* ... port 3 */
 };
 
+struct sil_port_priv {
+	u32 notification;
+	u8 tf_valid;
+	struct ata_taskfile tf;
+	int active_port;
+	u32 sien;
+};
+
 MODULE_AUTHOR("Jeff Garzik");
 MODULE_DESCRIPTION("low-level driver for Silicon Image SATA controller");
 MODULE_LICENSE("GPL");
@@ -315,7 +350,10 @@ static int sil_set_mode(struct ata_link *link, struct ata_device **r_failed)
 	if (rc)
 		return rc;
 
+	/* Well, what's this?  Sil buses are MASTER only... */
 	ata_link_for_each_dev(dev, link) {
+		if (dev->devno >= 2)
+			continue;
 		if (!ata_dev_enabled(dev))
 			dev_mode[dev->devno] = 0;	/* PIO0/1/2 */
 		else if (dev->flags & ATA_DFLAG_PIO)
@@ -355,34 +393,108 @@ static inline void __iomem *sil_scr_addr(struct ata_port *ap, unsigned int sc_re
 
 static int sil_scr_read(struct ata_port *ap, unsigned int sc_reg, u32 *val)
 {
-	void __iomem *mmio = sil_scr_addr(ap, sc_reg);
-
-	if (mmio) {
+	struct sil_port_priv *pp = ap->private_data;
+
+	if (sc_reg == SCR_NOTIFICATION) {
+		*val = pp->notification;
+	} else {
+		void __iomem *mmio = sil_scr_addr(ap, sc_reg);
+	
+		if (!mmio) {
+			return -EINVAL;
+		}
 		*val = readl(mmio);
-		return 0;
 	}
-	return -EINVAL;
+	return 0;
 }
 
 static int sil_scr_write(struct ata_port *ap, unsigned int sc_reg, u32 val)
 {
-	void __iomem *mmio = sil_scr_addr(ap, sc_reg);
+	struct sil_port_priv *pp = ap->private_data;
 
-	if (mmio) {
+	if (sc_reg == SCR_NOTIFICATION) {
+		pp->notification &= ~val;
+	} else {
+		void __iomem *mmio = sil_scr_addr(ap, sc_reg);
+
+		if (!mmio) {
+			return -EINVAL;
+		}
 		writel(val, mmio);
-		return 0;
 	}
-	return -EINVAL;
+	return 0;
+}
+
+static u8 sil_check_status(struct ata_port *ap)
+{
+	struct sil_port_priv *pp = ap->private_data;
+
+	if (pp->tf_valid) {
+		return pp->tf.command;
+	}
+	return ata_check_status(ap);
 }
 
 static void sil_host_intr(struct ata_port *ap, u32 bmdma2)
 {
-	struct ata_eh_info *ehi = &ap->link.eh_info;
-	struct ata_queued_cmd *qc = ata_qc_from_tag(ap, ap->link.active_tag);
+	void __iomem *mmio_base = ap->host->iomap[SIL_MMIO_BAR];
+	struct sil_port_priv *pp = ap->private_data;
+        struct ata_link *link;
+	struct ata_eh_info *ehi;
+	struct ata_queued_cmd *qc;
 	u8 status;
 
 	if (unlikely(bmdma2 & SIL_DMA_SATA_IRQ)) {
 		u32 serror;
+		u32 smisc = readl(mmio_base + sil_port[ap->port_no].smisc);
+
+		if (smisc & SIL_SMISC_IFIS) {
+			u32 rxfis0;
+
+			rxfis0 = readl(mmio_base + sil_port[ap->port_no].rxfis);
+
+			if ((rxfis0 & 0xFF) == 0x34) {
+				/* D2H - after accepting this FIS data will land up in
+				 * the taskfile, so better to grab them now.  It happens
+				 * always when X bit is cleared in port's error register -
+				 * device then sends its register state, overwritting
+			         * result code of PMP write command.  Besides this 100%
+			         * reproducible case it happens in some other situations
+				 * as well, so let's remember current task file and interrupt
+				 * status...
+				 */
+				pp->tf_valid = 0;
+				ata_tf_read(ap, &pp->tf);
+				pp->tf_valid = 1;
+			}
+
+			/*
+			 * Accept request.  Otherwise some devices will start retrying request
+			 * back to back, rendering link completely unusable.  We do not care about
+			 * OK or ERR, just accept the thing - non-data FISes fit in 7 dwords
+			 * provided by adapter, and if somebody sends us unexpected data FIS,
+			 * bad luck...
+			 */
+			writel(smisc | SIL_SMISC_IFIS_ACCEPT, mmio_base + sil_port[ap->port_no].smisc);
+			if ((rxfis0 & 0xFF) == 0xA1) { /* FIS was Set Device Bits */
+				if (rxfis0 & 0x8000) { /* Notification */
+					pp->notification |= 1 << ((rxfis0 >> 8) & 0x0F);
+				}
+				if (rxfis0 & 0x4000) {
+					/* Interrupt */
+				}
+				if (!(ap->flags & SIL_FLAG_IRQ_DISABLED)) {
+					sata_async_notification(ap);
+				}
+			}
+			if (rxfis0 & 0x4000) { /* IRQ bit was set in FIS.  Throw away IRQ state. */
+				ata_check_status(ap);
+			}
+			if (!(bmdma2 & SIL_DMA_COMPLETE)) {
+				return;
+			}
+			goto handle_ide_done;
+		}
 
 		/* SIEN doesn't mask SATA IRQs on some 3112s.  Those
 		 * controllers continue to assert IRQ as long as
@@ -391,6 +503,10 @@ static void sil_host_intr(struct ata_port *ap, u32 bmdma2)
 		sil_scr_read(ap, SCR_ERROR, &serror);
 		sil_scr_write(ap, SCR_ERROR, serror);
 
+		if (ap->flags & SIL_FLAG_IRQ_DISABLED) {
+			return;
+		}
+
 		/* Trigger hotplug and accumulate SError only if the
 		 * port isn't already frozen.  Otherwise, PHY events
 		 * during hardreset makes controllers with broken SIEN
@@ -403,13 +519,38 @@ static void sil_host_intr(struct ata_port *ap, u32 bmdma2)
 
 		goto freeze;
 	}
+handle_ide_done:
+	/* If we are executing command synchronously, just clear interrupt. */
+	if (ap->flags & (SIL_FLAG_POLLING | SIL_FLAG_IRQ_DISABLED)) {
+		ata_check_status(ap);
+		return;
+	}
+
+	/* This looks suspicious... Old code was not reading status,
+	 * which looks dangerous to me.
+	 */
+	if (ap->flags & ATA_FLAG_DISABLED) {
+		ata_check_status(ap);
+		return;
+	}
 
-	if (unlikely(!qc))
+        link = NULL;
+        /* determine active link */
+        ata_port_for_each_link(link, ap)
+                if (ata_link_active(link))
+                        break;
+        if (!link)
+                link = &ap->link;
+	ehi = &link->eh_info;
+	qc = ata_qc_from_tag(ap, link->active_tag);
+
+	if (unlikely(!qc)) {
 		goto freeze;
+	}
 
 	if (unlikely(qc->tf.flags & ATA_TFLAG_POLLING)) {
 		/* this sometimes happens, just clear IRQ */
-		ata_chk_status(ap);
+		ata_check_status(ap);
 		return;
 	}
 
@@ -446,7 +587,7 @@ static void sil_host_intr(struct ata_port *ap, u32 bmdma2)
 	}
 
 	/* check main status, clearing INTRQ */
-	status = ata_chk_status(ap);
+	status = ata_check_status(ap);
 	if (unlikely(status & ATA_BUSY))
 		goto err_hsm;
 
@@ -481,7 +622,7 @@ static irqreturn_t sil_interrupt(int irq, void *dev_instance)
 		struct ata_port *ap = host->ports[i];
 		u32 bmdma2 = readl(mmio_base + sil_port[ap->port_no].bmdma2);
 
-		if (unlikely(!ap || ap->flags & ATA_FLAG_DISABLED))
+		if (unlikely(!ap))
 			continue;
 
 		/* turn off SATA_IRQ if not supported */
@@ -504,37 +645,41 @@ static irqreturn_t sil_interrupt(int irq, void *dev_instance)
 static void sil_freeze(struct ata_port *ap)
 {
 	void __iomem *mmio_base = ap->host->iomap[SIL_MMIO_BAR];
-	u32 tmp;
+	struct sil_port_priv *pp = ap->private_data;
 
 	/* global IRQ mask doesn't block SATA IRQ, turn off explicitly */
-	writel(0, mmio_base + sil_port[ap->port_no].sien);
+	/*
+	 * Make sure to not ever disable SIL_SIEN_IFIS, link is busy
+	 * while interlocked FIS is in progress.
+	 */
+	pp->sien &= ~SIL_SIEN_N;
+	writel(pp->sien, mmio_base + sil_port[ap->port_no].sien);
 
 	/* plug IRQ */
-	tmp = readl(mmio_base + SIL_SYSCFG);
-	tmp |= SIL_MASK_IDE0_INT << ap->port_no;
-	writel(tmp, mmio_base + SIL_SYSCFG);
-	readl(mmio_base + SIL_SYSCFG);	/* flush */
+	ap->flags |= SIL_FLAG_IRQ_DISABLED;
+	pp->notification = 0;
 }
 
 static void sil_thaw(struct ata_port *ap)
 {
 	void __iomem *mmio_base = ap->host->iomap[SIL_MMIO_BAR];
-	u32 tmp;
+	struct sil_port_priv *pp = ap->private_data;
 
 	/* clear IRQ */
-	ata_chk_status(ap);
+	pp->notification = 0; /* I'm not sure, but sil24 does that */
+	ata_check_status(ap);
 	ata_bmdma_irq_clear(ap);
 
-	/* turn on SATA IRQ if supported */
-	if (!(ap->flags & SIL_FLAG_NO_SATA_IRQ))
-		writel(SIL_SIEN_N, mmio_base + sil_port[ap->port_no].sien);
+	ap->flags &= ~SIL_FLAG_IRQ_DISABLED;
 
-	/* turn on IRQ */
-	tmp = readl(mmio_base + SIL_SYSCFG);
-	tmp &= ~(SIL_MASK_IDE0_INT << ap->port_no);
-	writel(tmp, mmio_base + SIL_SYSCFG);
+	/* turn on SATA IRQ if supported */
+	if (!(ap->flags & SIL_FLAG_NO_SATA_IRQ)) {
+		pp->sien |= SIL_SIEN_N;
+		writel(pp->sien, mmio_base + sil_port[ap->port_no].sien);
+	}
 }
 
+
 /**
  *	sil_dev_config - Apply device/host-specific errata fixups
  *	@dev: Device to be examined
@@ -663,28 +808,36 @@ static int sil_init_one (struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (board_id == sil_3114)
 		n_ports = 4;
 
-	host = ata_host_alloc_pinfo(&pdev->dev, ppi, n_ports);
-	if (!host)
-		return -ENOMEM;
-
 	/* acquire resources and fill host */
 	rc = pcim_enable_device(pdev);
 	if (rc)
 		return rc;
-
 	rc = pcim_iomap_regions(pdev, 1 << SIL_MMIO_BAR, DRV_NAME);
 	if (rc == -EBUSY)
 		pcim_pin_device(pdev);
 	if (rc)
-		return rc;
+		goto err_out;
+
+        if (!devres_open_group(&pdev->dev, NULL, GFP_KERNEL))
+                return -ENOMEM;
+
+	host = ata_host_alloc_pinfo(&pdev->dev, ppi, n_ports);
+	if (!host) {
+		rc = -ENOMEM;
+		devres_release_group(&pdev->dev, NULL);
+		goto err_out;
+	}
+
+        devres_remove_group(&pdev->dev, NULL);
+
 	host->iomap = pcim_iomap_table(pdev);
 
 	rc = pci_set_dma_mask(pdev, ATA_DMA_MASK);
 	if (rc)
-		return rc;
+		goto err_out;
 	rc = pci_set_consistent_dma_mask(pdev, ATA_DMA_MASK);
 	if (rc)
-		return rc;
+		goto err_out;
 
 	mmio_base = host->iomap[SIL_MMIO_BAR];
 
@@ -705,6 +858,8 @@ static int sil_init_one (struct pci_dev *pdev, const struct pci_device_id *ent)
 	pci_set_master(pdev);
 	return ata_host_activate(host, pdev->irq, sil_interrupt, IRQF_SHARED,
 				 &sil_sht);
+err_out:
+	return rc;
 }
 
 #ifdef CONFIG_PM
@@ -724,6 +879,216 @@ static int sil_pci_device_resume(struct pci_dev *pdev)
 }
 #endif
 
+static u32 sil_wait_register(void __iomem *reg, u32 mask, u32 val,
+                      unsigned long interval_msec,
+                      unsigned long timeout_msec)
+{
+        unsigned long timeout;
+        u32 tmp;
+
+        tmp = ioread8(reg);
+
+        /* Calculate timeout _after_ the first read to make sure
+         * preceding writes reach the controller before starting to
+         * eat away the timeout.
+         */
+        timeout = jiffies + (timeout_msec * HZ) / 1000;
+
+        while ((tmp & mask) == val && time_before(jiffies, timeout)) {
+                msleep(interval_msec);
+                tmp = ioread8(reg);
+        }
+
+        return tmp;
+}
+
+static void sil_select_pmp(struct ata_port *ap, int pmp)
+{
+	struct sil_port_priv *pp = ap->private_data;
+
+	writeb(pmp, sil_scr_addr(ap, SCR_CONTROL) + 2);
+	pp->active_port = pmp;
+}
+
+static int sil_exec_polled_cmd(struct ata_port *ap, int pmp,
+                               struct ata_taskfile *tf, int is_cmd, u16 flags,
+                               unsigned long timeout_msec)
+{
+	struct sil_port_priv *pp = ap->private_data;
+	int active_port;
+	unsigned int tmp;
+
+	ap->flags |= SIL_FLAG_POLLING;
+
+	active_port = pp->active_port;
+	sil_select_pmp(ap, pmp);
+	sil_tf_load(ap, tf);
+	ata_exec_command(ap, tf);
+        if (timeout_msec) {
+                tmp = sil_wait_register(ap->ioaddr.status_addr, 0x80, 0x80,
+                                        1, timeout_msec * 2);
+                if (tmp & 0x80) {
+			ap->flags &= ~SIL_FLAG_POLLING;
+			if (pmp != active_port)
+				sil_select_pmp(ap, active_port);
+                        return -EBUSY;
+                }
+		sil_tf_read(ap, tf);
+		tmp = tf->command;
+        } else {
+		tmp = sil_check_status(ap);
+	}
+	ap->flags &= ~SIL_FLAG_POLLING;
+	if (pmp != active_port)
+		sil_select_pmp(ap, active_port);
+        return ((tmp & 0x51) == 0x50) ? 0 : -EIO;
+}
+
+static int sil_pmp_read(struct ata_device *dev, int pmp, int reg, u32 *r_val)
+{
+        struct ata_port *ap = dev->link->ap;
+        struct ata_taskfile tf;
+        int rc;
+
+        sata_pmp_read_init_tf(&tf, dev, pmp, reg);
+        rc = sil_exec_polled_cmd(ap, SATA_PMP_CTRL_PORT, &tf, 1, 0,
+                                 SATA_PMP_SCR_TIMEOUT);
+        if (rc == 0)
+                *r_val = sata_pmp_read_val(&tf);
+        return rc;
+}
+
+static int sil_pmp_write(struct ata_device *dev, int pmp, int reg, u32 val)
+{
+        struct ata_port *ap = dev->link->ap;
+        struct ata_taskfile tf;
+
+        sata_pmp_write_init_tf(&tf, dev, pmp, reg, val);
+        return sil_exec_polled_cmd(ap, SATA_PMP_CTRL_PORT, &tf, 1, 0,
+                                   SATA_PMP_SCR_TIMEOUT);
+}
+
+static unsigned int sil_qc_issue(struct ata_queued_cmd *qc)
+{
+        struct ata_port *ap = qc->ap;
+
+	sil_select_pmp(ap, qc->dev->link->pmp);	
+	return ata_qc_issue_prot(qc);
+}
+
+static int sil_softreset(struct ata_link *link, unsigned int *classes,
+                              unsigned long deadline)
+{
+        int pmp = 0;
+        struct ata_port *ap = link->ap;
+
+        if (ap->flags & ATA_FLAG_PMP)
+                pmp = SATA_PMP_CTRL_PORT;
+
+	sil_select_pmp(ap, pmp);	
+	return ata_std_softreset(link, classes, deadline);
+}
+
+static int sil_pmp_softreset(struct ata_link *link, unsigned int *classes,
+                              unsigned long deadline)
+{
+	sil_select_pmp(link->ap, link->pmp);	
+	return ata_std_softreset(link, classes, deadline);
+}
+
+static void sil_error_handler(struct ata_port *ap)
+{
+        sata_pmp_do_eh(ap, ata_std_prereset, sil_softreset,
+                       sata_std_hardreset, ata_std_postreset,
+                       sata_pmp_std_prereset, sil_pmp_softreset,
+                       sata_pmp_std_hardreset, sata_pmp_std_postreset);
+}
+
+static void sil_tf_load(struct ata_port *ap, const struct ata_taskfile *tf)
+{
+	struct sil_port_priv *pp = ap->private_data;
+
+	((struct ata_taskfile*)tf)->ctl &= ~ATA_NIEN; /* Ugly! */
+	pp->tf_valid = 0;
+	ata_tf_load(ap, tf);
+}
+
+static void sil_tf_read(struct ata_port *ap, struct ata_taskfile *tf)
+{
+	struct sil_port_priv *pp = ap->private_data;
+
+	if (pp->tf_valid) {
+		*tf = pp->tf;
+		pp->tf_valid = 0;
+	} else {
+		ata_tf_read(ap, tf);
+	}
+}
+
+static int sil_port_start(struct ata_port *ap)
+{
+	struct sil_port_priv *pp;
+	int rc;
+	void __iomem *mmio_base = ap->host->iomap[SIL_MMIO_BAR];
+	u32 tmp;
+
+	rc = ata_port_start(ap);
+	if (rc)
+		return rc;
+
+        pp = devm_kzalloc(ap->host->dev, sizeof(*pp), GFP_KERNEL);
+        if (!pp)
+                return -ENOMEM;
+	ap->private_data = pp;
+
+	ata_check_status(ap);
+	ata_bmdma_irq_clear(ap);
+
+	pp->sien = SIL_SIEN_IFIS;
+	writel(pp->sien, mmio_base + sil_port[ap->port_no].sien);
+	tmp = readl(mmio_base + SIL_SYSCFG);
+	tmp &= ~(SIL_MASK_IDE0_INT << ap->port_no);
+	writel(tmp, mmio_base + SIL_SYSCFG);
+
+	/* Set pm_fiscfg to 0b10 - Interlock FIS */
+	tmp = readl(mmio_base + sil_port[ap->port_no].smisc);
+	tmp &= ~0x00000600;
+	tmp |=  0x00000400;
+	writel(tmp, mmio_base + sil_port[ap->port_no].smisc);
+	/* Set FISA1cfg to 0b10 - Interlock FIS */
+#if 0
+	tmp = readl(mmio_base + sil_port[ap->port_no].sfis_cfg);
+	tmp &= ~0x0000C000;
+	tmp |=  0x00008000;
+#else
+	tmp  =  0x10409554;
+#endif
+	writel(tmp, mmio_base + sil_port[ap->port_no].sfis_cfg);
+	return 0;
+}
+
+static void sil_port_stop(struct ata_port *ap)
+{
+	void __iomem *mmio_base = ap->host->iomap[SIL_MMIO_BAR];
+	u32 tmp;
+
+	/* Set FISA1cfg to 0b00 - Accept (this is default) */
+	tmp = readl(mmio_base + sil_port[ap->port_no].sfis_cfg);
+	tmp &= ~0x0000C000;
+	writel(tmp, mmio_base + sil_port[ap->port_no].sfis_cfg);
+	/* Set pm_fiscfg to 0b00 - Accept (this is default) */
+	tmp = readl(mmio_base + sil_port[ap->port_no].smisc);
+	tmp &= ~0x00000600;
+	writel(tmp, mmio_base + sil_port[ap->port_no].smisc);
+	writel(0, mmio_base + sil_port[ap->port_no].sien);
+	tmp = readl(mmio_base + SIL_SYSCFG);
+	if (!(tmp & (SIL_MASK_IDE0_INT << ap->port_no))) {
+		tmp |= SIL_MASK_IDE0_INT << ap->port_no;
+		writel(tmp, mmio_base + SIL_SYSCFG);
+		readl(mmio_base + SIL_SYSCFG);	/* flush */
+	}
+}
+
 static int __init sil_init(void)
 {
 	return pci_register_driver(&sil_pci_driver);
