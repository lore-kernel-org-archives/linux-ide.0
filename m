From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 1/2] ide: ide_unregister() warm-plug bugfix
Date: Sat, 5 Jul 2008 14:50:01 +0200
Message-ID: <200807051450.01321.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gv-out-0910.google.com ([216.239.58.189]:10930 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752638AbYGEMvH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 5 Jul 2008 08:51:07 -0400
Received: by gv-out-0910.google.com with SMTP id e6so282661gvc.37
        for <linux-ide@vger.kernel.org>; Sat, 05 Jul 2008 05:51:06 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Fix ide_unregister() to work for ports with no devices attached to them.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
for 2.6.26

 drivers/ide/ide.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

Index: b/drivers/ide/ide.c
===================================================================
--- a/drivers/ide/ide.c
+++ b/drivers/ide/ide.c
@@ -315,13 +315,14 @@ void ide_unregister(ide_hwif_t *hwif)
 
 	BUG_ON(in_interrupt());
 	BUG_ON(irqs_disabled());
+
 	mutex_lock(&ide_cfg_mtx);
-	spin_lock_irq(&ide_lock);
-	if (!hwif->present)
-		goto abort;
-	__ide_port_unregister_devices(hwif);
-	hwif->present = 0;
 
+	spin_lock_irq(&ide_lock);
+	if (hwif->present) {
+		__ide_port_unregister_devices(hwif);
+		hwif->present = 0;
+	}
 	spin_unlock_irq(&ide_lock);
 
 	ide_proc_unregister_port(hwif);
@@ -359,7 +360,6 @@ void ide_unregister(ide_hwif_t *hwif)
 	/* restore hwif data to pristine status */
 	ide_init_port_data(hwif, hwif->index);
 
-abort:
 	spin_unlock_irq(&ide_lock);
 	mutex_unlock(&ide_cfg_mtx);
 }
