From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 08/21] sata_sil24: separate out sil24_exec_polled_cmd()
Date: Mon, 16 Jul 2007 14:29:39 +0900
Message-ID: <11845637792724-git-send-email-htejun@gmail.com>
References: <11845637782629-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.236]:11877 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751972AbXGPF3u (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 16 Jul 2007 01:29:50 -0400
Received: by nz-out-0506.google.com with SMTP id s18so736627nze
        for <linux-ide@vger.kernel.org>; Sun, 15 Jul 2007 22:29:50 -0700 (PDT)
In-Reply-To: <11845637782629-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, Forrest Zhao <forrest.zhao@gmail.com>
Cc: Tejun Heo <htejun@gmail.com>

Separate out sil24_exec_polled_cmd() from sil24_softreset().  This
will be used to implement sil24_pmp_read/write().

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/sata_sil24.c |   76 ++++++++++++++++++++++++++++++++++------------
 1 files changed, 56 insertions(+), 20 deletions(-)

diff --git a/drivers/ata/sata_sil24.c b/drivers/ata/sata_sil24.c
index 5f8afa9..e6fe4c4 100644
--- a/drivers/ata/sata_sil24.c
+++ b/drivers/ata/sata_sil24.c
@@ -531,16 +531,60 @@ static int sil24_init_port(struct ata_port *ap)
 	return 0;
 }
 
-static int sil24_softreset(struct ata_port *ap, unsigned int *class,
-			   unsigned long deadline)
+static int sil24_exec_polled_cmd(struct ata_port *ap, int pmp,
+				 const struct ata_taskfile *tf,
+				 int is_cmd, u32 ctrl,
+				 unsigned long timeout_msec)
 {
 	void __iomem *port = ap->ioaddr.cmd_addr;
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
+static int sil24_softreset(struct ata_port *ap, unsigned int *class,
+			   unsigned long deadline)
+{
+	unsigned long timeout_msec = 0;
 	struct ata_taskfile tf;
-	u32 mask, irq_stat;
 	const char *reason;
+	int rc;
 
 	DPRINTK("ENTER\n");
 
@@ -557,24 +601,16 @@ static int sil24_softreset(struct ata_port *ap, unsigned int *class,
 	}
 
 	/* do SRST */
-	prb->ctrl = cpu_to_le16(PRB_CTRL_SRST);
-	prb->fis[1] = 0; /* no PMP yet */
+	if (time_after(deadline, jiffies))
+		timeout_msec = jiffies_to_msecs(deadline - jiffies);
 
-	writel((u32)paddr, port + PORT_CMD_ACTIVATE);
-	writel((u64)paddr >> 32, port + PORT_CMD_ACTIVATE + 4);
-
-	mask = (PORT_IRQ_COMPLETE | PORT_IRQ_ERROR) << PORT_IRQ_RAW_SHIFT;
-	irq_stat = ata_wait_register(port + PORT_IRQ_STAT, mask, 0x0,
-				     100, jiffies_to_msecs(deadline - jiffies));
-
-	writel(irq_stat, port + PORT_IRQ_STAT); /* clear IRQs */
-	irq_stat >>= PORT_IRQ_RAW_SHIFT;
-
-	if (!(irq_stat & PORT_IRQ_COMPLETE)) {
-		if (irq_stat & PORT_IRQ_ERROR)
-			reason = "SRST command error";
-		else
-			reason = "timeout";
+	ata_tf_init(ap->device, &tf);	/* doesn't really matter */
+	rc = sil24_exec_polled_cmd(ap, 0, &tf, 0, PRB_CTRL_SRST, timeout_msec);
+	if (rc == -EBUSY) {
+		reason = "timeout";
+		goto err;
+	} else if (rc) {
+		reason = "SRST command error";
 		goto err;
 	}
 
-- 
1.5.0.3


