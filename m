Return-Path: <SRS0=c38X=4U=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A46FEC3F2DC
	for <linux-ide@archiver.kernel.org>; Tue,  3 Mar 2020 09:39:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AB97205ED
	for <linux-ide@archiver.kernel.org>; Tue,  3 Mar 2020 09:39:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728214AbgCCJjs (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 3 Mar 2020 04:39:48 -0500
Received: from mx2.suse.de ([195.135.220.15]:47728 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728225AbgCCJjq (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Tue, 3 Mar 2020 04:39:46 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id AFBD9B1FE;
        Tue,  3 Mar 2020 09:39:41 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Tejun Heo <tj@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 12/40] sata_mv: replace DPRINTK with 'pci_dump' module parameter
Date:   Tue,  3 Mar 2020 10:37:45 +0100
Message-Id: <20200303093813.18523-13-hare@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200303093813.18523-1-hare@suse.de>
References: <20200303093813.18523-1-hare@suse.de>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Implement module parameter 'pci_dump' and move the DPRINTK calls
over to dev_printk().

Signed-off-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/ata/sata_mv.c | 88 ++++++++++++++++++++++++++++-----------------------
 1 file changed, 49 insertions(+), 39 deletions(-)

diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
index d7228f8e9297..1eb93976af8d 100644
--- a/drivers/ata/sata_mv.c
+++ b/drivers/ata/sata_mv.c
@@ -83,6 +83,10 @@ module_param(irq_coalescing_usecs, int, S_IRUGO);
 MODULE_PARM_DESC(irq_coalescing_usecs,
 		 "IRQ coalescing time threshold in usecs");
 
+static int pci_dump;
+module_param(pci_dump, int, S_IRUGO);
+MODULE_PARM_DESC(pci_dump, "Enable dumping of PCI registers on error");
+
 enum {
 	/* BAR's are enumerated in terms of pci_resource_start() terms */
 	MV_PRIMARY_BAR		= 0,	/* offset 0x10: memory space */
@@ -1245,42 +1249,43 @@ static int mv_stop_edma(struct ata_port *ap)
 	return err;
 }
 
-#ifdef ATA_DEBUG
-static void mv_dump_mem(void __iomem *start, unsigned bytes)
+static void mv_dump_mem(struct device *dev, void __iomem *start, unsigned bytes)
 {
-	int b, w;
+	int b, w, o;
+	unsigned char linebuf[38];
+
 	for (b = 0; b < bytes; ) {
-		DPRINTK("%p: ", start + b);
-		for (w = 0; b < bytes && w < 4; w++) {
-			printk("%08x ", readl(start + b));
+		for (w = 0, o = 0; b < bytes && w < 4; w++) {
+			o += snprintf(linebuf + o, 38 - o,
+				      "%08x ", readl(start + b));
 			b += sizeof(u32);
 		}
-		printk("\n");
+		dev_printk(KERN_DEBUG, dev, "%s: %p: %s\n",
+			   __func__, start + b, linebuf);
 	}
 }
-#endif
-#if defined(ATA_DEBUG) || defined(CONFIG_PCI)
+
 static void mv_dump_pci_cfg(struct pci_dev *pdev, unsigned bytes)
 {
-#ifdef ATA_DEBUG
-	int b, w;
+	int b, w, o;
 	u32 dw;
+	unsigned char linebuf[38];
+
 	for (b = 0; b < bytes; ) {
-		DPRINTK("%02x: ", b);
-		for (w = 0; b < bytes && w < 4; w++) {
+		for (w = 0, o = 0; b < bytes && w < 4; w++) {
 			(void) pci_read_config_dword(pdev, b, &dw);
-			printk("%08x ", dw);
+			o += snprintf(linebuf + o, 38 - o,
+				      "%08x ", dw);
 			b += sizeof(u32);
 		}
-		printk("\n");
+		dev_printk(KERN_DEBUG, &pdev->dev, "%s: %02x: %s\n",
+			   __func__, b, linebuf);
 	}
-#endif
 }
-#endif
+
 static void mv_dump_all_regs(void __iomem *mmio_base, int port,
 			     struct pci_dev *pdev)
 {
-#ifdef ATA_DEBUG
 	void __iomem *hc_base = mv_hc_base(mmio_base,
 					   port >> MV_PORT_HC_SHIFT);
 	void __iomem *port_base;
@@ -1295,31 +1300,34 @@ static void mv_dump_all_regs(void __iomem *mmio_base, int port,
 		start_port = port;
 		num_ports = num_hcs = 1;
 	}
-	DPRINTK("All registers for port(s) %u-%u:\n", start_port,
-		num_ports > 1 ? num_ports - 1 : start_port);
+	dev_printk(KERN_DEBUG, &pdev->dev,
+		   "%s: All registers for port(s) %u-%u:\n", __func__,
+		   start_port, num_ports > 1 ? num_ports - 1 : start_port);
 
-	if (NULL != pdev) {
-		DPRINTK("PCI config space regs:\n");
-		mv_dump_pci_cfg(pdev, 0x68);
-	}
-	DPRINTK("PCI regs:\n");
-	mv_dump_mem(mmio_base+0xc00, 0x3c);
-	mv_dump_mem(mmio_base+0xd00, 0x34);
-	mv_dump_mem(mmio_base+0xf00, 0x4);
-	mv_dump_mem(mmio_base+0x1d00, 0x6c);
+	dev_printk(KERN_DEBUG, &pdev->dev,
+		   "%s: PCI config space regs:\n", __func__);
+	mv_dump_pci_cfg(pdev, 0x68);
+
+	dev_printk(KERN_DEBUG, &pdev->dev, "%s: PCI regs:\n", __func__);
+	mv_dump_mem(&pdev->dev, mmio_base+0xc00, 0x3c);
+	mv_dump_mem(&pdev->dev, mmio_base+0xd00, 0x34);
+	mv_dump_mem(&pdev->dev, mmio_base+0xf00, 0x4);
+	mv_dump_mem(&pdev->dev, mmio_base+0x1d00, 0x6c);
 	for (hc = start_hc; hc < start_hc + num_hcs; hc++) {
 		hc_base = mv_hc_base(mmio_base, hc);
-		DPRINTK("HC regs (HC %i):\n", hc);
-		mv_dump_mem(hc_base, 0x1c);
+		dev_printk(KERN_DEBUG, &pdev->dev, "%s: HC regs (HC %i):\n",
+			   __func__, hc);
+		mv_dump_mem(&pdev->dev, hc_base, 0x1c);
 	}
 	for (p = start_port; p < start_port + num_ports; p++) {
 		port_base = mv_port_base(mmio_base, p);
-		DPRINTK("EDMA regs (port %i):\n", p);
-		mv_dump_mem(port_base, 0x54);
-		DPRINTK("SATA regs (port %i):\n", p);
-		mv_dump_mem(port_base+0x300, 0x60);
+		dev_printk(KERN_DEBUG, &pdev->dev, "%s: EDMA regs (port %i):\n",
+			   __func__, p);
+		mv_dump_mem(&pdev->dev, port_base, 0x54);
+		dev_printk(KERN_DEBUG, &pdev->dev, "%s: SATA regs (port %i):\n",
+			   __func__, p);
+		mv_dump_mem(&pdev->dev, port_base+0x300, 0x60);
 	}
-#endif
 }
 
 static unsigned int mv_scr_offset(unsigned int sc_reg_in)
@@ -2958,9 +2966,11 @@ static int mv_pci_error(struct ata_host *host, void __iomem *mmio)
 
 	dev_err(host->dev, "PCI ERROR; PCI IRQ cause=0x%08x\n", err_cause);
 
-	DPRINTK("All regs @ PCI error\n");
-	mv_dump_all_regs(mmio, -1, to_pci_dev(host->dev));
-
+	if (pci_dump) {
+		dev_printk(KERN_DEBUG, host->dev, "%s: All regs @ PCI error\n",
+			   __func__);
+		mv_dump_all_regs(mmio, -1, to_pci_dev(host->dev));
+	}
 	writelfl(0, mmio + hpriv->irq_cause_offset);
 
 	for (i = 0; i < host->n_ports; i++) {
-- 
2.16.4

