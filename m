From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: [PATCH] remove no longer needed AMIGA/MAC hacks from IDE resource handling code
Date: Tue, 16 Mar 2004 23:20:19 +0100
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <200403162320.19774.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:56518 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S261745AbUCPWNY
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 16 Mar 2004 17:13:24 -0500
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-ide@vger.kernel.org


Hi Geert,

Now when you've fixed macide.c what do you think about this patch?

Regards,
Bartlomiej


[IDE] remove no longer needed AMIGA/MAC hacks from resource handling code

Nowadays buddha.c, gayle.c and macide.c handle resources themselves.

 linux-2.6.5-rc1-root/drivers/ide/ide.c |   22 ++--------------------
 1 files changed, 2 insertions(+), 20 deletions(-)

diff -puN drivers/ide/ide.c~ide_resource_cleanup drivers/ide/ide.c
--- linux-2.6.5-rc1/drivers/ide/ide.c~ide_resource_cleanup	2004-03-16 22:48:38.304238712 +0100
+++ linux-2.6.5-rc1-root/drivers/ide/ide.c	2004-03-16 23:03:50.592549808 +0100
@@ -518,11 +518,6 @@ int ide_hwif_request_regions(ide_hwif_t 
 	addr = hwif->io_ports[IDE_CONTROL_OFFSET];
 	if (addr && !hwif_request_region(hwif, addr, 1))
 		goto control_region_busy;
-#if defined(CONFIG_AMIGA) || defined(CONFIG_MAC)
-	addr = hwif->io_ports[IDE_IRQ_OFFSET];
-	if (addr && !hwif_request_region(hwif, addr, 1))
-		goto irq_region_busy;
-#endif /* (CONFIG_AMIGA) || (CONFIG_MAC) */
 	hwif->straight8 = 0;
 	addr = hwif->io_ports[IDE_DATA_OFFSET];
 	if ((addr | 7) == hwif->io_ports[IDE_STATUS_OFFSET]) {
@@ -542,12 +537,6 @@ int ide_hwif_request_regions(ide_hwif_t 
 	return 0;
 
 data_region_busy:
-#if defined(CONFIG_AMIGA) || defined(CONFIG_MAC)
-	addr = hwif->io_ports[IDE_IRQ_OFFSET];
-	if (addr)
-		hwif_release_region(addr, 1);
-irq_region_busy:
-#endif /* (CONFIG_AMIGA) || (CONFIG_MAC) */
 	addr = hwif->io_ports[IDE_CONTROL_OFFSET];
 	if (addr)
 		hwif_release_region(addr, 1);
@@ -577,20 +566,13 @@ void ide_hwif_release_regions(ide_hwif_t
 		return;
 	if (hwif->io_ports[IDE_CONTROL_OFFSET])
 		hwif_release_region(hwif->io_ports[IDE_CONTROL_OFFSET], 1);
-#if defined(CONFIG_AMIGA) || defined(CONFIG_MAC)
-	if (hwif->io_ports[IDE_IRQ_OFFSET])
-		hwif_release_region(hwif->io_ports[IDE_IRQ_OFFSET], 1);
-#endif /* (CONFIG_AMIGA) || (CONFIG_MAC) */
-
 	if (hwif->straight8) {
 		hwif_release_region(hwif->io_ports[IDE_DATA_OFFSET], 8);
 		return;
 	}
-	for (i = IDE_DATA_OFFSET; i <= IDE_STATUS_OFFSET; i++) {
-		if (hwif->io_ports[i]) {
+	for (i = IDE_DATA_OFFSET; i <= IDE_STATUS_OFFSET; i++)
+		if (hwif->io_ports[i])
 			hwif_release_region(hwif->io_ports[i], 1);
-		}
-	}
 }
 
 EXPORT_SYMBOL(ide_hwif_release_regions);

_

