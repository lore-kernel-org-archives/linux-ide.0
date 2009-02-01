From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 08/15] ide: add IDE_HFLAG_4DRIVES host flag
Date: Sun, 01 Feb 2009 18:50:05 +0100
Message-ID: <20090201175005.19144.90449.sendpatchset@localhost.localdomain>
References: <20090201174909.19144.67767.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.189]:6833 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755575AbZBARtO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 1 Feb 2009 12:49:14 -0500
In-Reply-To: <20090201174909.19144.67767.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] ide: add IDE_HFLAG_4DRIVES host flag

Add IDE_HFLAG_4DRIVES host flag and use it instead of ide_4drives
chipset type in ide_init_port().

There should be no functional changes caused by this patch.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-4drives.c |    3 ++-
 drivers/ide/ide-probe.c   |    4 ++--
 include/linux/ide.h       |    2 ++
 3 files changed, 6 insertions(+), 3 deletions(-)

Index: b/drivers/ide/ide-4drives.c
===================================================================
--- a/drivers/ide/ide-4drives.c
+++ b/drivers/ide/ide-4drives.c
@@ -23,7 +23,8 @@ static const struct ide_port_ops ide_4dr
 
 static const struct ide_port_info ide_4drives_port_info = {
 	.port_ops		= &ide_4drives_port_ops,
-	.host_flags		= IDE_HFLAG_SERIALIZE | IDE_HFLAG_NO_DMA,
+	.host_flags		= IDE_HFLAG_SERIALIZE | IDE_HFLAG_NO_DMA |
+				  IDE_HFLAG_4DRIVES,
 };
 
 static int __init ide_4drives_init(void)
Index: b/drivers/ide/ide-probe.c
===================================================================
--- a/drivers/ide/ide-probe.c
+++ b/drivers/ide/ide-probe.c
@@ -1352,8 +1352,8 @@ int ide_host_register(struct ide_host *h
 		if (ide_probe_port(hwif) == 0)
 			hwif->present = 1;
 
-		if (hwif->chipset != ide_4drives || !hwif->mate ||
-		    !hwif->mate->present)
+		if ((hwif->host_flags & IDE_HFLAG_4DRIVES) == 0 ||
+		    hwif->mate == NULL || hwif->mate->present == 0)
 			ide_register_port(hwif);
 
 		if (hwif->present)
Index: b/include/linux/ide.h
===================================================================
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -1324,6 +1324,8 @@ enum {
 	IDE_HFLAG_SERIALIZE		= (1 << 20),
 	/* host is DTC2278 */
 	IDE_HFLAG_DTC2278		= (1 << 21),
+	/* 4 devices on a single set of I/O ports */
+	IDE_HFLAG_4DRIVES		= (1 << 22),
 	/* host is TRM290 */
 	IDE_HFLAG_TRM290		= (1 << 23),
 	/* use 32-bit I/O ops */
