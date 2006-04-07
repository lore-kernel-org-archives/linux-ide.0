From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 5/5] sata_sil24: use ata_wait_register()
Date: Fri, 7 Apr 2006 17:02:47 +0900
Message-ID: <11443969673866-git-send-email-htejun@gmail.com>
References: <11443969673485-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.239]:26579 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932338AbWDGIC5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 7 Apr 2006 04:02:57 -0400
Received: by wproxy.gmail.com with SMTP id 58so293793wri
        for <linux-ide@vger.kernel.org>; Fri, 07 Apr 2006 01:02:56 -0700 (PDT)
In-Reply-To: <11443969673485-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Replace hard-coded waiting loops in sata_sil24 to ata_wait_register().

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/sata_sil24.c |   30 ++++++++++--------------------
 1 files changed, 10 insertions(+), 20 deletions(-)

27b5423eb7db51a79751f46fd73a17df4a39f851
diff --git a/drivers/scsi/sata_sil24.c b/drivers/scsi/sata_sil24.c
index c75c228..edb62c3 100644
--- a/drivers/scsi/sata_sil24.c
+++ b/drivers/scsi/sata_sil24.c
@@ -433,8 +433,7 @@ static int sil24_softreset(struct ata_po
 	struct sil24_port_priv *pp = ap->private_data;
 	struct sil24_prb *prb = &pp->cmd_block[0].ata.prb;
 	dma_addr_t paddr = pp->cmd_block_dma;
-	unsigned long timeout = jiffies + ATA_TMOUT_BOOT;
-	u32 irq_enable, irq_stat;
+	u32 mask, irq_enable, irq_stat;
 	const char *reason;
 
 	DPRINTK("ENTER\n");
@@ -460,16 +459,12 @@ static int sil24_softreset(struct ata_po
 
 	writel((u32)paddr, port + PORT_CMD_ACTIVATE);
 
-	do {
-		irq_stat = readl(port + PORT_IRQ_STAT);
-		writel(irq_stat, port + PORT_IRQ_STAT);		/* clear irq */
+	mask = (PORT_IRQ_COMPLETE | PORT_IRQ_ERROR) << PORT_IRQ_RAW_SHIFT;
+	irq_stat = ata_wait_register(port + PORT_IRQ_STAT, mask, 0x0,
+				     100, ATA_TMOUT_BOOT / HZ * 1000);
 
-		irq_stat >>= PORT_IRQ_RAW_SHIFT;
-		if (irq_stat & (PORT_IRQ_COMPLETE | PORT_IRQ_ERROR))
-			break;
-
-		msleep(100);
-	} while (time_before(jiffies, timeout));
+	writel(irq_stat, port + PORT_IRQ_STAT); /* clear IRQs */
+	irq_stat >>= PORT_IRQ_RAW_SHIFT;
 
 	/* restore IRQs */
 	writel(irq_enable, port + PORT_IRQ_ENABLE_SET);
@@ -938,14 +933,13 @@ static int sil24_init_one(struct pci_dev
 	/* GPIO off */
 	writel(0, host_base + HOST_FLASH_CMD);
 
-	/* Mask interrupts during initialization */
+	/* clear global reset & mask interrupts during initialization */
 	writel(0, host_base + HOST_CTRL);
 
 	for (i = 0; i < probe_ent->n_ports; i++) {
 		void __iomem *port = port_base + i * PORT_REGS_SIZE;
 		unsigned long portu = (unsigned long)port;
 		u32 tmp;
-		int cnt;
 
 		probe_ent->port[i].cmd_addr = portu + PORT_PRB;
 		probe_ent->port[i].scr_addr = portu + PORT_SCONTROL;
@@ -959,13 +953,9 @@ static int sil24_init_one(struct pci_dev
 		tmp = readl(port + PORT_CTRL_STAT);
 		if (tmp & PORT_CS_PORT_RST) {
 			writel(PORT_CS_PORT_RST, port + PORT_CTRL_CLR);
-			readl(port + PORT_CTRL_STAT);	/* sync */
-			for (cnt = 0; cnt < 10; cnt++) {
-				msleep(10);
-				tmp = readl(port + PORT_CTRL_STAT);
-				if (!(tmp & PORT_CS_PORT_RST))
-					break;
-			}
+			tmp = ata_wait_register(port + PORT_CTRL_STAT,
+						PORT_CS_PORT_RST,
+						PORT_CS_PORT_RST, 10, 100);
 			if (tmp & PORT_CS_PORT_RST)
 				dev_printk(KERN_ERR, &pdev->dev,
 				           "failed to clear port RST\n");
-- 
1.2.4


