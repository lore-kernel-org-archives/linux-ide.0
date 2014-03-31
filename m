From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH] pata_octeon_cf: fix ata_host_activate() failure handling
Date: Mon, 31 Mar 2014 19:53:56 +0200
Message-ID: <5439252.0G82yiBcdS@amdc1032>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:25408 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753270AbaCaRyS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 31 Mar 2014 13:54:18 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>, linux-ide@vger.kernel.org, linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org

Add missing kfree() call to ata_host_activate() failure path.

Cc: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/ata/pata_octeon_cf.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

Index: b/drivers/ata/pata_octeon_cf.c
===================================================================
--- a/drivers/ata/pata_octeon_cf.c	2014-03-14 16:45:04.320724377 +0100
+++ b/drivers/ata/pata_octeon_cf.c	2014-03-31 18:58:44.367604046 +0200
@@ -1020,13 +1020,16 @@ static int octeon_cf_probe(struct platfo
 
 	ata_port_desc(ap, "cmd %p ctl %p", base, ap->ioaddr.ctl_addr);
 
-
 	dev_info(&pdev->dev, "version " DRV_VERSION" %d bit%s.\n",
 		 is_16bit ? 16 : 8,
 		 cf_port->is_true_ide ? ", True IDE" : "");
 
-	return ata_host_activate(host, irq, irq_handler,
-				 IRQF_SHARED, &octeon_cf_sht);
+	rv = ata_host_activate(host, irq, irq_handler,
+			       IRQF_SHARED, &octeon_cf_sht);
+	if (rv)
+		goto free_cf_port;
+
+	return 0;
 
 free_cf_port:
 	kfree(cf_port);

