From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] au1xxx: fix au1xxx_set_pio_mode()
Date: Thu, 26 Jul 2007 21:55:19 +0200
Message-ID: <200707262155.19693.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.172]:62760 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936226AbXGZT75 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 26 Jul 2007 15:59:57 -0400
Received: by ug-out-1314.google.com with SMTP id j3so591339ugf
        for <linux-ide@vger.kernel.org>; Thu, 26 Jul 2007 12:59:57 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


Set transfer mode on the device before programming the host controller for
the new timings (matches what auide_tune_chipset() is doing wrt DMA modes).

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/mips/au1xxx-ide.c |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

Index: b/drivers/ide/mips/au1xxx-ide.c
===================================================================
--- a/drivers/ide/mips/au1xxx-ide.c
+++ b/drivers/ide/mips/au1xxx-ide.c
@@ -103,7 +103,9 @@ static void au1xxx_set_pio_mode(ide_driv
 {
 	int mem_sttime;
 	int mem_stcfg;
-	u8 speed;
+
+	if (ide_config_drive_speed(drive, pio + XFER_PIO_0))
+		return;
 
 	mem_sttime = 0;
 	mem_stcfg  = au_readl(MEM_STCFG2);
@@ -164,9 +166,6 @@ static void au1xxx_set_pio_mode(ide_driv
 
 	au_writel(mem_sttime,MEM_STTIME2);
 	au_writel(mem_stcfg,MEM_STCFG2);
-
-	speed = pio + XFER_PIO_0;
-	ide_config_drive_speed(drive, speed);
 }
 
 static int auide_tune_chipset(ide_drive_t *drive, const u8 speed)
