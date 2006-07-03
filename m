From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 10/11] sata_sil24: separate out sil24_init_controller()
Date: Mon, 3 Jul 2006 16:07:27 +0900
Message-ID: <1151910447886-git-send-email-htejun@gmail.com>
References: <11519104451998-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.229]:16620 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751140AbWGCHG6 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 3 Jul 2006 03:06:58 -0400
Received: by wr-out-0506.google.com with SMTP id 71so571501wri
        for <linux-ide@vger.kernel.org>; Mon, 03 Jul 2006 00:06:58 -0700 (PDT)
In-Reply-To: <11519104451998-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, lkml@rtr.ca, axboe@suse.de, forrest.zhao@intel.com, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Separate out controller initialization from sil24_init_one() into
sil24_init_controller().  This will be used by resume.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/sata_sil24.c |  107 ++++++++++++++++++++++++++-------------------
 1 files changed, 62 insertions(+), 45 deletions(-)

efd4e54c03974c6c924c3123b612f589b51ab9b1
diff --git a/drivers/scsi/sata_sil24.c b/drivers/scsi/sata_sil24.c
index fa3268d..16565e2 100644
--- a/drivers/scsi/sata_sil24.c
+++ b/drivers/scsi/sata_sil24.c
@@ -988,6 +988,64 @@ static void sil24_host_stop(struct ata_h
 	kfree(hpriv);
 }
 
+static void sil24_init_controller(struct pci_dev *pdev, int n_ports,
+				  unsigned long host_flags,
+				  void __iomem *host_base,
+				  void __iomem *port_base)
+{
+	u32 tmp;
+	int i;
+
+	/* GPIO off */
+	writel(0, host_base + HOST_FLASH_CMD);
+
+	/* clear global reset & mask interrupts during initialization */
+	writel(0, host_base + HOST_CTRL);
+
+	/* init ports */
+	for (i = 0; i < n_ports; i++) {
+		void __iomem *port = port_base + i * PORT_REGS_SIZE;
+
+		/* Initial PHY setting */
+		writel(0x20c, port + PORT_PHY_CFG);
+
+		/* Clear port RST */
+		tmp = readl(port + PORT_CTRL_STAT);
+		if (tmp & PORT_CS_PORT_RST) {
+			writel(PORT_CS_PORT_RST, port + PORT_CTRL_CLR);
+			tmp = ata_wait_register(port + PORT_CTRL_STAT,
+						PORT_CS_PORT_RST,
+						PORT_CS_PORT_RST, 10, 100);
+			if (tmp & PORT_CS_PORT_RST)
+				dev_printk(KERN_ERR, &pdev->dev,
+				           "failed to clear port RST\n");
+		}
+
+		/* Configure IRQ WoC */
+		if (host_flags & SIL24_FLAG_PCIX_IRQ_WOC)
+			writel(PORT_CS_IRQ_WOC, port + PORT_CTRL_STAT);
+		else
+			writel(PORT_CS_IRQ_WOC, port + PORT_CTRL_CLR);
+
+		/* Zero error counters. */
+		writel(0x8000, port + PORT_DECODE_ERR_THRESH);
+		writel(0x8000, port + PORT_CRC_ERR_THRESH);
+		writel(0x8000, port + PORT_HSHK_ERR_THRESH);
+		writel(0x0000, port + PORT_DECODE_ERR_CNT);
+		writel(0x0000, port + PORT_CRC_ERR_CNT);
+		writel(0x0000, port + PORT_HSHK_ERR_CNT);
+
+		/* Always use 64bit activation */
+		writel(PORT_CS_32BIT_ACTV, port + PORT_CTRL_CLR);
+
+		/* Clear port multiplier enable and resume bits */
+		writel(PORT_CS_PM_EN | PORT_CS_RESUME, port + PORT_CTRL_CLR);
+	}
+
+	/* Turn on interrupts */
+	writel(IRQ_STAT_4PORTS, host_base + HOST_CTRL);
+}
+
 static int sil24_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 {
 	static int printed_version = 0;
@@ -1076,9 +1134,6 @@ static int sil24_init_one(struct pci_dev
 		}
 	}
 
-	/* GPIO off */
-	writel(0, host_base + HOST_FLASH_CMD);
-
 	/* Apply workaround for completion IRQ loss on PCI-X errata */
 	if (probe_ent->host_flags & SIL24_FLAG_PCIX_IRQ_WOC) {
 		tmp = readl(host_base + HOST_CTRL);
@@ -1090,56 +1145,18 @@ static int sil24_init_one(struct pci_dev
 			probe_ent->host_flags &= ~SIL24_FLAG_PCIX_IRQ_WOC;
 	}
 
-	/* clear global reset & mask interrupts during initialization */
-	writel(0, host_base + HOST_CTRL);
-
 	for (i = 0; i < probe_ent->n_ports; i++) {
-		void __iomem *port = port_base + i * PORT_REGS_SIZE;
-		unsigned long portu = (unsigned long)port;
+		unsigned long portu =
+			(unsigned long)port_base + i * PORT_REGS_SIZE;
 
 		probe_ent->port[i].cmd_addr = portu;
 		probe_ent->port[i].scr_addr = portu + PORT_SCONTROL;
 
 		ata_std_ports(&probe_ent->port[i]);
-
-		/* Initial PHY setting */
-		writel(0x20c, port + PORT_PHY_CFG);
-
-		/* Clear port RST */
-		tmp = readl(port + PORT_CTRL_STAT);
-		if (tmp & PORT_CS_PORT_RST) {
-			writel(PORT_CS_PORT_RST, port + PORT_CTRL_CLR);
-			tmp = ata_wait_register(port + PORT_CTRL_STAT,
-						PORT_CS_PORT_RST,
-						PORT_CS_PORT_RST, 10, 100);
-			if (tmp & PORT_CS_PORT_RST)
-				dev_printk(KERN_ERR, &pdev->dev,
-				           "failed to clear port RST\n");
-		}
-
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
-		writel(PORT_CS_PM_EN | PORT_CS_RESUME, port + PORT_CTRL_CLR);
 	}
 
-	/* Turn on interrupts */
-	writel(IRQ_STAT_4PORTS, host_base + HOST_CTRL);
+	sil24_init_controller(pdev, probe_ent->n_ports, probe_ent->host_flags,
+			      host_base, port_base);
 
 	pci_set_master(pdev);
 
-- 
1.3.2


