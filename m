From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 11/15] ide: use ide_remove_port_from_hwgroup in init_irq()
Date: Fri, 04 Jan 2008 22:25:48 +0100
Message-ID: <20080104212548.6978.61443.sendpatchset@localhost.localdomain>
References: <20080104212424.6978.93646.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.171]:37216 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755434AbYADVON (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 4 Jan 2008 16:14:13 -0500
Received: by ug-out-1314.google.com with SMTP id z38so2833655ugc.16
        for <linux-ide@vger.kernel.org>; Fri, 04 Jan 2008 13:14:12 -0800 (PST)
In-Reply-To: <20080104212424.6978.93646.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

There should be no functionality changes caused by this patch.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
-77 bytes
 drivers/ide/ide-probe.c |   18 +-----------------
 drivers/ide/ide.c       |    2 +-
 include/linux/ide.h     |    1 +
 3 files changed, 3 insertions(+), 18 deletions(-)

Index: b/drivers/ide/ide-probe.c
===================================================================
--- a/drivers/ide/ide-probe.c
+++ b/drivers/ide/ide-probe.c
@@ -1074,23 +1074,7 @@ static int init_irq (ide_hwif_t *hwif)
 	mutex_unlock(&ide_cfg_mtx);
 	return 0;
 out_unlink:
-	spin_lock_irq(&ide_lock);
-	if (hwif->next == hwif) {
-		BUG_ON(hwgroup->hwif != hwif);
-		kfree(hwgroup);
-	} else {
-		ide_hwif_t *g;
-		g = hwgroup->hwif;
-		while (g->next != hwif)
-			g = g->next;
-		g->next = hwif->next;
-		if (hwgroup->hwif == hwif) {
-			BUG_ON(hwgroup->drive);
-			hwgroup->hwif = g;
-		}
-		BUG_ON(hwgroup->hwif == hwif);
-	}
-	spin_unlock_irq(&ide_lock);
+	ide_remove_port_from_hwgroup(hwif);
 out_up:
 	mutex_unlock(&ide_cfg_mtx);
 	return 1;
Index: b/drivers/ide/ide.c
===================================================================
--- a/drivers/ide/ide.c
+++ b/drivers/ide/ide.c
@@ -461,7 +461,7 @@ static void ide_hwif_restore(ide_hwif_t 
 	hwif->hwif_data			= tmp_hwif->hwif_data;
 }
 
-static void ide_remove_port_from_hwgroup(ide_hwif_t *hwif)
+void ide_remove_port_from_hwgroup(ide_hwif_t *hwif)
 {
 	ide_hwgroup_t *hwgroup = hwif->hwgroup;
 
Index: b/include/linux/ide.h
===================================================================
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -1194,6 +1194,7 @@ static inline void ide_acpi_init(ide_hwi
 static inline void ide_acpi_set_state(ide_hwif_t *hwif, int on) {}
 #endif
 
+void ide_remove_port_from_hwgroup(ide_hwif_t *);
 extern int ide_hwif_request_regions(ide_hwif_t *hwif);
 extern void ide_hwif_release_regions(ide_hwif_t* hwif);
 extern void ide_unregister (unsigned int index);
