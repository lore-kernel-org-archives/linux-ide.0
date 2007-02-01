From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 1/2] pata_platform: fix devres conversion
Date: Thu, 1 Feb 2007 15:05:22 +0900
Message-ID: <20070201060522.GK8606@htj.dyndns.org>
References: <11692764264005-git-send-email-htejun@gmail.com> <45C0827C.2050207@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.228]:3113 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161203AbXBAGF3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 1 Feb 2007 01:05:29 -0500
Received: by wx-out-0506.google.com with SMTP id h31so446327wxd
        for <linux-ide@vger.kernel.org>; Wed, 31 Jan 2007 22:05:29 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <45C0827C.2050207@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: gregkh@suse.de, alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

devres updates for pata_platform were dropped while merging devres
patches due to merge conflict.  This is the updated version.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/pata_platform.c |   31 +++++++------------------------
 1 file changed, 7 insertions(+), 24 deletions(-)

Index: work/drivers/ata/pata_platform.c
===================================================================
--- work.orig/drivers/ata/pata_platform.c
+++ work/drivers/ata/pata_platform.c
@@ -47,23 +47,6 @@ static int pata_platform_set_mode(struct
 	return 0;
 }
 
-static void pata_platform_host_stop(struct ata_host *host)
-{
-	int i;
-
-	/*
-	 * Unmap the bases for MMIO
-	 */
-	for (i = 0; i < host->n_ports; i++) {
-		struct ata_port *ap = host->ports[i];
-
-		if (ap->flags & ATA_FLAG_MMIO) {
-			iounmap((void __iomem *)ap->ioaddr.ctl_addr);
-			iounmap((void __iomem *)ap->ioaddr.cmd_addr);
-		}
-	}
-}
-
 static struct scsi_host_template pata_platform_sht = {
 	.module			= THIS_MODULE,
 	.name			= DRV_NAME,
@@ -106,8 +89,6 @@ static struct ata_port_operations pata_p
 	.irq_clear		= ata_bmdma_irq_clear,
 
 	.port_start		= ata_port_start,
-	.port_stop		= ata_port_stop,
-	.host_stop		= pata_platform_host_stop
 };
 
 static void pata_platform_setup_port(struct ata_ioports *ioaddr,
@@ -209,15 +190,17 @@ static int __devinit pata_platform_probe
 	if (mmio) {
 		ae.port_flags |= ATA_FLAG_MMIO;
 
-		ae.port[0].cmd_addr = (unsigned long)ioremap(io_res->start,
-				io_res->end - io_res->start + 1);
+		ae.port[0].cmd_addr = (unsigned long)
+			devm_ioremap(&pdev->dev, io_res->start,
+				     io_res->end - io_res->start + 1);
 		if (unlikely(!ae.port[0].cmd_addr)) {
 			dev_err(&pdev->dev, "failed to remap IO base\n");
 			return -ENXIO;
 		}
 
-		ae.port[0].ctl_addr = (unsigned long)ioremap(ctl_res->start,
-				ctl_res->end - ctl_res->start + 1);
+		ae.port[0].ctl_addr = (unsigned long)
+			devm_ioremap(&pdev->dev, ctl_res->start,
+				     ctl_res->end - ctl_res->start + 1);
 		if (unlikely(!ae.port[0].ctl_addr)) {
 			dev_err(&pdev->dev, "failed to remap CTL base\n");
 			ret = -ENXIO;
@@ -261,7 +244,7 @@ static int __devexit pata_platform_remov
 	struct device *dev = &pdev->dev;
 	struct ata_host *host = dev_get_drvdata(dev);
 
-	ata_host_remove(host);
+	ata_host_detach(host);
 	dev_set_drvdata(dev, NULL);
 
 	return 0;
