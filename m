From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 12/12] sata_sil24: implement PORT_RST
Date: Sat, 8 Jul 2006 14:58:09 +0900
Message-ID: <11523382893054-git-send-email-htejun@gmail.com>
References: <11523382873130-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.234]:8053 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S964804AbWGHF5W (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 8 Jul 2006 01:57:22 -0400
Received: by wr-out-0506.google.com with SMTP id 36so1484772wra
        for <linux-ide@vger.kernel.org>; Fri, 07 Jul 2006 22:57:21 -0700 (PDT)
In-Reply-To: <11523382873130-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, lkml@rtr.ca, forrest.zhao@intel.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

As DEV_RST (hardreset) sometimes fail to recover the controller
(especially after PMP DMA CS errata).  In such cases, perform PORT_RST
prior to DEV_RST.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/sata_sil24.c |   97 ++++++++++++++++++++++++++++++++-------------
 1 files changed, 70 insertions(+), 27 deletions(-)

8972274451231ed8fda138f7a696e1f40d4deebb
diff --git a/drivers/scsi/sata_sil24.c b/drivers/scsi/sata_sil24.c
index 5e93f1c..593c054 100644
--- a/drivers/scsi/sata_sil24.c
+++ b/drivers/scsi/sata_sil24.c
@@ -320,6 +320,7 @@ struct sil24_port_priv {
 	union sil24_cmd_block *cmd_block;	/* 32 cmd blocks */
 	dma_addr_t cmd_block_dma;		/* DMA base addr for them */
 	struct ata_taskfile tf;			/* Cached taskfile registers */
+	int do_port_rst;
 };
 
 /* ap->host_set->private_data */
@@ -539,6 +540,29 @@ static void sil24_tf_read(struct ata_por
 	*tf = pp->tf;
 }
 
+static void sil24_config_port(void __iomem *port, unsigned long host_flags)
+{
+	/* configure IRQ WoC */
+	if (host_flags & SIL24_FLAG_PCIX_IRQ_WOC)
+		writel(PORT_CS_IRQ_WOC, port + PORT_CTRL_STAT);
+	else
+		writel(PORT_CS_IRQ_WOC, port + PORT_CTRL_CLR);
+
+	/* zero error counters. */
+	writel(0x8000, port + PORT_DECODE_ERR_THRESH);
+	writel(0x8000, port + PORT_CRC_ERR_THRESH);
+	writel(0x8000, port + PORT_HSHK_ERR_THRESH);
+	writel(0x0000, port + PORT_DECODE_ERR_CNT);
+	writel(0x0000, port + PORT_CRC_ERR_CNT);
+	writel(0x0000, port + PORT_HSHK_ERR_CNT);
+
+	/* always use 64bit activation */
+	writel(PORT_CS_32BIT_ACTV, port + PORT_CTRL_CLR);
+
+	/* clear port multiplier enable and resume bits */
+	writel(PORT_CS_PMP_EN | PORT_CS_PMP_RESUME, port + PORT_CTRL_CLR);
+}
+
 static void sil24_config_pmp(struct ata_port *ap, int attached)
 {
 	void __iomem *port = (void __iomem *)ap->ioaddr.cmd_addr;
@@ -567,6 +591,7 @@ static void sil24_clear_pmp(struct ata_p
 static int sil24_init_port(struct ata_port *ap)
 {
 	void __iomem *port = (void __iomem *)ap->ioaddr.cmd_addr;
+	struct sil24_port_priv *pp = ap->private_data;
 	u32 tmp;
 
 	writel(PORT_CS_INIT, port + PORT_CTRL_STAT);
@@ -578,8 +603,12 @@ static int sil24_init_port(struct ata_po
 	/* clear PMP error status */
 	sil24_clear_pmp(ap);
 
-	if ((tmp & (PORT_CS_INIT | PORT_CS_RDY)) != PORT_CS_RDY)
+	if ((tmp & (PORT_CS_INIT | PORT_CS_RDY)) != PORT_CS_RDY) {
+		pp->do_port_rst = 1;
+		ap->link.eh_context.i.action |= ATA_EH_HARDRESET;
 		return -EIO;
+	}
+
 	return 0;
 }
 
@@ -688,10 +717,34 @@ static int sil24_hardreset(struct ata_li
 {
 	struct ata_port *ap = link->ap;
 	void __iomem *port = (void __iomem *)ap->ioaddr.cmd_addr;
+	struct sil24_port_priv *pp = ap->private_data;
+	int did_port_rst = 0;
 	const char *reason;
 	int tout_msec, rc;
 	u32 tmp;
 
+ retry:
+	/* Sometimes, DEV_RST is not enough to recover the controller.
+	 * This happens a lot after PM DMA CS errata.
+	 */
+	if (pp->do_port_rst) {
+		ata_port_printk(ap, KERN_WARNING, "controller in dubious "
+				"state, performing PORT_RST\n");
+
+		writel(PORT_CS_PORT_RST, port + PORT_CTRL_STAT);
+		msleep(10);
+		writel(PORT_CS_PORT_RST, port + PORT_CTRL_CLR);
+		ata_wait_register(port + PORT_CTRL_STAT, PORT_CS_RDY, 0,
+				  10, 5000);
+
+		/* restore port configuration */
+		sil24_config_port(port, ap->flags);
+		sil24_config_pmp(ap, ap->nr_pmp_links);
+
+		pp->do_port_rst = 0;
+		did_port_rst = 1;
+	}
+
 	/* sil24 does the right thing(tm) without any protection */
 	sata_set_spd(link);
 
@@ -728,6 +781,11 @@ static int sil24_hardreset(struct ata_li
 	return -EAGAIN;
 
  err:
+	if (!did_port_rst) {
+		pp->do_port_rst = 1;
+		goto retry;
+	}
+
 	ata_link_printk(link, KERN_ERR, "hardreset failed (%s)\n", reason);
 	return -EIO;
 }
@@ -996,6 +1054,7 @@ static void sil24_error_intr(struct ata_
 			ehi->err_mask |= AC_ERR_OTHER;
 			ehi->action |= ATA_EH_HARDRESET;
 			ata_ehi_push_desc(ehi, ", PMP DMA CS errata");
+			pp->do_port_rst = 1;
 			freeze = 1;
 		}
 
@@ -1143,18 +1202,18 @@ static irqreturn_t sil24_interrupt(int i
 
 static void sil24_error_handler(struct ata_port *ap)
 {
-	struct ata_eh_context *ehc = &ap->link.eh_context;
+	struct sil24_port_priv *pp = ap->private_data;
 
-	if (sil24_init_port(ap)) {
+	if (sil24_init_port(ap))
 		ata_eh_freeze_port(ap);
-		ehc->i.action |= ATA_EH_HARDRESET;
-	}
 
 	/* perform recovery */
 	sata_pmp_do_eh(ap, ata_std_prereset, sil24_softreset, sil24_hardreset,
 		       ata_std_postreset, sata_pmp_std_prereset,
 		       sil24_pmp_softreset, sil24_pmp_hardreset,
 		       sata_pmp_std_postreset);
+
+	pp->do_port_rst = 0;
 }
 
 static void sil24_post_internal_cmd(struct ata_queued_cmd *qc)
@@ -1165,8 +1224,10 @@ static void sil24_post_internal_cmd(stru
 		qc->err_mask |= AC_ERR_OTHER;
 
 	/* make DMA engine forget about the failed command */
-	if (qc->err_mask)
-		sil24_init_port(ap);
+	if (qc->err_mask) {
+		if (sil24_init_port(ap))
+			ata_eh_freeze_port(ap);
+	}
 }
 
 static inline void sil24_cblk_free(struct sil24_port_priv *pp, struct device *dev)
@@ -1268,26 +1329,8 @@ static void sil24_init_controller(struct
 				           "failed to clear port RST\n");
 		}
 
-		/* Configure IRQ WoC */
-		if (host_flags & SIL24_FLAG_PCIX_IRQ_WOC)
-			writel(PORT_CS_IRQ_WOC, port + PORT_CTRL_STAT);
-		else
-			writel(PORT_CS_IRQ_WOC, port + PORT_CTRL_CLR);
-
-		/* Zero error counters. */
-		writel(0x8000, port + PORT_DECODE_ERR_THRESH);
-		writel(0x8000, port + PORT_CRC_ERR_THRESH);
-		writel(0x8000, port + PORT_HSHK_ERR_THRESH);
-		writel(0x0000, port + PORT_DECODE_ERR_CNT);
-		writel(0x0000, port + PORT_CRC_ERR_CNT);
-		writel(0x0000, port + PORT_HSHK_ERR_CNT);
-
-		/* Always use 64bit activation */
-		writel(PORT_CS_32BIT_ACTV, port + PORT_CTRL_CLR);
-
-		/* Clear port multiplier enable and resume bits */
-		writel(PORT_CS_PMP_EN | PORT_CS_PMP_RESUME,
-		       port + PORT_CTRL_CLR);
+		/* configure port */
+		sil24_config_port(port, host_flags);
 	}
 
 	/* Turn on interrupts */
-- 
1.3.2


