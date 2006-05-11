From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 09/11] ahci: convert to new EH
Date: Thu, 11 May 2006 22:21:29 +0900
Message-ID: <1147353689306-git-send-email-htejun@gmail.com>
References: <11473536873966-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.205]:34485 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751715AbWEKNVi (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 11 May 2006 09:21:38 -0400
Received: by nz-out-0102.google.com with SMTP id 13so189303nzn
        for <linux-ide@vger.kernel.org>; Thu, 11 May 2006 06:21:38 -0700 (PDT)
In-Reply-To: <11473536873966-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, forrest.zhao@intel.com, efalk@google.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Convert AHCI to new EH.  Unfortunately, ICH7 AHCI reacts badly if IRQ
mask is diddled during operation.  So, freezing is implemented by
unconditionally clearing interrupt conditions while frozen.

* Interrupts are categorized according to required action.
  e.g. Connection status or unknown FIS error requires freezing the
  port while TF or HBUS_DATA don't.

* Only CONNECT (reflects SErr.X) interrupt is taken into account not
  PHYRDY (SErr.N), as CONNECT is better cue for starting EH.

* AHCI may be invoked without any active command.  e.g. CONNECT irq
  occuring while no qc in progress still triggers EH and will reset
  the port and revalidate attached device.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/ahci.c |  222 +++++++++++++++++++++++++++++----------------------
 1 files changed, 127 insertions(+), 95 deletions(-)

9e72390810673cbad9f1a994e7b2dd897c924178
diff --git a/drivers/scsi/ahci.c b/drivers/scsi/ahci.c
index a4fb8d0..c2b9c93 100644
--- a/drivers/scsi/ahci.c
+++ b/drivers/scsi/ahci.c
@@ -71,6 +71,7 @@ enum {
 	AHCI_CMD_CLR_BUSY	= (1 << 10),
 
 	RX_FIS_D2H_REG		= 0x40,	/* offset of D2H Register FIS data */
+	RX_FIS_UNK		= 0x60, /* offset of Unknown FIS data */
 
 	board_ahci		= 0,
 	board_ahci_vt8251	= 1,
@@ -128,15 +129,16 @@ enum {
 	PORT_IRQ_PIOS_FIS	= (1 << 1), /* PIO Setup FIS rx'd */
 	PORT_IRQ_D2H_REG_FIS	= (1 << 0), /* D2H Register FIS rx'd */
 
-	PORT_IRQ_FATAL		= PORT_IRQ_TF_ERR |
-				  PORT_IRQ_HBUS_ERR |
-				  PORT_IRQ_HBUS_DATA_ERR |
-				  PORT_IRQ_IF_ERR,
-	DEF_PORT_IRQ		= PORT_IRQ_FATAL | PORT_IRQ_PHYRDY |
-				  PORT_IRQ_CONNECT | PORT_IRQ_SG_DONE |
-				  PORT_IRQ_UNK_FIS | PORT_IRQ_SDB_FIS |
-				  PORT_IRQ_DMAS_FIS | PORT_IRQ_PIOS_FIS |
-				  PORT_IRQ_D2H_REG_FIS,
+	PORT_IRQ_FREEZE		= PORT_IRQ_HBUS_ERR |
+				  PORT_IRQ_IF_ERR |
+				  PORT_IRQ_CONNECT |
+				  PORT_IRQ_UNK_FIS,
+	PORT_IRQ_ERROR		= PORT_IRQ_FREEZE |
+				  PORT_IRQ_TF_ERR |
+				  PORT_IRQ_HBUS_DATA_ERR,
+	DEF_PORT_IRQ		= PORT_IRQ_ERROR | PORT_IRQ_SG_DONE |
+				  PORT_IRQ_SDB_FIS | PORT_IRQ_DMAS_FIS |
+				  PORT_IRQ_PIOS_FIS | PORT_IRQ_D2H_REG_FIS,
 
 	/* PORT_CMD bits */
 	PORT_CMD_ATAPI		= (1 << 24), /* Device is ATAPI */
@@ -197,13 +199,13 @@ static unsigned int ahci_qc_issue(struct
 static irqreturn_t ahci_interrupt (int irq, void *dev_instance, struct pt_regs *regs);
 static int ahci_probe_reset(struct ata_port *ap, unsigned int *classes);
 static void ahci_irq_clear(struct ata_port *ap);
-static void ahci_eng_timeout(struct ata_port *ap);
 static int ahci_port_start(struct ata_port *ap);
 static void ahci_port_stop(struct ata_port *ap);
 static void ahci_tf_read(struct ata_port *ap, struct ata_taskfile *tf);
 static void ahci_qc_prep(struct ata_queued_cmd *qc);
 static u8 ahci_check_status(struct ata_port *ap);
-static inline int ahci_host_intr(struct ata_port *ap, struct ata_queued_cmd *qc);
+static void ahci_error_handler(struct ata_port *ap);
+static void ahci_post_internal_cmd(struct ata_queued_cmd *qc);
 static void ahci_remove_one (struct pci_dev *pdev);
 
 static struct scsi_host_template ahci_sht = {
@@ -237,14 +239,15 @@ static const struct ata_port_operations 
 	.qc_prep		= ahci_qc_prep,
 	.qc_issue		= ahci_qc_issue,
 
-	.eng_timeout		= ahci_eng_timeout,
-
 	.irq_handler		= ahci_interrupt,
 	.irq_clear		= ahci_irq_clear,
 
 	.scr_read		= ahci_scr_read,
 	.scr_write		= ahci_scr_write,
 
+	.error_handler		= ahci_error_handler,
+	.post_internal_cmd	= ahci_post_internal_cmd,
+
 	.port_start		= ahci_port_start,
 	.port_stop		= ahci_port_stop,
 };
@@ -681,10 +684,16 @@ static int ahci_hardreset(struct ata_por
 static void ahci_postreset(struct ata_port *ap, unsigned int *class)
 {
 	void __iomem *port_mmio = (void __iomem *) ap->ioaddr.cmd_addr;
+	unsigned long flags;
 	u32 new_tmp, tmp;
 
 	ata_std_postreset(ap, class);
 
+	/* clear stored SError */
+	spin_lock_irqsave(&ap->host_set->lock, flags);
+	ap->eh_info.serror = 0;
+	spin_unlock_irqrestore(&ap->host_set->lock, flags);
+
 	/* Make sure port's ATAPI bit is set appropriately */
 	new_tmp = tmp = readl(port_mmio + PORT_CMD);
 	if (*class == ATA_DEV_ATAPI)
@@ -789,108 +798,112 @@ static void ahci_qc_prep(struct ata_queu
 	ahci_fill_cmd_slot(pp, opts);
 }
 
-static void ahci_restart_port(struct ata_port *ap, u32 irq_stat)
+static void ahci_error_intr(struct ata_port *ap, u32 irq_stat)
 {
-	void __iomem *mmio = ap->host_set->mmio_base;
-	void __iomem *port_mmio = ahci_port_base(mmio, ap->port_no);
-	u32 tmp;
+	struct ahci_port_priv *pp = ap->private_data;
+	struct ata_eh_info *ehi = &ap->eh_info;
+	unsigned int err_mask = 0, action = 0;
+	struct ata_queued_cmd *qc;
+	u32 serror;
 
-	if ((ap->device[0].class != ATA_DEV_ATAPI) ||
-	    ((irq_stat & PORT_IRQ_TF_ERR) == 0))
-		ata_port_printk(ap, KERN_WARNING, "port reset, "
-		       "p_is %x is %x pis %x cmd %x tf %x ss %x se %x\n",
-			irq_stat,
-			readl(mmio + HOST_IRQ_STAT),
-			readl(port_mmio + PORT_IRQ_STAT),
-			readl(port_mmio + PORT_CMD),
-			readl(port_mmio + PORT_TFDATA),
-			readl(port_mmio + PORT_SCR_STAT),
-			readl(port_mmio + PORT_SCR_ERR));
+	ata_ehi_clear_desc(ehi);
 
-	/* stop DMA */
-	ahci_stop_engine(ap);
+	/* AHCI needs SError cleared; otherwise, it might lock up */
+	serror = ahci_scr_read(ap, SCR_ERROR);
+	ahci_scr_write(ap, SCR_ERROR, serror);
 
-	/* clear SATA phy error, if any */
-	tmp = readl(port_mmio + PORT_SCR_ERR);
-	writel(tmp, port_mmio + PORT_SCR_ERR);
+	/* analyze @irq_stat */
+	ata_ehi_push_desc(ehi, "irq_stat 0x%08x", irq_stat);
 
-	/* if DRQ/BSY is set, device needs to be reset.
-	 * if so, issue COMRESET
-	 */
-	tmp = readl(port_mmio + PORT_TFDATA);
-	if (tmp & (ATA_BUSY | ATA_DRQ)) {
-		writel(0x301, port_mmio + PORT_SCR_CTL);
-		readl(port_mmio + PORT_SCR_CTL); /* flush */
-		udelay(10);
-		writel(0x300, port_mmio + PORT_SCR_CTL);
-		readl(port_mmio + PORT_SCR_CTL); /* flush */
+	if (irq_stat & PORT_IRQ_TF_ERR)
+		err_mask |= AC_ERR_DEV;
+
+	if (irq_stat & (PORT_IRQ_HBUS_ERR | PORT_IRQ_HBUS_DATA_ERR)) {
+		err_mask |= AC_ERR_HOST_BUS;
+		action |= ATA_EH_SOFTRESET;
 	}
 
-	/* re-start DMA */
-	ahci_start_engine(ap);
-}
+	if (irq_stat & PORT_IRQ_IF_ERR) {
+		err_mask |= AC_ERR_ATA_BUS;
+		action |= ATA_EH_SOFTRESET;
+		ata_ehi_push_desc(ehi, ", interface fatal error");
+	}
 
-static void ahci_eng_timeout(struct ata_port *ap)
-{
-	struct ata_host_set *host_set = ap->host_set;
-	void __iomem *mmio = host_set->mmio_base;
-	void __iomem *port_mmio = ahci_port_base(mmio, ap->port_no);
-	struct ata_queued_cmd *qc;
-	unsigned long flags;
+	if (irq_stat & (PORT_IRQ_CONNECT | PORT_IRQ_PHYRDY)) {
+		err_mask |= AC_ERR_ATA_BUS;
+		action |= ATA_EH_SOFTRESET;
+		ata_ehi_push_desc(ehi, ", %s", irq_stat & PORT_IRQ_CONNECT ?
+			"connection status changed" : "PHY RDY changed");
+	}
 
-	ata_port_printk(ap, KERN_WARNING, "handling error/timeout\n");
+	if (irq_stat & PORT_IRQ_UNK_FIS) {
+		u32 *unk = (u32 *)(pp->rx_fis + RX_FIS_UNK);
 
-	spin_lock_irqsave(&host_set->lock, flags);
+		err_mask |= AC_ERR_HSM;
+		action |= ATA_EH_SOFTRESET;
+		ata_ehi_push_desc(ehi, ", unknown FIS %08x %08x %08x %08x",
+				  unk[0], unk[1], unk[2], unk[3]);
+	}
 
-	ahci_restart_port(ap, readl(port_mmio + PORT_IRQ_STAT));
-	qc = ata_qc_from_tag(ap, ap->active_tag);
-	qc->err_mask |= AC_ERR_TIMEOUT;
+	/* okay, let's hand over to EH */
+	ehi->serror |= serror;
+	ehi->action |= action;
 
-	spin_unlock_irqrestore(&host_set->lock, flags);
+	qc = ata_qc_from_tag(ap, ap->active_tag);
+	if (qc)
+		qc->err_mask |= err_mask;
+	else
+		ehi->err_mask |= err_mask;
 
-	ata_eh_qc_complete(qc);
+	if (irq_stat & PORT_IRQ_FREEZE)
+		ata_port_freeze(ap);
+	else
+		ata_port_abort(ap);
 }
 
-static inline int ahci_host_intr(struct ata_port *ap, struct ata_queued_cmd *qc)
+static void ahci_host_intr(struct ata_port *ap)
 {
 	void __iomem *mmio = ap->host_set->mmio_base;
 	void __iomem *port_mmio = ahci_port_base(mmio, ap->port_no);
-	u32 status, serr, ci;
-
-	serr = readl(port_mmio + PORT_SCR_ERR);
-	writel(serr, port_mmio + PORT_SCR_ERR);
+	struct ata_eh_info *ehi = &ap->eh_info;
+	struct ata_queued_cmd *qc;
+	u32 status, serror, ci;
 
 	status = readl(port_mmio + PORT_IRQ_STAT);
 	writel(status, port_mmio + PORT_IRQ_STAT);
 
-	ci = readl(port_mmio + PORT_CMD_ISSUE);
-	if (likely((ci & 0x1) == 0)) {
-		if (qc) {
-			WARN_ON(qc->err_mask);
-			ata_qc_complete(qc);
-			qc = NULL;
-		}
+	/* AHCI gets unhappy if IRQ mask is diddled with while the
+	 * port is active, so we cannot disable IRQ when freezing.
+	 * Clear IRQ conditions and hope screaming IRQs don't happen.
+	 */
+	if (unlikely(ap->flags & ATA_FLAG_FROZEN)) {
+		/* some AHCI errors hang the controller until SError
+		 * is cleared.  Store & clear it.
+		 */
+		serror = ahci_scr_read(ap, SCR_ERROR);
+		ahci_scr_write(ap, SCR_ERROR, serror);
+		ehi->serror |= serror;
+		return;
 	}
 
-	if (status & PORT_IRQ_FATAL) {
-		unsigned int err_mask;
-		if (status & PORT_IRQ_TF_ERR)
-			err_mask = AC_ERR_DEV;
-		else if (status & PORT_IRQ_IF_ERR)
-			err_mask = AC_ERR_ATA_BUS;
-		else
-			err_mask = AC_ERR_HOST_BUS;
-
-		/* command processing has stopped due to error; restart */
-		ahci_restart_port(ap, status);
+	if (unlikely(status & PORT_IRQ_ERROR)) {
+		ahci_error_intr(ap, status);
+		return;
+	}
 
-		if (qc) {
-			qc->err_mask |= err_mask;
+	if ((qc = ata_qc_from_tag(ap, ap->active_tag))) {
+		ci = readl(port_mmio + PORT_CMD_ISSUE);
+		if ((ci & 0x1) == 0) {
 			ata_qc_complete(qc);
+			return;
 		}
 	}
 
-	return 1;
+	/* spurious interrupt */
+	if (ata_ratelimit())
+		ata_port_printk(ap, KERN_INFO, "spurious interrupt "
+				"(irq_stat 0x%x active_tag %d)\n",
+				status, ap->active_tag);
 }
 
 static void ahci_irq_clear(struct ata_port *ap)
@@ -927,14 +940,7 @@ static irqreturn_t ahci_interrupt (int i
 
 		ap = host_set->ports[i];
 		if (ap) {
-			struct ata_queued_cmd *qc;
-			qc = ata_qc_from_tag(ap, ap->active_tag);
-			if (!ahci_host_intr(ap, qc))
-				if (ata_ratelimit())
-					dev_printk(KERN_WARNING, host_set->dev,
-					  "unhandled interrupt on port %u\n",
-					  i);
-
+			ahci_host_intr(ap);
 			VPRINTK("port %u\n", i);
 		} else {
 			VPRINTK("port %u (no irq)\n", i);
@@ -951,7 +957,7 @@ static irqreturn_t ahci_interrupt (int i
 		handled = 1;
 	}
 
-        spin_unlock(&host_set->lock);
+	spin_unlock(&host_set->lock);
 
 	VPRINTK("EXIT\n");
 
@@ -969,6 +975,32 @@ static unsigned int ahci_qc_issue(struct
 	return 0;
 }
 
+static void ahci_error_handler(struct ata_port *ap)
+{
+	if (!(ap->flags & ATA_FLAG_FROZEN)) {
+		/* restart engine */
+		ahci_stop_engine(ap);
+		ahci_start_engine(ap);
+	}
+
+	/* perform recovery */
+	ata_do_eh(ap, ahci_softreset, ahci_hardreset, ahci_postreset);
+}
+
+static void ahci_post_internal_cmd(struct ata_queued_cmd *qc)
+{
+	struct ata_port *ap = qc->ap;
+
+	if (qc->flags & ATA_QCFLAG_FAILED)
+		qc->err_mask |= AC_ERR_OTHER;
+
+	if (qc->err_mask) {
+		/* make DMA engine forget about the failed command */
+		ahci_stop_engine(ap);
+		ahci_start_engine(ap);
+	}
+}
+
 static void ahci_setup_port(struct ata_ioports *port, unsigned long base,
 			    unsigned int port_idx)
 {
-- 
1.2.4


