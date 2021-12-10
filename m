Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 628B4C43219
	for <linux-ide@archiver.kernel.org>; Fri, 10 Dec 2021 07:29:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237611AbhLJHdG (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 10 Dec 2021 02:33:06 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:34980 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237558AbhLJHcz (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 10 Dec 2021 02:32:55 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id B1AA221117;
        Fri, 10 Dec 2021 07:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1639121358; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nQ/i/lSfSuUN+NBIwnNpb8mcXW/+zJQ82gaAeWv5UDU=;
        b=nfvFEiAEPJYVF2ZrxGBSPbnE2de1TzvwMbMzfFEdFitnsxq6iOYz0d6o56e9KdaHS6mLPv
        OJHbnhRN25XaD1v9u5qGLutCyDQNSXzepCth4AwYsb2zXqyBdkCNREU8Xpwjyj9SjVaKfL
        1jNQ7blkbUjqj7n+KPw305pgPS26McI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1639121358;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nQ/i/lSfSuUN+NBIwnNpb8mcXW/+zJQ82gaAeWv5UDU=;
        b=4gzuVS3JDOzc+qWtIcJvsi4/3WT/we9yHKxAEa2zftKYRRvqkhtoc56uNm1KidCF31eHY4
        dsIoGxqBvna6GcCg==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id 9D213A3BA5;
        Fri, 10 Dec 2021 07:29:18 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
        id 9AB745192041; Fri, 10 Dec 2021 08:29:18 +0100 (CET)
From:   Hannes Reinecke <hare@suse.de>
To:     Damien LeMoal <damien.lemoal@wdc.com>
Cc:     linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 16/68] sata_mv: replace DPRINTK with dynamic debugging
Date:   Fri, 10 Dec 2021 08:28:13 +0100
Message-Id: <20211210072905.15666-17-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20211210072905.15666-1-hare@suse.de>
References: <20211210072905.15666-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Move the DPRINTK calls over to dynamic debugging.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/ata/sata_mv.c | 74 +++++++++++++++++++++----------------------
 1 file changed, 37 insertions(+), 37 deletions(-)

diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
index c5b3d45a7c39..40a92c89e6d7 100644
--- a/drivers/ata/sata_mv.c
+++ b/drivers/ata/sata_mv.c
@@ -1248,42 +1248,43 @@ static int mv_stop_edma(struct ata_port *ap)
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
+		dev_dbg(dev, "%s: %p: %s\n",
+			__func__, start + b, linebuf);
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
+		dev_dbg(&pdev->dev, "%s: %02x: %s\n",
+			__func__, b, linebuf);
 	}
-#endif
 }
-#endif
+
 static void mv_dump_all_regs(void __iomem *mmio_base,
 			     struct pci_dev *pdev)
 {
-#ifdef ATA_DEBUG
 	void __iomem *hc_base;
 	void __iomem *port_base;
 	int start_port, num_ports, p, start_hc, num_hcs, hc;
@@ -1291,31 +1292,30 @@ static void mv_dump_all_regs(void __iomem *mmio_base,
 	start_hc = start_port = 0;
 	num_ports = 8;		/* should be benign for 4 port devs */
 	num_hcs = 2;
-	DPRINTK("All registers for port(s) %u-%u:\n", start_port,
-		num_ports > 1 ? num_ports - 1 : start_port);
+	dev_dbg(&pdev->dev,
+		"%s: All registers for port(s) %u-%u:\n", __func__,
+		start_port, num_ports > 1 ? num_ports - 1 : start_port);
 
-	if (NULL != pdev) {
-		DPRINTK("PCI config space regs:\n");
-		mv_dump_pci_cfg(pdev, 0x68);
-	}
-	DPRINTK("PCI regs:\n");
-	mv_dump_mem(mmio_base+0xc00, 0x3c);
-	mv_dump_mem(mmio_base+0xd00, 0x34);
-	mv_dump_mem(mmio_base+0xf00, 0x4);
-	mv_dump_mem(mmio_base+0x1d00, 0x6c);
+	dev_dbg(&pdev->dev, "%s: PCI config space regs:\n", __func__);
+	mv_dump_pci_cfg(pdev, 0x68);
+
+	dev_dbg(&pdev->dev, "%s: PCI regs:\n", __func__);
+	mv_dump_mem(&pdev->dev, mmio_base+0xc00, 0x3c);
+	mv_dump_mem(&pdev->dev, mmio_base+0xd00, 0x34);
+	mv_dump_mem(&pdev->dev, mmio_base+0xf00, 0x4);
+	mv_dump_mem(&pdev->dev, mmio_base+0x1d00, 0x6c);
 	for (hc = start_hc; hc < start_hc + num_hcs; hc++) {
 		hc_base = mv_hc_base(mmio_base, hc);
-		DPRINTK("HC regs (HC %i):\n", hc);
-		mv_dump_mem(hc_base, 0x1c);
+		dev_dbg(&pdev->dev, "%s: HC regs (HC %i):\n", __func__, hc);
+		mv_dump_mem(&pdev->dev, hc_base, 0x1c);
 	}
 	for (p = start_port; p < start_port + num_ports; p++) {
 		port_base = mv_port_base(mmio_base, p);
-		DPRINTK("EDMA regs (port %i):\n", p);
-		mv_dump_mem(port_base, 0x54);
-		DPRINTK("SATA regs (port %i):\n", p);
-		mv_dump_mem(port_base+0x300, 0x60);
+		dev_dbg(&pdev->dev, "%s: EDMA regs (port %i):\n", __func__, p);
+		mv_dump_mem(&pdev->dev, port_base, 0x54);
+		dev_dbg(&pdev->dev, "%s: SATA regs (port %i):\n", __func__, p);
+		mv_dump_mem(&pdev->dev, port_base+0x300, 0x60);
 	}
-#endif
 }
 
 static unsigned int mv_scr_offset(unsigned int sc_reg_in)
@@ -2955,7 +2955,7 @@ static int mv_pci_error(struct ata_host *host, void __iomem *mmio)
 
 	dev_err(host->dev, "PCI ERROR; PCI IRQ cause=0x%08x\n", err_cause);
 
-	DPRINTK("All regs @ PCI error\n");
+	dev_dbg(host->dev, "%s: All regs @ PCI error\n", __func__);
 	mv_dump_all_regs(mmio, to_pci_dev(host->dev));
 
 	writelfl(0, mmio + hpriv->irq_cause_offset);
-- 
2.29.2

