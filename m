From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 5/9] delkin_cb: add warm-plug support
Date: Mon, 02 Jun 2008 22:23:26 +0200
Message-ID: <20080602202326.7265.15042.sendpatchset@localhost.localdomain>
References: <20080602202253.7265.23590.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.187]:17008 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754100AbYFBUV5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 2 Jun 2008 16:21:57 -0400
Received: by mu-out-0910.google.com with SMTP id w8so1229319mue.1
        for <linux-ide@vger.kernel.org>; Mon, 02 Jun 2008 13:21:56 -0700 (PDT)
In-Reply-To: <20080602202253.7265.23590.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

Don't fail the probe if there are no devices attached to the controller.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/pci/delkin_cb.c |    4 ----
 1 file changed, 4 deletions(-)

Index: b/drivers/ide/pci/delkin_cb.c
===================================================================
--- a/drivers/ide/pci/delkin_cb.c
+++ b/drivers/ide/pci/delkin_cb.c
@@ -99,15 +99,11 @@ delkin_cb_probe (struct pci_dev *dev, co
 
 	ide_device_add(idx, &delkin_cb_port_info);
 
-	if (!hwif->present)
-		goto out_disable;
-
 	pci_set_drvdata(dev, hwif);
 
 	return 0;
 
 out_disable:
-	printk(KERN_ERR "delkin_cb: no IDE devices found\n");
 	pci_release_regions(dev);
 	pci_disable_device(dev);
 	return -ENODEV;
