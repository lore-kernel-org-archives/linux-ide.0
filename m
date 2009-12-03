From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 1/6] alim15x3: remove obsolete and dangerous wdc_udma parameter
Date: Thu, 03 Dec 2009 20:51:54 +0100
Message-ID: <20091203195154.9093.14693.sendpatchset@localhost>
References: <20091203195145.9093.88261.sendpatchset@localhost>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756091AbZLCTwl@vger.kernel.org>
In-Reply-To: <20091203195145.9093.88261.sendpatchset@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>
List-Id: linux-ide@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] alim15x3: remove obsolete and dangerous wdc_udma parameter

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/alim15x3.c |   12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

Index: b/drivers/ide/alim15x3.c
===================================================================
--- a/drivers/ide/alim15x3.c
+++ b/drivers/ide/alim15x3.c
@@ -40,16 +40,6 @@
 #define DRV_NAME "alim15x3"
 
 /*
- * Allow UDMA on M1543C-E chipset for WDC disks that ignore CRC checking
- * (this is DANGEROUS and could result in data corruption).
- */
-static int wdc_udma;
-
-module_param(wdc_udma, bool, 0);
-MODULE_PARM_DESC(wdc_udma,
-		 "allow UDMA on M1543C-E chipset for WDC disks (DANGEROUS)");
-
-/*
  *	ALi devices are not plug in. Otherwise these static values would
  *	need to go. They ought to go away anyway
  */
@@ -132,7 +122,7 @@ static u8 ali_udma_filter(ide_drive_t *d
 	if (m5229_revision > 0x20 && m5229_revision < 0xC2) {
 		if (drive->media != ide_disk)
 			return 0;
-		if (wdc_udma == 0 && chip_is_1543c_e &&
+		if (chip_is_1543c_e &&
 		    strstr((char *)&drive->id[ATA_ID_PROD], "WDC "))
 			return 0;
 	}
