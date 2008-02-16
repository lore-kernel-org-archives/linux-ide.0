From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 04/12] cmd640: cleanup setup_device_ptrs()
Date: Sat, 16 Feb 2008 17:39:18 +0100
Message-ID: <20080216163918.10174.58524.sendpatchset@localhost.localdomain>
References: <20080216163856.10174.72546.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.157]:14693 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758588AbYBPQYp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 16 Feb 2008 11:24:45 -0500
Received: by fg-out-1718.google.com with SMTP id e21so842257fga.17
        for <linux-ide@vger.kernel.org>; Sat, 16 Feb 2008 08:24:44 -0800 (PST)
In-Reply-To: <20080216163856.10174.72546.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

This loop is no longer needed.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/pci/cmd640.c |   14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

Index: b/drivers/ide/pci/cmd640.c
===================================================================
--- a/drivers/ide/pci/cmd640.c
+++ b/drivers/ide/pci/cmd640.c
@@ -409,19 +409,9 @@ static void __init check_prefetch (unsig
  */
 static void __init setup_device_ptrs (void)
 {
-	unsigned int i;
+	cmd_hwif0 = &ide_hwifs[0];
+	cmd_hwif1 = &ide_hwifs[1];
 
-	cmd_hwif0 = &ide_hwifs[0]; /* default, if not found below */
-	cmd_hwif1 = &ide_hwifs[1]; /* default, if not found below */
-	for (i = 0; i < MAX_HWIFS; i++) {
-		ide_hwif_t *hwif = &ide_hwifs[i];
-		if (hwif->chipset == ide_unknown) {
-			if (hwif->io_ports[IDE_DATA_OFFSET] == 0x1f0)
-				cmd_hwif0 = hwif;
-			else if (hwif->io_ports[IDE_DATA_OFFSET] == 0x170)
-				cmd_hwif1 = hwif;
-		}
-	}
 	cmd_drives[0] = &cmd_hwif0->drives[0];
 	cmd_drives[1] = &cmd_hwif0->drives[1];
 	cmd_drives[2] = &cmd_hwif1->drives[0];
