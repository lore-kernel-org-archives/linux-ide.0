From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 4/15] opti621: fix deadlock on error handling
Date: Mon, 1 Oct 2007 23:33:48 +0200
Message-ID: <200710012333.48551.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.169]:62096 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756858AbXJAVji (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 1 Oct 2007 17:39:38 -0400
Received: by ug-out-1314.google.com with SMTP id z38so1977013ugc
        for <linux-ide@vger.kernel.org>; Mon, 01 Oct 2007 14:39:38 -0700 (PDT)
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
 drivers/ide/pci/opti621.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

Index: b/drivers/ide/pci/opti621.c
===================================================================
--- a/drivers/ide/pci/opti621.c
+++ b/drivers/ide/pci/opti621.c
@@ -1,5 +1,5 @@
 /*
- *  linux/drivers/ide/pci/opti621.c		Version 0.8	Aug 27, 2007
+ *  linux/drivers/ide/pci/opti621.c		Version 0.9	Sep 24, 2007
  *
  *  Copyright (C) 1996-1998  Linus Torvalds & authors (see below)
  */
@@ -133,6 +133,8 @@ static int reg_base;
 #define PIO_NOT_EXIST 254
 #define PIO_DONT_KNOW 255
 
+static DEFINE_SPINLOCK(opti621_lock);
+
 /* there are stored pio numbers from other calls of opti621_set_pio_mode */
 static void compute_pios(ide_drive_t *drive, const u8 pio)
 /* Store values into drive->drive_data
@@ -278,7 +280,7 @@ static void opti621_set_pio_mode(ide_dri
 		second.recovery_time, drdy);
 #endif
 
-	spin_lock_irqsave(&ide_lock, flags);
+	spin_lock_irqsave(&opti621_lock, flags);
 
      	reg_base = hwif->io_ports[IDE_DATA_OFFSET];
 
@@ -317,7 +319,7 @@ static void opti621_set_pio_mode(ide_dri
 	/*  and read prefetch for both drives */
 	write_reg(misc, MISC_REG);
 
-	spin_unlock_irqrestore(&ide_lock, flags);
+	spin_unlock_irqrestore(&opti621_lock, flags);
 }
 
 /*
