From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 3/4] sis5513: clear prefetch and postwrite for ATAPI devices
Date: Thu, 9 Aug 2007 22:14:17 +0200
Message-ID: <200708092214.18015.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.190]:30594 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755668AbXHIUQH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 9 Aug 2007 16:16:07 -0400
Received: by mu-out-0910.google.com with SMTP id i10so796187mue
        for <linux-ide@vger.kernel.org>; Thu, 09 Aug 2007 13:16:05 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


Clear prefetch and postwrite for ATAPI devices instead of depending on BIOS.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/pci/sis5513.c |   13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

Index: b/drivers/ide/pci/sis5513.c
===================================================================
--- a/drivers/ide/pci/sis5513.c
+++ b/drivers/ide/pci/sis5513.c
@@ -1,5 +1,5 @@
 /*
- * linux/drivers/ide/pci/sis5513.c	Version 0.29	Aug 1, 2007
+ * linux/drivers/ide/pci/sis5513.c	Version 0.30	Aug 9, 2007
  *
  * Copyright (C) 1999-2000	Andre Hedrick <andre@linux-ide.org>
  * Copyright (C) 2002		Lionel Bouton <Lionel.Bouton@inet6.fr>, Maintainer
@@ -522,20 +522,19 @@ static void sis_program_timings(ide_driv
 		sis_ata133_program_timings(drive, mode);
 }
 
-/* Enables per-drive prefetch and postwrite */
 static void config_drive_art_rwp (ide_drive_t *drive)
 {
 	ide_hwif_t *hwif	= HWIF(drive);
 	struct pci_dev *dev	= hwif->pci_dev;
-
 	u8 reg4bh		= 0;
-	u8 rw_prefetch		= (0x11 << drive->dn);
+	u8 rw_prefetch		= 0;
 
-	if (drive->media != ide_disk)
-		return;
 	pci_read_config_byte(dev, 0x4b, &reg4bh);
 
-	if ((reg4bh & rw_prefetch) != rw_prefetch)
+	if (drive->media == ide_disk)
+		rw_prefetch = 0x11 << drive->dn;
+
+	if ((reg4bh & (0x11 << drive->dn)) != rw_prefetch)
 		pci_write_config_byte(dev, 0x4b, reg4bh|rw_prefetch);
 }
 
