From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 16/21] sl82c105: convert to use ide_timing_find_mode()
Date: Wed, 28 May 2008 23:42:58 +0200
Message-ID: <20080528214258.16327.89370.sendpatchset@localhost.localdomain>
References: <20080528213944.16327.92950.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.189]:51223 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755942AbYE1VpZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 28 May 2008 17:45:25 -0400
Received: by mu-out-0910.google.com with SMTP id w8so2394621mue.1
        for <linux-ide@vger.kernel.org>; Wed, 28 May 2008 14:45:22 -0700 (PDT)
In-Reply-To: <20080528213944.16327.92950.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

There should be no functional changes caused by this patch.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/Kconfig        |    1 +
 drivers/ide/pci/sl82c105.c |    3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

Index: b/drivers/ide/Kconfig
===================================================================
--- a/drivers/ide/Kconfig
+++ b/drivers/ide/Kconfig
@@ -704,6 +704,7 @@ config BLK_DEV_SIS5513
 config BLK_DEV_SL82C105
 	tristate "Winbond SL82c105 support"
 	depends on (PPC || ARM)
+	select IDE_TIMINGS
 	select BLK_DEV_IDEDMA_PCI
 	help
 	  If you have a Winbond SL82c105 IDE controller, say Y here to enable
Index: b/drivers/ide/pci/sl82c105.c
===================================================================
--- a/drivers/ide/pci/sl82c105.c
+++ b/drivers/ide/pci/sl82c105.c
@@ -47,10 +47,11 @@
  */
 static unsigned int get_pio_timings(ide_drive_t *drive, u8 pio)
 {
+	struct ide_timing *t = ide_timing_find_mode(XFER_PIO_0 + pio);
 	unsigned int cmd_on, cmd_off;
 	u8 iordy = 0;
 
-	cmd_on  = (ide_pio_timings[pio].active_time + 29) / 30;
+	cmd_on  = (t->active + 29) / 30;
 	cmd_off = (ide_pio_cycle_time(drive, pio) - 30 * cmd_on + 29) / 30;
 
 	if (cmd_on == 0)
