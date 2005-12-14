From: Jeremy Higdon <jeremy@sgi.com>
Subject: [PATCH 2.6.15-rc5 1/1] sgiioc4: check for no hwifs available
Date: Tue, 13 Dec 2005 17:17:28 -0800
Message-ID: <20051214011728.GA184713@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from omx3-ext.sgi.com ([192.48.171.25]:15764 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S1030409AbVLNBRa (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 13 Dec 2005 20:17:30 -0500
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2])
	by omx3.sgi.com (8.12.11/8.12.9/linux-outbound_gateway-1.1) with ESMTP id jBE1grRZ028190
	for <linux-ide@vger.kernel.org>; Tue, 13 Dec 2005 17:42:53 -0800
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: jrn@sgi.com, maule@sgi.com

Add a check to the sgiioc4 driver for the case where all available
ide_hwifs structures are in use.

Signed-off-by: Jeremy Higdon <jeremy@sgi.com>

--- linux-2.6.15-rc5/drivers/ide/pci/sgiioc4.c	2005-12-03 21:10:42.000000000 -0800
+++ linux-2.6.15-rc5-new/drivers/ide/pci/sgiioc4.c	2005-12-13 01:03:52.000000000 -0800
@@ -622,12 +622,18 @@
 	ide_hwif_t *hwif;
 	int h;
 
+	/*
+	 * Find an empty HWIF; if none available, return -ENOMEM.
+	 */
 	for (h = 0; h < MAX_HWIFS; ++h) {
 		hwif = &ide_hwifs[h];
-		/* Find an empty HWIF */
 		if (hwif->chipset == ide_unknown)
 			break;
 	}
+	if (h == MAX_HWIFS) {
+		printk(KERN_ERR "%s: too many IDE interfaces, no room in table\n", d->name);
+		return -ENOMEM;
+	}
 
 	/*  Get the CmdBlk and CtrlBlk Base Registers */
 	base = pci_resource_start(dev, 0) + IOC4_CMD_OFFSET;
