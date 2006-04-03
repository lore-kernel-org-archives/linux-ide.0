From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 13/13] ahci: convert to new EH
Date: Mon, 3 Apr 2006 12:44:39 +0900
Message-ID: <11440358793058-git-send-email-htejun@gmail.com>
References: <11440358783861-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.205]:64516 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932411AbWDCDot (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 2 Apr 2006 23:44:49 -0400
Received: by zproxy.gmail.com with SMTP id o37so1665772nzf
        for <linux-ide@vger.kernel.org>; Sun, 02 Apr 2006 20:44:48 -0700 (PDT)
In-Reply-To: <11440358783861-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, albertcc@tw.ibm.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Convert AHCI to new EH.  Unfortunately, ICH7 AHCI reacts badly if IRQ
mask is diddled during operation.  So, freezing is implemented by
unconditionally clearing interrupt conditions while frozen.

* AHCI interrupt handler does not analyze any of error conditions.  It
  just records relevant status registers in driver private area and
  invoke EH.  EH is responsible for decoding all those information.

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

 drivers/scsi/ahci.c |  235 ++++++++++++++++++++++++++++++++-------------------
 1 files changed, 147 insertions(+), 88 deletions(-)

d3b0304d82c87014e4f6d589d1671215e5ac7347
diff --git a/drivers/scsi/ahci.c b/drivers/scsi/ahci.c
index 8403cf3..21aea0b 100644
--- a/drivers/scsi/ahci.c
+++ b/drivers/scsi/ahci.c
@@ -71,6 +71,7 @@ enum {
 	AHCI_CMD_CLR_BUSY	= (1 << 10),
 
 	RX_FIS_D2H_REG		= 0x40,	/* offset of D2H Register FIS data */
+	RX_FIS_UNK		= 0x60, /* offset of Unknown FIS data */
 
 	board_ahci		= 0,
 
@@ -127,15 +128,16 @@ enum {
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
@@ -184,6 +186,9 @@ struct ahci_port_priv {
 	struct ahci_sg		*cmd_tbl_sg;
 	void			*rx_fis;
 	dma_addr_t		rx_fis_dma;
+	/* register values stored by interrupt handler for EH */
+	u32			eh_irq_stat;
+	u32			eh_serror;
 };
 
 static u32 ahci_scr_read (struct ata_port *ap, unsigned int sc_reg);
@@ -193,13 +198,13 @@ static unsigned int ahci_qc_issue(struct
 static irqreturn_t ahci_interrupt (int irq, void *dev_instance, struct pt_regs *regs);
 static int ahci_probe_reset(struct ata_port *ap, unsigned int *classes);
 static void ahci_irq_clear(struct ata_port *ap);
-static void ahci_eng_timeout(struct ata_port *ap);
+static void ahci_error_handler(struct ata_port *ap);
+static void ahci_post_internal_cmd(struct ata_queued_cmd *qc);
 static int ahci_port_start(struct ata_port *ap);
 static void ahci_port_stop(struct ata_port *ap);
 static void ahci_tf_read(struct ata_port *ap, struct ata_taskfile *tf);
 static void ahci_qc_prep(struct ata_queued_cmd *qc);
 static u8 ahci_check_status(struct ata_port *ap);
-static inline int ahci_host_intr(struct ata_port *ap, struct ata_queued_cmd *qc);
 static void ahci_remove_one (struct pci_dev *pdev);
 
 static struct scsi_host_template ahci_sht = {
@@ -234,7 +239,8 @@ static const struct ata_port_operations 
 	.qc_prep		= ahci_qc_prep,
 	.qc_issue		= ahci_qc_issue,
 
-	.eng_timeout		= ahci_eng_timeout,
+	.error_handler		= ahci_error_handler,
+	.post_internal_cmd	= ahci_post_internal_cmd,
 
 	.irq_handler		= ahci_interrupt,
 	.irq_clear		= ahci_irq_clear,
@@ -779,108 +785,163 @@ static void ahci_qc_prep(struct ata_queu
 	ahci_fill_cmd_slot(pp, opts);
 }
 
-static void ahci_restart_port(struct ata_port *ap, u32 irq_stat)
+static unsigned int ahci_eh_autopsy(struct ata_port *ap,
+				    struct ata_queued_cmd *qc, u32 irq_stat,
+				    char *desc, size_t desc_sz)
 {
-	void __iomem *mmio = ap->host_set->mmio_base;
-	void __iomem *port_mmio = ahci_port_base(mmio, ap->port_no);
-	u32 tmp;
+	struct ahci_port_priv *pp = ap->private_data;
+	unsigned int err_mask = 0, action = 0;
+	int rc;
 
-	if ((ap->device[0].class != ATA_DEV_ATAPI) ||
-	    ((irq_stat & PORT_IRQ_TF_ERR) == 0))
-		printk(KERN_WARNING "ata%u: port reset, "
-		       "p_is %x is %x pis %x cmd %x tf %x ss %x se %x\n",
-			ap->id,
-			irq_stat,
-			readl(mmio + HOST_IRQ_STAT),
-			readl(port_mmio + PORT_IRQ_STAT),
-			readl(port_mmio + PORT_CMD),
-			readl(port_mmio + PORT_TFDATA),
-			readl(port_mmio + PORT_SCR_STAT),
-			readl(port_mmio + PORT_SCR_ERR));
+	rc = scnprintf(desc, desc_sz, "irq_stat 0x%08x", irq_stat);
+	desc += rc;
+	desc_sz -= rc;
 
-	/* stop DMA */
-	ahci_stop_engine(ap);
+	if (irq_stat & PORT_IRQ_TF_ERR)
+		err_mask |= AC_ERR_DEV;
 
-	/* clear SATA phy error, if any */
-	tmp = readl(port_mmio + PORT_SCR_ERR);
-	writel(tmp, port_mmio + PORT_SCR_ERR);
+	if (irq_stat & (PORT_IRQ_HBUS_ERR | PORT_IRQ_HBUS_DATA_ERR)) {
+		err_mask |= AC_ERR_HOST_BUS;
+		action |= ATA_PORT_SOFTRESET;
+	}
 
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
+	if (irq_stat & PORT_IRQ_IF_ERR) {
+		err_mask |= AC_ERR_ATA_BUS;
+		action |= ATA_PORT_SOFTRESET;
+		rc = scnprintf(desc, desc_sz, ", Interface fatal error");
+		desc += rc;
+		desc_sz -= rc;
 	}
 
-	/* re-start DMA */
-	ahci_start_engine(ap);
+	if (irq_stat & PORT_IRQ_CONNECT) {
+		err_mask |= AC_ERR_ATA_BUS;
+		action |= ATA_PORT_SOFTRESET;
+		rc = scnprintf(desc, desc_sz, ", Connection status changed");
+		desc += rc;
+		desc_sz -= rc;
+	}
+
+	if (irq_stat & PORT_IRQ_UNK_FIS) {
+		unsigned int *unk = (unsigned int *)(pp->rx_fis + RX_FIS_UNK);
+
+		err_mask |= AC_ERR_HSM;
+		action |= ATA_PORT_SOFTRESET;
+		rc = scnprintf(desc, desc_sz,
+			       ", Unknown FIS %08x %08x %08x %08x",
+			       unk[0], unk[1], unk[2], unk[3]);
+		desc += rc;
+		desc_sz -= rc;
+	}
+
+	if (qc)
+		qc->err_mask |= err_mask;
+
+	return action;
 }
 
-static void ahci_eng_timeout(struct ata_port *ap)
+static void ahci_error_handler(struct ata_port *ap)
 {
-	struct ata_host_set *host_set = ap->host_set;
-	void __iomem *mmio = host_set->mmio_base;
-	void __iomem *port_mmio = ahci_port_base(mmio, ap->port_no);
+	struct ahci_port_priv *pp = ap->private_data;
+	unsigned int action = 0;
+	u32 irq_stat, serror;
+	struct ata_taskfile tf;
 	struct ata_queued_cmd *qc;
-	unsigned long flags;
+	char desc[70] = "";
+
+	/* fetch & clear error information from interrupt handler */
+	irq_stat = pp->eh_irq_stat;
+	serror = pp->eh_serror;
 
-	printk(KERN_WARNING "ata%u: handling error/timeout\n", ap->id);
+	pp->eh_irq_stat = 0;
+	pp->eh_serror = 0;
 
-	spin_lock_irqsave(&host_set->lock, flags);
+	if (!(ap->flags & ATA_FLAG_FROZEN)) {
+		/* restart engine */
+		ahci_stop_engine(ap);
+		ahci_start_engine(ap);
+	}
+
+	/* perform recovery */
+	qc = ata_eh_determine_qc(ap, &tf);
+
+	action |= ahci_eh_autopsy(ap, qc, irq_stat, desc, sizeof(desc));
+	action |= ata_eh_autopsy(ap, qc, &tf, serror);
+	ata_eh_report(ap, qc, &tf, serror, action, desc);
+	ata_eh_revive(ap, action,
+		      ahci_softreset, ahci_hardreset, ahci_postreset);
+	ata_eh_finish_qcs(ap, qc, &tf);
+}
+
+static void ahci_post_internal_cmd(struct ata_queued_cmd *qc)
+{
+	struct ata_port *ap = qc->ap;
+	struct ahci_port_priv *pp = ap->private_data;
 
-	ahci_restart_port(ap, readl(port_mmio + PORT_IRQ_STAT));
-	qc = ata_qc_from_tag(ap, ap->active_tag);
-	qc->err_mask |= AC_ERR_TIMEOUT;
+	if (qc->flags & ATA_QCFLAG_FAILED)
+		qc->err_mask |= AC_ERR_OTHER;
 
-	spin_unlock_irqrestore(&host_set->lock, flags);
+	if (qc->err_mask) {
+		/* make DMA engine forget about the failed command */
+		ahci_stop_engine(ap);
+		ahci_start_engine(ap);
+	}
 
-	ata_eh_qc_complete(qc);
+	pp->eh_irq_stat = 0;
+	pp->eh_serror = 0;
 }
 
-static inline int ahci_host_intr(struct ata_port *ap, struct ata_queued_cmd *qc)
+static inline int ahci_host_intr(struct ata_port *ap)
 {
+	struct ahci_port_priv *pp = ap->private_data;
 	void __iomem *mmio = ap->host_set->mmio_base;
 	void __iomem *port_mmio = ahci_port_base(mmio, ap->port_no);
-	u32 status, serr, ci;
-
-	serr = readl(port_mmio + PORT_SCR_ERR);
-	writel(serr, port_mmio + PORT_SCR_ERR);
+	u32 status, serror, ci;
+	unsigned int eh_flags;
 
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
+	if (ap->flags & ATA_FLAG_FROZEN) {
+		scr_write(ap, SCR_ERROR, scr_read(ap, SCR_ERROR));
+		return 1;
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
-
-		if (qc) {
-			qc->err_mask |= err_mask;
-			ata_qc_complete(qc);
+	if (!(status & PORT_IRQ_ERROR)) {
+		struct ata_queued_cmd *qc;
+
+		if ((qc = ata_qc_from_tag(ap, ap->active_tag))) {
+			ci = readl(port_mmio + PORT_CMD_ISSUE);
+			if ((ci & 0x1) == 0) {
+				ata_qc_complete(qc);
+				return 1;
+			}
 		}
+
+		if (ata_ratelimit())
+			printk(KERN_INFO "ata%u: spurious interrupt "
+			       "(irq_stat 0x%x active_tag %d)\n",
+			       ap->id, status, ap->active_tag);
+
+		return 1;
 	}
 
+	/* Something weird is going on.  Hand over to EH. */
+	serror = scr_read(ap, SCR_ERROR);
+	scr_write(ap, SCR_ERROR, serror);
+
+	pp->eh_irq_stat = status;
+	pp->eh_serror = serror;
+
+	eh_flags = ATA_EH_ABORT;
+	if (status & PORT_IRQ_FREEZE)
+		eh_flags |= ATA_EH_FREEZE;
+
+	ata_eh_schedule_port(ap, eh_flags);
+
 	return 1;
 }
 
@@ -918,9 +979,7 @@ static irqreturn_t ahci_interrupt (int i
 
 		ap = host_set->ports[i];
 		if (ap) {
-			struct ata_queued_cmd *qc;
-			qc = ata_qc_from_tag(ap, ap->active_tag);
-			if (!ahci_host_intr(ap, qc))
+			if (!ahci_host_intr(ap))
 				if (ata_ratelimit())
 					dev_printk(KERN_WARNING, host_set->dev,
 					  "unhandled interrupt on port %u\n",
@@ -942,7 +1001,7 @@ static irqreturn_t ahci_interrupt (int i
 		handled = 1;
 	}
 
-        spin_unlock(&host_set->lock);
+	spin_unlock(&host_set->lock);
 
 	VPRINTK("EXIT\n");
 
-- 
1.2.4


