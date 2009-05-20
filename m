From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] ide: skip probe if there are no devices on the port
Date: Wed, 20 May 2009 17:33:06 +0200
Message-ID: <200905201733.06830.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ew0-f176.google.com ([209.85.219.176]:60721 "EHLO
	mail-ew0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753629AbZETPcL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 20 May 2009 11:32:11 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

In ide_probe_port() skip probe if ide_port_wait_ready() returns -ENODEV
and print error message instead of debug one if it returns -EBUSY.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
against Linus' tree

 drivers/ide/ide-probe.c |   10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

Index: b/drivers/ide/ide-probe.c
===================================================================
--- a/drivers/ide/ide-probe.c
+++ b/drivers/ide/ide-probe.c
@@ -702,8 +702,12 @@ static int ide_probe_port(ide_hwif_t *hw
 	if (irqd)
 		disable_irq(hwif->irq);
 
-	if (ide_port_wait_ready(hwif) == -EBUSY)
-		printk(KERN_DEBUG "%s: Wait for ready failed before probe !\n", hwif->name);
+	rc = ide_port_wait_ready(hwif);
+	if (rc == -ENODEV) {
+		printk(KERN_INFO "%s: no devices on the port\n", hwif->name);
+		goto out;
+	} else if (rc == -EBUSY)
+		printk(KERN_ERR "%s: not ready before the probe\n", hwif->name);
 
 	/*
 	 * Second drive should only exist if first drive was found,
@@ -714,7 +718,7 @@ static int ide_probe_port(ide_hwif_t *hw
 		if (drive->dev_flags & IDE_DFLAG_PRESENT)
 			rc = 0;
 	}
-
+out:
 	/*
 	 * Use cached IRQ number. It might be (and is...) changed by probe
 	 * code above
