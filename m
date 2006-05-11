From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 10/10] sata_sil24: implement PORT_RST
Date: Fri, 12 May 2006 01:43:43 +0900
Message-ID: <11473658232595-git-send-email-htejun@gmail.com>
References: <11473658222012-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.180]:10480 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1030347AbWEKQnz (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 11 May 2006 12:43:55 -0400
Received: by py-out-1112.google.com with SMTP id f28so308107pyf
        for <linux-ide@vger.kernel.org>; Thu, 11 May 2006 09:43:54 -0700 (PDT)
In-Reply-To: <11473658222012-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, forrest.zhao@intel.com, efalk@google.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

DEV_RST (hardreset) sometimes fail to recover the controller
(especially after PM CS DMA errata).  In such cases, perform PORT_RST
prior to DEV_RST.

---

 drivers/scsi/sata_sil24.c |   98 +++++++++++++++++++++++++++++++++------------
 1 files changed, 72 insertions(+), 26 deletions(-)

246bc1468a20be1c93d294eb0b75a9df71e2a8ef
diff --git a/drivers/scsi/sata_sil24.c b/drivers/scsi/sata_sil24.c
index 1979cfc..9b7f46f 100644
--- a/drivers/scsi/sata_sil24.c
+++ b/drivers/scsi/sata_sil24.c
@@ -318,6 +318,7 @@ static struct sil24_cerr_info {
 struct sil24_port_priv {
 	union sil24_cmd_block *cmd_block;	/* 32 cmd blocks */
 	dma_addr_t cmd_block_dma;		/* DMA base addr for them */
+	int do_port_rst;
 };
 
 /* ap->host_set->private_data */
@@ -510,6 +511,30 @@ static void sil24_scr_write(struct ata_p
 	}
 }
 
+static void sil24_config_controller(void __iomem *port,
+				    unsigned long host_flags)
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
+	writel(PORT_CS_PM_EN | PORT_CS_PM_RESUME, port + PORT_CTRL_CLR);
+}
+
 static void sil24_config_pm(struct ata_port *ap, int attached)
 {
 	void __iomem *port = (void __iomem *)ap->ioaddr.cmd_addr;
@@ -538,6 +563,7 @@ static void sil24_clear_pm(struct ata_po
 static int sil24_init_port(struct ata_port *ap)
 {
 	void __iomem *port = (void __iomem *)ap->ioaddr.cmd_addr;
+	struct sil24_port_priv *pp = ap->private_data;
 	u32 tmp;
 
 	writel(PORT_CS_INIT, port + PORT_CTRL_STAT);
@@ -549,8 +575,12 @@ static int sil24_init_port(struct ata_po
 	/* clear PM error status */
 	sil24_clear_pm(ap);
 
-	if ((tmp & (PORT_CS_INIT | PORT_CS_RDY)) != PORT_CS_RDY)
+	if ((tmp & (PORT_CS_INIT | PORT_CS_RDY)) != PORT_CS_RDY) {
+		pp->do_port_rst = 1;
+		ap->link.eh_context.i.action |= ATA_EH_HARDRESET;
 		return -EIO;
+	}
+
 	return 0;
 }
 
@@ -659,10 +689,34 @@ static int sil24_hardreset(struct ata_li
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
+		sil24_config_controller(port, ap->flags);
+		sil24_config_pm(ap, ap->nr_pm_links);
+
+		pp->do_port_rst = 0;
+		did_port_rst = 1;
+	}
+
 	/* sil24 does the right thing(tm) without any protection */
 	ata_set_sata_spd(link);
 
@@ -700,6 +754,11 @@ static int sil24_hardreset(struct ata_li
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
@@ -910,6 +969,7 @@ static void sil24_thaw(struct ata_port *
 static void sil24_error_intr(struct ata_port *ap)
 {
 	void __iomem *port = (void __iomem *)ap->ioaddr.cmd_addr;
+	struct sil24_port_priv *pp = ap->private_data;
 	int freeze = 0;
 	struct ata_link *link;
 	struct ata_eh_info *ehi;
@@ -974,6 +1034,7 @@ static void sil24_error_intr(struct ata_
 			ehi->err_mask |= AC_ERR_OTHER;
 			ehi->action |= ATA_EH_HARDRESET;
 			ata_ehi_push_desc(ehi, ", PM DMA CS errata");
+			pp->do_port_rst = 1;
 			freeze = 1;
 		}
 
@@ -1116,17 +1177,17 @@ static irqreturn_t sil24_interrupt(int i
 
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
 	ata_pm_do_eh(ap, ata_std_prereset, sil24_softreset, sil24_hardreset,
 		     ata_std_postreset, ata_pm_std_prereset, sil24_pm_softreset,
 		     sil24_pm_hardreset, ata_pm_std_postreset);
+
+	pp->do_port_rst = 0;
 }
 
 static void sil24_post_internal_cmd(struct ata_queued_cmd *qc)
@@ -1137,8 +1198,10 @@ static void sil24_post_internal_cmd(stru
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
@@ -1334,25 +1397,8 @@ static int sil24_init_one(struct pci_dev
 				           "failed to clear port RST\n");
 		}
 
-		/* Configure IRQ WoC */
-		if (probe_ent->host_flags & SIL24_FLAG_PCIX_IRQ_WOC)
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
-		writel(PORT_CS_PM_EN | PORT_CS_PM_RESUME, port + PORT_CTRL_CLR);
+		/* configure controller */
+		sil24_config_controller(port, probe_ent->host_flags);
 	}
 
 	/* Turn on interrupts */
-- 
1.2.4


