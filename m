From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 9/15] ide: factor out code removing port from hwgroup from ide_unregister()
Date: Fri, 04 Jan 2008 22:25:31 +0100
Message-ID: <20080104212531.6978.41142.sendpatchset@localhost.localdomain>
References: <20080104212424.6978.93646.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.170]:38027 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755383AbYADVNz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 4 Jan 2008 16:13:55 -0500
Received: by ug-out-1314.google.com with SMTP id z38so2833654ugc.16
        for <linux-ide@vger.kernel.org>; Fri, 04 Jan 2008 13:13:54 -0800 (PST)
In-Reply-To: <20080104212424.6978.93646.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide.c |   65 +++++++++++++++++++++++++++++-------------------------
 1 file changed, 36 insertions(+), 29 deletions(-)

Index: b/drivers/ide/ide.c
===================================================================
--- a/drivers/ide/ide.c
+++ b/drivers/ide/ide.c
@@ -461,6 +461,41 @@ static void ide_hwif_restore(ide_hwif_t 
 	hwif->hwif_data			= tmp_hwif->hwif_data;
 }
 
+static void ide_remove_port_from_hwgroup(ide_hwif_t *hwif)
+{
+	ide_hwgroup_t *hwgroup = hwif->hwgroup;
+
+	spin_lock_irq(&ide_lock);
+	/*
+	 * Remove us from the hwgroup, and free
+	 * the hwgroup if we were the only member
+	 */
+	if (hwif->next == hwif) {
+		BUG_ON(hwgroup->hwif != hwif);
+		kfree(hwgroup);
+	} else {
+		/* There is another interface in hwgroup.
+		 * Unlink us, and set hwgroup->drive and ->hwif to
+		 * something sane.
+		 */
+		ide_hwif_t *g = hwgroup->hwif;
+
+		while (g->next != hwif)
+			g = g->next;
+		g->next = hwif->next;
+		if (hwgroup->hwif == hwif) {
+			/* Chose a random hwif for hwgroup->hwif.
+			 * It's guaranteed that there are no drives
+			 * left in the hwgroup.
+			 */
+			BUG_ON(hwgroup->drive != NULL);
+			hwgroup->hwif = g;
+		}
+		BUG_ON(hwgroup->hwif == hwif);
+	}
+	spin_unlock_irq(&ide_lock);
+}
+
 /**
  *	ide_unregister		-	free an IDE interface
  *	@index: index of interface (will change soon to a pointer)
@@ -528,36 +563,8 @@ void ide_unregister(unsigned int index)
 	if (irq_count == 1)
 		free_irq(hwif->irq, hwgroup);
 
-	spin_lock_irq(&ide_lock);
-	/*
-	 * Remove us from the hwgroup, and free
-	 * the hwgroup if we were the only member
-	 */
-	if (hwif->next == hwif) {
-		BUG_ON(hwgroup->hwif != hwif);
-		kfree(hwgroup);
-	} else {
-		/* There is another interface in hwgroup.
-		 * Unlink us, and set hwgroup->drive and ->hwif to
-		 * something sane.
-		 */
-		g = hwgroup->hwif;
-		while (g->next != hwif)
-			g = g->next;
-		g->next = hwif->next;
-		if (hwgroup->hwif == hwif) {
-			/* Chose a random hwif for hwgroup->hwif.
-			 * It's guaranteed that there are no drives
-			 * left in the hwgroup.
-			 */
-			BUG_ON(hwgroup->drive != NULL);
-			hwgroup->hwif = g;
-		}
-		BUG_ON(hwgroup->hwif == hwif);
-	}
+	ide_remove_port_from_hwgroup(hwif);
 
-	/* More messed up locking ... */
-	spin_unlock_irq(&ide_lock);
 	device_unregister(&hwif->gendev);
 	wait_for_completion(&hwif->gendev_rel_comp);
 
