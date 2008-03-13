From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 2/12] ht6560b: add "vlb_clock=" parameter
Date: Thu, 13 Mar 2008 23:43:59 +0100
Message-ID: <20080313224359.7051.8198.sendpatchset@localhost.localdomain>
References: <20080313224352.7051.44005.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.157]:14483 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756830AbYCMW3R (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 13 Mar 2008 18:29:17 -0400
Received: by fg-out-1718.google.com with SMTP id e21so3539392fga.17
        for <linux-ide@vger.kernel.org>; Thu, 13 Mar 2008 15:29:17 -0700 (PDT)
In-Reply-To: <20080313224352.7051.44005.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

Add "vlb_clock=" parameter for specifying VLB clock frequency (in MHz).

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/legacy/ht6560b.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

Index: b/drivers/ide/legacy/ht6560b.c
===================================================================
--- a/drivers/ide/legacy/ht6560b.c
+++ b/drivers/ide/legacy/ht6560b.c
@@ -116,6 +116,8 @@
 #define HT_TIMING(drivea) (u8)((drivea)->drive_data & 0x00ff)
 #define HT_TIMING_DEFAULT 0xff
 
+static int vlb_clock;
+
 /*
  * This routine handles interface switching for the peculiar hardware design
  * on the F.G.I./Holtek HT-6560B VLB IDE interface.
@@ -212,8 +214,8 @@ static u8 ht_pio2timings(ide_drive_t *dr
 {
 	int active_time, recovery_time;
 	int active_cycles, recovery_cycles;
-	int bus_speed = system_bus_clock();
-	
+	int bus_speed = vlb_clock ? vlb_clock : system_bus_clock();
+
         if (pio) {
 		unsigned int cycle_time;
 
@@ -328,6 +330,9 @@ static int probe_ht6560b;
 module_param_named(probe, probe_ht6560b, bool, 0);
 MODULE_PARM_DESC(probe, "probe for HT6560B chipset");
 
+module_param(vlb_clock, int, 0);
+MODULE_PARM_DESC(vlb_clock, "VLB clock frequency (in MHz)");
+
 static const struct ide_port_ops ht6560b_port_ops = {
 	.port_init_devs		= ht6560b_port_init_devs,
 	.set_pio_mode		= ht6560b_set_pio_mode,
