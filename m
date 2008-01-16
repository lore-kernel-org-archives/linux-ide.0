From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 17/22] ide: move ide_acpi_init() call to ide_device_add_all()
Date: Thu, 17 Jan 2008 00:28:04 +0100
Message-ID: <20080116232804.9166.57061.sendpatchset@localhost.localdomain>
References: <20080116232556.9166.13457.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.175]:10937 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755562AbYAPXPY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 16 Jan 2008 18:15:24 -0500
Received: by ug-out-1314.google.com with SMTP id z38so275986ugc.16
        for <linux-ide@vger.kernel.org>; Wed, 16 Jan 2008 15:15:23 -0800 (PST)
In-Reply-To: <20080116232556.9166.13457.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

There should be no functionality changes caused by this patch.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-probe.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

Index: b/drivers/ide/ide-probe.c
===================================================================
--- a/drivers/ide/ide-probe.c
+++ b/drivers/ide/ide-probe.c
@@ -1260,7 +1260,6 @@ static int hwif_init(ide_hwif_t *hwif)
 done:
 	blk_register_region(MKDEV(hwif->major, 0), MAX_DRIVES << PARTN_BITS,
 			    THIS_MODULE, ata_probe, ata_lock, hwif);
-	ide_acpi_init(hwif);
 	return 1;
 
 out:
@@ -1429,6 +1428,8 @@ int ide_device_add_all(u8 idx[MAX_HWIFS]
 			rc = -1;
 			continue;
 		}
+
+		ide_acpi_init(hwif);
 	}
 
 	for (i = 0; i < MAX_HWIFS; i++) {
