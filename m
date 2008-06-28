From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 4/7] ide: move ide_remove_port_from_hwgroup() to ide-probe.c
Date: Sat, 28 Jun 2008 23:44:24 +0200
Message-ID: <20080628214424.21345.82726.sendpatchset@localhost.localdomain>
References: <20080628214355.21345.94835.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.188]:38355 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754759AbYF1VmQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 28 Jun 2008 17:42:16 -0400
Received: by mu-out-0910.google.com with SMTP id w8so348168mue.1
        for <linux-ide@vger.kernel.org>; Sat, 28 Jun 2008 14:42:15 -0700 (PDT)
In-Reply-To: <20080628214355.21345.94835.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-probe.c |   35 +++++++++++++++++++++++++++++++++++
 drivers/ide/ide.c       |   35 -----------------------------------
 2 files changed, 35 insertions(+), 35 deletions(-)

Index: b/drivers/ide/ide-probe.c
===================================================================
--- a/drivers/ide/ide-probe.c
+++ b/drivers/ide/ide-probe.c
@@ -994,6 +994,41 @@ static void ide_port_setup_devices(ide_h
 	mutex_unlock(&ide_cfg_mtx);
 }
 
+void ide_remove_port_from_hwgroup(ide_hwif_t *hwif)
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
 /*
  * This routine sets up the irq for an ide interface, and creates a new
  * hwgroup for the irq/hwif if none was previously assigned.
Index: b/drivers/ide/ide.c
===================================================================
--- a/drivers/ide/ide.c
+++ b/drivers/ide/ide.c
@@ -133,41 +133,6 @@ static void ide_port_init_devices_data(i
 	}
 }
 
-void ide_remove_port_from_hwgroup(ide_hwif_t *hwif)
-{
-	ide_hwgroup_t *hwgroup = hwif->hwgroup;
-
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
-		ide_hwif_t *g = hwgroup->hwif;
-
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
-	spin_unlock_irq(&ide_lock);
-}
-
 /* Called with ide_lock held. */
 static void __ide_port_unregister_devices(ide_hwif_t *hwif)
 {
