From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 3/5] alim15x3: add "wdc_udma" module parameter
Date: Thu, 8 May 2008 23:04:45 +0200
Message-ID: <200805082304.45583.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.154]:52725 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759606AbYEHUuW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 8 May 2008 16:50:22 -0400
Received: by fg-out-1718.google.com with SMTP id 19so633176fgg.17
        for <linux-ide@vger.kernel.org>; Thu, 08 May 2008 13:50:22 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Add "wdc_udma" module parameter for allowing UDMA transfers
on M1543C-E chipset for WDC disks.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/pci/alim15x3.c |   15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

Index: b/drivers/ide/pci/alim15x3.c
===================================================================
--- a/drivers/ide/pci/alim15x3.c
+++ b/drivers/ide/pci/alim15x3.c
@@ -39,6 +39,16 @@
 #include <asm/io.h>
 
 /*
+ * Allow UDMA on M1543C-E chipset for WDC disks that ignore CRC checking
+ * (this is DANGEROUS and could result in data corruption).
+ */
+static int wdc_udma;
+
+module_param(wdc_udma, bool, 0);
+MODULE_PARM_DESC(wdc_udma,
+		 "allow UDMA on M1543C-E chipset for WDC disks (DANGEROUS)");
+
+/*
  *	ALi devices are not plug in. Otherwise these static values would
  *	need to go. They ought to go away anyway
  */
@@ -116,7 +126,7 @@ static void ali_set_pio_mode(ide_drive_t
  *	The actual rules for the ALi are:
  *		No UDMA on revisions <= 0x20
  *		Disk only for revisions < 0xC2
- *		Not WDC drives for revisions < 0xC2
+ *		Not WDC drives on M1543C-E (?)
  *
  *	FIXME: WDC ifdef needs to die
  */
@@ -127,7 +137,8 @@ static u8 ali_udma_filter(ide_drive_t *d
 		if (drive->media != ide_disk)
 			return 0;
 #ifndef CONFIG_WDC_ALI15X3
-		if (chip_is_1543c_e && strstr(drive->id->model, "WDC "))
+		if (chip_is_1543c_e && strstr(drive->id->model, "WDC ") &&
+		    wdc_udma == 0)
 			return 0;
 #endif
 	}
