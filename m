From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 21/22] ide: move hwif->present check out from ide_proc_register_port()
Date: Thu, 17 Jan 2008 00:28:32 +0100
Message-ID: <20080116232832.9166.29628.sendpatchset@localhost.localdomain>
References: <20080116232556.9166.13457.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.175]:10937 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755970AbYAPXPw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 16 Jan 2008 18:15:52 -0500
Received: by ug-out-1314.google.com with SMTP id z38so275986ugc.16
        for <linux-ide@vger.kernel.org>; Wed, 16 Jan 2008 15:15:51 -0800 (PST)
In-Reply-To: <20080116232556.9166.13457.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

Move hwif->present check out from ide_proc_register_port() to
ide_device_add_all().

There should be no functionality changes caused by this patch.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-probe.c |    9 +++++++--
 drivers/ide/ide-proc.c  |    3 ---
 2 files changed, 7 insertions(+), 5 deletions(-)

Index: b/drivers/ide/ide-probe.c
===================================================================
--- a/drivers/ide/ide-probe.c
+++ b/drivers/ide/ide-probe.c
@@ -1448,8 +1448,13 @@ int ide_device_add_all(u8 idx[MAX_HWIFS]
 	}
 
 	for (i = 0; i < MAX_HWIFS; i++) {
-		if (idx[i] != 0xff)
-			ide_proc_register_port(&ide_hwifs[idx[i]]);
+		if (idx[i] == 0xff)
+			continue;
+
+		hwif = &ide_hwifs[idx[i]];
+
+		if (hwif->present)
+			ide_proc_register_port(hwif);
 	}
 
 	return rc;
Index: b/drivers/ide/ide-proc.c
===================================================================
--- a/drivers/ide/ide-proc.c
+++ b/drivers/ide/ide-proc.c
@@ -793,9 +793,6 @@ static ide_proc_entry_t hwif_entries[] =
 
 void ide_proc_register_port(ide_hwif_t *hwif)
 {
-	if (!hwif->present)
-		return;
-
 	if (!hwif->proc) {
 		hwif->proc = proc_mkdir(hwif->name, proc_ide_root);
 
