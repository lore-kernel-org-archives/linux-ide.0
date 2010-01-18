From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 40/64] ide: add SATA cable detection support
Date: Mon, 18 Jan 2010 18:19:44 +0100
Message-ID: <20100118171944.14623.92267.sendpatchset@localhost>
References: <20100118171349.14623.90030.sendpatchset@localhost>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ew0-f214.google.com ([209.85.219.214]:52797 "EHLO
	mail-ew0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755263Ab0ARRUz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 18 Jan 2010 12:20:55 -0500
In-Reply-To: <20100118171349.14623.90030.sendpatchset@localhost>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] ide: add SATA cable detection support

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-iops.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: b/drivers/ide/ide-iops.c
===================================================================
--- a/drivers/ide/ide-iops.c
+++ b/drivers/ide/ide-iops.c
@@ -231,7 +231,7 @@ u8 eighty_ninty_three(ide_drive_t *drive
 	u16 *id = drive->id;
 	int ivb = ide_in_drive_list(id, ivb_list);
 
-	if (hwif->cbl == ATA_CBL_PATA40_SHORT)
+	if (hwif->cbl == ATA_CBL_SATA || hwif->cbl == ATA_CBL_PATA40_SHORT)
 		return 1;
 
 	if (ivb)
