From: Tejun Heo <htejun@gmail.com>
Subject: ahci: improve and limit spurious interrupt messages, take#3
Date: Thu, 25 Jan 2007 19:16:28 +0900
Message-ID: <20070125101628.GA8606@htj.dyndns.org>
References: <20070115090117.GL10987@htj.dyndns.org> <20070116065239.GO10987@htj.dyndns.org> <45B806DA.1050107@pobox.com> <45B8626B.9090002@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.238]:35755 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965757AbXAYKQe (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 25 Jan 2007 05:16:34 -0500
Received: by nz-out-0506.google.com with SMTP id s1so376399nze
        for <linux-ide@vger.kernel.org>; Thu, 25 Jan 2007 02:16:34 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <45B8626B.9090002@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

We're still seeing a lot of issues with NCQ implementation in drive
firmwares.  Sprious FISes during NCQ command phase occur on many
drives and some of them seem potentially dangerous (at least to me).
Until we find the solution, spurious messages can give us more info.
Improve and limit them such that more info can be reported while not
disturbing users too much.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
Fixed as advised.  Thanks.

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 5998f74..659949a 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -75,6 +75,7 @@ enum {
 	AHCI_CMD_CLR_BUSY	= (1 << 10),
 
 	RX_FIS_D2H_REG		= 0x40,	/* offset of D2H Register FIS data */
+	RX_FIS_SDB		= 0x58, /* offset of SDB FIS data */
 	RX_FIS_UNK		= 0x60, /* offset of Unknown FIS data */
 
 	board_ahci		= 0,
@@ -202,6 +203,10 @@ struct ahci_port_priv {
 	dma_addr_t		cmd_tbl_dma;
 	void			*rx_fis;
 	dma_addr_t		rx_fis_dma;
+	/* for NCQ spurious interrupt analysis */
+	int			ncq_saw_spurious_sdb_cnt;
+	unsigned int		ncq_saw_d2h:1;
+	unsigned int		ncq_saw_dmas:1;
 };
 
 static u32 ahci_scr_read (struct ata_port *ap, unsigned int sc_reg);
@@ -1126,8 +1131,9 @@ static void ahci_host_intr(struct ata_port *ap)
 	void __iomem *mmio = ap->host->mmio_base;
 	void __iomem *port_mmio = ahci_port_base(mmio, ap->port_no);
 	struct ata_eh_info *ehi = &ap->eh_info;
+	struct ahci_port_priv *pp = ap->private_data;
 	u32 status, qc_active;
-	int rc;
+	int rc, known_irq = 0;
 
 	status = readl(port_mmio + PORT_IRQ_STAT);
 	writel(status, port_mmio + PORT_IRQ_STAT);
@@ -1154,17 +1160,52 @@ static void ahci_host_intr(struct ata_port *ap)
 
 	/* hmmm... a spurious interupt */
 
-	/* some devices send D2H reg with I bit set during NCQ command phase */
-	if (ap->sactive && (status & PORT_IRQ_D2H_REG_FIS))
+	/* if !NCQ, ignore.  No modern ATA device has broken HSM
+	 * implementation for non-NCQ commands.
+	 */
+	if (!ap->sactive)
 		return;
 
-	/* ignore interim PIO setup fis interrupts */
-	if (ata_tag_valid(ap->active_tag) && (status & PORT_IRQ_PIOS_FIS))
-		return;
+	if (status & PORT_IRQ_D2H_REG_FIS) {
+		if (!pp->ncq_saw_d2h)
+			ata_port_printk(ap, KERN_INFO,
+				"D2H reg with I during NCQ, "
+				"this message won't be printed again\n");
+		pp->ncq_saw_d2h = 1;
+		known_irq = 1;
+	}
+
+	if (status & PORT_IRQ_DMAS_FIS) {
+		if (!pp->ncq_saw_dmas)
+			ata_port_printk(ap, KERN_INFO,
+				"DMAS FIS during NCQ, "
+				"this message won't be printed again\n");
+		pp->ncq_saw_dmas = 1;
+		known_irq = 1;
+	}
+
+	if (status & PORT_IRQ_SDB_FIS &&
+		   pp->ncq_saw_spurious_sdb_cnt < 10) {
+		/* SDB FIS containing spurious completions might be
+		 * dangerous, we need to know more about them.  Print
+		 * more of it.
+		 */
+		const u32 *f = pp->rx_fis + RX_FIS_SDB;
+
+		ata_port_printk(ap, KERN_INFO, "Spurious SDB FIS during NCQ "
+				"issue=0x%x SAct=0x%x FIS=%08x:%08x%s\n",
+				readl(port_mmio + PORT_CMD_ISSUE),
+				readl(port_mmio + PORT_SCR_ACT), f[0], f[1],
+				pp->ncq_saw_spurious_sdb_cnt < 10 ?
+				"" : ", shutting up");
+
+		pp->ncq_saw_spurious_sdb_cnt++;
+		known_irq = 1;
+	}
 
-	if (ata_ratelimit())
+	if (!known_irq)
 		ata_port_printk(ap, KERN_INFO, "spurious interrupt "
-				"(irq_stat 0x%x active_tag %d sactive 0x%x)\n",
+				"(irq_stat 0x%x active_tag 0x%x sactive 0x%x)\n",
 				status, ap->active_tag, ap->sactive);
 }
 
