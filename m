From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 1/12] ali14xx: add "vlb_clock=" parameter
Date: Thu, 13 Mar 2008 23:43:52 +0100
Message-ID: <20080313224352.7051.44005.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.190]:64877 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752279AbYCMW3N (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 13 Mar 2008 18:29:13 -0400
Received: by fk-out-0910.google.com with SMTP id z23so3586994fkz.5
        for <linux-ide@vger.kernel.org>; Thu, 13 Mar 2008 15:29:10 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

Add "vlb_clock=" parameter for specifying VLB clock frequency (in MHz).

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/legacy/ali14xx.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

Index: b/drivers/ide/legacy/ali14xx.c
===================================================================
--- a/drivers/ide/legacy/ali14xx.c
+++ b/drivers/ide/legacy/ali14xx.c
@@ -51,6 +51,8 @@
 
 #define DRV_NAME "ali14xx"
 
+static int vlb_clock;
+
 /* port addresses for auto-detection */
 #define ALI_NUM_PORTS 4
 static const int ports[ALI_NUM_PORTS] __initdata =
@@ -116,7 +118,7 @@ static void ali14xx_set_pio_mode(ide_dri
 	int time1, time2;
 	u8 param1, param2, param3, param4;
 	unsigned long flags;
-	int bus_speed = system_bus_clock();
+	int bus_speed = vlb_clock ? vlb_clock : system_bus_clock();
 
 	/* calculate timing, according to PIO mode */
 	time1 = ide_pio_cycle_time(drive, pio);
@@ -225,6 +227,9 @@ static int probe_ali14xx;
 module_param_named(probe, probe_ali14xx, bool, 0);
 MODULE_PARM_DESC(probe, "probe for ALI M14xx chipsets");
 
+module_param(vlb_clock, int, 0);
+MODULE_PARM_DESC(vlb_clock, "VLB clock frequency (in MHz)");
+
 static int __init ali14xx_init(void)
 {
 	if (probe_ali14xx == 0)
