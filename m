From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 14/15] ide: factor out code for tuning devices from ide_probe_port()
Date: Fri, 04 Jan 2008 22:26:13 +0100
Message-ID: <20080104212613.6978.76964.sendpatchset@localhost.localdomain>
References: <20080104212424.6978.93646.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.171]:37216 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755522AbYADVOh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 4 Jan 2008 16:14:37 -0500
Received: by ug-out-1314.google.com with SMTP id z38so2833655ugc.16
        for <linux-ide@vger.kernel.org>; Fri, 04 Jan 2008 13:14:36 -0800 (PST)
In-Reply-To: <20080104212424.6978.93646.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

* Factor out code for tuning devices from ide_probe_port()
  to ide_port_tune_devices().

* Move ide_port_tune_devices() call from ide_probe_port()
  to ide_device_add_all().

There should be no functionality changes caused by this patch.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-probe.c |   15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

Index: b/drivers/ide/ide-probe.c
===================================================================
--- a/drivers/ide/ide-probe.c
+++ b/drivers/ide/ide-probe.c
@@ -794,6 +794,13 @@ static int ide_probe_port(ide_hwif_t *hw
 	if (!hwif->present)
 		return -ENODEV;
 
+	return 0;
+}
+
+static void ide_port_tune_devices(ide_hwif_t *hwif)
+{
+	int unit;
+
 	for (unit = 0; unit < MAX_DRIVES; unit++) {
 		ide_drive_t *drive = &hwif->drives[unit];
 
@@ -827,8 +834,6 @@ static int ide_probe_port(ide_hwif_t *hw
 		else
 			drive->no_io_32bit = drive->id->dword_io ? 1 : 0;
 	}
-
-	return 0;
 }
 
 #if MAX_HWIFS > 1
@@ -1309,8 +1314,12 @@ int ide_device_add_all(u8 *idx)
 			continue;
 		}
 
-		if (ide_probe_port(hwif) < 0)
+		if (ide_probe_port(hwif) < 0) {
 			ide_hwif_release_regions(hwif);
+			continue;
+		}
+
+		ide_port_tune_devices(hwif);
 	}
 
 	for (i = 0; i < MAX_HWIFS; i++) {
