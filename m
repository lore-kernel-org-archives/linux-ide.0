From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 5/15] slc90e66: fix deadlock on error handling
Date: Mon, 1 Oct 2007 23:34:39 +0200
Message-ID: <200710012334.39975.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.172]:61343 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757162AbXJAVjl (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 1 Oct 2007 17:39:41 -0400
Received: by ug-out-1314.google.com with SMTP id z38so1977009ugc
        for <linux-ide@vger.kernel.org>; Mon, 01 Oct 2007 14:39:40 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


* Stop abusing ide_lock lock (switch to a private locking).

  Fixes same issue as fixed by Alan Cox in atiixp host driver with
  commit 6c5f8cc33eb2e10b6ab788bbe259fc142a068627.

* Bump driver version.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/pci/slc90e66.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

Index: b/drivers/ide/pci/slc90e66.c
===================================================================
--- a/drivers/ide/pci/slc90e66.c
+++ b/drivers/ide/pci/slc90e66.c
@@ -1,5 +1,5 @@
 /*
- *  linux/drivers/ide/pci/slc90e66.c	Version 0.18	Aug 9, 2007
+ *  linux/drivers/ide/pci/slc90e66.c	Version 0.19	Sep 24, 2007
  *
  *  Copyright (C) 2000-2002 Andre Hedrick <andre@linux-ide.org>
  *  Copyright (C) 2006-2007 MontaVista Software, Inc. <source@mvista.com>
@@ -21,6 +21,8 @@
 
 #include <asm/io.h>
 
+static DEFINE_SPINLOCK(slc90e66_lock);
+
 static void slc90e66_set_pio_mode(ide_drive_t *drive, const u8 pio)
 {
 	ide_hwif_t *hwif	= HWIF(drive);
@@ -40,7 +42,7 @@ static void slc90e66_set_pio_mode(ide_dr
 					{ 2, 1 },
 					{ 2, 3 }, };
 
-	spin_lock_irqsave(&ide_lock, flags);
+	spin_lock_irqsave(&slc90e66_lock, flags);
 	pci_read_config_word(dev, master_port, &master_data);
 
 	if (pio > 1)
@@ -71,7 +73,7 @@ static void slc90e66_set_pio_mode(ide_dr
 	pci_write_config_word(dev, master_port, master_data);
 	if (is_slave)
 		pci_write_config_byte(dev, slave_port, slave_data);
-	spin_unlock_irqrestore(&ide_lock, flags);
+	spin_unlock_irqrestore(&slc90e66_lock, flags);
 }
 
 static void slc90e66_set_dma_mode(ide_drive_t *drive, const u8 speed)
