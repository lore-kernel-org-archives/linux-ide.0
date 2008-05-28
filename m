From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 09/21] ht6560b: convert to use ide_timing_find_mode()
Date: Wed, 28 May 2008 23:41:04 +0200
Message-ID: <20080528214104.16327.34235.sendpatchset@localhost.localdomain>
References: <20080528213944.16327.92950.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gv-out-0910.google.com ([216.239.58.189]:29491 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754795AbYE1Voe (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 28 May 2008 17:44:34 -0400
Received: by gv-out-0910.google.com with SMTP id e6so1537473gvc.37
        for <linux-ide@vger.kernel.org>; Wed, 28 May 2008 14:44:32 -0700 (PDT)
In-Reply-To: <20080528213944.16327.92950.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

There should be no functional changes caused by this patch.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/Kconfig          |    1 +
 drivers/ide/legacy/ht6560b.c |    7 +++----
 2 files changed, 4 insertions(+), 4 deletions(-)

Index: b/drivers/ide/Kconfig
===================================================================
--- a/drivers/ide/Kconfig
+++ b/drivers/ide/Kconfig
@@ -1008,6 +1008,7 @@ config BLK_DEV_DTC2278
 
 config BLK_DEV_HT6560B
 	tristate "Holtek HT6560B support"
+	select IDE_TIMINGS
 	help
 	  This driver is enabled at runtime using the "ht6560b.probe" kernel
 	  boot parameter. It enables support for the secondary IDE interface
Index: b/drivers/ide/legacy/ht6560b.c
===================================================================
--- a/drivers/ide/legacy/ht6560b.c
+++ b/drivers/ide/legacy/ht6560b.c
@@ -216,6 +216,7 @@ static u8 ht_pio2timings(ide_drive_t *dr
 
         if (pio) {
 		unsigned int cycle_time;
+		struct ide_timing *t = ide_timing_find_mode(XFER_PIO_0 + pio);
 
 		cycle_time = ide_pio_cycle_time(drive, pio);
 
@@ -224,10 +225,8 @@ static u8 ht_pio2timings(ide_drive_t *dr
 		 *  actual cycle time for recovery and activity
 		 *  according system bus speed.
 		 */
-		active_time = ide_pio_timings[pio].active_time;
-		recovery_time = cycle_time
-			- active_time
-			- ide_pio_timings[pio].setup_time;
+		active_time = t->active;
+		recovery_time = cycle_time - active_time - t->setup;
 		/*
 		 *  Cycle times should be Vesa bus cycles
 		 */
