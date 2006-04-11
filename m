From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 14/14] sata_sil24: convert to new EH
Date: Tue, 11 Apr 2006 22:48:23 +0900
Message-ID: <11447633031542-git-send-email-htejun@gmail.com>
References: <11447633013561-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.236]:12958 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750952AbWDKNsf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 11 Apr 2006 09:48:35 -0400
Received: by wproxy.gmail.com with SMTP id i11so926523wra
        for <linux-ide@vger.kernel.org>; Tue, 11 Apr 2006 06:48:34 -0700 (PDT)
In-Reply-To: <11447633013561-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, lkosewsk@gmail.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Convert sata_sil24 to new EH.

* When port is frozen, IRQ for the port is masked.

* sil24_softreset() doesn't need to mangle with IRQ mask anymore.
  libata ensures that the port is frozen during reset.

* Only turn on interrupts which are handled by interrupt handler and
  EH.  As we don't handle SDB notify yet, turn it off. DEV_XCHG and
  UNK_FIS are handled by EH and thus turned on.

* sil24_softreset() usually fails to recover the port after DEV_XCHG.
  ATA_PORT_HARDRESET is used as recovery action for DEV_XCHG.

* sil24 may be invoked without any active command.  e.g. DEV_XCHG irq
  occuring while no qc in progress still triggers EH and will reset
  the port and revalidate attached device.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/sata_sil24.c |  330 +++++++++++++++++++++++++++------------------
 1 files changed, 195 insertions(+), 135 deletions(-)

