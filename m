From: Bill Pemberton <wfp5p@virginia.edu>
Subject: [PATCH] ata: fix shadows sparse warning
Date: Fri, 30 Apr 2010 09:56:49 -0400
Message-ID: <1272635809-9974-1-git-send-email-wfp5p@virginia.edu>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from viridian.itc.Virginia.EDU ([128.143.12.139]:46092 "EHLO
	viridian.itc.virginia.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933354Ab0D3SLJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 30 Apr 2010 14:11:09 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

A variable named irq_stat was declared in a few places that
resulted in sparse complaining.  This also could result in confusion
with irq_stat array.

Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
---
 drivers/ata/libahci.c       |   32 +++++++++++++++---------------
 drivers/ata/sata_inic162x.c |   22 ++++++++++----------
 drivers/ata/sata_nv.c       |   46 +++++++++++++++++++++---------------------
 drivers/ata/sata_sil24.c    |   32 +++++++++++++++---------------
 4 files changed, 66 insertions(+), 66 deletions(-)

diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index 34fc57d..d35e6c3 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -1445,7 +1445,7 @@ static void ahci_fbs_dec_intr(struct ata_port *ap)
 			   "failed to clear device error\n");
 }
 
-static void ahci_error_intr(struct ata_port *ap, u32 irq_stat)
+static void ahci_error_intr(struct ata_port *ap, u32 irq_status)
 {
 	struct ahci_host_priv *hpriv = ap->host->private_data;
 	struct ahci_port_priv *pp = ap->private_data;
@@ -1481,7 +1481,7 @@ static void ahci_error_intr(struct ata_port *ap, u32 irq_stat)
 
 	/* record irq stat */
 	ata_ehi_clear_desc(host_ehi);
-	ata_ehi_push_desc(host_ehi, "irq_stat 0x%08x", irq_stat);
+	ata_ehi_push_desc(host_ehi, "irq_status 0x%08x", irq_status);
 
 	/* AHCI needs SError cleared; otherwise, it might lock up */
 	ahci_scr_read(&ap->link, SCR_ERROR, &serror);
@@ -1490,9 +1490,9 @@ static void ahci_error_intr(struct ata_port *ap, u32 irq_stat)
 
 	/* some controllers set IRQ_IF_ERR on device errors, ignore it */
 	if (hpriv->flags & AHCI_HFLAG_IGN_IRQ_IF_ERR)
-		irq_stat &= ~PORT_IRQ_IF_ERR;
+		irq_status &= ~PORT_IRQ_IF_ERR;
 
-	if (irq_stat & PORT_IRQ_TF_ERR) {
+	if (irq_status & PORT_IRQ_TF_ERR) {
 		/* If qc is active, charge it; otherwise, the active
 		 * link.  There's no active qc on NCQ errors.  It will
 		 * be determined by EH by reading log page 10h.
@@ -1506,7 +1506,7 @@ static void ahci_error_intr(struct ata_port *ap, u32 irq_stat)
 			host_ehi->serror &= ~SERR_INTERNAL;
 	}
 
-	if (irq_stat & PORT_IRQ_UNK_FIS) {
+	if (irq_status & PORT_IRQ_UNK_FIS) {
 		u32 *unk = (u32 *)(pp->rx_fis + RX_FIS_UNK);
 
 		active_ehi->err_mask |= AC_ERR_HSM;
@@ -1516,19 +1516,19 @@ static void ahci_error_intr(struct ata_port *ap, u32 irq_stat)
 				  unk[0], unk[1], unk[2], unk[3]);
 	}
 
-	if (sata_pmp_attached(ap) && (irq_stat & PORT_IRQ_BAD_PMP)) {
+	if (sata_pmp_attached(ap) && (irq_status & PORT_IRQ_BAD_PMP)) {
 		active_ehi->err_mask |= AC_ERR_HSM;
 		active_ehi->action |= ATA_EH_RESET;
 		ata_ehi_push_desc(active_ehi, "incorrect PMP");
 	}
 
-	if (irq_stat & (PORT_IRQ_HBUS_ERR | PORT_IRQ_HBUS_DATA_ERR)) {
+	if (irq_status & (PORT_IRQ_HBUS_ERR | PORT_IRQ_HBUS_DATA_ERR)) {
 		host_ehi->err_mask |= AC_ERR_HOST_BUS;
 		host_ehi->action |= ATA_EH_RESET;
 		ata_ehi_push_desc(host_ehi, "host bus error");
 	}
 
-	if (irq_stat & PORT_IRQ_IF_ERR) {
+	if (irq_status & PORT_IRQ_IF_ERR) {
 		if (fbs_need_dec)
 			active_ehi->err_mask |= AC_ERR_DEV;
 		else {
@@ -1539,16 +1539,16 @@ static void ahci_error_intr(struct ata_port *ap, u32 irq_stat)
 		ata_ehi_push_desc(host_ehi, "interface fatal error");
 	}
 
-	if (irq_stat & (PORT_IRQ_CONNECT | PORT_IRQ_PHYRDY)) {
+	if (irq_status & (PORT_IRQ_CONNECT | PORT_IRQ_PHYRDY)) {
 		ata_ehi_hotplugged(host_ehi);
 		ata_ehi_push_desc(host_ehi, "%s",
-			irq_stat & PORT_IRQ_CONNECT ?
+			irq_status & PORT_IRQ_CONNECT ?
 			"connection status changed" : "PHY RDY changed");
 	}
 
 	/* okay, let's hand over to EH */
 
-	if (irq_stat & PORT_IRQ_FREEZE)
+	if (irq_status & PORT_IRQ_FREEZE)
 		ata_port_freeze(ap);
 	else if (fbs_need_dec) {
 		ata_link_abort(link);
@@ -1656,7 +1656,7 @@ irqreturn_t ahci_interrupt(int irq, void *dev_instance)
 	struct ahci_host_priv *hpriv;
 	unsigned int i, handled = 0;
 	void __iomem *mmio;
-	u32 irq_stat, irq_masked;
+	u32 irq_status, irq_masked;
 
 	VPRINTK("ENTER\n");
 
@@ -1664,11 +1664,11 @@ irqreturn_t ahci_interrupt(int irq, void *dev_instance)
 	mmio = hpriv->mmio;
 
 	/* sigh.  0xffffffff is a valid return from h/w */
-	irq_stat = readl(mmio + HOST_IRQ_STAT);
-	if (!irq_stat)
+	irq_status = readl(mmio + HOST_IRQ_STAT);
+	if (!irq_status)
 		return IRQ_NONE;
 
-	irq_masked = irq_stat & hpriv->port_map;
+	irq_masked = irq_status & hpriv->port_map;
 
 	spin_lock(&host->lock);
 
@@ -1701,7 +1701,7 @@ irqreturn_t ahci_interrupt(int irq, void *dev_instance)
 	 * Also, use the unmasked value to clear interrupt as spurious
 	 * pending event on a dummy port might cause screaming IRQ.
 	 */
-	writel(irq_stat, mmio + HOST_IRQ_STAT);
+	writel(irq_status, mmio + HOST_IRQ_STAT);
 
 	spin_unlock(&host->lock);
 
diff --git a/drivers/ata/sata_inic162x.c b/drivers/ata/sata_inic162x.c
index 27dc6c8..f26df2f 100644
--- a/drivers/ata/sata_inic162x.c
+++ b/drivers/ata/sata_inic162x.c
@@ -307,7 +307,7 @@ static void inic_stop_idma(struct ata_port *ap)
 	writew(0, port_base + PORT_IDMA_CTL);
 }
 
-static void inic_host_err_intr(struct ata_port *ap, u8 irq_stat, u16 idma_stat)
+static void inic_host_err_intr(struct ata_port *ap, u8 irq_status, u16 idma_stat)
 {
 	struct ata_eh_info *ehi = &ap->link.eh_info;
 	struct inic_port_priv *pp = ap->private_data;
@@ -315,12 +315,12 @@ static void inic_host_err_intr(struct ata_port *ap, u8 irq_stat, u16 idma_stat)
 	bool freeze = false;
 
 	ata_ehi_clear_desc(ehi);
-	ata_ehi_push_desc(ehi, "irq_stat=0x%x idma_stat=0x%x",
-			  irq_stat, idma_stat);
+	ata_ehi_push_desc(ehi, "irq_status=0x%x idma_stat=0x%x",
+			  irq_status, idma_stat);
 
 	inic_stop_idma(ap);
 
-	if (irq_stat & (PIRQ_OFFLINE | PIRQ_ONLINE)) {
+	if (irq_status & (PIRQ_OFFLINE | PIRQ_ONLINE)) {
 		ata_ehi_push_desc(ehi, "hotplug");
 		ata_ehi_hotplugged(ehi);
 		freeze = true;
@@ -367,16 +367,16 @@ static void inic_host_intr(struct ata_port *ap)
 {
 	void __iomem *port_base = inic_port_base(ap);
 	struct ata_queued_cmd *qc = ata_qc_from_tag(ap, ap->link.active_tag);
-	u8 irq_stat;
+	u8 irq_status;
 	u16 idma_stat;
 
 	/* read and clear IRQ status */
-	irq_stat = readb(port_base + PORT_IRQ_STAT);
-	writeb(irq_stat, port_base + PORT_IRQ_STAT);
+	irq_status = readb(port_base + PORT_IRQ_STAT);
+	writeb(irq_status, port_base + PORT_IRQ_STAT);
 	idma_stat = readw(port_base + PORT_IDMA_STAT);
 
-	if (unlikely((irq_stat & PIRQ_ERR) || (idma_stat & IDMA_STAT_ERR)))
-		inic_host_err_intr(ap, irq_stat, idma_stat);
+	if (unlikely((irq_status & PIRQ_ERR) || (idma_stat & IDMA_STAT_ERR)))
+		inic_host_err_intr(ap, irq_status, idma_stat);
 
 	if (unlikely(!qc))
 		goto spurious;
@@ -397,8 +397,8 @@ static void inic_host_intr(struct ata_port *ap)
 
  spurious:
 	ata_port_printk(ap, KERN_WARNING, "unhandled interrupt: "
-			"cmd=0x%x irq_stat=0x%x idma_stat=0x%x\n",
-			qc ? qc->tf.command : 0xff, irq_stat, idma_stat);
+			"cmd=0x%x irq_status=0x%x idma_stat=0x%x\n",
+			qc ? qc->tf.command : 0xff, irq_status, idma_stat);
 }
 
 static irqreturn_t inic_interrupt(int irq, void *dev_instance)
diff --git a/drivers/ata/sata_nv.c b/drivers/ata/sata_nv.c
index 2a98b09..62d8651 100644
--- a/drivers/ata/sata_nv.c
+++ b/drivers/ata/sata_nv.c
@@ -899,18 +899,18 @@ static int nv_adma_check_cpb(struct ata_port *ap, int cpb_num, int force_err)
 	return 0;
 }
 
-static int nv_host_intr(struct ata_port *ap, u8 irq_stat)
+static int nv_host_intr(struct ata_port *ap, u8 irq_status)
 {
 	struct ata_queued_cmd *qc = ata_qc_from_tag(ap, ap->link.active_tag);
 
 	/* freeze if hotplugged */
-	if (unlikely(irq_stat & (NV_INT_ADDED | NV_INT_REMOVED))) {
+	if (unlikely(irq_status & (NV_INT_ADDED | NV_INT_REMOVED))) {
 		ata_port_freeze(ap);
 		return 1;
 	}
 
 	/* bail out if not our interrupt */
-	if (!(irq_stat & NV_INT_DEV))
+	if (!(irq_status & NV_INT_DEV))
 		return 0;
 
 	/* DEV interrupt w/ no active qc? */
@@ -944,22 +944,22 @@ static irqreturn_t nv_adma_interrupt(int irq, void *dev_instance)
 
 			/* if ADMA is disabled, use standard ata interrupt handler */
 			if (pp->flags & NV_ADMA_ATAPI_SETUP_COMPLETE) {
-				u8 irq_stat = readb(host->iomap[NV_MMIO_BAR] + NV_INT_STATUS_CK804)
+				u8 irq_status = readb(host->iomap[NV_MMIO_BAR] + NV_INT_STATUS_CK804)
 					>> (NV_INT_PORT_SHIFT * i);
-				handled += nv_host_intr(ap, irq_stat);
+				handled += nv_host_intr(ap, irq_status);
 				continue;
 			}
 
 			/* if in ATA register mode, check for standard interrupts */
 			if (pp->flags & NV_ADMA_PORT_REGISTER_MODE) {
-				u8 irq_stat = readb(host->iomap[NV_MMIO_BAR] + NV_INT_STATUS_CK804)
+				u8 irq_status = readb(host->iomap[NV_MMIO_BAR] + NV_INT_STATUS_CK804)
 					>> (NV_INT_PORT_SHIFT * i);
 				if (ata_tag_valid(ap->link.active_tag))
 					/** NV_INT_DEV indication seems unreliable at times
 					    at least in ADMA mode. Force it on always when a
 					    command is active, to prevent losing interrupts. */
-					irq_stat |= NV_INT_DEV;
-				handled += nv_host_intr(ap, irq_stat);
+					irq_status |= NV_INT_DEV;
+				handled += nv_host_intr(ap, irq_status);
 			}
 
 			notifier = readl(mmio + NV_ADMA_NOTIFIER);
@@ -1521,7 +1521,7 @@ static irqreturn_t nv_generic_interrupt(int irq, void *dev_instance)
 	return IRQ_RETVAL(handled);
 }
 
-static irqreturn_t nv_do_interrupt(struct ata_host *host, u8 irq_stat)
+static irqreturn_t nv_do_interrupt(struct ata_host *host, u8 irq_status)
 {
 	int i, handled = 0;
 
@@ -1529,9 +1529,9 @@ static irqreturn_t nv_do_interrupt(struct ata_host *host, u8 irq_stat)
 		struct ata_port *ap = host->ports[i];
 
 		if (ap && !(ap->flags & ATA_FLAG_DISABLED))
-			handled += nv_host_intr(ap, irq_stat);
+			handled += nv_host_intr(ap, irq_status);
 
-		irq_stat >>= NV_INT_PORT_SHIFT;
+		irq_status >>= NV_INT_PORT_SHIFT;
 	}
 
 	return IRQ_RETVAL(handled);
@@ -1540,12 +1540,12 @@ static irqreturn_t nv_do_interrupt(struct ata_host *host, u8 irq_stat)
 static irqreturn_t nv_nf2_interrupt(int irq, void *dev_instance)
 {
 	struct ata_host *host = dev_instance;
-	u8 irq_stat;
+	u8 irq_status;
 	irqreturn_t ret;
 
 	spin_lock(&host->lock);
-	irq_stat = ioread8(host->ports[0]->ioaddr.scr_addr + NV_INT_STATUS);
-	ret = nv_do_interrupt(host, irq_stat);
+	irq_status = ioread8(host->ports[0]->ioaddr.scr_addr + NV_INT_STATUS);
+	ret = nv_do_interrupt(host, irq_status);
 	spin_unlock(&host->lock);
 
 	return ret;
@@ -1554,12 +1554,12 @@ static irqreturn_t nv_nf2_interrupt(int irq, void *dev_instance)
 static irqreturn_t nv_ck804_interrupt(int irq, void *dev_instance)
 {
 	struct ata_host *host = dev_instance;
-	u8 irq_stat;
+	u8 irq_status;
 	irqreturn_t ret;
 
 	spin_lock(&host->lock);
-	irq_stat = readb(host->iomap[NV_MMIO_BAR] + NV_INT_STATUS_CK804);
-	ret = nv_do_interrupt(host, irq_stat);
+	irq_status = readb(host->iomap[NV_MMIO_BAR] + NV_INT_STATUS_CK804);
+	ret = nv_do_interrupt(host, irq_status);
 	spin_unlock(&host->lock);
 
 	return ret;
@@ -2371,27 +2371,27 @@ static irqreturn_t nv_swncq_interrupt(int irq, void *dev_instance)
 	unsigned int i;
 	unsigned int handled = 0;
 	unsigned long flags;
-	u32 irq_stat;
+	u32 irq_status;
 
 	spin_lock_irqsave(&host->lock, flags);
 
-	irq_stat = readl(host->iomap[NV_MMIO_BAR] + NV_INT_STATUS_MCP55);
+	irq_status = readl(host->iomap[NV_MMIO_BAR] + NV_INT_STATUS_MCP55);
 
 	for (i = 0; i < host->n_ports; i++) {
 		struct ata_port *ap = host->ports[i];
 
 		if (ap && !(ap->flags & ATA_FLAG_DISABLED)) {
 			if (ap->link.sactive) {
-				nv_swncq_host_interrupt(ap, (u16)irq_stat);
+				nv_swncq_host_interrupt(ap, (u16)irq_status);
 				handled = 1;
 			} else {
-				if (irq_stat)	/* reserve Hotplug */
+				if (irq_status)	/* reserve Hotplug */
 					nv_swncq_irq_clear(ap, 0xfff0);
 
-				handled += nv_host_intr(ap, (u8)irq_stat);
+				handled += nv_host_intr(ap, (u8)irq_status);
 			}
 		}
-		irq_stat >>= NV_INT_PORT_SHIFT_MCP55;
+		irq_status >>= NV_INT_PORT_SHIFT_MCP55;
 	}
 
 	spin_unlock_irqrestore(&host->lock, flags);
diff --git a/drivers/ata/sata_sil24.c b/drivers/ata/sata_sil24.c
index 433b6b8..8ac5f61 100644
--- a/drivers/ata/sata_sil24.c
+++ b/drivers/ata/sata_sil24.c
@@ -612,7 +612,7 @@ static int sil24_exec_polled_cmd(struct ata_port *ap, int pmp,
 	struct sil24_port_priv *pp = ap->private_data;
 	struct sil24_prb *prb = &pp->cmd_block[0].ata.prb;
 	dma_addr_t paddr = pp->cmd_block_dma;
-	u32 irq_enabled, irq_mask, irq_stat;
+	u32 irq_enabled, irq_mask, irq_status;
 	int rc;
 
 	prb->ctrl = cpu_to_le16(ctrl);
@@ -626,19 +626,19 @@ static int sil24_exec_polled_cmd(struct ata_port *ap, int pmp,
 	writel((u64)paddr >> 32, port + PORT_CMD_ACTIVATE + 4);
 
 	irq_mask = (PORT_IRQ_COMPLETE | PORT_IRQ_ERROR) << PORT_IRQ_RAW_SHIFT;
-	irq_stat = ata_wait_register(port + PORT_IRQ_STAT, irq_mask, 0x0,
+	irq_status = ata_wait_register(port + PORT_IRQ_STAT, irq_mask, 0x0,
 				     10, timeout_msec);
 
 	writel(irq_mask, port + PORT_IRQ_STAT); /* clear IRQs */
-	irq_stat >>= PORT_IRQ_RAW_SHIFT;
+	irq_status >>= PORT_IRQ_RAW_SHIFT;
 
-	if (irq_stat & PORT_IRQ_COMPLETE)
+	if (irq_status & PORT_IRQ_COMPLETE)
 		rc = 0;
 	else {
 		/* force port into known state */
 		sil24_init_port(ap);
 
-		if (irq_stat & PORT_IRQ_ERROR)
+		if (irq_status & PORT_IRQ_ERROR)
 			rc = -EIO;
 		else
 			rc = -EBUSY;
@@ -976,33 +976,33 @@ static void sil24_error_intr(struct ata_port *ap)
 	struct ata_link *link;
 	struct ata_eh_info *ehi;
 	int abort = 0, freeze = 0;
-	u32 irq_stat;
+	u32 irq_status;
 
 	/* on error, we need to clear IRQ explicitly */
-	irq_stat = readl(port + PORT_IRQ_STAT);
-	writel(irq_stat, port + PORT_IRQ_STAT);
+	irq_status = readl(port + PORT_IRQ_STAT);
+	writel(irq_status, port + PORT_IRQ_STAT);
 
 	/* first, analyze and record host port events */
 	link = &ap->link;
 	ehi = &link->eh_info;
 	ata_ehi_clear_desc(ehi);
 
-	ata_ehi_push_desc(ehi, "irq_stat 0x%08x", irq_stat);
+	ata_ehi_push_desc(ehi, "irq_status 0x%08x", irq_status);
 
-	if (irq_stat & PORT_IRQ_SDB_NOTIFY) {
+	if (irq_status & PORT_IRQ_SDB_NOTIFY) {
 		ata_ehi_push_desc(ehi, "SDB notify");
 		sata_async_notification(ap);
 	}
 
-	if (irq_stat & (PORT_IRQ_PHYRDY_CHG | PORT_IRQ_DEV_XCHG)) {
+	if (irq_status & (PORT_IRQ_PHYRDY_CHG | PORT_IRQ_DEV_XCHG)) {
 		ata_ehi_hotplugged(ehi);
 		ata_ehi_push_desc(ehi, "%s",
-				  irq_stat & PORT_IRQ_PHYRDY_CHG ?
+				  irq_status & PORT_IRQ_PHYRDY_CHG ?
 				  "PHY RDY changed" : "device exchanged");
 		freeze = 1;
 	}
 
-	if (irq_stat & PORT_IRQ_UNK_FIS) {
+	if (irq_status & PORT_IRQ_UNK_FIS) {
 		ehi->err_mask |= AC_ERR_HSM;
 		ehi->action |= ATA_EH_RESET;
 		ata_ehi_push_desc(ehi, "unknown FIS");
@@ -1010,7 +1010,7 @@ static void sil24_error_intr(struct ata_port *ap)
 	}
 
 	/* deal with command error */
-	if (irq_stat & PORT_IRQ_ERROR) {
+	if (irq_status & PORT_IRQ_ERROR) {
 		struct sil24_cerr_info *ci = NULL;
 		unsigned int err_mask = 0, action = 0;
 		u32 context, cerr;
@@ -1042,8 +1042,8 @@ static void sil24_error_intr(struct ata_port *ap)
 				qc = ata_qc_from_tag(ap, link->active_tag);
 
 				ata_ehi_clear_desc(ehi);
-				ata_ehi_push_desc(ehi, "irq_stat 0x%08x",
-						  irq_stat);
+				ata_ehi_push_desc(ehi, "irq_status 0x%08x",
+						  irq_status);
 			} else {
 				err_mask |= AC_ERR_HSM;
 				action |= ATA_EH_RESET;
-- 
1.7.0.6

