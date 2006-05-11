From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 09/10] sata_sil24: implement PM support
Date: Fri, 12 May 2006 01:43:43 +0900
Message-ID: <11473658233154-git-send-email-htejun@gmail.com>
References: <11473658222012-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.195]:19721 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1030346AbWEKQnz (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 11 May 2006 12:43:55 -0400
Received: by nz-out-0102.google.com with SMTP id 13so248086nzn
        for <linux-ide@vger.kernel.org>; Thu, 11 May 2006 09:43:54 -0700 (PDT)
In-Reply-To: <11473658222012-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, forrest.zhao@intel.com, efalk@google.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Implement PM support.  sil24 supports full FIS-switching.  However, it
has a PM DMA CS errata which requires port-wide resetting if commands
are outstanding to three or more devices when an error occurs on one
of them.

ATAPI commands often result in CHECK SENSE and it's crucial to not
reset them before fetching sense data.  Unfortunately, ATAPI CHECK
SENSE causes a lot of problem if command is outstanding to any other
device usually resulting in port-wide reset.  So, sata_sil24
implements sil24_qc_defer() which guarantees ATAPI command is run by
itself.

---

 drivers/scsi/sata_sil24.c |  206 ++++++++++++++++++++++++++++++++++++++++++---
 1 files changed, 193 insertions(+), 13 deletions(-)

8bab6c564499e24143045c65d524b2a48becaf9c
diff --git a/drivers/scsi/sata_sil24.c b/drivers/scsi/sata_sil24.c
index 75b04e2..1979cfc 100644
--- a/drivers/scsi/sata_sil24.c
+++ b/drivers/scsi/sata_sil24.c
@@ -165,7 +165,7 @@ enum {
 
 	DEF_PORT_IRQ		= PORT_IRQ_COMPLETE | PORT_IRQ_ERROR |
 				  PORT_IRQ_PHYRDY_CHG | PORT_IRQ_DEV_XCHG |
-				  PORT_IRQ_UNK_FIS,
+				  PORT_IRQ_UNK_FIS | PORT_IRQ_SDB_NOTIFY,
 
 	/* bits[27:16] are unmasked (raw) */
 	PORT_IRQ_RAW_SHIFT	= 16,
@@ -234,7 +234,8 @@ enum {
 	/* host flags */
 	SIL24_COMMON_FLAGS	= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
 				  ATA_FLAG_MMIO | ATA_FLAG_PIO_DMA |
-				  ATA_FLAG_NCQ,
+				  ATA_FLAG_NCQ | ATA_FLAG_PM |
+				  ATA_FLAG_SDB_NOTIFY,
 	SIL24_FLAG_PCIX_IRQ_WOC	= (1 << 24), /* IRQ loss errata on PCI-X */
 
 	IRQ_STAT_4PORTS		= 0xf,
@@ -328,10 +329,15 @@ struct sil24_host_priv {
 static void sil24_dev_config(struct ata_port *ap, struct ata_device *dev);
 static u32 sil24_scr_read(struct ata_port *ap, unsigned sc_reg);
 static void sil24_scr_write(struct ata_port *ap, unsigned sc_reg, u32 val);
+static int sil24_qc_defer(struct ata_queued_cmd *qc);
 static void sil24_qc_prep(struct ata_queued_cmd *qc);
 static unsigned int sil24_qc_issue(struct ata_queued_cmd *qc);
 static void sil24_irq_clear(struct ata_port *ap);
 static irqreturn_t sil24_interrupt(int irq, void *dev_instance, struct pt_regs *regs);
+static void sil24_pm_attach(struct ata_port *ap);
+static void sil24_pm_detach(struct ata_port *ap);
+static int sil24_pm_read(struct ata_device *dev, int pmp, int reg, u32 *r_val);
+static int sil24_pm_write(struct ata_device *dev, int pmp, int reg, u32 val);
 static void sil24_freeze(struct ata_port *ap);
 static void sil24_thaw(struct ata_port *ap);
 static void sil24_error_handler(struct ata_port *ap);
@@ -385,7 +391,7 @@ static const struct ata_port_operations 
 	.check_altstatus	= ata_noop_check_status,
 	.dev_select		= ata_noop_dev_select,
 
-	.qc_defer		= ata_std_qc_defer,
+	.qc_defer		= sil24_qc_defer,
 	.qc_prep		= sil24_qc_prep,
 	.qc_issue		= sil24_qc_issue,
 
@@ -395,6 +401,11 @@ static const struct ata_port_operations 
 	.scr_read		= sil24_scr_read,
 	.scr_write		= sil24_scr_write,
 
+	.pm_attach		= sil24_pm_attach,
+	.pm_detach		= sil24_pm_detach,
+	.pm_read		= sil24_pm_read,
+	.pm_write		= sil24_pm_write,
+
 	.freeze			= sil24_freeze,
 	.thaw			= sil24_thaw,
 	.error_handler		= sil24_error_handler,
@@ -499,6 +510,31 @@ static void sil24_scr_write(struct ata_p
 	}
 }
 
+static void sil24_config_pm(struct ata_port *ap, int attached)
+{
+	void __iomem *port = (void __iomem *)ap->ioaddr.cmd_addr;
+
+	if (attached)
+		writel(PORT_CS_PM_EN, port + PORT_CTRL_STAT);
+	else
+		writel(PORT_CS_PM_EN, port + PORT_CTRL_CLR);
+}
+
+static void sil24_clear_pm(struct ata_port *ap)
+{
+	void __iomem *port = (void __iomem *)ap->ioaddr.cmd_addr;
+	int i;
+
+	writel(PORT_CS_PM_RESUME, port + PORT_CTRL_CLR);
+
+	for (i = 0; i < ATA_PM_MAX_PORTS; i++) {
+		void __iomem *pm_base = port + PORT_PM + i * PORT_PM_SIZE;
+
+		writel(0, pm_base + PORT_PM_STATUS);
+		writel(0, pm_base + PORT_PM_QACTIVE);
+	}
+}
+
 static int sil24_init_port(struct ata_port *ap)
 {
 	void __iomem *port = (void __iomem *)ap->ioaddr.cmd_addr;
@@ -510,6 +546,9 @@ static int sil24_init_port(struct ata_po
 	tmp = ata_wait_register(port + PORT_CTRL_STAT,
 				PORT_CS_RDY, 0, 10, 100);
 
+	/* clear PM error status */
+	sil24_clear_pm(ap);
+
 	if ((tmp & (PORT_CS_INIT | PORT_CS_RDY)) != PORT_CS_RDY)
 		return -EIO;
 	return 0;
@@ -613,7 +652,7 @@ static int sil24_do_softreset(struct ata
 
 static int sil24_softreset(struct ata_link *link, unsigned int *class)
 {
-	return sil24_do_softreset(link, class, 0);
+	return sil24_do_softreset(link, class, ATA_PM_CTRL_PORT);
 }
 
 static int sil24_hardreset(struct ata_link *link, unsigned int *class)
@@ -684,6 +723,38 @@ static inline void sil24_fill_sg(struct 
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
+	 * weird problems if other commands are active.  PM DMA CS
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
@@ -756,6 +827,63 @@ static void sil24_irq_clear(struct ata_p
 	/* unused */
 }
 
+static void sil24_pm_attach(struct ata_port *ap)
+{
+	sil24_config_pm(ap, 1);
+	sil24_clear_pm(ap);
+}
+
+static void sil24_pm_detach(struct ata_port *ap)
+{
+	sil24_clear_pm(ap);
+	sil24_config_pm(ap, 0);
+}
+
+static int sil24_pm_read(struct ata_device *dev, int pmp, int reg, u32 *r_val)
+{
+	struct ata_port *ap = dev->link->ap;
+	struct ata_taskfile tf;
+	int rc;
+
+	ata_pm_read_init_tf(&tf, dev, pmp, reg);
+	rc = sil24_exec_polled_cmd(ap, 0, &tf, ATA_PM_CTRL_PORT, 1,
+				   ATA_PM_SCR_TIMEOUT);
+	if (rc == 0) {
+		sil24_read_tf(ap, 0, &tf);
+		*r_val = ata_pm_read_val(&tf);
+	}
+	return rc;
+}
+
+static int sil24_pm_write(struct ata_device *dev, int pmp, int reg, u32 val)
+{
+	struct ata_port *ap = dev->link->ap;
+	struct ata_taskfile tf;
+
+	ata_pm_write_init_tf(&tf, dev, pmp, reg, val);
+	return sil24_exec_polled_cmd(ap, 0, &tf, ATA_PM_CTRL_PORT, 1,
+				     ATA_PM_SCR_TIMEOUT);
+}
+
+static int sil24_pm_softreset(struct ata_link *link, unsigned int *class)
+{
+	return sil24_do_softreset(link, class, link->pmp);
+}
+
+static int sil24_pm_hardreset(struct ata_link *link, unsigned int *class)
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
+	return ata_pm_std_hardreset(link, class);
+}
+
 static void sil24_freeze(struct ata_port *ap)
 {
 	void __iomem *port = (void __iomem *)ap->ioaddr.cmd_addr;
@@ -782,8 +910,9 @@ static void sil24_thaw(struct ata_port *
 static void sil24_error_intr(struct ata_port *ap)
 {
 	void __iomem *port = (void __iomem *)ap->ioaddr.cmd_addr;
-	struct ata_eh_info *ehi = &ap->link.eh_info;
 	int freeze = 0;
+	struct ata_link *link;
+	struct ata_eh_info *ehi;
 	u32 irq_stat;
 
 	/* on error, we need to clear IRQ explicitly */
@@ -791,6 +920,8 @@ static void sil24_error_intr(struct ata_
 	writel(irq_stat, port + PORT_IRQ_STAT);
 
 	/* first, analyze and record host port events */
+	link = &ap->link;
+	ehi = &link->eh_info;
 	ata_ehi_clear_desc(ehi);
 
 	ata_ehi_push_desc(ehi, "irq_stat 0x%08x", irq_stat);
@@ -817,12 +948,59 @@ static void sil24_error_intr(struct ata_
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
+			ata_ehi_push_desc(ehi, ", PM DMA CS errata");
+			freeze = 1;
+		}
+
+		/* find out the offending link and qc */
+		if (ap->nr_pm_links) {
+			context = readl(port + PORT_CONTEXT);
+			pmp = (context >> 5) & 0xf;
+
+			if (pmp < ap->nr_pm_links) {
+				link = &ap->pm_link[pmp];
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
@@ -841,7 +1019,6 @@ static void sil24_error_intr(struct ata_
 		}
 
 		/* record error info */
-		qc = ata_qc_from_tag(ap, ap->link.active_tag);
 		if (qc) {
 			sil24_read_tf(ap, sil24_tag(qc->tag), &qc->result_tf);
 			qc->err_mask |= err_mask;
@@ -849,13 +1026,15 @@ static void sil24_error_intr(struct ata_
 			ehi->err_mask |= err_mask;
 
 		ehi->action |= action;
+
+		/* if PM, resume */
+		if (ap->nr_pm_links)
+			writel(PORT_CS_PM_RESUME, port + PORT_CTRL_STAT);
 	}
 
-	/* freeze or abort */
+	/* freeze? */
 	if (freeze)
 		ata_port_freeze(ap);
-	else
-		ata_port_abort(ap);
 }
 
 static void sil24_finish_qc(struct ata_queued_cmd *qc)
@@ -945,8 +1124,9 @@ static void sil24_error_handler(struct a
 	}
 
 	/* perform recovery */
-	ata_do_eh(ap, ata_std_prereset, sil24_softreset, sil24_hardreset,
-		  ata_std_postreset);
+	ata_pm_do_eh(ap, ata_std_prereset, sil24_softreset, sil24_hardreset,
+		     ata_std_postreset, ata_pm_std_prereset, sil24_pm_softreset,
+		     sil24_pm_hardreset, ata_pm_std_postreset);
 }
 
 static void sil24_post_internal_cmd(struct ata_queued_cmd *qc)
-- 
1.2.4


