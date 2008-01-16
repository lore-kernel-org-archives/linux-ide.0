From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 10/22] ide: skip not present devices in init_gendisk()
Date: Thu, 17 Jan 2008 00:27:16 +0100
Message-ID: <20080116232716.9166.83558.sendpatchset@localhost.localdomain>
References: <20080116232556.9166.13457.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.175]:10937 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753174AbYAPXOg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 16 Jan 2008 18:14:36 -0500
Received: by ug-out-1314.google.com with SMTP id z38so275986ugc.16
        for <linux-ide@vger.kernel.org>; Wed, 16 Jan 2008 15:14:35 -0800 (PST)
In-Reply-To: <20080116232556.9166.13457.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

No need to initialize drive->gendev and waste memory on IDE settings
for not present devices.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-probe.c |    4 ++++
 1 file changed, 4 insertions(+)

Index: b/drivers/ide/ide-probe.c
===================================================================
--- a/drivers/ide/ide-probe.c
+++ b/drivers/ide/ide-probe.c
@@ -1194,6 +1194,10 @@ static void init_gendisk (ide_hwif_t *hw
 
 	for (unit = 0; unit < MAX_DRIVES; ++unit) {
 		ide_drive_t * drive = &hwif->drives[unit];
+
+		if (!drive->present)
+			continue;
+
 		ide_add_generic_settings(drive);
 		snprintf(drive->gendev.bus_id,BUS_ID_SIZE,"%u.%u",
 			 hwif->index,unit);