0300dfe12d10341a2f82a93b3cc64436352088a0
diff --git a/drivers/scsi/sata_sil24.c b/drivers/scsi/sata_sil24.c
index 9320368..bbbc18a 100644
--- a/drivers/scsi/sata_sil24.c
+++ b/drivers/scsi/sata_sil24.c
@@ -156,6 +156,10 @@ enum {
 	PORT_IRQ_HANDSHAKE	= (1 << 10), /* handshake error threshold */
 	PORT_IRQ_SDB_NOTIFY	= (1 << 11), /* SDB notify received */
 
+	PORT_IRQ_FREEZE		= PORT_IRQ_DEV_XCHG | PORT_IRQ_UNK_FIS,
+	DEF_PORT_IRQ		= PORT_IRQ_FREEZE |
+				  PORT_IRQ_COMPLETE | PORT_IRQ_ERROR,
+
 	/* bits[27:16] are unmasked (raw) */
 	PORT_IRQ_RAW_SHIFT	= 16,
 	PORT_IRQ_MASKED_MASK	= 0x7ff,
@@ -242,6 +246,58 @@ union sil24_cmd_block {
 	struct sil24_atapi_block atapi;
 };
 
+static struct sil24_cerr_info {
+	unsigned int err_mask, action;
+	const char *desc;
+} sil24_cerr_db[] = {
+	[0]			= { AC_ERR_DEV, 0,	/* covers ATAPI CC */
+				    "device error" },
+	[PORT_CERR_DEV]		= { AC_ERR_DEV, ATA_PORT_REVALIDATE,
+				    "device error via D2H FIS" },
+	[PORT_CERR_SDB]		= { AC_ERR_DEV, ATA_PORT_REVALIDATE,
+				    "device error via SDB FIS" },
+	[PORT_CERR_DATA]	= { AC_ERR_ATA_BUS, ATA_PORT_SOFTRESET,
+				    "error in data FIS" },
+	[PORT_CERR_SEND]	= { AC_ERR_ATA_BUS, ATA_PORT_SOFTRESET,
+				    "failed to transmit command FIS" },
+	[PORT_CERR_INCONSISTENT] = { AC_ERR_HSM, ATA_PORT_SOFTRESET,
+				     "protocol mismatch" },
+	[PORT_CERR_DIRECTION]	= { AC_ERR_HSM, ATA_PORT_SOFTRESET,
+				    "data directon mismatch" },
+	[PORT_CERR_UNDERRUN]	= { AC_ERR_HSM, ATA_PORT_SOFTRESET,
+				    "ran out of SGEs while writing" },
+	[PORT_CERR_OVERRUN]	= { AC_ERR_HSM, ATA_PORT_SOFTRESET,
+				    "ran out of SGEs while reading" },
+	[PORT_CERR_PKT_PROT]	= { AC_ERR_HSM, ATA_PORT_SOFTRESET,
+				    "invalid data directon for ATAPI CDB" },
+	[PORT_CERR_SGT_BOUNDARY] = { AC_ERR_SYSTEM, ATA_PORT_SOFTRESET,
+				     "SGT no on qword boundary" },
+	[PORT_CERR_SGT_TGTABRT]	= { AC_ERR_HOST_BUS, ATA_PORT_SOFTRESET,
+				    "PCI target abort while fetching SGT" },
+	[PORT_CERR_SGT_MSTABRT]	= { AC_ERR_HOST_BUS, ATA_PORT_SOFTRESET,
+				    "PCI master abort while fetching SGT" },
+	[PORT_CERR_SGT_PCIPERR]	= { AC_ERR_HOST_BUS, ATA_PORT_SOFTRESET,
+				    "PCI parity error while fetching SGT" },
+	[PORT_CERR_CMD_BOUNDARY] = { AC_ERR_SYSTEM, ATA_PORT_SOFTRESET,
+				     "PRB not on qword boundary" },
+	[PORT_CERR_CMD_TGTABRT]	= { AC_ERR_HOST_BUS, ATA_PORT_SOFTRESET,
+				    "PCI target abort while fetching PRB" },
+	[PORT_CERR_CMD_MSTABRT]	= { AC_ERR_HOST_BUS, ATA_PORT_SOFTRESET,
+				    "PCI master abort while fetching PRB" },
+	[PORT_CERR_CMD_PCIPERR]	= { AC_ERR_HOST_BUS, ATA_PORT_SOFTRESET,
+				    "PCI parity error while fetching PRB" },
+	[PORT_CERR_XFR_UNDEF]	= { AC_ERR_HOST_BUS, ATA_PORT_SOFTRESET,
+				    "undefined error while transferring data" },
+	[PORT_CERR_XFR_TGTABRT]	= { AC_ERR_HOST_BUS, ATA_PORT_SOFTRESET,
+				    "PCI target abort while transferring data" },
+	[PORT_CERR_XFR_MSTABRT]	= { AC_ERR_HOST_BUS, ATA_PORT_SOFTRESET,
+				    "PCI master abort while transferring data" },
+	[PORT_CERR_XFR_PCIPERR]	= { AC_ERR_HOST_BUS, ATA_PORT_SOFTRESET,
+				    "PCI parity error while transferring data" },
+	[PORT_CERR_SENDSERVICE]	= { AC_ERR_HSM, ATA_PORT_SOFTRESET,
+				    "FIS received while sending service FIS" },
+};
+
 /*
  * ap->private_data
  *
@@ -251,7 +307,8 @@ union sil24_cmd_block {
 struct sil24_port_priv {
 	union sil24_cmd_block *cmd_block;	/* 32 cmd blocks */
 	dma_addr_t cmd_block_dma;		/* DMA base addr for them */
-	struct ata_taskfile tf;			/* Cached taskfile registers */
+	struct ata_taskfile tf;			/* cached taskfile registers */
+	u32 eh_irq_stat;			/* saved irq_stat for EH */
 };
 
 /* ap->host_set->private_data */
