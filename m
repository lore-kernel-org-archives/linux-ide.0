From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH Linux 2.6.12 06/09] NCQ: convert ahci to use new NCQ helpers
Date: Mon, 27 Jun 2005 00:21:37 +0900 (KST)
Message-ID: <20050626152105.281AA8F3@htj.dyndns.org>
References: <20050626152105.D86561FB@htj.dyndns.org>
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.203]:27926 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261315AbVFZPVn (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 26 Jun 2005 11:21:43 -0400
Received: by wproxy.gmail.com with SMTP id i21so222875wra
        for <linux-ide@vger.kernel.org>; Sun, 26 Jun 2005 08:21:42 -0700 (PDT)
In-Reply-To: <20050626152105.D86561FB@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, axboe@suse.de, linux-ide@vger.kernel.org

06_NCQ_ahci-new-eh.patch

	This patch converts ahci to use new NCQ helpers.

Signed-off-by: Tejun Heo <htejun@gmail.com>

 ahci.c |  359 +++++++++++------------------------------------------------------
 1 files changed, 63 insertions(+), 296 deletions(-)

Index: work/drivers/scsi/ahci.c
===================================================================
--- work.orig/drivers/scsi/ahci.c	2005-06-27 00:20:29.000000000 +0900
+++ work/drivers/scsi/ahci.c	2005-06-27 00:20:31.000000000 +0900
@@ -171,7 +171,6 @@ struct ahci_port_priv {
 	dma_addr_t		cmd_tbl_dma;
 	void			*rx_fis;
 	dma_addr_t		rx_fis_dma;
-	u32			sactive;
 };
 
 static u32 ahci_scr_read (struct ata_port *ap, unsigned int sc_reg);
@@ -427,6 +426,47 @@ static void ahci_scr_write (struct ata_p
 	writel(val, (void *) ap->ioaddr.scr_addr + (sc_reg * 4));
 }
 
+static void ahci_stop_dma(struct ata_port *ap)
+{
+	void __iomem *port_mmio = (void __iomem *) ap->ioaddr.cmd_addr;
+	u32 tmp;
+	int work;
+
+	/* stop DMA */
+	tmp = readl(port_mmio + PORT_CMD);
+	tmp &= ~PORT_CMD_START;
+	writel(tmp, port_mmio + PORT_CMD);
+
+	/* wait for engine to stop. */
+	work = 500;
+	while (work-- > 0) {
+		tmp = readl(port_mmio + PORT_CMD);
+		if ((tmp & PORT_CMD_LIST_ON) == 0)
+			break;
+		msleep(1);
+	}
+}
+
+static void ahci_start_dma(struct ata_port *ap)
+{
+	void __iomem *port_mmio = (void __iomem *) ap->ioaddr.cmd_addr;
+	u32 tmp;
+
+	/* clear SATA phy error, if any */
+	tmp = readl(port_mmio + PORT_SCR_ERR);
+	writel(tmp, port_mmio + PORT_SCR_ERR);
+
+	/* clear status */
+	tmp = readl(port_mmio + PORT_IRQ_STAT);
+	writel(tmp, port_mmio + PORT_IRQ_STAT);
+
+	/* re-start DMA */
+	tmp = readl(port_mmio + PORT_CMD);
+	tmp |= PORT_CMD_START;
+	writel(tmp, port_mmio + PORT_CMD);
+	readl(port_mmio + PORT_CMD); /* flush */
+}
+
 static void ahci_phy_reset(struct ata_port *ap)
 {
 	void __iomem *port_mmio = (void __iomem *) ap->ioaddr.cmd_addr;
@@ -551,290 +591,36 @@ static void ahci_qc_prep(struct ata_queu
 	ahci_fill_sg(qc, offset);
 }
 
-/*
- * Return 1 if COMRESET was done
- */
-static int ahci_intr_error(struct ata_port *ap, u32 irq_stat)
+static void ahci_eng_timeout(struct ata_port *ap)
 {
-	void *mmio = ap->host_set->mmio_base;
-	void *port_mmio = ahci_port_base(mmio, ap->port_no);
+	void __iomem *port_mmio = (void __iomem *) ap->ioaddr.cmd_addr;
+	int reset = 0;
 	u32 tmp;
-	int work, reset = 0;
 
-	/* stop DMA */
-	tmp = readl(port_mmio + PORT_CMD);
-	tmp &= ~PORT_CMD_START;
-	writel(tmp, port_mmio + PORT_CMD);
-
-	/* wait for engine to stop.  TODO: this could be
-	 * as long as 500 msec
-	 */
-	work = 1000;
-	while (work-- > 0) {
-		tmp = readl(port_mmio + PORT_CMD);
-		if ((tmp & PORT_CMD_LIST_ON) == 0)
-			break;
-		udelay(10);
-	}
-
-	/* clear SATA phy error, if any */
-	tmp = readl(port_mmio + PORT_SCR_ERR);
-	writel(tmp, port_mmio + PORT_SCR_ERR);
-
-	/* clear status */
-	tmp = readl(port_mmio + PORT_IRQ_STAT);
-	writel(tmp, port_mmio + PORT_IRQ_STAT);
+	ahci_stop_dma(ap);
 
-	/* if DRQ/BSY is set, device needs to be reset.
-	 * if so, issue COMRESET
+	/*
+	 * if DRQ/BSY is set, device needs to be reset; otherwise,
+	 * restarting DMA engine should suffice.
 	 */
 	tmp = readl(port_mmio + PORT_TFDATA);
 	if (tmp & (ATA_BUSY | ATA_DRQ)) {
-		printk(KERN_WARNING "ata%u: stat=%x, issuing COMRESET\n", ap->id, tmp);
-		writel(0x301, port_mmio + PORT_SCR_CTL);
-		readl(port_mmio + PORT_SCR_CTL); /* flush */
-		udelay(10);
-		writel(0x300, port_mmio + PORT_SCR_CTL);
-		readl(port_mmio + PORT_SCR_CTL); /* flush */
+		printk(KERN_WARNING DRV_NAME
+		       " ata%u: stat=%x, issuing COMRESET\n", ap->id, tmp);
+		__sata_phy_reset(ap);
 		reset = 1;
 	}
 
-	/* re-start DMA */
-	tmp = readl(port_mmio + PORT_CMD);
-	tmp |= PORT_CMD_START;
-	writel(tmp, port_mmio + PORT_CMD);
-	readl(port_mmio + PORT_CMD); /* flush */
-
-	printk(KERN_WARNING "ata%u: error occurred, port reset\n", ap->id);
-	return reset;
-}
-
-static void ahci_complete_requests(struct ata_port *ap, u32 tag_mask, int err)
-{
-	while (tag_mask) {
-		struct ata_queued_cmd *qc;
-		int tag = ffs(tag_mask) - 1;
-
-		tag_mask &= ~(1 << tag);
-		qc = ata_qc_from_tag(ap, tag);
-		if (qc)
-			ata_qc_complete(qc, err);
-		else
-			printk(KERN_ERR "ahci: missing tag %d\n", tag);
-	}
-}
-
-static void dump_log_page(unsigned char *p)
-{
-	int i;
-
-	printk("LOG 0x10: nq=%d, tag=%d\n", p[0] >> 7, p[0] & 0x1f);
-
-	for (i = 2; i < 14; i++)
-		printk("%d:%d ", i, p[i]);
+	ahci_start_dma(ap);
 
-	printk("\n");
-}
-
-/*
- * TODO: needs to use READ_LOG_EXT/page=10h to retrieve error information
- */
-extern void ata_qc_free(struct ata_queued_cmd *qc);
-static void ahci_ncq_timeout(struct ata_port *ap)
-{
-	struct ahci_port_priv *pp = ap->private_data;
-	void *mmio = ap->host_set->mmio_base;
-	void *port_mmio = ahci_port_base(mmio, ap->port_no);
-	struct ata_queued_cmd *qc;
-	unsigned long flags;
-	char *buffer;
-	u32 sactive;
-	int reset;
-
-	printk(KERN_WARNING "ata%u: ncq interrupt error (Q=%08lx)\n", ap->id, ap->sactive);
-
-	spin_lock_irqsave(&ap->host_set->lock, flags);
-
-	sactive = readl(port_mmio + PORT_SCR_ACT);
-
-	printk(KERN_WARNING "ata%u: SActive 0x%x (0x%x)\n", ap->id, sactive, pp->sactive);
-	reset = ahci_intr_error(ap, readl(port_mmio + PORT_IRQ_STAT));
-
-	spin_unlock_irqrestore(&ap->host_set->lock, flags);
-
-	/*
-	 * if COMRESET was done, we don't have to issue a log page read
-	 */
-	if (reset)
-		goto done;
-
-	buffer = kmalloc(512, GFP_KERNEL);
-	if (!buffer) {
-		printk(KERN_ERR "ata%u: unable to allocate memory for error\n", ap->id);
-		goto done;
-	}
-
-	if (ata_read_log_page(ap, 0, READ_LOG_SATA_NCQ_PAGE, buffer, 1, 0)) {
-		printk(KERN_ERR "ata%u: unable to read log page\n", ap->id);
-		goto out;
-	}
-
-	dump_log_page(buffer);
-
-	/*
-	 * if NQ is cleared, bottom 5 bits contain the tag of the errored
-	 * command
-	 */
-	if ((buffer[0] & (1 << 7)) == 0) {
-		int tag = buffer[0] & 0x1f;
-
-		qc = ata_qc_from_tag(ap, tag);
-		if (qc)
-			ata_qc_complete(qc, ATA_ERR);
-	}
-
-	/*
-	 * requeue the remaining commands
-	 */
-	while (pp->sactive) {
-		int tag = ffs(pp->sactive) - 1;
-
-		pp->sactive &= ~(1 << tag);
-		qc = ata_qc_from_tag(ap, tag);
-		if (qc) {
-			if (qc->scsicmd)
-				ata_qc_free(qc);
-			else
-				ata_qc_complete(qc, ATA_ERR);
-		} else
-			printk(KERN_ERR "ata%u: missing tag %d\n", ap->id, tag);
-	}
-
-out:
-	kfree(buffer);
-done:
-	ata_scsi_unblock_requests(ap);
-}
-
-static void ahci_nonncq_timeout(struct ata_port *ap)
-{
-	void *mmio = ap->host_set->mmio_base;
-	void *port_mmio = ahci_port_base(mmio, ap->port_no);
-	struct ata_queued_cmd *qc;
-
-	DPRINTK("ENTER\n");
-
-	ahci_intr_error(ap, readl(port_mmio + PORT_IRQ_STAT));
-
-	qc = ata_qc_from_tag(ap, ap->active_tag);
-	if (!qc) {
-		printk(KERN_ERR "ata%u: BUG: timeout without command\n",
-		       ap->id);
-	} else {
-		/* hack alert!  We cannot use the supplied completion
-	 	 * function from inside the ->eh_strategy_handler() thread.
-	 	 * libata is the only user of ->eh_strategy_handler() in
-	 	 * any kernel, so the default scsi_done() assumes it is
-	 	 * not being called from the SCSI EH.
-	 	 */
-		qc->scsidone = scsi_finish_command;
-		ata_qc_complete(qc, ATA_ERR);
-	}
-}
-
-static void ahci_eng_timeout(struct ata_port *ap)
-{
-	struct ahci_port_priv *pp = ap->private_data;
-
-	if (pp->sactive)
-		ahci_ncq_timeout(ap);
-	else
-		ahci_nonncq_timeout(ap);
-}
-
-static int ahci_ncq_intr(struct ata_port *ap, u32 status)
-{
-	struct ahci_port_priv *pp = ap->private_data;
-	void *mmio = ap->host_set->mmio_base;
-	void *port_mmio = ahci_port_base(mmio, ap->port_no);
-
-	if (!pp->sactive)
-		return 0;
-
-	if (status & PORT_IRQ_SDB_FIS) {
-		u8 *sdb = pp->rx_fis + RX_FIS_SDB_REG;
-		u32 sactive, mask;
-
-		if (unlikely(sdb[2] & ATA_ERR)) {
-			printk("SDB fis, stat %x, err %x\n", sdb[2], sdb[3]);
-			return 1;
-		}
-
-		/*
-		 * SActive will have the bits cleared for completed commands
-		 */
-		sactive = readl(port_mmio + PORT_SCR_ACT);
-		mask = pp->sactive & ~sactive;
-		if (mask) {
-			ahci_complete_requests(ap, mask, 0);
-			pp->sactive = sactive;
-			return 1;
-		} else
-			printk(KERN_INFO "ata%u: SDB with no bits cleared\n", ap->id);
-	} else if (status & PORT_IRQ_D2H_REG_FIS) {
-		u8 *d2h = pp->rx_fis + RX_FIS_D2H_REG;
-
-		/*
-		 * pre-BSY clear error, let timeout error handling take care
-		 * of it when it kicks in
-		 */
-		if (d2h[2] & ATA_ERR) {
-			VPRINTK("D2H fis, err %x\n", d2h[2]);
-			return 1;
-		}
-
-		printk("D2H fis\n");
-	} else
-		printk(KERN_WARNING "ata%u: unhandled FIS, stat %x\n", ap->id, status);
-
-	return 0;
-}
-
-static void ahci_ncq_intr_error(struct ata_port *ap, u32 status)
-{
-	struct ahci_port_priv *pp = ap->private_data;
-	struct ata_queued_cmd *qc;
-	struct ata_taskfile tf;
-	int tag;
-
-	printk(KERN_ERR "ata%u: NCQ err status 0x%x\n", ap->id, status);
-
-	if (status & PORT_IRQ_D2H_REG_FIS) {
-		ahci_tf_read(ap, &tf);
-		tag = tf.nsect >> 3;
-
-		qc = ata_qc_from_tag(ap, tag);
-		if (qc) {
-			printk(KERN_ERR "ata%u: ending bad tag %d\n", ap->id, tag);
-			pp->sactive &= ~(1 << tag);
-			ata_qc_complete(qc, ATA_ERR);
-		} else
-			printk(KERN_ERR "ata%u: error on tag %d, but not present\n", ap->id, tag);
-	}
-
-	/*
-	 * let command timeout deal with error handling
-	 */
-	ata_scsi_block_requests(ap);
+	/* let libata layer recover */
+	ata_ncq_recover(ap, reset);
 }
 
 static inline int ahci_host_intr(struct ata_port *ap)
 {
-	struct ahci_port_priv *pp = ap->private_data;
-	void *mmio = ap->host_set->mmio_base;
-	void *port_mmio = ahci_port_base(mmio, ap->port_no);
-	struct ata_queued_cmd *qc;
-	u32 status, serr, ci;
+	void __iomem *port_mmio = (void __iomem *) ap->ioaddr.cmd_addr;
+	u32 status, serr;
 
 	serr = readl(port_mmio + PORT_SCR_ERR);
 	writel(serr, port_mmio + PORT_SCR_ERR);
@@ -842,29 +628,13 @@ static inline int ahci_host_intr(struct 
 	status = readl(port_mmio + PORT_IRQ_STAT);
 	writel(status, port_mmio + PORT_IRQ_STAT);
 
-	if (status & PORT_IRQ_FATAL) {
-		printk("ata%u: irq error %x %x, tag %d\n", ap->id, serr, status, ap->active_tag);
-		if (pp->sactive)
-			ahci_ncq_intr_error(ap, status);
-		else
-			ahci_intr_error(ap, status);
-
-		return 1;
-	}
-
-	if (ahci_ncq_intr(ap, status))
-		return 1;
-
-	ci = readl(port_mmio + PORT_CMD_ISSUE);
-
-	if ((ci & (1 << ap->active_tag)) == 0) {
-		VPRINTK("NON-NCQ interrupt\n");
-
-		qc = ata_qc_from_tag(ap, ap->active_tag);
-		if (qc && (qc->flags & ATA_QCFLAG_ACTIVE) &&
-		    !(qc->flags & ATA_QCFLAG_NCQ))
-			ata_qc_complete(qc, 0);
-	}
+	if (!(status & PORT_IRQ_FATAL)) {
+		void *cmd_issue = port_mmio + PORT_CMD_ISSUE;
+		if (ap->sactive ||
+		    (readl(cmd_issue) & (1 << ap->active_tag)) == 0)
+			ata_ncq_complete(ap);
+	} else
+		ata_ncq_abort(ap);
 
 	return 1;
 }
@@ -921,13 +691,10 @@ static irqreturn_t ahci_interrupt (int i
 static int ahci_qc_issue(struct ata_queued_cmd *qc)
 {
 	struct ata_port *ap = qc->ap;
-	struct ahci_port_priv *pp = ap->private_data;
 	void *port_mmio = (void *) ap->ioaddr.cmd_addr;
 	unsigned int tag = ata_qc_to_tag(qc);
 
 	if (qc->flags & ATA_QCFLAG_NCQ) {
-		pp->sactive |= (1 << tag);
-
 		writel(1 << tag, port_mmio + PORT_SCR_ACT);
 		readl(port_mmio + PORT_SCR_ACT);
 	}

