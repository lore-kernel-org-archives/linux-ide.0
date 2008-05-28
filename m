From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 10/21] qd65xx: convert to use ide_timing_find_mode()
Date: Wed, 28 May 2008 23:42:15 +0200
Message-ID: <20080528214215.16327.58984.sendpatchset@localhost.localdomain>
References: <20080528213944.16327.92950.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.191]:51381 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755824AbYE1Vom (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 28 May 2008 17:44:42 -0400
Received: by mu-out-0910.google.com with SMTP id w8so2394678mue.1
        for <linux-ide@vger.kernel.org>; Wed, 28 May 2008 14:44:39 -0700 (PDT)
In-Reply-To: <20080528213944.16327.92950.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

There should be no functional changes caused by this patch.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/Kconfig         |    1 +
 drivers/ide/legacy/qd65xx.c |    3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

Index: b/drivers/ide/Kconfig
===================================================================
--- a/drivers/ide/Kconfig
+++ b/drivers/ide/Kconfig
@@ -1018,6 +1018,7 @@ config BLK_DEV_HT6560B
 
 config BLK_DEV_QD65XX
 	tristate "QDI QD65xx support"
+	select IDE_TIMINGS
 	help
 	  This driver is enabled at runtime using the "qd65xx.probe" kernel
 	  boot parameter.  It permits faster I/O speeds to be set.  See the
Index: b/drivers/ide/legacy/qd65xx.c
===================================================================
--- a/drivers/ide/legacy/qd65xx.c
+++ b/drivers/ide/legacy/qd65xx.c
@@ -207,6 +207,7 @@ static void qd6500_set_pio_mode(ide_driv
 static void qd6580_set_pio_mode(ide_drive_t *drive, const u8 pio)
 {
 	ide_hwif_t *hwif = drive->hwif;
+	struct ide_timing *t = ide_timing_find_mode(XFER_PIO_0 + pio);
 	unsigned int cycle_time;
 	int active_time   = 175;
 	int recovery_time = 415; /* worst case values from the dos driver */
@@ -236,7 +237,7 @@ static void qd6580_set_pio_mode(ide_driv
 					active_time = 110;
 					recovery_time = cycle_time - 120;
 				} else {
-					active_time = ide_pio_timings[pio].active_time;
+					active_time = t->active;
 					recovery_time = cycle_time - active_time;
 				}
 		}
