From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 12/12] sata_sil24: implement PORT_RST
Date: Mon, 16 Oct 2006 08:47:18 +0900
Message-ID: <1160956038813-git-send-email-htejun@gmail.com>
References: <11609560371552-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.188]:41616 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932237AbWJOXre (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 15 Oct 2006 19:47:34 -0400
Received: by nf-out-0910.google.com with SMTP id c2so636840nfe
        for <linux-ide@vger.kernel.org>; Sun, 15 Oct 2006 16:47:32 -0700 (PDT)
In-Reply-To: <11609560371552-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

As DEV_RST (hardreset) sometimes fail to recover the controller
(especially after PMP DMA CS errata).  In such cases, perform PORT_RST
prior to DEV_RST.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/sata_sil24.c |   87 +++++++++++++++++++++++++++++++++++-----------
 1 files changed, 66 insertions(+), 21 deletions(-)

diff --git a/drivers/ata/sata_sil24.c b/drivers/ata/sata_sil24.c
index 1832adf..75d2e9a 100644
--- a/drivers/ata/sata_sil24.c
+++ b/drivers/ata/sata_sil24.c
@@ -320,6 +320,7 @@ struct sil24_port_priv {
 	union sil24_cmd_block *cmd_block;	/* 32 cmd blocks */
 	dma_addr_t cmd_block_dma;		/* DMA base addr for them */
 	struct ata_taskfile tf;			/* Cached taskfile registers */
+	int do_port_rst;
 };
 
 /* ap->host->private_data */
@@ -546,6 +547,29 @@ static void sil24_tf_read(struct ata_por
 	*tf = pp->tf;
 }
 
+static void sil24_config_port(void __iomem *port, unsigned long port_flags)
+{
+	/* configure IRQ WoC */
+	if (port_flags & SIL24_FLAG_PCIX_IRQ_WOC)
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
@@ -574,6 +598,7 @@ static void sil24_clear_pmp(struct ata_p
 static int sil24_init_port(struct ata_port *ap)
 {
 	void __iomem *port = (void __iomem *)ap->ioaddr.cmd_addr;
+	struct sil24_port_priv *pp = ap->private_data;
 	u32 tmp;
 
 	/* clear PMP error status */
@@ -586,8 +611,12 @@ static int sil24_init_port(struct ata_po
 	tmp = ata_wait_register(port + PORT_CTRL_STAT,
 				PORT_CS_RDY, 0, 10, 100);
 
-	if ((tmp & (PORT_CS_INIT | PORT_CS_RDY)) != PORT_CS_RDY)
+	if ((tmp & (PORT_CS_INIT | PORT_CS_RDY)) != PORT_CS_RDY) {
+		pp->do_port_rst = 1;
+		ap->link.eh_context.i.action |= ATA_EH_HARDRESET;
 		return -EIO;
+	}
+
 	return 0;
 }
 
@@ -696,10 +725,34 @@ static int sil24_hardreset(struct ata_li
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
 
@@ -736,6 +789,11 @@ static int sil24_hardreset(struct ata_li
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
@@ -1004,6 +1062,7 @@ static void sil24_error_intr(struct ata_
 			ehi->err_mask |= AC_ERR_OTHER;
 			ehi->action |= ATA_EH_HARDRESET;
 			ata_ehi_push_desc(ehi, ", PMP DMA CS errata");
+			pp->do_port_rst = 1;
 			freeze = 1;
 		}
 
@@ -1151,6 +1210,8 @@ static irqreturn_t sil24_interrupt(int i
 
 static void sil24_error_handler(struct ata_port *ap)
 {
+	struct sil24_port_priv *pp = ap->private_data;
+
 	if (sil24_init_port(ap))
 		ata_eh_freeze_port(ap);
 
@@ -1159,6 +1220,8 @@ static void sil24_error_handler(struct a
 		       ata_std_postreset, sata_pmp_std_prereset,
 		       sil24_pmp_softreset, sil24_pmp_hardreset,
 		       sata_pmp_std_postreset);
+
+	pp->do_port_rst = 0;
 }
 
 static void sil24_post_internal_cmd(struct ata_queued_cmd *qc)
@@ -1272,26 +1335,8 @@ static void sil24_init_controller(struct
 				           "failed to clear port RST\n");
 		}
 
-		/* Configure IRQ WoC */
-		if (port_flags & SIL24_FLAG_PCIX_IRQ_WOC)
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
+		sil24_config_port(port, port_flags);
 	}
 
 	/* Turn on interrupts */
-- 
1.4.2.3


