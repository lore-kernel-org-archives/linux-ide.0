From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 9/12] sata_sil24: separate out sil24_exec_polled_cmd()
Date: Mon, 16 Oct 2006 08:47:18 +0900
Message-ID: <11609560382894-git-send-email-htejun@gmail.com>
References: <11609560371552-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.189]:14479 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932230AbWJOXrc (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 15 Oct 2006 19:47:32 -0400
Received: by nf-out-0910.google.com with SMTP id c2so636805nfe
        for <linux-ide@vger.kernel.org>; Sun, 15 Oct 2006 16:47:31 -0700 (PDT)
In-Reply-To: <11609560371552-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Separate out sil24_exec_polled_cmd() from sil24_softreset().  This
will be used to implement sil24_pmp_read/write().

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/sata_sil24.c |   75 +++++++++++++++++++++++++++++++++-------------
 1 files changed, 54 insertions(+), 21 deletions(-)

diff --git a/drivers/ata/sata_sil24.c b/drivers/ata/sata_sil24.c
index b7c0322..29e53d6 100644
--- a/drivers/ata/sata_sil24.c
+++ b/drivers/ata/sata_sil24.c
@@ -546,16 +546,59 @@ static int sil24_init_port(struct ata_po
 	return 0;
 }
 
-static int sil24_softreset(struct ata_link *link, unsigned int *class)
+static int sil24_exec_polled_cmd(struct ata_port *ap, u32 ctrl,
+				 const struct ata_taskfile *tf,
+				 int pmp, int is_cmd,
+				 unsigned long timeout_msec)
 {
-	struct ata_port *ap = link->ap;
 	void __iomem *port = (void __iomem *)ap->ioaddr.cmd_addr;
 	struct sil24_port_priv *pp = ap->private_data;
 	struct sil24_prb *prb = &pp->cmd_block[0].ata.prb;
 	dma_addr_t paddr = pp->cmd_block_dma;
+	u32 irq_enabled, irq_mask, irq_stat;
+	int rc;
+
+	prb->ctrl = cpu_to_le16(ctrl);
+	ata_tf_to_fis(tf, pmp, is_cmd, prb->fis);
+
+	/* temporarily plug completion and error interrupts */
+	irq_enabled = readl(port + PORT_IRQ_ENABLE_SET);
+	writel(PORT_IRQ_COMPLETE | PORT_IRQ_ERROR, port + PORT_IRQ_ENABLE_CLR);
+
+	writel((u32)paddr, port + PORT_CMD_ACTIVATE);
+	writel((u64)paddr >> 32, port + PORT_CMD_ACTIVATE + 4);
+
+	irq_mask = (PORT_IRQ_COMPLETE | PORT_IRQ_ERROR) << PORT_IRQ_RAW_SHIFT;
+	irq_stat = ata_wait_register(port + PORT_IRQ_STAT, irq_mask, 0x0,
+				     10, timeout_msec);
+
+	writel(irq_mask, port + PORT_IRQ_STAT); /* clear IRQs */
+	irq_stat >>= PORT_IRQ_RAW_SHIFT;
+
+	if (irq_stat & PORT_IRQ_COMPLETE)
+		rc = 0;
+	else {
+		/* force port into known state */
+		sil24_init_port(ap);
+
+		if (irq_stat & PORT_IRQ_ERROR)
+			rc = -EIO;
+		else
+			rc = -EBUSY;
+	}
+
+	/* restore IRQ enabled */
+	writel(irq_enabled, port + PORT_IRQ_ENABLE_SET);
+
+	return rc;
+}
+
+static int sil24_softreset(struct ata_link *link, unsigned int *class)
+{
+	struct ata_port *ap = link->ap;
 	struct ata_taskfile tf;
-	u32 mask, irq_stat;
 	const char *reason;
+	int rc;
 
 	DPRINTK("ENTER\n");
 
@@ -572,24 +615,14 @@ static int sil24_softreset(struct ata_li
 	}
 
 	/* do SRST */
-	prb->ctrl = cpu_to_le16(PRB_CTRL_SRST);
-	prb->fis[1] = 0; /* no PMP yet */
-
-	writel((u32)paddr, port + PORT_CMD_ACTIVATE);
-	writel((u64)paddr >> 32, port + PORT_CMD_ACTIVATE + 4);
-
-	mask = (PORT_IRQ_COMPLETE | PORT_IRQ_ERROR) << PORT_IRQ_RAW_SHIFT;
-	irq_stat = ata_wait_register(port + PORT_IRQ_STAT, mask, 0x0,
-				     100, ATA_TMOUT_BOOT / HZ * 1000);
-
-	writel(irq_stat, port + PORT_IRQ_STAT); /* clear IRQs */
-	irq_stat >>= PORT_IRQ_RAW_SHIFT;
-
-	if (!(irq_stat & PORT_IRQ_COMPLETE)) {
-		if (irq_stat & PORT_IRQ_ERROR)
-			reason = "SRST command error";
-		else
-			reason = "timeout";
+	ata_tf_init(link->device, &tf);	/* doesn't really matter */
+	rc = sil24_exec_polled_cmd(ap, PRB_CTRL_SRST, &tf, 0, 0,
+				   ATA_TMOUT_BOOT / HZ * 1000);
+	if (rc == -EBUSY) {
+		reason = "timeout";
+		goto err;
+	} else if (rc) {
+		reason = "SRST command error";
 		goto err;
 	}
 
-- 
1.4.2.3


