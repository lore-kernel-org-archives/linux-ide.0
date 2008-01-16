From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 16/22] ide: factor out devices setup from init_irq()
Date: Thu, 17 Jan 2008 00:27:57 +0100
Message-ID: <20080116232757.9166.7078.sendpatchset@localhost.localdomain>
References: <20080116232556.9166.13457.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.174]:10411 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755417AbYAPXPR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 16 Jan 2008 18:15:17 -0500
Received: by ug-out-1314.google.com with SMTP id z38so275985ugc.16
        for <linux-ide@vger.kernel.org>; Wed, 16 Jan 2008 15:15:16 -0800 (PST)
In-Reply-To: <20080116232556.9166.13457.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

* Factor out devices setup from init_irq() to ide_port_setup_devices().

While at it:
* Do devices setup after printing port information.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-probe.c |   44 ++++++++++++++++++++++++++++----------------
 1 file changed, 28 insertions(+), 16 deletions(-)

Index: b/drivers/ide/ide-probe.c
===================================================================
--- a/drivers/ide/ide-probe.c
+++ b/drivers/ide/ide-probe.c
@@ -929,6 +929,31 @@ static void ide_add_drive_to_hwgroup(ide
 }
 
 /*
+ * For any present drive:
+ * - allocate the block device queue
+ * - link drive into the hwgroup
+ */
+static void ide_port_setup_devices(ide_hwif_t *hwif)
+{
+	int i;
+
+	for (i = 0; i < MAX_DRIVES; i++) {
+		ide_drive_t *drive = &hwif->drives[i];
+
+		if (!drive->present)
+			continue;
+
+		if (ide_init_queue(drive)) {
+			printk(KERN_ERR "ide: failed to init %s\n",
+					drive->name);
+			continue;
+		}
+
+		ide_add_drive_to_hwgroup(drive);
+	}
+}
+
+/*
  * This routine sets up the irq for an ide interface, and creates a new
  * hwgroup for the irq/hwif if none was previously assigned.
  *
@@ -1037,22 +1062,6 @@ static int init_irq (ide_hwif_t *hwif)
 			hwif->rqsize = 65536;
 	}
 
-	/*
-	 * For any present drive:
-	 * - allocate the block device queue
-	 * - link drive into the hwgroup
-	 */
-	for (index = 0; index < MAX_DRIVES; ++index) {
-		ide_drive_t *drive = &hwif->drives[index];
-		if (!drive->present)
-			continue;
-		if (ide_init_queue(drive)) {
-			printk(KERN_ERR "ide: failed to init %s\n",drive->name);
-			continue;
-		}
-		ide_add_drive_to_hwgroup(drive);
-	}
-
 #if !defined(__mc68000__) && !defined(CONFIG_APUS)
 	printk("%s at 0x%03lx-0x%03lx,0x%03lx on irq %d", hwif->name,
 		hwif->io_ports[IDE_DATA_OFFSET],
@@ -1066,6 +1075,9 @@ static int init_irq (ide_hwif_t *hwif)
 		printk(" (%sed with %s)",
 			hwif->sharing_irq ? "shar" : "serializ", match->name);
 	printk("\n");
+
+	ide_port_setup_devices(hwif);
+
 	mutex_unlock(&ide_cfg_mtx);
 	return 0;
 out_unlink:
