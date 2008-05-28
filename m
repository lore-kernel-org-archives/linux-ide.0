From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 15/21] opti621: convert to use ide_timing_find_mode()
Date: Wed, 28 May 2008 23:42:51 +0200
Message-ID: <20080528214251.16327.69202.sendpatchset@localhost.localdomain>
References: <20080528213944.16327.92950.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.189]:51223 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755875AbYE1VpQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 28 May 2008 17:45:16 -0400
Received: by mu-out-0910.google.com with SMTP id w8so2394621mue.1
        for <linux-ide@vger.kernel.org>; Wed, 28 May 2008 14:45:15 -0700 (PDT)
In-Reply-To: <20080528213944.16327.92950.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

There should be no functional changes caused by this patch.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/Kconfig       |    1 +
 drivers/ide/pci/opti621.c |   10 +++++-----
 2 files changed, 6 insertions(+), 5 deletions(-)

Index: b/drivers/ide/Kconfig
===================================================================
--- a/drivers/ide/Kconfig
+++ b/drivers/ide/Kconfig
@@ -426,6 +426,7 @@ config BLK_DEV_GENERIC
 config BLK_DEV_OPTI621
 	tristate "OPTi 82C621 chipset enhanced support (EXPERIMENTAL)"
 	depends on EXPERIMENTAL
+	select IDE_TIMINGS
 	select BLK_DEV_IDEPCI
 	help
 	  This is a driver for the OPTi 82C621 EIDE controller.
Index: b/drivers/ide/pci/opti621.c
===================================================================
--- a/drivers/ide/pci/opti621.c
+++ b/drivers/ide/pci/opti621.c
@@ -208,15 +208,15 @@ typedef struct pio_clocks_s {
 static void compute_clocks(int pio, pio_clocks_t *clks)
 {
 	if (pio != PIO_NOT_EXIST) {
-		int adr_setup, data_pls;
+		struct ide_timing *t = ide_timing_find_mode(XFER_PIO_0 + pio);
+		int adr_setup = t->setup, data_pls = t->active;
 		int bus_speed = ide_pci_clk ? ide_pci_clk : 33;
 
-		adr_setup = ide_pio_timings[pio].setup_time;
-		data_pls = ide_pio_timings[pio].active_time;
 		clks->address_time = cmpt_clk(adr_setup, bus_speed);
 		clks->data_time = cmpt_clk(data_pls, bus_speed);
-		clks->recovery_time = cmpt_clk(ide_pio_timings[pio].cycle_time
-			- adr_setup-data_pls, bus_speed);
+		clks->recovery_time = cmpt_clk(t->cycle	- adr_setup - data_pls,
+					       bus_speed);
+
 		if (clks->address_time < 1)
 			clks->address_time = 1;
 		if (clks->address_time > 4)
