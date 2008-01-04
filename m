From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 15/15] ide: move hwif_register() call out of ide_probe_port()
Date: Fri, 04 Jan 2008 22:26:21 +0100
Message-ID: <20080104212621.6978.60873.sendpatchset@localhost.localdomain>
References: <20080104212424.6978.93646.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.171]:37216 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754169AbYADVOo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 4 Jan 2008 16:14:44 -0500
Received: by ug-out-1314.google.com with SMTP id z38so2833655ugc.16
        for <linux-ide@vger.kernel.org>; Fri, 04 Jan 2008 13:14:44 -0800 (PST)
In-Reply-To: <20080104212424.6978.93646.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

* Add BUG_ON(hwif->present) at the start of ide_probe_port().

* Move hwif_register() call (along with setting hwif->present) from
  ide_probe_port() to ide_device_add_all().

  As a result the port will be registered with the device tree _after_:
  - probing both devices (if both are present)
  - port reset (if hwif->reset is set)
  - restoring local IRQs state and re-enabling port IRQ

While at it:

* Rename hwif_register() to ide_register_port().

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
+17 bytes
 drivers/ide/ide-probe.c |   27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

Index: b/drivers/ide/ide-probe.c
===================================================================
--- a/drivers/ide/ide-probe.c
+++ b/drivers/ide/ide-probe.c
@@ -613,7 +613,7 @@ static void hwif_release_dev (struct dev
 	complete(&hwif->gendev_rel_comp);
 }
 
-static void hwif_register (ide_hwif_t *hwif)
+static void ide_register_port(ide_hwif_t *hwif)
 {
 	int ret;
 
@@ -742,7 +742,9 @@ static int ide_probe_port(ide_hwif_t *hw
 {
 	unsigned long flags;
 	unsigned int irqd;
-	int unit;
+	int unit, rc = -ENODEV;
+
+	BUG_ON(hwif->present);
 
 	if (hwif->noprobe)
 		return -EACCES;
@@ -767,14 +769,8 @@ static int ide_probe_port(ide_hwif_t *hw
 		ide_drive_t *drive = &hwif->drives[unit];
 		drive->dn = (hwif->channel ? 2 : 0) + unit;
 		(void) probe_for_drive(drive);
-		if (drive->present && !hwif->present) {
-			hwif->present = 1;
-			if (hwif->chipset != ide_4drives ||
-			    !hwif->mate || 
-			    !hwif->mate->present) {
-				hwif_register(hwif);
-			}
-		}
+		if (drive->present)
+			rc = 0;
 	}
 	if (hwif->io_ports[IDE_CONTROL_OFFSET] && hwif->reset) {
 		printk(KERN_WARNING "%s: reset\n", hwif->name);
@@ -791,10 +787,7 @@ static int ide_probe_port(ide_hwif_t *hw
 	if (irqd)
 		enable_irq(irqd);
 
-	if (!hwif->present)
-		return -ENODEV;
-
-	return 0;
+	return rc;
 }
 
 static void ide_port_tune_devices(ide_hwif_t *hwif)
@@ -1319,6 +1312,12 @@ int ide_device_add_all(u8 *idx)
 			continue;
 		}
 
+		hwif->present = 1;
+
+		if (hwif->chipset != ide_4drives || !hwif->mate ||
+		    !hwif->mate->present)
+			ide_register_port(hwif);
+
 		ide_port_tune_devices(hwif);
 	}
 
