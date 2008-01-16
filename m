From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 19/22] ide-acpi: remove dead code from do_drive_get_GTF()
Date: Thu, 17 Jan 2008 00:28:18 +0100
Message-ID: <20080116232818.9166.98150.sendpatchset@localhost.localdomain>
References: <20080116232556.9166.13457.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.174]:10411 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755095AbYAPXPi (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 16 Jan 2008 18:15:38 -0500
Received: by ug-out-1314.google.com with SMTP id z38so275985ugc.16
        for <linux-ide@vger.kernel.org>; Wed, 16 Jan 2008 15:15:37 -0800 (PST)
In-Reply-To: <20080116232556.9166.13457.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

These pointers are always setup in ide_acpi_init().

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-acpi.c |   10 ----------
 1 file changed, 10 deletions(-)

Index: b/drivers/ide/ide-acpi.c
===================================================================
--- a/drivers/ide/ide-acpi.c
+++ b/drivers/ide/ide-acpi.c
@@ -280,16 +280,6 @@ static int do_drive_get_GTF(ide_drive_t 
 
 	port = hwif->channel ? drive->dn - 2: drive->dn;
 
-	if (!drive->acpidata) {
-		if (port == 0) {
-			drive->acpidata = &hwif->acpidata->master;
-			hwif->acpidata->master.drive = drive;
-		} else {
-			drive->acpidata = &hwif->acpidata->slave;
-			hwif->acpidata->slave.drive = drive;
-		}
-	}
-
 	DEBPRINT("ENTER: %s at %s, port#: %d, hard_port#: %d\n",
 		 hwif->name, dev->bus_id, port, hwif->channel);
 
