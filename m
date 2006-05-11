From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 11/11] sata_sil24: convert to new EH
Date: Thu, 11 May 2006 22:21:29 +0900
Message-ID: <11473536893684-git-send-email-htejun@gmail.com>
References: <11473536873966-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.181]:11512 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751741AbWEKNVj (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 11 May 2006 09:21:39 -0400
Received: by py-out-1112.google.com with SMTP id f28so234284pyf
        for <linux-ide@vger.kernel.org>; Thu, 11 May 2006 06:21:39 -0700 (PDT)
In-Reply-To: <11473536873966-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, forrest.zhao@intel.com, efalk@google.com, linux-ide@vger.kernel.org
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

 drivers/scsi/sata_sil24.c |  330 ++++++++++++++++++++++++++-------------------
 1 files changed, 188 insertions(+), 142 deletions(-)

5b5d5120add6debc3e80842b94464678aeee4036
diff --git a/drivers/scsi/sata_sil24.c b/drivers/scsi/sata_sil24.c
index 6144f7c..adbb5a6 100644
--- a/drivers/scsi/sata_sil24.c
+++ b/drivers/scsi/sata_sil24.c
@@ -156,6 +156,9 @@ enum {
 	PORT_IRQ_HANDSHAKE	= (1 << 10), /* handshake error threshold */
 	PORT_IRQ_SDB_NOTIFY	= (1 << 11), /* SDB notify received */
 
+	DEF_PORT_IRQ		= PORT_IRQ_COMPLETE | PORT_IRQ_ERROR |
+				  PORT_IRQ_DEV_XCHG | PORT_IRQ_UNK_FIS,
+
 	/* bits[27:16] are unmasked (raw) */
 	PORT_IRQ_RAW_SHIFT	= 16,
 	PORT_IRQ_MASKED_MASK	= 0x7ff,
@@ -242,6 +245,58 @@ union sil24_cmd_block {
 	struct sil24_atapi_block atapi;
 };
 
+static struct sil24_cerr_info {
+	unsigned int err_mask, action;
+	const char *desc;
+} sil24_cerr_db[] = {
+	[0]			= { AC_ERR_DEV, ATA_EH_REVALIDATE,
+				    "device error" },
+	[PORT_CERR_DEV]		= { AC_ERR_DEV, ATA_EH_REVALIDATE,
+				    "device error via D2H FIS" },
+	[PORT_CERR_SDB]		= { AC_ERR_DEV, ATA_EH_REVALIDATE,
+				    "device error via SDB FIS" },
+	[PORT_CERR_DATA]	= { AC_ERR_ATA_BUS, ATA_EH_SOFTRESET,
+				    "error in data FIS" },
+	[PORT_CERR_SEND]	= { AC_ERR_ATA_BUS, ATA_EH_SOFTRESET,
+				    "failed to transmit command FIS" },
+	[PORT_CERR_INCONSISTENT] = { AC_ERR_HSM, ATA_EH_SOFTRESET,
+				     "protocol mismatch" },
+	[PORT_CERR_DIRECTION]	= { AC_ERR_HSM, ATA_EH_SOFTRESET,
+				    "data directon mismatch" },
+	[PORT_CERR_UNDERRUN]	= { AC_ERR_HSM, ATA_EH_SOFTRESET,
+				    "ran out of SGEs while writing" },
+	[PORT_CERR_OVERRUN]	= { AC_ERR_HSM, ATA_EH_SOFTRESET,
+				    "ran out of SGEs while reading" },
+	[PORT_CERR_PKT_PROT]	= { AC_ERR_HSM, ATA_EH_SOFTRESET,
+				    "invalid data directon for ATAPI CDB" },
+	[PORT_CERR_SGT_BOUNDARY] = { AC_ERR_SYSTEM, ATA_EH_SOFTRESET,
+				     "SGT no on qword boundary" },
+	[PORT_CERR_SGT_TGTABRT]	= { AC_ERR_HOST_BUS, ATA_EH_SOFTRESET,
+				    "PCI target abort while fetching SGT" },
+	[PORT_CERR_SGT_MSTABRT]	= { AC_ERR_HOST_BUS, ATA_EH_SOFTRESET,
+				    "PCI master abort while fetching SGT" },
+	[PORT_CERR_SGT_PCIPERR]	= { AC_ERR_HOST_BUS, ATA_EH_SOFTRESET,
+				    "PCI parity error while fetching SGT" },
+	[PORT_CERR_CMD_BOUNDARY] = { AC_ERR_SYSTEM, ATA_EH_SOFTRESET,
+				     "PRB not on qword boundary" },
+	[PORT_CERR_CMD_TGTABRT]	= { AC_ERR_HOST_BUS, ATA_EH_SOFTRESET,
+				    "PCI target abort while fetching PRB" },
+	[PORT_CERR_CMD_MSTABRT]	= { AC_ERR_HOST_BUS, ATA_EH_SOFTRESET,
+				    "PCI master abort while fetching PRB" },
+	[PORT_CERR_CMD_PCIPERR]	= { AC_ERR_HOST_BUS, ATA_EH_SOFTRESET,
+				    "PCI parity error while fetching PRB" },
+	[PORT_CERR_XFR_UNDEF]	= { AC_ERR_HOST_BUS, ATA_EH_SOFTRESET,
+				    "undefined error while transferring data" },
+	[PORT_CERR_XFR_TGTABRT]	= { AC_ERR_HOST_BUS, ATA_EH_SOFTRESET,
+				    "PCI target abort while transferring data" },
+	[PORT_CERR_XFR_MSTABRT]	= { AC_ERR_HOST_BUS, ATA_EH_SOFTRESET,
+				    "PCI master abort while transferring data" },
+	[PORT_CERR_XFR_PCIPERR]	= { AC_ERR_HOST_BUS, ATA_EH_SOFTRESET,
+				    "PCI parity error while transferring data" },
+	[PORT_CERR_SENDSERVICE]	= { AC_ERR_HSM, ATA_EH_SOFTRESET,
+				    "FIS received while sending service FIS" },
+};
+
 /*
  * ap->private_data
  *
@@ -269,8 +324,11 @@ static int sil24_probe_reset(struct ata_
 static void sil24_qc_prep(struct ata_queued_cmd *qc);
 static unsigned int sil24_qc_issue(struct ata_queued_cmd *qc);
 static void sil24_irq_clear(struct ata_port *ap);
-static void sil24_eng_timeout(struct ata_port *ap);
 static irqreturn_t sil24_interrupt(int irq, void *dev_instance, struct pt_regs *regs);
+static void sil24_freeze(struct ata_port *ap);
+static void sil24_thaw(struct ata_port *ap);
+static void sil24_error_handler(struct ata_port *ap);
+static void sil24_post_internal_cmd(struct ata_queued_cmd *qc);
 static int sil24_port_start(struct ata_port *ap);
 static void sil24_port_stop(struct ata_port *ap);
 static void sil24_host_stop(struct ata_host_set *host_set);
@@ -325,14 +383,17 @@ static const struct ata_port_operations 
 	.qc_prep		= sil24_qc_prep,
 	.qc_issue		= sil24_qc_issue,
 
-	.eng_timeout		= sil24_eng_timeout,
-
 	.irq_handler		= sil24_interrupt,
 	.irq_clear		= sil24_irq_clear,
 
 	.scr_read		= sil24_scr_read,
 	.scr_write		= sil24_scr_write,
 
+	.freeze			= sil24_freeze,
+	.thaw			= sil24_thaw,
+	.error_handler		= sil24_error_handler,
+	.post_internal_cmd	= sil24_post_internal_cmd,
+
 	.port_start		= sil24_port_start,
 	.port_stop		= sil24_port_stop,
 	.host_stop		= sil24_host_stop,
@@ -459,7 +520,7 @@ static int sil24_softreset(struct ata_po
 	struct sil24_port_priv *pp = ap->private_data;
 	struct sil24_prb *prb = &pp->cmd_block[0].ata.prb;
 	dma_addr_t paddr = pp->cmd_block_dma;
-	u32 mask, irq_enable, irq_stat;
+	u32 mask, irq_stat;
 	const char *reason;
 
 	DPRINTK("ENTER\n");
@@ -470,10 +531,6 @@ static int sil24_softreset(struct ata_po
 		goto out;
 	}
 
-	/* temporarily turn off IRQs during SRST */
-	irq_enable = readl(port + PORT_IRQ_ENABLE_SET);
-	writel(irq_enable, port + PORT_IRQ_ENABLE_CLR);
-
 	/* put the port into known state */
 	if (sil24_init_port(ap)) {
 		reason ="port not ready";
@@ -494,9 +551,6 @@ static int sil24_softreset(struct ata_po
 	writel(irq_stat, port + PORT_IRQ_STAT); /* clear IRQs */
 	irq_stat >>= PORT_IRQ_RAW_SHIFT;
 
-	/* restore IRQs */
-	writel(irq_enable, port + PORT_IRQ_ENABLE_SET);
-
 	if (!(irq_stat & PORT_IRQ_COMPLETE)) {
 		if (irq_stat & PORT_IRQ_ERROR)
 			reason = "SRST command error";
@@ -655,158 +709,134 @@ static void sil24_irq_clear(struct ata_p
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
+static void sil24_thaw(struct ata_port *ap)
 {
-	int cnt;
+	void __iomem *port = (void __iomem *)ap->ioaddr.cmd_addr;
 	u32 tmp;
 
-	/* Reset controller state.  Is this correct? */
-	writel(PORT_CS_DEV_RST, port + PORT_CTRL_STAT);
-	readl(port + PORT_CTRL_STAT);	/* sync */
-
-	/* Max ~100ms */
-	for (cnt = 0; cnt < 1000; cnt++) {
-		udelay(100);
-		tmp = readl(port + PORT_CTRL_STAT);
-		if (!(tmp & PORT_CS_DEV_RST))
-			break;
-	}
-
-	if (tmp & PORT_CS_DEV_RST)
-		return -1;
+	/* clear IRQ */
+	tmp = readl(port + PORT_IRQ_STAT);
+	writel(tmp, port + PORT_IRQ_STAT);
 
-	if (tmp & PORT_CS_RDY)
-		return 0;
-
-	return __sil24_restart_controller(port);
+	/* turn IRQ back on */
+	writel(DEF_PORT_IRQ, port + PORT_IRQ_ENABLE_SET);
 }
 
-static void sil24_reset_controller(struct ata_port *ap)
+static void sil24_error_intr(struct ata_port *ap)
 {
-	printk(KERN_NOTICE DRV_NAME
-	       " ata%u: resetting controller...\n", ap->id);
-	if (__sil24_reset_controller((void __iomem *)ap->ioaddr.cmd_addr))
-                printk(KERN_ERR DRV_NAME
-                       " ata%u: failed to reset controller\n", ap->id);
-}
-
-static void sil24_eng_timeout(struct ata_port *ap)
-{
-	struct ata_queued_cmd *qc;
-
-	qc = ata_qc_from_tag(ap, ap->active_tag);
-
-	ata_port_printk(ap, KERN_ERR, "command timeout\n");
-	qc->err_mask |= AC_ERR_TIMEOUT;
-	ata_eh_qc_complete(qc);
-
-	sil24_reset_controller(ap);
-}
-
-static void sil24_error_intr(struct ata_port *ap, u32 slot_stat)
-{
-	struct ata_queued_cmd *qc = ata_qc_from_tag(ap, ap->active_tag);
-	struct sil24_port_priv *pp = ap->private_data;
 	void __iomem *port = (void __iomem *)ap->ioaddr.cmd_addr;
-	u32 irq_stat, cmd_err, sstatus, serror;
-	unsigned int err_mask;
+	struct ata_eh_info *ehi = &ap->eh_info;
+	int freeze = 0;
+	u32 irq_stat;
 
+	/* on error, we need to clear IRQ explicitly */
 	irq_stat = readl(port + PORT_IRQ_STAT);
-	writel(irq_stat, port + PORT_IRQ_STAT);		/* clear irq */
+	writel(irq_stat, port + PORT_IRQ_STAT);
 
-	if (!(irq_stat & PORT_IRQ_ERROR)) {
-		/* ignore non-completion, non-error irqs for now */
-		printk(KERN_WARNING DRV_NAME
-		       "ata%u: non-error exception irq (irq_stat %x)\n",
-		       ap->id, irq_stat);
-		return;
-	}
+	/* first, analyze and record host port events */
+	ata_ehi_clear_desc(ehi);
 
-	cmd_err = readl(port + PORT_CMD_ERR);
-	sstatus = readl(port + PORT_SSTATUS);
-	serror = readl(port + PORT_SERROR);
-	if (serror)
-		writel(serror, port + PORT_SERROR);
+	ata_ehi_push_desc(ehi, "irq_stat 0x%08x", irq_stat);
 
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
+	if (irq_stat & PORT_IRQ_DEV_XCHG) {
+		ehi->err_mask |= AC_ERR_ATA_BUS;
+		/* sil24 doesn't recover very well from phy
+		 * disconnection with a softreset.  Force hardreset.
 		 */
-		err_mask = AC_ERR_OTHER;
-		sil24_reset_controller(ap);
-	}
+		ehi->action |= ATA_EH_HARDRESET;
+		ata_ehi_push_desc(ehi, ", device_exchanged");
+		freeze = 1;
+	}
+
+	if (irq_stat & PORT_IRQ_UNK_FIS) {
+		ehi->err_mask |= AC_ERR_HSM;
+		ehi->action |= ATA_EH_SOFTRESET;
+		ata_ehi_push_desc(ehi , ", unknown FIS");
+		freeze = 1;
+	}
+
+	/* deal with command error */
+	if (irq_stat & PORT_IRQ_ERROR) {
+		struct sil24_cerr_info *ci = NULL;
+		unsigned int err_mask = 0, action = 0;
+		struct ata_queued_cmd *qc;
+		u32 cerr;
+
+		/* analyze CMD_ERR */
+		cerr = readl(port + PORT_CMD_ERR);
+		if (cerr < ARRAY_SIZE(sil24_cerr_db))
+			ci = &sil24_cerr_db[cerr];
+
+		if (ci && ci->desc) {
+			err_mask |= ci->err_mask;
+			action |= ci->action;
+			ata_ehi_push_desc(ehi, ", %s", ci->desc);
+		} else {
+			err_mask |= AC_ERR_OTHER;
+			action |= ATA_EH_SOFTRESET;
+			ata_ehi_push_desc(ehi, ", unknown command error %d",
+					  cerr);
+		}
 
-	if (qc) {
-		qc->err_mask |= err_mask;
-		ata_qc_complete(qc);
+		/* record error info */
+		qc = ata_qc_from_tag(ap, ap->active_tag);
+		if (qc) {
+			int tag = qc->tag;
+			if (unlikely(ata_tag_internal(tag)))
+				tag = 0;
+			sil24_update_tf(ap);
+			qc->err_mask |= err_mask;
+		} else
+			ehi->err_mask |= err_mask;
+
+		ehi->action |= action;
 	}
+
+	/* freeze or abort */
+	if (freeze)
+		ata_port_freeze(ap);
+	else
+		ata_port_abort(ap);
 }
 
 static inline void sil24_host_intr(struct ata_port *ap)
 {
-	struct ata_queued_cmd *qc = ata_qc_from_tag(ap, ap->active_tag);
 	void __iomem *port = (void __iomem *)ap->ioaddr.cmd_addr;
+	struct ata_queued_cmd *qc;
 	u32 slot_stat;
 
 	slot_stat = readl(port + PORT_SLOT_STAT);
-	if (!(slot_stat & HOST_SSTAT_ATTN)) {
-		struct sil24_port_priv *pp = ap->private_data;
 
-		if (ap->flags & SIL24_FLAG_PCIX_IRQ_WOC)
-			writel(PORT_IRQ_COMPLETE, port + PORT_IRQ_STAT);
+	if (unlikely(slot_stat & HOST_SSTAT_ATTN)) {
+		sil24_error_intr(ap);
+		return;
+	}
 
-		if (qc) {
-			if (qc->flags & ATA_QCFLAG_RESULT_TF)
-				sil24_update_tf(ap);
-			qc->err_mask |= ac_err_mask(pp->tf.command);
-			ata_qc_complete(qc);
-		}
-	} else
-		sil24_error_intr(ap, slot_stat);
+	if (ap->flags & SIL24_FLAG_PCIX_IRQ_WOC)
+		writel(PORT_IRQ_COMPLETE, port + PORT_IRQ_STAT);
+
+	qc = ata_qc_from_tag(ap, ap->active_tag);
+	if (qc) {
+		if (qc->flags & ATA_QCFLAG_RESULT_TF)
+			sil24_update_tf(ap);
+		ata_qc_complete(qc);
+		return;
+	}
+
+	if (ata_ratelimit())
+		ata_port_printk(ap, KERN_INFO, "spurious interrupt "
+			"(slot_stat 0x%x active_tag %d)\n",
+			slot_stat, ap->active_tag);
 }
 
 static irqreturn_t sil24_interrupt(int irq, void *dev_instance, struct pt_regs *regs)
@@ -846,6 +876,31 @@ static irqreturn_t sil24_interrupt(int i
 	return IRQ_RETVAL(handled);
 }
 
+static void sil24_error_handler(struct ata_port *ap)
+{
+	struct ata_eh_context *ehc = &ap->eh_context;
+
+	if (sil24_init_port(ap)) {
+		ata_eh_freeze_port(ap);
+		ehc->i.action |= ATA_EH_HARDRESET;
+	}
+
+	/* perform recovery */
+	ata_do_eh(ap, sil24_softreset, sil24_hardreset, ata_std_postreset);
+}
+
+static void sil24_post_internal_cmd(struct ata_queued_cmd *qc)
+{
+	struct ata_port *ap = qc->ap;
+
+	if (qc->flags & ATA_QCFLAG_FAILED)
+		qc->err_mask |= AC_ERR_OTHER;
+
+	/* make DMA engine forget about the failed command */
+	if (qc->err_mask)
+		sil24_init_port(ap);
+}
+
 static inline void sil24_cblk_free(struct sil24_port_priv *pp, struct device *dev)
 {
 	const size_t cb_size = sizeof(*pp->cmd_block);
@@ -1058,15 +1113,6 @@ static int sil24_init_one(struct pci_dev
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


