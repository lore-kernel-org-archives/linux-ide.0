From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] qd65xx: remove commented out code
Date: Fri, 22 Feb 2008 21:58:24 +0100
Message-ID: <200802222158.24652.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.172]:28252 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753520AbYBVUqc (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 22 Feb 2008 15:46:32 -0500
Received: by ug-out-1314.google.com with SMTP id z38so1409160ugc.16
        for <linux-ide@vger.kernel.org>; Fri, 22 Feb 2008 12:46:31 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/legacy/qd65xx.c |   37 -------------------------------------
 1 file changed, 37 deletions(-)

Index: b/drivers/ide/legacy/qd65xx.c
===================================================================
--- a/drivers/ide/legacy/qd65xx.c
+++ b/drivers/ide/legacy/qd65xx.c
@@ -334,43 +334,6 @@ static void __init qd6580_port_init_devs
 	hwif->drives[1].drive_data = t2;
 }
 
-/*
- * qd_unsetup:
- *
- * called to unsetup an ata channel : back to default values, unlinks tuning
- */
-/*
-static void __exit qd_unsetup(ide_hwif_t *hwif)
-{
-	u8 config = hwif->config_data;
-	int base = hwif->select_data;
-	void *set_pio_mode = (void *)hwif->set_pio_mode;
-
-	if (hwif->chipset != ide_qd65xx)
-		return;
-
-	printk(KERN_NOTICE "%s: back to defaults\n", hwif->name);
-
-	hwif->selectproc = NULL;
-	hwif->set_pio_mode = NULL;
-
-	if (set_pio_mode == (void *)qd6500_set_pio_mode) {
-		// will do it for both
-		outb(QD6500_DEF_DATA, QD_TIMREG(&hwif->drives[0]));
-	} else if (set_pio_mode == (void *)qd6580_set_pio_mode) {
-		if (QD_CONTROL(hwif) & QD_CONTR_SEC_DISABLED) {
-			outb(QD6580_DEF_DATA, QD_TIMREG(&hwif->drives[0]));
-			outb(QD6580_DEF_DATA2, QD_TIMREG(&hwif->drives[1]));
-		} else {
-			outb(hwif->channel ? QD6580_DEF_DATA2 : QD6580_DEF_DATA, QD_TIMREG(&hwif->drives[0]));
-		}
-	} else {
-		printk(KERN_WARNING "Unknown qd65xx tuning fonction !\n");
-		printk(KERN_WARNING "keeping settings !\n");
-	}
-}
-*/
-
 static const struct ide_port_info qd65xx_port_info __initdata = {
 	.chipset		= ide_qd65xx,
 	.host_flags		= IDE_HFLAG_IO_32BIT |
