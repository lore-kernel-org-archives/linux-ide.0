From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 1/3] ide: ide_dev_has_iordy() -> ata_id_has_iordy()
Date: Mon, 28 Jul 2008 22:55:58 +0200
Message-ID: <200807282255.58904.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.187]:19157 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751991AbYG1VDU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 28 Jul 2008 17:03:20 -0400
Received: by fk-out-0910.google.com with SMTP id 18so3557648fkq.5
        for <linux-ide@vger.kernel.org>; Mon, 28 Jul 2008 14:03:18 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Sergei Shtylyov <sshtylyov@ru.mvista.com>

* Remove (id[ATA_ID_FIELD_VALID] & 2) check from ide_dev_has_iordy()
  (it is for validity of words 64-70, IORDY is in word 49).

* ide_dev_has_iordy() -> ata_id_has_iordy()

Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/pci/sl82c105.c |    2 +-
 include/linux/ide.h        |    5 -----
 2 files changed, 1 insertion(+), 6 deletions(-)

Index: b/drivers/ide/pci/sl82c105.c
===================================================================
--- a/drivers/ide/pci/sl82c105.c
+++ b/drivers/ide/pci/sl82c105.c
@@ -61,7 +61,7 @@ static unsigned int get_pio_timings(ide_
 	if (cmd_off == 0)
 		cmd_off = 1;
 
-	if (pio > 2 || ide_dev_has_iordy(drive->id))
+	if (pio > 2 || ata_id_has_iordy(drive->id))
 		iordy = 0x40;
 
 	return (cmd_on - 1) << 8 | (cmd_off - 1) | iordy;
Index: b/include/linux/ide.h
===================================================================
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -1391,11 +1391,6 @@ const char *ide_xfer_verbose(u8 mode);
 extern void ide_toggle_bounce(ide_drive_t *drive, int on);
 extern int ide_set_xfer_rate(ide_drive_t *drive, u8 rate);
 
-static inline int ide_dev_has_iordy(u16 *id)
-{
-	return ((id[ATA_ID_FIELD_VALID] & 2) && ata_id_has_iordy(id)) ? 1 : 0;
-}
-
 static inline int ide_dev_is_sata(u16 *id)
 {
 	/*
