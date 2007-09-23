From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 08/10] ahci: implement PMP support
Date: Sun, 23 Sep 2007 13:19:54 +0900
Message-ID: <11905211942840-git-send-email-htejun@gmail.com>
References: <1190521193410-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.178]:9486 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752747AbXIWEUJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 23 Sep 2007 00:20:09 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1547039wah
        for <linux-ide@vger.kernel.org>; Sat, 22 Sep 2007 21:20:09 -0700 (PDT)
In-Reply-To: <1190521193410-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Implement AHCI PMP support.  ahci only supports command based
switching.  Also, for some reason, NCQ over PMP doesn't work now.
Other than that, everything works.

Tested on ICH9R, JMB360/363 + SIMG3726, 4726 and 5744.

Signed-off-by: Tejun Heo <htejun@gmail.com>
Cc: Forrest Zhao <forrest.zhao@gmail.com>
---
 drivers/ata/ahci.c |  220 +++++++++++++++++++++++++++++++++++++++++-----------
 1 files changed, 174 insertions(+), 46 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 9f3c591..d06a8b3 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -46,7 +46,7 @@
 #include <linux/libata.h>
 
 #define DRV_NAME	"ahci"
-#define DRV_VERSION	"2.3"
+#define DRV_VERSION	"3.0"
 
 
 enum {
@@ -96,6 +96,7 @@ enum {
 
 	/* HOST_CAP bits */
 	HOST_CAP_SSC		= (1 << 14), /* Slumber capable */
+	HOST_CAP_PMP		= (1 << 17), /* Port Multiplier support */
 	HOST_CAP_CLO		= (1 << 24), /* Command List Override support */
 	HOST_CAP_SSS		= (1 << 27), /* Staggered Spin-up */
 	HOST_CAP_SNTF		= (1 << 29), /* SNotification register */
@@ -143,7 +144,8 @@ enum {
 				  PORT_IRQ_IF_ERR |
 				  PORT_IRQ_CONNECT |
 				  PORT_IRQ_PHYRDY |
-				  PORT_IRQ_UNK_FIS,
+				  PORT_IRQ_UNK_FIS |
+				  PORT_IRQ_BAD_PMP,
 	PORT_IRQ_ERROR		= PORT_IRQ_FREEZE |
 				  PORT_IRQ_TF_ERR |
 				  PORT_IRQ_HBUS_DATA_ERR,
@@ -153,6 +155,7 @@ enum {
 
 	/* PORT_CMD bits */
 	PORT_CMD_ATAPI		= (1 << 24), /* Device is ATAPI */
+	PORT_CMD_PMP		= (1 << 17), /* PMP attached */
 	PORT_CMD_LIST_ON	= (1 << 15), /* cmd list DMA engine running */
 	PORT_CMD_FIS_ON		= (1 << 14), /* FIS DMA engine running */
 	PORT_CMD_FIS_RX		= (1 << 4), /* Enable FIS receive DMA engine */
@@ -204,6 +207,7 @@ struct ahci_host_priv {
 };
 
 struct ahci_port_priv {
+	struct ata_link		*active_link;
 	struct ahci_cmd_hdr	*cmd_slot;
 	dma_addr_t		cmd_slot_dma;
 	void			*cmd_tbl;
@@ -229,6 +233,10 @@ static void ahci_qc_prep(struct ata_queued_cmd *qc);
 static u8 ahci_check_status(struct ata_port *ap);
 static void ahci_freeze(struct ata_port *ap);
 static void ahci_thaw(struct ata_port *ap);
+static void ahci_pmp_attach(struct ata_port *ap);
+static void ahci_pmp_detach(struct ata_port *ap);
+static int ahci_pmp_read(struct ata_device *dev, int pmp, int reg, u32 *r_val);
+static int ahci_pmp_write(struct ata_device *dev, int pmp, int reg, u32 val);
 static void ahci_error_handler(struct ata_port *ap);
 static void ahci_vt8251_error_handler(struct ata_port *ap);
 static void ahci_post_internal_cmd(struct ata_queued_cmd *qc);
@@ -268,7 +276,7 @@ static const struct ata_port_operations ahci_ops = {
 
 	.tf_read		= ahci_tf_read,
 
-	.qc_defer		= ata_std_qc_defer,
+	.qc_defer		= sata_pmp_qc_defer_cmd_switch,
 	.qc_prep		= ahci_qc_prep,
 	.qc_issue		= ahci_qc_issue,
 
@@ -283,6 +291,11 @@ static const struct ata_port_operations ahci_ops = {
 	.error_handler		= ahci_error_handler,
 	.post_internal_cmd	= ahci_post_internal_cmd,
 
+	.pmp_attach		= ahci_pmp_attach,
+	.pmp_detach		= ahci_pmp_detach,
+	.pmp_read		= ahci_pmp_read,
+	.pmp_write		= ahci_pmp_write,
+
 #ifdef CONFIG_PM
 	.port_suspend		= ahci_port_suspend,
 	.port_resume		= ahci_port_resume,
@@ -299,7 +312,7 @@ static const struct ata_port_operations ahci_vt8251_ops = {
 
 	.tf_read		= ahci_tf_read,
 
-	.qc_defer		= ata_std_qc_defer,
+	.qc_defer		= sata_pmp_qc_defer_cmd_switch,
 	.qc_prep		= ahci_qc_prep,
 	.qc_issue		= ahci_qc_issue,
 
@@ -314,6 +327,11 @@ static const struct ata_port_operations ahci_vt8251_ops = {
 	.error_handler		= ahci_vt8251_error_handler,
 	.post_internal_cmd	= ahci_post_internal_cmd,
 
+	.pmp_attach		= ahci_pmp_attach,
+	.pmp_detach		= ahci_pmp_detach,
+	.pmp_read		= ahci_pmp_read,
+	.pmp_write		= ahci_pmp_write,
+
 #ifdef CONFIG_PM
 	.port_suspend		= ahci_port_suspend,
 	.port_resume		= ahci_port_resume,
@@ -1108,7 +1126,12 @@ static int ahci_do_softreset(struct ata_link *link, unsigned int *class,
 static int ahci_softreset(struct ata_link *link, unsigned int *class,
 			  unsigned long deadline)
 {
-	return ahci_do_softreset(link, class, 0, deadline);
+	int pmp = 0;
+
+	if (link->ap->flags & ATA_FLAG_PMP)
+		pmp = SATA_PMP_CTRL_PORT;
+
+	return ahci_do_softreset(link, class, pmp, deadline);
 }
 
 static int ahci_hardreset(struct ata_link *link, unsigned int *class,
@@ -1135,7 +1158,7 @@ static int ahci_hardreset(struct ata_link *link, unsigned int *class,
 
 	if (rc == 0 && ata_link_online(link))
 		*class = ahci_dev_classify(ap);
-	if (*class == ATA_DEV_UNKNOWN)
+	if (rc != -EAGAIN && *class == ATA_DEV_UNKNOWN)
 		*class = ATA_DEV_NONE;
 
 	DPRINTK("EXIT, rc=%d, class=%u\n", rc, *class);
@@ -1190,6 +1213,12 @@ static void ahci_postreset(struct ata_link *link, unsigned int *class)
 	}
 }
 
+static int ahci_pmp_softreset(struct ata_link *link, unsigned int *class,
+			      unsigned long deadline)
+{
+	return ahci_do_softreset(link, class, link->pmp, deadline);
+}
+
 static u8 ahci_check_status(struct ata_port *ap)
 {
 	void __iomem *mmio = ap->ioaddr.cmd_addr;
@@ -1248,7 +1277,7 @@ static void ahci_qc_prep(struct ata_queued_cmd *qc)
 	 */
 	cmd_tbl = pp->cmd_tbl + qc->tag * AHCI_CMD_TBL_SZ;
 
-	ata_tf_to_fis(&qc->tf, 0, 1, cmd_tbl);
+	ata_tf_to_fis(&qc->tf, qc->dev->link->pmp, 1, cmd_tbl);
 	if (is_atapi) {
 		memset(cmd_tbl + AHCI_CMD_TBL_CDB, 0, 32);
 		memcpy(cmd_tbl + AHCI_CMD_TBL_CDB, qc->cdb, qc->dev->cdb_len);
@@ -1261,7 +1290,7 @@ static void ahci_qc_prep(struct ata_queued_cmd *qc)
 	/*
 	 * Fill in command slot information.
 	 */
-	opts = cmd_fis_len | n_elem << 16;
+	opts = cmd_fis_len | n_elem << 16 | (qc->dev->link->pmp << 12);
 	if (qc->tf.flags & ATA_TFLAG_WRITE)
 		opts |= AHCI_CMD_WRITE;
 	if (is_atapi)
@@ -1273,65 +1302,85 @@ static void ahci_qc_prep(struct ata_queued_cmd *qc)
 static void ahci_error_intr(struct ata_port *ap, u32 irq_stat)
 {
 	struct ahci_port_priv *pp = ap->private_data;
-	struct ata_eh_info *ehi = &ap->link.eh_info;
-	unsigned int err_mask = 0, action = 0;
-	struct ata_queued_cmd *qc;
+	struct ata_eh_info *host_ehi = &ap->link.eh_info;
+	struct ata_link *link = NULL;
+	struct ata_queued_cmd *active_qc;
+	struct ata_eh_info *active_ehi;
 	u32 serror;
 
-	ata_ehi_clear_desc(ehi);
+	/* determine active link */
+	ata_port_for_each_link(link, ap)
+		if (ata_link_active(link))
+			break;
+	if (!link)
+		link = &ap->link;
+
+	active_qc = ata_qc_from_tag(ap, link->active_tag);
+	active_ehi = &link->eh_info;
+
+	/* record irq stat */
+	ata_ehi_clear_desc(host_ehi);
+	ata_ehi_push_desc(host_ehi, "irq_stat 0x%08x", irq_stat);
 
 	/* AHCI needs SError cleared; otherwise, it might lock up */
 	ahci_scr_read(ap, SCR_ERROR, &serror);
 	ahci_scr_write(ap, SCR_ERROR, serror);
-
-	/* analyze @irq_stat */
-	ata_ehi_push_desc(ehi, "irq_stat 0x%08x", irq_stat);
+	host_ehi->serror |= serror;
 
 	/* some controllers set IRQ_IF_ERR on device errors, ignore it */
 	if (ap->flags & AHCI_FLAG_IGN_IRQ_IF_ERR)
 		irq_stat &= ~PORT_IRQ_IF_ERR;
 
 	if (irq_stat & PORT_IRQ_TF_ERR) {
-		err_mask |= AC_ERR_DEV;
+		/* If qc is active, charge it; otherwise, the active
+		 * link.  There's no active qc on NCQ errors.  It will
+		 * be determined by EH by reading log page 10h.
+		 */
+		if (active_qc)
+			active_qc->err_mask |= AC_ERR_DEV;
+		else
+			active_ehi->err_mask |= AC_ERR_DEV;
+
 		if (ap->flags & AHCI_FLAG_IGN_SERR_INTERNAL)
-			serror &= ~SERR_INTERNAL;
+			host_ehi->serror &= ~SERR_INTERNAL;
+	}
+
+	if (irq_stat & PORT_IRQ_UNK_FIS) {
+		u32 *unk = (u32 *)(pp->rx_fis + RX_FIS_UNK);
+
+		active_ehi->err_mask |= AC_ERR_HSM;
+		active_ehi->action |= ATA_EH_SOFTRESET;
+		ata_ehi_push_desc(active_ehi,
+				  "unknown FIS %08x %08x %08x %08x" ,
+				  unk[0], unk[1], unk[2], unk[3]);
+	}
+
+	if (ap->nr_pmp_links && (irq_stat & PORT_IRQ_BAD_PMP)) {
+		active_ehi->err_mask |= AC_ERR_HSM;
+		active_ehi->action |= ATA_EH_SOFTRESET;
+		ata_ehi_push_desc(active_ehi, "incorrect PMP");
 	}
 
 	if (irq_stat & (PORT_IRQ_HBUS_ERR | PORT_IRQ_HBUS_DATA_ERR)) {
-		err_mask |= AC_ERR_HOST_BUS;
-		action |= ATA_EH_SOFTRESET;
+		host_ehi->err_mask |= AC_ERR_HOST_BUS;
+		host_ehi->action |= ATA_EH_SOFTRESET;
+		ata_ehi_push_desc(host_ehi, "host bus error");
 	}
 
 	if (irq_stat & PORT_IRQ_IF_ERR) {
-		err_mask |= AC_ERR_ATA_BUS;
-		action |= ATA_EH_SOFTRESET;
-		ata_ehi_push_desc(ehi, "interface fatal error");
+		host_ehi->err_mask |= AC_ERR_ATA_BUS;
+		host_ehi->action |= ATA_EH_SOFTRESET;
+		ata_ehi_push_desc(host_ehi, "interface fatal error");
 	}
 
 	if (irq_stat & (PORT_IRQ_CONNECT | PORT_IRQ_PHYRDY)) {
-		ata_ehi_hotplugged(ehi);
-		ata_ehi_push_desc(ehi, "%s", irq_stat & PORT_IRQ_CONNECT ?
+		ata_ehi_hotplugged(host_ehi);
+		ata_ehi_push_desc(host_ehi, "%s",
+			irq_stat & PORT_IRQ_CONNECT ?
 			"connection status changed" : "PHY RDY changed");
 	}
 
-	if (irq_stat & PORT_IRQ_UNK_FIS) {
-		u32 *unk = (u32 *)(pp->rx_fis + RX_FIS_UNK);
-
-		err_mask |= AC_ERR_HSM;
-		action |= ATA_EH_SOFTRESET;
-		ata_ehi_push_desc(ehi, "unknown FIS %08x %08x %08x %08x",
-				  unk[0], unk[1], unk[2], unk[3]);
-	}
-
 	/* okay, let's hand over to EH */
-	ehi->serror |= serror;
-	ehi->action |= action;
-
-	qc = ata_qc_from_tag(ap, ap->link.active_tag);
-	if (qc)
-		qc->err_mask |= err_mask;
-	else
-		ehi->err_mask |= err_mask;
 
 	if (irq_stat & PORT_IRQ_FREEZE)
 		ata_port_freeze(ap);
@@ -1369,7 +1418,8 @@ static void ahci_port_intr(struct ata_port *ap)
 			sata_async_notification(ap);
 	}
 
-	if (ap->link.sactive)
+	/* pp->active_link is valid iff any command is in flight */
+	if (ap->qc_active && pp->active_link->sactive)
 		qc_active = readl(port_mmio + PORT_SCR_ACT);
 	else
 		qc_active = readl(port_mmio + PORT_CMD_ISSUE);
@@ -1507,6 +1557,13 @@ static unsigned int ahci_qc_issue(struct ata_queued_cmd *qc)
 {
 	struct ata_port *ap = qc->ap;
 	void __iomem *port_mmio = ahci_port_base(ap);
+	struct ahci_port_priv *pp = ap->private_data;
+
+	/* Keep track of the currently active link.  It will be used
+	 * in completion path to determine whether NCQ phase is in
+	 * progress.
+	 */
+	pp->active_link = qc->dev->link;
 
 	if (qc->tf.protocol == ATA_PROT_NCQ)
 		writel(1 << qc->tag, port_mmio + PORT_SCR_ACT);
@@ -1536,8 +1593,11 @@ static void ahci_thaw(struct ata_port *ap)
 	writel(tmp, port_mmio + PORT_IRQ_STAT);
 	writel(1 << ap->port_no, mmio + HOST_IRQ_STAT);
 
-	/* turn IRQ back on */
-	writel(pp->intr_mask, port_mmio + PORT_IRQ_MASK);
+	/* turn IRQ back on, ignore BAD_PMP if PMP isn't attached */
+	tmp = pp->intr_mask;
+	if (!ap->nr_pmp_links)
+		tmp &= ~PORT_IRQ_BAD_PMP;
+	writel(tmp, port_mmio + PORT_IRQ_MASK);
 }
 
 static void ahci_error_handler(struct ata_port *ap)
@@ -1549,8 +1609,10 @@ static void ahci_error_handler(struct ata_port *ap)
 	}
 
 	/* perform recovery */
-	ata_do_eh(ap, ata_std_prereset, ahci_softreset, ahci_hardreset,
-		  ahci_postreset);
+	sata_pmp_do_eh(ap, ata_std_prereset, ahci_softreset,
+		       ahci_hardreset, ahci_postreset,
+		       sata_pmp_std_prereset, ahci_pmp_softreset,
+		       sata_pmp_std_hardreset, sata_pmp_std_postreset);
 }
 
 static void ahci_vt8251_error_handler(struct ata_port *ap)
@@ -1575,11 +1637,74 @@ static void ahci_post_internal_cmd(struct ata_queued_cmd *qc)
 		ahci_kick_engine(ap, 1);
 }
 
+static void ahci_pmp_attach(struct ata_port *ap)
+{
+	void __iomem *port_mmio = ahci_port_base(ap);
+	u32 cmd;
+
+	cmd = readl(port_mmio + PORT_CMD);
+	cmd |= PORT_CMD_PMP;
+	writel(cmd, port_mmio + PORT_CMD);
+}
+
+static void ahci_pmp_detach(struct ata_port *ap)
+{
+	void __iomem *port_mmio = ahci_port_base(ap);
+	struct ahci_host_priv *hpriv = ap->host->private_data;
+	unsigned long flags;
+	u32 cmd;
+
+	cmd = readl(port_mmio + PORT_CMD);
+	cmd &= ~PORT_CMD_PMP;
+	writel(cmd, port_mmio + PORT_CMD);
+
+	if (hpriv->cap & HOST_CAP_NCQ) {
+		spin_lock_irqsave(ap->lock, flags);
+		ap->flags |= ATA_FLAG_NCQ;
+		spin_unlock_irqrestore(ap->lock, flags);
+	}
+}
+
+static int ahci_pmp_read(struct ata_device *dev, int pmp, int reg, u32 *r_val)
+{
+	struct ata_port *ap = dev->link->ap;
+	struct ata_taskfile tf;
+	int rc;
+
+	ahci_kick_engine(ap, 0);
+
+	sata_pmp_read_init_tf(&tf, dev, pmp, reg);
+	rc = ahci_exec_polled_cmd(ap, SATA_PMP_CTRL_PORT, &tf, 1, 0,
+				  SATA_PMP_SCR_TIMEOUT);
+	if (rc == 0) {
+		ahci_tf_read(ap, &tf);
+		*r_val = sata_pmp_read_val(&tf);
+	}
+	return rc;
+}
+
+static int ahci_pmp_write(struct ata_device *dev, int pmp, int reg, u32 val)
+{
+	struct ata_port *ap = dev->link->ap;
+	struct ata_taskfile tf;
+
+	ahci_kick_engine(ap, 0);
+
+	sata_pmp_write_init_tf(&tf, dev, pmp, reg, val);
+	return ahci_exec_polled_cmd(ap, SATA_PMP_CTRL_PORT, &tf, 1, 0,
+				    SATA_PMP_SCR_TIMEOUT);
+}
+
 static int ahci_port_resume(struct ata_port *ap)
 {
 	ahci_power_up(ap);
 	ahci_start_port(ap);
 
+	if (ap->nr_pmp_links)
+		ahci_pmp_attach(ap);
+	else
+		ahci_pmp_detach(ap);
+
 	return 0;
 }
 
@@ -1860,6 +1985,9 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (hpriv->cap & HOST_CAP_NCQ)
 		pi.flags |= ATA_FLAG_NCQ;
 
+	if (hpriv->cap & HOST_CAP_PMP)
+		pi.flags |= ATA_FLAG_PMP;
+
 	host = ata_host_alloc_pinfo(&pdev->dev, ppi, fls(hpriv->port_map));
 	if (!host)
 		return -ENOMEM;
-- 
1.5.0.3


