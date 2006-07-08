From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 11/12] sata_sil24: implement PMP support
Date: Sat, 8 Jul 2006 14:58:09 +0900
Message-ID: <11523382891290-git-send-email-htejun@gmail.com>
References: <11523382873130-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0102.google.com ([66.249.82.204]:43740 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S964815AbWGHF5X (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 8 Jul 2006 01:57:23 -0400
Received: by wx-out-0102.google.com with SMTP id t10so1206438wxc
        for <linux-ide@vger.kernel.org>; Fri, 07 Jul 2006 22:57:23 -0700 (PDT)
In-Reply-To: <11523382873130-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, lkml@rtr.ca, forrest.zhao@intel.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Implement PMP support.  sil24 supports full FIS-switching.  However,
it has a PMP DMA CS errata which requires port-wide resetting if
commands are outstanding to three or more devices when an error occurs
on one of them.

ATAPI commands often result in CHECK SENSE and it's crucial to not
reset them before fetching sense data.  Unfortunately, ATAPI CHECK
SENSE causes a lot of problem if command is outstanding to any other
device usually resulting in port-wide reset.  So, sata_sil24
implements sil24_qc_defer() which guarantees ATAPI command is run by
itself.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/sata_sil24.c |  212 +++++++++++++++++++++++++++++++++++++++++++--
 1 files changed, 202 insertions(+), 10 deletions(-)

35a05dc2f59de02f444eb3b993e0cfea24a7cdae
diff --git a/drivers/scsi/sata_sil24.c b/drivers/scsi/sata_sil24.c
index 7c868f6..5e93f1c 100644
--- a/drivers/scsi/sata_sil24.c
+++ b/drivers/scsi/sata_sil24.c
@@ -166,7 +166,7 @@ enum {
 
 	DEF_PORT_IRQ		= PORT_IRQ_COMPLETE | PORT_IRQ_ERROR |
 				  PORT_IRQ_PHYRDY_CHG | PORT_IRQ_DEV_XCHG |
-				  PORT_IRQ_UNK_FIS,
+				  PORT_IRQ_UNK_FIS | PORT_IRQ_SDB_NOTIFY,
 
 	/* bits[27:16] are unmasked (raw) */
 	PORT_IRQ_RAW_SHIFT	= 16,
@@ -235,7 +235,8 @@ enum {
 	/* host flags */
 	SIL24_COMMON_FLAGS	= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
 				  ATA_FLAG_MMIO | ATA_FLAG_PIO_DMA |
-				  ATA_FLAG_NCQ | ATA_FLAG_SKIP_D2H_BSY,
+				  ATA_FLAG_NCQ | ATA_FLAG_SKIP_D2H_BSY |
+				  ATA_FLAG_PMP | ATA_FLAG_SDB_NOTIFY,
 	SIL24_FLAG_PCIX_IRQ_WOC	= (1 << 24), /* IRQ loss errata on PCI-X */
 
 	IRQ_STAT_4PORTS		= 0xf,
@@ -332,10 +333,15 @@ static u8 sil24_check_status(struct ata_
 static u32 sil24_scr_read(struct ata_port *ap, unsigned sc_reg);
 static void sil24_scr_write(struct ata_port *ap, unsigned sc_reg, u32 val);
 static void sil24_tf_read(struct ata_port *ap, struct ata_taskfile *tf);
+static int sil24_qc_defer(struct ata_queued_cmd *qc);
 static void sil24_qc_prep(struct ata_queued_cmd *qc);
 static unsigned int sil24_qc_issue(struct ata_queued_cmd *qc);
 static void sil24_irq_clear(struct ata_port *ap);
 static irqreturn_t sil24_interrupt(int irq, void *dev_instance, struct pt_regs *regs);
+static void sil24_pmp_attach(struct ata_port *ap);
+static void sil24_pmp_detach(struct ata_port *ap);
+static int sil24_pmp_read(struct ata_device *dev, int pmp, int reg, u32 *r_val);
+static int sil24_pmp_write(struct ata_device *dev, int pmp, int reg, u32 val);
 static void sil24_freeze(struct ata_port *ap);
 static void sil24_thaw(struct ata_port *ap);
 static void sil24_error_handler(struct ata_port *ap);
@@ -345,6 +351,7 @@ static void sil24_port_stop(struct ata_p
 static void sil24_host_stop(struct ata_host_set *host_set);
 static int sil24_init_one(struct pci_dev *pdev, const struct pci_device_id *ent);
 static int sil24_pci_device_resume(struct pci_dev *pdev);
+static int sil24_port_resume(struct ata_port *ap);
 
 static const struct pci_device_id sil24_pci_tbl[] = {
 	{ 0x1095, 0x3124, PCI_ANY_ID, PCI_ANY_ID, 0, 0, BID_SIL3124 },
@@ -396,7 +403,7 @@ static const struct ata_port_operations 
 
 	.tf_read		= sil24_tf_read,
 
-	.qc_defer		= ata_std_qc_defer,
+	.qc_defer		= sil24_qc_defer,
 	.qc_prep		= sil24_qc_prep,
 	.qc_issue		= sil24_qc_issue,
 
@@ -406,6 +413,11 @@ static const struct ata_port_operations 
 	.scr_read		= sil24_scr_read,
 	.scr_write		= sil24_scr_write,
 
+	.pmp_attach		= sil24_pmp_attach,
+	.pmp_detach		= sil24_pmp_detach,
+	.pmp_read		= sil24_pmp_read,
+	.pmp_write		= sil24_pmp_write,
+
 	.freeze			= sil24_freeze,
 	.thaw			= sil24_thaw,
 	.error_handler		= sil24_error_handler,
@@ -417,6 +429,8 @@ static const struct ata_port_operations 
 	.port_start		= sil24_port_start,
 	.port_stop		= sil24_port_stop,
 	.host_stop		= sil24_host_stop,
+
+	.port_resume		= sil24_port_resume,
 };
 
 /*
@@ -525,6 +539,31 @@ static void sil24_tf_read(struct ata_por
 	*tf = pp->tf;
 }
 
+static void sil24_config_pmp(struct ata_port *ap, int attached)
+{
+	void __iomem *port = (void __iomem *)ap->ioaddr.cmd_addr;
+
+	if (attached)
+		writel(PORT_CS_PMP_EN, port + PORT_CTRL_STAT);
+	else
+		writel(PORT_CS_PMP_EN, port + PORT_CTRL_CLR);
+}
+
+static void sil24_clear_pmp(struct ata_port *ap)
+{
+	void __iomem *port = (void __iomem *)ap->ioaddr.cmd_addr;
+	int i;
+
+	writel(PORT_CS_PMP_RESUME, port + PORT_CTRL_CLR);
+
+	for (i = 0; i < SATA_PMP_MAX_PORTS; i++) {
+		void __iomem *pmp_base = port + PORT_PMP + i * PORT_PMP_SIZE;
+
+		writel(0, pmp_base + PORT_PMP_STATUS);
+		writel(0, pmp_base + PORT_PMP_QACTIVE);
+	}
+}
+
 static int sil24_init_port(struct ata_port *ap)
 {
 	void __iomem *port = (void __iomem *)ap->ioaddr.cmd_addr;
@@ -536,6 +575,9 @@ static int sil24_init_port(struct ata_po
 	tmp = ata_wait_register(port + PORT_CTRL_STAT,
 				PORT_CS_RDY, 0, 10, 100);
 
+	/* clear PMP error status */
+	sil24_clear_pmp(ap);
+
 	if ((tmp & (PORT_CS_INIT | PORT_CS_RDY)) != PORT_CS_RDY)
 		return -EIO;
 	return 0;
@@ -639,7 +681,7 @@ static int sil24_do_softreset(struct ata
 
 static int sil24_softreset(struct ata_link *link, unsigned int *class)
 {
-	return sil24_do_softreset(link, class, 0);
+	return sil24_do_softreset(link, class, SATA_PMP_CTRL_PORT);
 }
 
 static int sil24_hardreset(struct ata_link *link, unsigned int *class)
@@ -709,6 +751,38 @@ static inline void sil24_fill_sg(struct 
 	}
 }
 
+static int sil24_qc_defer(struct ata_queued_cmd *qc)
+{
+	struct ata_link *link = qc->dev->link;
+	struct ata_port *ap = link->ap;
+	u8 prot = qc->tf.protocol;
+	int is_atapi = (prot == ATA_PROT_ATAPI ||
+			prot == ATA_PROT_ATAPI_NODATA ||
+			prot == ATA_PROT_ATAPI_DMA);
+
+	/* ATAPI commands completing with CHECK_SENSE cause various
+	 * weird problems if other commands are active.  PMP DMA CS
+	 * errata doesn't cover all and HSM violation occurs even with
+	 * only one other device active.  Always run an ATAPI command
+	 * by itself.
+	 */
+	if (unlikely(ap->excl_link)) {
+		if (link == ap->excl_link) {
+			if (ap->nr_active_links)
+				return ATA_DEFER_PORT;
+			qc->flags |= ATA_QCFLAG_CLEAR_EXCL;
+		} else
+			return ATA_DEFER_LINK;
+	} else if (unlikely(is_atapi)) {
+		ap->excl_link = link;
+		if (ap->nr_active_links)
+			return ATA_DEFER_PORT;
+		qc->flags |= ATA_QCFLAG_CLEAR_EXCL;
+	}
+
+	return ata_std_qc_defer(qc);
+}
+
 static void sil24_qc_prep(struct ata_queued_cmd *qc)
 {
 	struct ata_port *ap = qc->ap;
@@ -781,6 +855,63 @@ static void sil24_irq_clear(struct ata_p
 	/* unused */
 }
 
+static void sil24_pmp_attach(struct ata_port *ap)
+{
+	sil24_config_pmp(ap, 1);
+	sil24_clear_pmp(ap);
+}
+
+static void sil24_pmp_detach(struct ata_port *ap)
+{
+	sil24_clear_pmp(ap);
+	sil24_config_pmp(ap, 0);
+}
+
+static int sil24_pmp_read(struct ata_device *dev, int pmp, int reg, u32 *r_val)
+{
+	struct ata_port *ap = dev->link->ap;
+	struct ata_taskfile tf;
+	int rc;
+
+	sata_pmp_read_init_tf(&tf, dev, pmp, reg);
+	rc = sil24_exec_polled_cmd(ap, 0, &tf, SATA_PMP_CTRL_PORT, 1,
+				   SATA_PMP_SCR_TIMEOUT);
+	if (rc == 0) {
+		sil24_read_tf(ap, 0, &tf);
+		*r_val = sata_pmp_read_val(&tf);
+	}
+	return rc;
+}
+
+static int sil24_pmp_write(struct ata_device *dev, int pmp, int reg, u32 val)
+{
+	struct ata_port *ap = dev->link->ap;
+	struct ata_taskfile tf;
+
+	sata_pmp_write_init_tf(&tf, dev, pmp, reg, val);
+	return sil24_exec_polled_cmd(ap, 0, &tf, SATA_PMP_CTRL_PORT, 1,
+				     SATA_PMP_SCR_TIMEOUT);
+}
+
+static int sil24_pmp_softreset(struct ata_link *link, unsigned int *class)
+{
+	return sil24_do_softreset(link, class, link->pmp);
+}
+
+static int sil24_pmp_hardreset(struct ata_link *link, unsigned int *class)
+{
+	int rc;
+
+	rc = sil24_init_port(link->ap);
+	if (rc) {
+		ata_link_printk(link, KERN_ERR,
+				"hardreset failed (port not ready)\n");
+		return rc;
+	}
+
+	return sata_pmp_std_hardreset(link, class);
+}
+
 static void sil24_freeze(struct ata_port *ap)
 {
 	void __iomem *port = (void __iomem *)ap->ioaddr.cmd_addr;
@@ -808,7 +939,8 @@ static void sil24_error_intr(struct ata_
 {
 	void __iomem *port = (void __iomem *)ap->ioaddr.cmd_addr;
 	struct sil24_port_priv *pp = ap->private_data;
-	struct ata_eh_info *ehi = &ap->link.eh_info;
+	struct ata_link *link;
+	struct ata_eh_info *ehi;
 	int freeze = 0;
 	u32 irq_stat;
 
@@ -817,6 +949,8 @@ static void sil24_error_intr(struct ata_
 	writel(irq_stat, port + PORT_IRQ_STAT);
 
 	/* first, analyze and record host port events */
+	link = &ap->link;
+	ehi = &link->eh_info;
 	ata_ehi_clear_desc(ehi);
 
 	ata_ehi_push_desc(ehi, "irq_stat 0x%08x", irq_stat);
@@ -836,12 +970,59 @@ static void sil24_error_intr(struct ata_
 		freeze = 1;
 	}
 
+	if (irq_stat & PORT_IRQ_SDB_NOTIFY) {
+		/* No SNotification register.  We don't know which
+		 * ports should be aborted.  Just let them timeout.
+		 */
+		ehi->err_mask |= AC_ERR_OTHER;
+		ata_ehi_push_desc(ehi, ", SDB notify");
+		ata_port_schedule_eh(ap);
+	}
+
 	/* deal with command error */
 	if (irq_stat & PORT_IRQ_ERROR) {
 		struct sil24_cerr_info *ci = NULL;
+		struct ata_queued_cmd *qc = NULL;
 		unsigned int err_mask = 0, action = 0;
-		struct ata_queued_cmd *qc;
-		u32 cerr;
+		u32 context, cerr;
+		int pmp;
+
+		/* DMA Context Switch Failure in Port Multiplier Mode
+		 * errata.  If we have active commands to 3 or more
+		 * devices, any error condition on active devices can
+		 * corrupt DMA context switching.
+		 */
+		if (ap->nr_active_links >= 3) {
+			ehi->err_mask |= AC_ERR_OTHER;
+			ehi->action |= ATA_EH_HARDRESET;
+			ata_ehi_push_desc(ehi, ", PMP DMA CS errata");
+			freeze = 1;
+		}
+
+		/* find out the offending link and qc */
+		if (ap->nr_pmp_links) {
+			context = readl(port + PORT_CONTEXT);
+			pmp = (context >> 5) & 0xf;
+
+			if (pmp < ap->nr_pmp_links) {
+				link = &ap->pmp_link[pmp];
+				ehi = &link->eh_info;
+				qc = ata_qc_from_tag(ap, link->active_tag);
+
+				ata_ehi_clear_desc(ehi);
+				ata_ehi_push_desc(ehi, "irq_stat 0x%08x",
+						  irq_stat);
+
+				ata_link_abort(link);
+			} else {
+				err_mask |= AC_ERR_HSM;
+				action |= ATA_EH_HARDRESET;
+				freeze = 1;
+			}
+		} else {
+			qc = ata_qc_from_tag(ap, link->active_tag);
+			ata_link_abort(link);
+		}
 
 		/* analyze CMD_ERR */
 		cerr = readl(port + PORT_CMD_ERR);
@@ -860,7 +1041,6 @@ static void sil24_error_intr(struct ata_
 		}
 
 		/* record error info */
-		qc = ata_qc_from_tag(ap, ap->link.active_tag);
 		if (qc) {
 			sil24_read_tf(ap, qc->tag, &pp->tf);
 			qc->err_mask |= err_mask;
@@ -868,6 +1048,10 @@ static void sil24_error_intr(struct ata_
 			ehi->err_mask |= err_mask;
 
 		ehi->action |= action;
+
+		/* if PMP, resume */
+		if (ap->nr_pmp_links)
+			writel(PORT_CS_PMP_RESUME, port + PORT_CTRL_STAT);
 	}
 
 	/* freeze or abort */
@@ -967,8 +1151,10 @@ static void sil24_error_handler(struct a
 	}
 
 	/* perform recovery */
-	ata_do_eh(ap, ata_std_prereset, sil24_softreset, sil24_hardreset,
-		  ata_std_postreset);
+	sata_pmp_do_eh(ap, ata_std_prereset, sil24_softreset, sil24_hardreset,
+		       ata_std_postreset, sata_pmp_std_prereset,
+		       sil24_pmp_softreset, sil24_pmp_hardreset,
+		       sata_pmp_std_postreset);
 }
 
 static void sil24_post_internal_cmd(struct ata_queued_cmd *qc)
@@ -1260,6 +1446,12 @@ static int sil24_pci_device_resume(struc
 	return 0;
 }
 
+static int sil24_port_resume(struct ata_port *ap)
+{
+	sil24_config_pmp(ap, ap->nr_pmp_links);
+	return 0;
+}
+
 static int __init sil24_init(void)
 {
 	return pci_module_init(&sil24_pci_driver);
-- 
1.3.2


