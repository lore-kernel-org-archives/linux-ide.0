From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 15/22] ide: factor out adding drive to hwgroup from init_irq()
Date: Thu, 17 Jan 2008 00:27:50 +0100
Message-ID: <20080116232750.9166.93985.sendpatchset@localhost.localdomain>
References: <20080116232556.9166.13457.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.175]:10937 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753259AbYAPXPK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 16 Jan 2008 18:15:10 -0500
Received: by ug-out-1314.google.com with SMTP id z38so275986ugc.16
        for <linux-ide@vger.kernel.org>; Wed, 16 Jan 2008 15:15:09 -0800 (PST)
In-Reply-To: <20080116232556.9166.13457.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

Factor out adding drive to hwgroup from init_irq() to
ide_add_drive_to_hwgroup().

There should be no functionality changes caused by this patch.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-probe.c |   29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

Index: b/drivers/ide/ide-probe.c
===================================================================
--- a/drivers/ide/ide-probe.c
+++ b/drivers/ide/ide-probe.c
@@ -911,6 +911,23 @@ static int ide_init_queue(ide_drive_t *d
 	return 0;
 }
 
+static void ide_add_drive_to_hwgroup(ide_drive_t *drive)
+{
+	ide_hwgroup_t *hwgroup = drive->hwif->hwgroup;
+
+	spin_lock_irq(&ide_lock);
+	if (!hwgroup->drive) {
+		/* first drive for hwgroup. */
+		drive->next = drive;
+		hwgroup->drive = drive;
+		hwgroup->hwif = HWIF(hwgroup->drive);
+	} else {
+		drive->next = hwgroup->drive->next;
+		hwgroup->drive->next = drive;
+	}
+	spin_unlock_irq(&ide_lock);
+}
+
 /*
  * This routine sets up the irq for an ide interface, and creates a new
  * hwgroup for the irq/hwif if none was previously assigned.
@@ -1033,17 +1050,7 @@ static int init_irq (ide_hwif_t *hwif)
 			printk(KERN_ERR "ide: failed to init %s\n",drive->name);
 			continue;
 		}
-		spin_lock_irq(&ide_lock);
-		if (!hwgroup->drive) {
-			/* first drive for hwgroup. */
-			drive->next = drive;
-			hwgroup->drive = drive;
-			hwgroup->hwif = HWIF(hwgroup->drive);
-		} else {
-			drive->next = hwgroup->drive->next;
-			hwgroup->drive->next = drive;
-		}
-		spin_unlock_irq(&ide_lock);
+		ide_add_drive_to_hwgroup(drive);
 	}
 
 #if !defined(__mc68000__) && !defined(CONFIG_APUS)
