Return-Path: <SRS0=c38X=4U=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D3F7C3F2DA
	for <linux-ide@archiver.kernel.org>; Tue,  3 Mar 2020 09:39:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 529B0205ED
	for <linux-ide@archiver.kernel.org>; Tue,  3 Mar 2020 09:39:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728274AbgCCJjr (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 3 Mar 2020 04:39:47 -0500
Received: from mx2.suse.de ([195.135.220.15]:47676 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728214AbgCCJjq (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Tue, 3 Mar 2020 04:39:46 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id B570BB201;
        Tue,  3 Mar 2020 09:39:41 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Tejun Heo <tj@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 13/40] sata_mv: kill 'port' argument in mv_dump_all_regs()
Date:   Tue,  3 Mar 2020 10:37:46 +0100
Message-Id: <20200303093813.18523-14-hare@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200303093813.18523-1-hare@suse.de>
References: <20200303093813.18523-1-hare@suse.de>
Sender: linux-ide-owner@vger.kernel.org
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
index 1eb93976af8d..940b7f2e9105 100644
--- a/drivers/ata/sata_mv.c
+++ b/drivers/ata/sata_mv.c
@@ -1283,23 +1283,13 @@ static void mv_dump_pci_cfg(struct pci_dev *pdev, unsigned bytes)
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
@@ -1314,13 +1304,13 @@ static void mv_dump_all_regs(void __iomem *mmio_base, int port,
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
@@ -2969,7 +2959,7 @@ static int mv_pci_error(struct ata_host *host, void __iomem *mmio)
 	if (pci_dump) {
 		dev_printk(KERN_DEBUG, host->dev, "%s: All regs @ PCI error\n",
 			   __func__);
-		mv_dump_all_regs(mmio, -1, to_pci_dev(host->dev));
+		mv_dump_all_regs(mmio, to_pci_dev(host->dev));
 	}
 	writelfl(0, mmio + hpriv->irq_cause_offset);
 
-- 
2.16.4

