From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 06/13] sata_sil24: implement loss of completion interrupt on PCI-X errta fix
Date: Fri, 7 Apr 2006 17:16:53 +0900
Message-ID: <11443978131417-git-send-email-htejun@gmail.com>
References: <114439781363-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.239]:223 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932367AbWDGIRD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 7 Apr 2006 04:17:03 -0400
Received: by wproxy.gmail.com with SMTP id i11so294609wra
        for <linux-ide@vger.kernel.org>; Fri, 07 Apr 2006 01:17:03 -0700 (PDT)
In-Reply-To: <114439781363-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org, Carlos.Pardo@siliconimage.com
Cc: Tejun Heo <htejun@gmail.com>

SiI3124 might lose completion interrupt if completion interrupt occurs
shortly after SLOT_STAT register is read for the previous completion
interrupt if it is operating in PCI-X mode.

This currently doesn't trigger as libata never queues more than one
command, but it will with NCQ changes.  This patch implements the
workaround - turning on WoC and explicitly clearing interrupt.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/sata_sil24.c |   27 +++++++++++++++++++++++++--
 1 files changed, 25 insertions(+), 2 deletions(-)

bfc72a2448cce3be32f0aae2927fb8643152ebcd
diff --git a/drivers/scsi/sata_sil24.c b/drivers/scsi/sata_sil24.c
index dd4db40..5f3a17d 100644
--- a/drivers/scsi/sata_sil24.c
+++ b/drivers/scsi/sata_sil24.c
@@ -221,6 +221,7 @@ enum {
 	/* host flags */
 	SIL24_COMMON_FLAGS	= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
 				  ATA_FLAG_MMIO | ATA_FLAG_PIO_DMA,
+	SIL24_FLAG_PCIX_IRQ_WOC	= (1 << 24), /* IRQ loss errata on PCI-X */
 
 	IRQ_STAT_4PORTS		= 0xf,
 };
@@ -349,7 +350,8 @@ static struct ata_port_info sil24_port_i
 	/* sil_3124 */
 	{
 		.sht		= &sil24_sht,
-		.host_flags	= SIL24_COMMON_FLAGS | SIL24_NPORTS2FLAG(4),
+		.host_flags	= SIL24_COMMON_FLAGS | SIL24_NPORTS2FLAG(4) |
+				  SIL24_FLAG_PCIX_IRQ_WOC,
 		.pio_mask	= 0x1f,			/* pio0-4 */
 		.mwdma_mask	= 0x07,			/* mwdma0-2 */
 		.udma_mask	= 0x3f,			/* udma0-5 */
@@ -738,6 +740,10 @@ static inline void sil24_host_intr(struc
 	slot_stat = readl(port + PORT_SLOT_STAT);
 	if (!(slot_stat & HOST_SSTAT_ATTN)) {
 		struct sil24_port_priv *pp = ap->private_data;
+
+		if (ap->flags & SIL24_FLAG_PCIX_IRQ_WOC)
+			writel(PORT_IRQ_COMPLETE, port + PORT_IRQ_STAT);
+
 		/*
 		 * !HOST_SSAT_ATTN guarantees successful completion,
 		 * so reading back tf registers is unnecessary for
@@ -869,6 +875,7 @@ static int sil24_init_one(struct pci_dev
 	void __iomem *host_base = NULL;
 	void __iomem *port_base = NULL;
 	int i, rc;
+	u32 tmp;
 
 	if (!printed_version++)
 		dev_printk(KERN_DEBUG, &pdev->dev, "version " DRV_VERSION "\n");
@@ -942,13 +949,23 @@ static int sil24_init_one(struct pci_dev
 	/* GPIO off */
 	writel(0, host_base + HOST_FLASH_CMD);
 
+	/* Apply workaround for completion IRQ loss on PCI-X errata */
+	if (probe_ent->host_flags & SIL24_FLAG_PCIX_IRQ_WOC) {
+		tmp = readl(host_base + HOST_CTRL);
+		if (tmp & (HOST_CTRL_TRDY | HOST_CTRL_STOP | HOST_CTRL_DEVSEL))
+			dev_printk(KERN_INFO, &pdev->dev,
+				   "Applying completion IRQ loss on PCI-X "
+				   "errata fix\n");
+		else
+			probe_ent->host_flags &= ~SIL24_FLAG_PCIX_IRQ_WOC;
+	}
+
 	/* clear global reset & mask interrupts during initialization */
 	writel(0, host_base + HOST_CTRL);
 
 	for (i = 0; i < probe_ent->n_ports; i++) {
 		void __iomem *port = port_base + i * PORT_REGS_SIZE;
 		unsigned long portu = (unsigned long)port;
-		u32 tmp;
 
 		probe_ent->port[i].cmd_addr = portu + PORT_PRB;
 		probe_ent->port[i].scr_addr = portu + PORT_SCONTROL;
@@ -958,6 +975,12 @@ static int sil24_init_one(struct pci_dev
 		/* Initial PHY setting */
 		writel(0x20c, port + PORT_PHY_CFG);
 
+		/* Configure IRQ WoC */
+		if (probe_ent->host_flags & SIL24_FLAG_PCIX_IRQ_WOC)
+			writel(PORT_CS_IRQ_WOC, port + PORT_CTRL_STAT);
+		else
+			writel(PORT_CS_IRQ_WOC, port + PORT_CTRL_CLR);
+
 		/* Clear port RST */
 		tmp = readl(port + PORT_CTRL_STAT);
 		if (tmp & PORT_CS_PORT_RST) {
-- 
1.2.4


