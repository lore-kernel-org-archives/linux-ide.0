From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 12/18] ide: remove needless CONFIG_BLK_DEV_HD hack from init_hwif()
Date: Fri, 08 Feb 2008 01:45:45 +0100
Message-ID: <20080208004545.17746.25806.sendpatchset@localhost.localdomain>
References: <20080208004421.17746.32557.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.177]:56884 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756276AbYBHAbd (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 7 Feb 2008 19:31:33 -0500
Received: by py-out-1112.google.com with SMTP id u52so5202281pyb.10
        for <linux-ide@vger.kernel.org>; Thu, 07 Feb 2008 16:31:33 -0800 (PST)
In-Reply-To: <20080208004421.17746.32557.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linuxppc-dev@ozlabs.org, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

request_irq() will fail if there is already another IRQ handler
registered and IRQ flags are mismatched.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-probe.c |    7 -------
 1 file changed, 7 deletions(-)

Index: b/drivers/ide/ide-probe.c
===================================================================
--- a/drivers/ide/ide-probe.c
+++ b/drivers/ide/ide-probe.c
@@ -1237,13 +1237,6 @@ static int hwif_init(ide_hwif_t *hwif)
 			return 0;
 		}
 	}
-#ifdef CONFIG_BLK_DEV_HD
-	if (hwif->irq == HD_IRQ && hwif->io_ports[IDE_DATA_OFFSET] != HD_DATA) {
-		printk("%s: CANNOT SHARE IRQ WITH OLD "
-			"HARDDISK DRIVER (hd.c)\n", hwif->name);
-		return 0;
-	}
-#endif /* CONFIG_BLK_DEV_HD */
 
 	if (register_blkdev(hwif->major, hwif->name))
 		return 0;
