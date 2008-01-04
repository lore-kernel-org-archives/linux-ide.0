From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 6/15] ide: remove needless zeroing of hwgroup fields from init_irq()
Date: Fri, 04 Jan 2008 22:25:08 +0100
Message-ID: <20080104212508.6978.62680.sendpatchset@localhost.localdomain>
References: <20080104212424.6978.93646.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.171]:37216 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755223AbYADVNc (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 4 Jan 2008 16:13:32 -0500
Received: by ug-out-1314.google.com with SMTP id z38so2833655ugc.16
        for <linux-ide@vger.kernel.org>; Fri, 04 Jan 2008 13:13:31 -0800 (PST)
In-Reply-To: <20080104212424.6978.93646.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

Since kmalloc_node() is called with __GFP_ZERO flag there is no need to
explicitly zero hwgroup fields.

While at it:

* Use 'hwif' instead of 'hwif->drives[0].hwif' for kmalloc_node() call.

* Fix whitespace damage.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
-27 bytes
 drivers/ide/ide-probe.c |   15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

Index: b/drivers/ide/ide-probe.c
===================================================================
--- a/drivers/ide/ide-probe.c
+++ b/drivers/ide/ide-probe.c
@@ -998,19 +998,14 @@ static int init_irq (ide_hwif_t *hwif)
 		hwgroup->hwif->next = hwif;
 		spin_unlock_irq(&ide_lock);
 	} else {
-		hwgroup = kmalloc_node(sizeof(ide_hwgroup_t),
-					GFP_KERNEL | __GFP_ZERO,
-					hwif_to_node(hwif->drives[0].hwif));
-		if (!hwgroup)
-	       		goto out_up;
+		hwgroup = kmalloc_node(sizeof(*hwgroup), GFP_KERNEL|__GFP_ZERO,
+				       hwif_to_node(hwif));
+		if (hwgroup == NULL)
+			goto out_up;
 
 		hwif->hwgroup = hwgroup;
+		hwgroup->hwif = hwif->next = hwif;
 
-		hwgroup->hwif     = hwif->next = hwif;
-		hwgroup->rq       = NULL;
-		hwgroup->handler  = NULL;
-		hwgroup->drive    = NULL;
-		hwgroup->busy     = 0;
 		init_timer(&hwgroup->timer);
 		hwgroup->timer.function = &ide_timer_expiry;
 		hwgroup->timer.data = (unsigned long) hwgroup;