@@ -269,7 +326,9 @@ static int sil24_probe_reset(struct ata_
 static void sil24_qc_prep(struct ata_queued_cmd *qc);
 static unsigned int sil24_qc_issue(struct ata_queued_cmd *qc);
 static void sil24_irq_clear(struct ata_port *ap);
-static void sil24_eng_timeout(struct ata_port *ap);
+static void sil24_freeze(struct ata_port *ap);
+static void sil24_error_handler(struct ata_port *ap);
+static void sil24_post_internal_cmd(struct ata_queued_cmd *qc);
 static irqreturn_t sil24_interrupt(int irq, void *dev_instance, struct pt_regs *regs);
 static int sil24_port_start(struct ata_port *ap);
 static void sil24_port_stop(struct ata_port *ap);
@@ -326,7 +385,9 @@ static const struct ata_port_operations 
 	.qc_prep		= sil24_qc_prep,
 	.qc_issue		= sil24_qc_issue,
 
-	.eng_timeout		= sil24_eng_timeout,
+	.freeze			= sil24_freeze,
+	.error_handler		= sil24_error_handler,
+	.post_internal_cmd	= sil24_post_internal_cmd,
 
 	.irq_handler		= sil24_interrupt,
 	.irq_clear		= sil24_irq_clear,
@@ -460,7 +521,7 @@ static int sil24_softreset(struct ata_po
 	struct sil24_port_priv *pp = ap->private_data;
 	struct sil24_prb *prb = &pp->cmd_block[0].ata.prb;
 	dma_addr_t paddr = pp->cmd_block_dma;
-	u32 mask, irq_enable, irq_stat;
+	u32 mask, irq_stat;
 	const char *reason;
 
 	DPRINTK("ENTER\n");
@@ -471,10 +532,6 @@ static int sil24_softreset(struct ata_po
 		goto out;
 	}
 
-	/* temporarily turn off IRQs during SRST */
-	irq_enable = readl(port + PORT_IRQ_ENABLE_SET);
-	writel(irq_enable, port + PORT_IRQ_ENABLE_CLR);
-
 	/* put the port into known state */
 	if (sil24_init_port(ap)) {
 		reason ="port not ready";
@@ -495,9 +552,6 @@ static int sil24_softreset(struct ata_po
 	writel(irq_stat, port + PORT_IRQ_STAT); /* clear IRQs */
 	irq_stat >>= PORT_IRQ_RAW_SHIFT;
 
-	/* restore IRQs */
-	writel(irq_enable, port + PORT_IRQ_ENABLE_SET);
-
 	if (!(irq_stat & PORT_IRQ_COMPLETE)) {
 		if (irq_stat & PORT_IRQ_ERROR)
 			reason = "SRST command error";
@@ -566,11 +620,27 @@ static int sil24_hardreset(struct ata_po
 	return -EIO;
 }
 
+static void sil24_postreset(struct ata_port *ap, unsigned int *classes)
+{
+	void __iomem *port = (void __iomem *)ap->ioaddr.cmd_addr;
+	u32 tmp;
+
+	/* clear IRQ */
+	tmp = readl(port + PORT_IRQ_STAT);
+	writel(tmp, port + PORT_IRQ_STAT);
+
+	/* turn IRQ back on */
+	writel(DEF_PORT_IRQ, port + PORT_IRQ_ENABLE_SET);
+
+	/* do the standard stuff */
+	ata_std_postreset(ap, classes);
+}
+
 static int sil24_probe_reset(struct ata_port *ap, unsigned int *classes)
 {
 	return ata_drive_probe_reset(ap, ata_std_probeinit,
 				     sil24_softreset, sil24_hardreset,
-				     ata_std_postreset, classes);
+				     sil24_postreset, classes);
 }
 
 static inline void sil24_fill_sg(struct ata_queued_cmd *qc,
@@ -656,152 +726,138 @@ static void sil24_irq_clear(struct ata_p
 	/* unused */
 }
 
-static int __sil24_restart_controller(void __iomem *port)
+static void sil24_freeze(struct ata_port *ap)
 {
-	u32 tmp;
-	int cnt;
-
-	writel(PORT_CS_INIT, port + PORT_CTRL_STAT);
-
-	/* Max ~10ms */
-	for (cnt = 0; cnt < 10000; cnt++) {
-		tmp = readl(port + PORT_CTRL_STAT);
-		if (tmp & PORT_CS_RDY)
-			return 0;
-		udelay(1);
-	}
-
-	return -1;
-}
+	void __iomem *port = (void __iomem *)ap->ioaddr.cmd_addr;
 
-static void sil24_restart_controller(struct ata_port *ap)
-{
-	if (__sil24_restart_controller((void __iomem *)ap->ioaddr.cmd_addr))
-		printk(KERN_ERR DRV_NAME
-		       " ata%u: failed to restart controller\n", ap->id);
+	/* Port-wide IRQ mask in HOST_CTRL doesn't really work, clear
+	 * PORT_IRQ_ENABLE instead.
+	 */
+	writel(0xffff, port + PORT_IRQ_ENABLE_CLR);
 }
 
-static int __sil24_reset_controller(void __iomem *port)
+static unsigned int sil24_eh_autopsy(struct ata_port *ap, u32 irq_stat,
+				     unsigned int *r_err_mask,
+				     char *desc, size_t desc_sz)
 {
-	int cnt;
-	u32 tmp;
-
-	/* Reset controller state.  Is this correct? */
-	writel(PORT_CS_DEV_RST, port + PORT_CTRL_STAT);
-	readl(port + PORT_CTRL_STAT);	/* sync */
+	void __iomem *port = (void __iomem *)ap->ioaddr.cmd_addr;
+	unsigned int err_mask = 0, action = 0;
+	int rc;
 
-	/* Max ~100ms */
-	for (cnt = 0; cnt < 1000; cnt++) {
-		udelay(100);
-		tmp = readl(port + PORT_CTRL_STAT);
-		if (!(tmp & PORT_CS_DEV_RST))
-			break;
+	rc = scnprintf(desc, desc_sz, "irq_stat 0x%08x", irq_stat);
+	desc += rc;
+	desc_sz -= rc;
+
+	if (irq_stat & PORT_IRQ_DEV_XCHG) {
+		err_mask |= AC_ERR_ATA_BUS;
+		/* sil24 doesn't recover very well from phy
+		 * disconnection with a softreset.  Force hardreset.
+		 */
+		action |= ATA_PORT_HARDRESET;
+		rc = scnprintf(desc, desc_sz, ", device exchanged");
+		desc += rc;
+		desc_sz -= rc;
 	}
 
-	if (tmp & PORT_CS_DEV_RST)
-		return -1;
-
-	if (tmp & PORT_CS_RDY)
-		return 0;
+	if (irq_stat & PORT_IRQ_UNK_FIS) {
+		err_mask |= AC_ERR_HSM;
+		action |= ATA_PORT_SOFTRESET;
+		rc = scnprintf(desc, desc_sz, ", unknown FIS");
+		desc += rc;
+		desc_sz -= rc;
+	}
 
-	return __sil24_restart_controller(port);
-}
+	if (irq_stat & PORT_IRQ_ERROR) {
+		struct sil24_cerr_info *ci = NULL;
+		u32 cerr;
+
+		cerr = readl(port + PORT_CMD_ERR);
+		if (cerr < ARRAY_SIZE(sil24_cerr_db))
+			ci = &sil24_cerr_db[cerr];
+
+		if (ci && ci->desc) {
+			err_mask |= ci->err_mask;
+			action |= ci->action;
+			rc = scnprintf(desc, desc_sz, ", %s", ci->desc);
+		} else {
+			err_mask |= AC_ERR_OTHER;
+			action |= ATA_PORT_SOFTRESET;
+			rc = scnprintf(desc, desc_sz,
+				       ", unknown command error %d", cerr);
+		}
+		desc += rc;
+		desc_sz -= rc;
+	}
 
-static void sil24_reset_controller(struct ata_port *ap)
-{
-	printk(KERN_NOTICE DRV_NAME
-	       " ata%u: resetting controller...\n", ap->id);
-	if (__sil24_reset_controller((void __iomem *)ap->ioaddr.cmd_addr))
-                printk(KERN_ERR DRV_NAME
-                       " ata%u: failed to reset controller\n", ap->id);
+	*r_err_mask |= err_mask;
+	return action;
 }
 
-static void sil24_eng_timeout(struct ata_port *ap)
+static void sil24_error_handler(struct ata_port *ap)
 {
+	struct sil24_port_priv *pp = ap->private_data;
+	unsigned int action = 0;
+	unsigned int err_mask = 0;
+	unsigned long flags;
+	u32 irq_stat, serror;
+	struct ata_taskfile tf;
 	struct ata_queued_cmd *qc;
+	char desc[70] = "";
 
-	qc = ata_qc_from_tag(ap, ap->active_tag);
+	/* fetch & clear error information */
+	spin_lock_irqsave(&ap->host_set->lock, flags);
+	irq_stat = pp->eh_irq_stat;
+	pp->eh_irq_stat = 0;
+	spin_unlock_irqrestore(&ap->host_set->lock, flags);
+
+	serror = scr_read(ap, SCR_ERROR);
+	scr_write(ap, SCR_ERROR, serror);
+
+	/* if not frozen, resume the port.  if fail, freeze */
+	if (!(ap->flags & ATA_FLAG_FROZEN))
+		if (sil24_init_port(ap))
+			ata_eh_schedule_port(ap, ATA_EH_FREEZE);
 
-	printk(KERN_ERR "ata%u: command timeout\n", ap->id);
-	qc->err_mask |= AC_ERR_TIMEOUT;
-	ata_eh_qc_complete(qc);
+	/* perform recovery */
+	action |= sil24_eh_autopsy(ap, irq_stat, &err_mask, desc, sizeof(desc));
+
+	qc = ata_eh_determine_qc(ap, &tf);
+	if (qc)
+		qc->err_mask |= err_mask;
 
-	sil24_reset_controller(ap);
+	action |= ata_eh_autopsy(ap, qc, &tf, serror);
+	ata_eh_report(ap, qc, &tf, serror, action, desc);
+	ata_eh_revive(ap, action,
+		      sil24_softreset, sil24_hardreset, sil24_postreset);
+	ata_eh_finish_qcs(ap, qc, &tf);
 }
 
-static void sil24_error_intr(struct ata_port *ap, u32 slot_stat)
+static void sil24_post_internal_cmd(struct ata_queued_cmd *qc)
 {
-	struct ata_queued_cmd *qc = ata_qc_from_tag(ap, ap->active_tag);
-	struct sil24_port_priv *pp = ap->private_data;
-	void __iomem *port = (void __iomem *)ap->ioaddr.cmd_addr;
-	u32 irq_stat, cmd_err, sstatus, serror;
-	unsigned int err_mask;
-
-	irq_stat = readl(port + PORT_IRQ_STAT);
-	writel(irq_stat, port + PORT_IRQ_STAT);		/* clear irq */
-
-	if (!(irq_stat & PORT_IRQ_ERROR)) {
-		/* ignore non-completion, non-error irqs for now */
-		printk(KERN_WARNING DRV_NAME
-		       "ata%u: non-error exception irq (irq_stat %x)\n",
-		       ap->id, irq_stat);
-		return;
-	}
+	struct ata_port *ap = qc->ap;
 
-	cmd_err = readl(port + PORT_CMD_ERR);
-	sstatus = readl(port + PORT_SSTATUS);
-	serror = readl(port + PORT_SERROR);
-	if (serror)
-		writel(serror, port + PORT_SERROR);
+	if (qc->flags & ATA_QCFLAG_FAILED)
+		qc->err_mask |= AC_ERR_OTHER;
 
-	/*
-	 * Don't log ATAPI device errors.  They're supposed to happen
-	 * and any serious errors will be logged using sense data by
-	 * the SCSI layer.
-	 */
-	if (ap->device[0].class != ATA_DEV_ATAPI || cmd_err > PORT_CERR_SDB)
-		printk("ata%u: error interrupt on port%d\n"
-		       "  stat=0x%x irq=0x%x cmd_err=%d sstatus=0x%x serror=0x%x\n",
-		       ap->id, ap->port_no, slot_stat, irq_stat, cmd_err, sstatus, serror);
-
-	if (cmd_err == PORT_CERR_DEV || cmd_err == PORT_CERR_SDB) {
-		/*
-		 * Device is reporting error, tf registers are valid.
-		 */
-		sil24_update_tf(ap);
-		err_mask = ac_err_mask(pp->tf.command);
-		sil24_restart_controller(ap);
-	} else {
-		/*
-		 * Other errors.  libata currently doesn't have any
-		 * mechanism to report these errors.  Just turn on
-		 * ATA_ERR.
-		 */
-		err_mask = AC_ERR_OTHER;
-		sil24_reset_controller(ap);
-	}
-
-	if (qc) {
-		qc->err_mask |= err_mask;
-		ata_qc_complete(qc);
-	}
+	/* make DMA engine forget about the failed command */
+	if (qc->err_mask)
+		sil24_init_port(ap);
 }
 
 static inline void sil24_host_intr(struct ata_port *ap)
 {
 	struct ata_queued_cmd *qc = ata_qc_from_tag(ap, ap->active_tag);
+	struct sil24_port_priv *pp = ap->private_data;
 	void __iomem *port = (void __iomem *)ap->ioaddr.cmd_addr;
-	u32 slot_stat;
+	u32 slot_stat, irq_stat;
+	unsigned int eh_flags;
 
 	slot_stat = readl(port + PORT_SLOT_STAT);
 	if (!(slot_stat & HOST_SSTAT_ATTN)) {
-		struct sil24_port_priv *pp = ap->private_data;
-
 		if (ap->flags & SIL24_FLAG_PCIX_IRQ_WOC)
 			writel(PORT_IRQ_COMPLETE, port + PORT_IRQ_STAT);
 
-		/*
-		 * !HOST_SSAT_ATTN guarantees successful completion,
+		/* !HOST_SSAT_ATTN guarantees successful completion,
 		 * so reading back tf registers is unnecessary for
 		 * most commands.  TODO: read tf registers for
 		 * commands which require these values on successful
@@ -814,8 +870,21 @@ static inline void sil24_host_intr(struc
 			qc->err_mask |= ac_err_mask(pp->tf.command);
 			ata_qc_complete(qc);
 		}
-	} else
-		sil24_error_intr(ap, slot_stat);
+
+		return;
+	}
+
+	/* something weird is going on, pass it to EH */
+	irq_stat = readl(port + PORT_IRQ_STAT);
+	writel(irq_stat, port + PORT_IRQ_STAT);
+
+	pp->eh_irq_stat = irq_stat;
+
+	eh_flags = ATA_EH_ABORT;
+	if (irq_stat & PORT_IRQ_FREEZE)
+		eh_flags |= ATA_EH_FREEZE;
+
+	ata_eh_schedule_port(ap, eh_flags);
 }
 
 static irqreturn_t sil24_interrupt(int irq, void *dev_instance, struct pt_regs *regs)
@@ -1067,15 +1136,6 @@ static int sil24_init_one(struct pci_dev
 		/* Always use 64bit activation */
 		writel(PORT_CS_32BIT_ACTV, port + PORT_CTRL_CLR);
 
-		/* Configure interrupts */
-		writel(0xffff, port + PORT_IRQ_ENABLE_CLR);
-		writel(PORT_IRQ_COMPLETE | PORT_IRQ_ERROR |
-		       PORT_IRQ_SDB_NOTIFY, port + PORT_IRQ_ENABLE_SET);
-
-		/* Clear interrupts */
-		writel(0x0fff0fff, port + PORT_IRQ_STAT);
-		writel(PORT_CS_IRQ_WOC, port + PORT_CTRL_CLR);
-
 		/* Clear port multiplier enable and resume bits */
 		writel(PORT_CS_PM_EN | PORT_CS_RESUME, port + PORT_CTRL_CLR);
 	}
-- 
1.2.4


