From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 2/6] ide: remove chipset type fixup from ide_host_register()
Date: Wed, 12 Nov 2008 22:15:15 +0100
Message-ID: <200811122215.15671.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.186]:18390 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755308AbYKLVcz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 12 Nov 2008 16:32:55 -0500
Received: by ti-out-0910.google.com with SMTP id b6so351755tic.23
        for <linux-ide@vger.kernel.org>; Wed, 12 Nov 2008 13:32:55 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Atsushi Nemoto <anemo@mba.ocn.ne.jp>, Sergei Shtylyov <sshtylyov@ru.mvista.com>

* Set chipset type explicitly in tx4938ide and tx4939ide host drivers
  (all other host drivers were updated already).

* Remove no longer used chipset type fixup from ide_host_register().

CC: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-probe.c |    3 ---
 drivers/ide/tx4938ide.c |    1 +
 drivers/ide/tx4939ide.c |    1 +
 3 files changed, 2 insertions(+), 3 deletions(-)

Index: b/drivers/ide/ide-probe.c
===================================================================
--- a/drivers/ide/ide-probe.c
+++ b/drivers/ide/ide-probe.c
@@ -1654,9 +1654,6 @@ int ide_host_register(struct ide_host *h
 		if (hwif == NULL)
 			continue;
 
-		if (hwif->chipset == ide_unknown)
-			hwif->chipset = ide_generic;
-
 		if (hwif->present)
 			hwif_register_devices(hwif);
 	}
Index: b/drivers/ide/tx4938ide.c
===================================================================
--- a/drivers/ide/tx4938ide.c
+++ b/drivers/ide/tx4938ide.c
@@ -226,6 +226,7 @@ static const struct ide_port_info tx4938
 #endif
 	.host_flags		= IDE_HFLAG_MMIO | IDE_HFLAG_NO_DMA,
 	.pio_mask		= ATA_PIO5,
+	.chipset		= ide_generic,
 };
 
 static int __init tx4938ide_probe(struct platform_device *pdev)
Index: b/drivers/ide/tx4939ide.c
===================================================================
--- a/drivers/ide/tx4939ide.c
+++ b/drivers/ide/tx4939ide.c
@@ -644,6 +644,7 @@ static const struct ide_port_info tx4939
 	.pio_mask		= ATA_PIO4,
 	.mwdma_mask		= ATA_MWDMA2,
 	.udma_mask		= ATA_UDMA5,
+	.chipset		= ide_generic,
 };
 
 static int __init tx4939ide_probe(struct platform_device *pdev)
