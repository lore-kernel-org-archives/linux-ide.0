Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAC47C4332F
	for <linux-ide@archiver.kernel.org>; Wed,  8 Dec 2021 16:33:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236998AbhLHQgj (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 8 Dec 2021 11:36:39 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:40654 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236990AbhLHQge (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 8 Dec 2021 11:36:34 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 39942218B5;
        Wed,  8 Dec 2021 16:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1638981180; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GgIDfCZ5/t7fef6SIjnvToW5EfLSo/30xJcueJUvdJc=;
        b=1hS3bFJOFJ090cYtydIBIYFjjm0707iOztHsiymWNIRktaVGq/VXO1v+zfMybjHr+0O6e8
        3OWyVZMy01OHsbAIEBCiHQruWIahTUKlCTrUEfKgFznbox6s/+Qk0VS/yWzYwgQiKNln9C
        J2jDmSKnuZUjJRQG1j0Qa2Sf+BizZvs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1638981180;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GgIDfCZ5/t7fef6SIjnvToW5EfLSo/30xJcueJUvdJc=;
        b=bsB6MN/KYxPReQw0FJNGUPntRhmUE7Hb77OHtowKhHBAQGOKswMuk/G+e+GbhIJDVmeYdK
        KsyikBjAOLByaFCg==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id 2CFAFA3B99;
        Wed,  8 Dec 2021 16:33:00 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
        id EB2AF5191F67; Wed,  8 Dec 2021 17:32:59 +0100 (CET)
From:   Hannes Reinecke <hare@suse.de>
To:     Damien LeMoal <damien.lemoal@wdc.com>
Cc:     linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 05/73] sata_mv: replace DPRINTK with 'pci_dump' module parameter
Date:   Wed,  8 Dec 2021 17:31:47 +0100
Message-Id: <20211208163255.114660-6-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20211208163255.114660-1-hare@suse.de>
References: <20211208163255.114660-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Implement module parameter 'pci_dump' and move the DPRINTK calls
over to dev_printk().

Signed-off-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/ata/sata_mv.c | 88 ++++++++++++++++++++++++-------------------
 1 file changed, 49 insertions(+), 39 deletions(-)

diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
index cae4c1eab102..f0257685495f 100644
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
@@ -1248,42 +1252,43 @@ static int mv_stop_edma(struct ata_port *ap)
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
@@ -1298,31 +1303,34 @@ static void mv_dump_all_regs(void __iomem *mmio_base, int port,
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
@@ -2962,9 +2970,11 @@ static int mv_pci_error(struct ata_host *host, void __iomem *mmio)
 
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
2.29.2

