From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 4/8] macide: remove drive->capacity64 quirk
Date: Sun, 06 Jan 2008 18:02:48 +0100
Message-ID: <20080106170248.6861.17796.sendpatchset@localhost.localdomain>
References: <20080106170220.6861.4814.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.173]:18967 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759422AbYAFQvB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 6 Jan 2008 11:51:01 -0500
Received: by ug-out-1314.google.com with SMTP id z38so3036620ugc.16
        for <linux-ide@vger.kernel.org>; Sun, 06 Jan 2008 08:51:00 -0800 (PST)
In-Reply-To: <20080106170220.6861.4814.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

Nowadays IDE core always provides drive ID and ide-disk always setups
drive->capacity64 so this quirk is no longer needed.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/legacy/macide.c |   10 ----------
 1 file changed, 10 deletions(-)

Index: b/drivers/ide/legacy/macide.c
===================================================================
--- a/drivers/ide/legacy/macide.c
+++ b/drivers/ide/legacy/macide.c
@@ -123,16 +123,6 @@ static int __init macide_init(void)
 		ide_init_port_data(hwif, index);
 		ide_init_port_hw(hwif, &hw);
 
-		if (macintosh_config->ide_type == MAC_IDE_BABOON &&
-		    macintosh_config->ident == MAC_MODEL_PB190) {
-			/* Fix breakage in ide-disk.c: drive capacity	*/
-			/* is not initialized for drives without a 	*/
-			/* hardware ID, and we can't get that without	*/
-			/* probing the drive which freezes a 190.	*/
-			ide_drive_t *drive = &hwif->drives[0];
-			drive->capacity64 = drive->cyl*drive->head*drive->sect;
-		}
-
 		hwif->mmio = 1;
 
 		ide_device_add(idx);
