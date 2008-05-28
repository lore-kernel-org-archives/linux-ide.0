From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 08/21] ali14xx: convert to use ide_timing_find_mode()
Date: Wed, 28 May 2008 23:40:54 +0200
Message-ID: <20080528214054.16327.46227.sendpatchset@localhost.localdomain>
References: <20080528213944.16327.92950.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.184]:50722 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754989AbYE1Vna (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 28 May 2008 17:43:30 -0400
Received: by mu-out-0910.google.com with SMTP id w8so2394261mue.1
        for <linux-ide@vger.kernel.org>; Wed, 28 May 2008 14:43:20 -0700 (PDT)
In-Reply-To: <20080528213944.16327.92950.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

There should be no functional changes caused by this patch.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/Kconfig          |    1 +
 drivers/ide/legacy/ali14xx.c |    3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

Index: b/drivers/ide/Kconfig
===================================================================
--- a/drivers/ide/Kconfig
+++ b/drivers/ide/Kconfig
@@ -988,6 +988,7 @@ config BLK_DEV_4DRIVES
 
 config BLK_DEV_ALI14XX
 	tristate "ALI M14xx support"
+	select IDE_TIMINGS
 	help
 	  This driver is enabled at runtime using the "ali14xx.probe" kernel
 	  boot parameter.  It enables support for the secondary IDE interface
Index: b/drivers/ide/legacy/ali14xx.c
===================================================================
--- a/drivers/ide/legacy/ali14xx.c
+++ b/drivers/ide/legacy/ali14xx.c
@@ -117,10 +117,11 @@ static void ali14xx_set_pio_mode(ide_dri
 	u8 param1, param2, param3, param4;
 	unsigned long flags;
 	int bus_speed = ide_vlb_clk ? ide_vlb_clk : 50;
+	struct ide_timing *t = ide_timing_find_mode(XFER_PIO_0 + pio);
 
 	/* calculate timing, according to PIO mode */
 	time1 = ide_pio_cycle_time(drive, pio);
-	time2 = ide_pio_timings[pio].active_time;
+	time2 = t->active;
 	param3 = param1 = (time2 * bus_speed + 999) / 1000;
 	param4 = param2 = (time1 * bus_speed + 999) / 1000 - param1;
 	if (pio < 3) {
