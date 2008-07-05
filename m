From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [git patches] IDE fixes
Date: Sat, 5 Jul 2008 20:38:23 +0200
Message-ID: <200807052038.23662.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.174]:52923 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751625AbYGESiV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 5 Jul 2008 14:38:21 -0400
Received: by ug-out-1314.google.com with SMTP id h2so919779ugf.16
        for <linux-ide@vger.kernel.org>; Sat, 05 Jul 2008 11:38:19 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org


Hi,

Few fixes for code which handles unregistering IDE ports.


Linus, please pull from:

master.kernel.org:/pub/scm/linux/kernel/git/bart/ide-2.6.git/

to receive the following updates:

 drivers/ide/ide-probe.c |    2 --
 drivers/ide/ide.c       |   24 ++++++++----------------
 2 files changed, 8 insertions(+), 18 deletions(-)


Bartlomiej Zolnierkiewicz (3):
      ide: fix hwif->gendev refcounting
      ide: ide_unregister() warm-plug bugfix
      ide: ide_unregister() locking bugfix


diff --git a/drivers/ide/ide-probe.c b/drivers/ide/ide-probe.c
index 380fa0c..d27061b 100644
--- a/drivers/ide/ide-probe.c
+++ b/drivers/ide/ide-probe.c
@@ -646,8 +646,6 @@ static int ide_register_port(ide_hwif_t *hwif)
 		goto out;
 	}
 
-	get_device(&hwif->gendev);
-
 	hwif->portdev = device_create_drvdata(ide_port_class, &hwif->gendev,
 					      MKDEV(0, 0), hwif, hwif->name);
 	if (IS_ERR(hwif->portdev)) {
diff --git a/drivers/ide/ide.c b/drivers/ide/ide.c
index c758dcb..300431d 100644
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
@@ -351,16 +352,15 @@ void ide_unregister(ide_hwif_t *hwif)
 	blk_unregister_region(MKDEV(hwif->major, 0), MAX_DRIVES<<PARTN_BITS);
 	kfree(hwif->sg_table);
 	unregister_blkdev(hwif->major, hwif->name);
-	spin_lock_irq(&ide_lock);
 
 	if (hwif->dma_base)
 		ide_release_dma_engine(hwif);
 
+	spin_lock_irq(&ide_lock);
 	/* restore hwif data to pristine status */
 	ide_init_port_data(hwif, hwif->index);
-
-abort:
 	spin_unlock_irq(&ide_lock);
+
 	mutex_unlock(&ide_cfg_mtx);
 }
 
@@ -1094,13 +1094,6 @@ struct bus_type ide_bus_type = {
 
 EXPORT_SYMBOL_GPL(ide_bus_type);
 
-static void ide_port_class_release(struct device *portdev)
-{
-	ide_hwif_t *hwif = dev_get_drvdata(portdev);
-
-	put_device(&hwif->gendev);
-}
-
 int ide_vlb_clk;
 EXPORT_SYMBOL_GPL(ide_vlb_clk);
 
@@ -1305,7 +1298,6 @@ static int __init ide_init(void)
 		ret = PTR_ERR(ide_port_class);
 		goto out_port_class;
 	}
-	ide_port_class->dev_release = ide_port_class_release;
 
 	init_ide_data();
 
