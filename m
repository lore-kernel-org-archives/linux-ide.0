From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 3/8] sata_sil24: implement loss of completion interrupt on PCI-X errta fix
Date: Wed, 5 Apr 2006 22:29:02 +0900
Message-ID: <11442437421505-git-send-email-htejun@gmail.com>
References: <11442437413563-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.230]:10522 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751124AbWDEN3L (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 5 Apr 2006 09:29:11 -0400
Received: by wproxy.gmail.com with SMTP id 68so150136wra
        for <linux-ide@vger.kernel.org>; Wed, 05 Apr 2006 06:29:10 -0700 (PDT)
In-Reply-To: <11442437413563-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, Carlos.Pardo@siliconimage.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

SiI3124 might lose completion interrupt if completion interrupt occurs
shortly after SLOT_STAT register is read for the previous completion
interrupt if it is operating in PCI-X mode.

This currently doesn't trigger as libata never queues more than one
command, but it will with NCQ changes.  This patch implements the
workaround - turning on WoC and explicitly clearing interrupt.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/sata_sil24.c |   29 +++++++++++++++++++++++++++--
 1 files changed, 27 insertions(+), 2 deletions(-)

1ecf730e0c67d7a94881897cd955b4623b0b9b58
diff --git a/drivers/scsi/sata_sil24.c b/drivers/scsi/sata_sil24.c
index 3d301b2..86233ac 100644
--- a/drivers/scsi/sata_sil24.c
+++ b/drivers/scsi/sata_sil24.c
@@ -207,6 +207,9 @@ enum {
 	BID_SIL3132		= 1,
 	BID_SIL3131		= 2,
 
+	/* private host flags */
+	SIL24_FLAG_PCIX_IRQ_WOC	= (1 << 24), /* IRQ loss errata on PCI-X */
+
 	IRQ_STAT_4PORTS		= 0xf,
 };
 
@@ -336,7 +339,8 @@ static struct ata_port_info sil24_port_i
 		.sht		= &sil24_sht,
 		.host_flags	= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
 				  ATA_FLAG_MMIO | ATA_FLAG_PIO_DMA |
-				  SIL24_NPORTS2FLAG(4),
+				  SIL24_NPORTS2FLAG(4) |
+				  SIL24_FLAG_PCIX_IRQ_WOC,
 		.pio_mask	= 0x1f,			/* pio0-4 */
 		.mwdma_mask	= 0x07,			/* mwdma0-2 */
 		.udma_mask	= 0x3f,			/* udma0-5 */
@@ -725,6 +729,10 @@ static inline void sil24_host_intr(struc
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
@@ -856,6 +864,7 @@ static int sil24_init_one(struct pci_dev
 	void __iomem *host_base = NULL;
 	void __iomem *port_base = NULL;
 	int i, rc;
+	u32 tmp;
 
 	if (!printed_version++)
 		dev_printk(KERN_DEBUG, &pdev->dev, "version " DRV_VERSION "\n");
@@ -929,13 +938,23 @@ static int sil24_init_one(struct pci_dev
 	/* GPIO off */
 	writel(0, host_base + HOST_FLASH_CMD);
 
+	/* Apply workaround for completion IRQ loss on PCI-X errata */
+	if (probe_ent->host_flags & SIL24_FLAG_PCIX_IRQ_WOC) {
+		tmp = readl(host_base + HOST_CTRL);
+		if (tmp & 0xe0000)
+			dev_printk(KERN_INFO, &pdev->dev,
+				   "Applying completion IRQ loss on PCI-X "
+				   "errata fix\n");
+		else
+			probe_ent->host_flags &= ~SIL24_FLAG_PCIX_IRQ_WOC;
+	}
+
 	/* Mask interrupts during initialization */
 	writel(0, host_base + HOST_CTRL);
 
 	for (i = 0; i < probe_ent->n_ports; i++) {
 		void __iomem *port = port_base + i * PORT_REGS_SIZE;
 		unsigned long portu = (unsigned long)port;
-		u32 tmp;
 		int cnt;
 
 		probe_ent->port[i].cmd_addr = portu + PORT_PRB;
@@ -946,6 +965,12 @@ static int sil24_init_one(struct pci_dev
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


