Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3464CC433FE
	for <linux-ide@archiver.kernel.org>; Wed,  8 Dec 2021 16:33:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234379AbhLHQgd (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 8 Dec 2021 11:36:33 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:40554 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234530AbhLHQgc (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 8 Dec 2021 11:36:32 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 2EC2D21891;
        Wed,  8 Dec 2021 16:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1638981180; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zLxVsA4hEpYmSJ5tzANcB+tN2xO9lh5TNStsTGJVX1A=;
        b=nbiRw+2LqlwVDbNDvvZ6kmHBmT+4Pbh+qlD4fNG8VY/hpmyOcqMiV/MeCEl2PkuMuUibGi
        xFULsQvJYW522WuFkHHCRCz1FETKvIG+XSS+20dVXXiFHEa2D69fsm13XYgbPLOFF+bQfD
        h7NCATbKslA/bmnWYC8ObXSYJm75Y4U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1638981180;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zLxVsA4hEpYmSJ5tzANcB+tN2xO9lh5TNStsTGJVX1A=;
        b=zpDuZ+82r91pIFiQ0jCWMftsm6WlbnIJ+GaU3xe+8VWnZs0unLDsb29HCm7JpD0krOa1X8
        eGvy+xqQzeArugCA==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id 27E5BA3B94;
        Wed,  8 Dec 2021 16:33:00 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
        id F17905191F69; Wed,  8 Dec 2021 17:32:59 +0100 (CET)
From:   Hannes Reinecke <hare@suse.de>
To:     Damien LeMoal <damien.lemoal@wdc.com>
Cc:     linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 06/73] sata_mv: kill 'port' argument in mv_dump_all_regs()
Date:   Wed,  8 Dec 2021 17:31:48 +0100
Message-Id: <20211208163255.114660-7-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20211208163255.114660-1-hare@suse.de>
References: <20211208163255.114660-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Always '-1', so drop it and simplify the function.

Signed-off-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/ata/sata_mv.c | 24 +++++++-----------------
 1 file changed, 7 insertions(+), 17 deletions(-)

diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
index f0257685495f..e86eddf83704 100644
--- a/drivers/ata/sata_mv.c
+++ b/drivers/ata/sata_mv.c
@@ -1286,23 +1286,13 @@ static void mv_dump_pci_cfg(struct pci_dev *pdev, unsigned bytes)
 	}
 }
 
-static void mv_dump_all_regs(void __iomem *mmio_base, int port,
-			     struct pci_dev *pdev)
+static void mv_dump_all_regs(void __iomem *mmio_base, struct pci_dev *pdev)
 {
-	void __iomem *hc_base = mv_hc_base(mmio_base,
-					   port >> MV_PORT_HC_SHIFT);
-	void __iomem *port_base;
 	int start_port, num_ports, p, start_hc, num_hcs, hc;
 
-	if (0 > port) {
-		start_hc = start_port = 0;
-		num_ports = 8;		/* shld be benign for 4 port devs */
-		num_hcs = 2;
-	} else {
-		start_hc = port >> MV_PORT_HC_SHIFT;
-		start_port = port;
-		num_ports = num_hcs = 1;
-	}
+	start_hc = start_port = 0;
+	num_ports = 8;		/* shld be benign for 4 port devs */
+	num_hcs = 2;
 	dev_printk(KERN_DEBUG, &pdev->dev,
 		   "%s: All registers for port(s) %u-%u:\n", __func__,
 		   start_port, num_ports > 1 ? num_ports - 1 : start_port);
@@ -1317,13 +1307,13 @@ static void mv_dump_all_regs(void __iomem *mmio_base, int port,
 	mv_dump_mem(&pdev->dev, mmio_base+0xf00, 0x4);
 	mv_dump_mem(&pdev->dev, mmio_base+0x1d00, 0x6c);
 	for (hc = start_hc; hc < start_hc + num_hcs; hc++) {
-		hc_base = mv_hc_base(mmio_base, hc);
+		void __iomem *hc_base = mv_hc_base(mmio_base, hc);
 		dev_printk(KERN_DEBUG, &pdev->dev, "%s: HC regs (HC %i):\n",
 			   __func__, hc);
 		mv_dump_mem(&pdev->dev, hc_base, 0x1c);
 	}
 	for (p = start_port; p < start_port + num_ports; p++) {
-		port_base = mv_port_base(mmio_base, p);
+		void __iomem *port_base = mv_port_base(mmio_base, p);
 		dev_printk(KERN_DEBUG, &pdev->dev, "%s: EDMA regs (port %i):\n",
 			   __func__, p);
 		mv_dump_mem(&pdev->dev, port_base, 0x54);
@@ -2973,7 +2963,7 @@ static int mv_pci_error(struct ata_host *host, void __iomem *mmio)
 	if (pci_dump) {
 		dev_printk(KERN_DEBUG, host->dev, "%s: All regs @ PCI error\n",
 			   __func__);
-		mv_dump_all_regs(mmio, -1, to_pci_dev(host->dev));
+		mv_dump_all_regs(mmio, to_pci_dev(host->dev));
 	}
 	writelfl(0, mmio + hpriv->irq_cause_offset);
 
-- 
2.29.2

