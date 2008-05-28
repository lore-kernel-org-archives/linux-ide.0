From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 13/21] cmd64x: convert to use ide_timing_find_mode()
Date: Wed, 28 May 2008 23:42:37 +0200
Message-ID: <20080528214237.16327.7342.sendpatchset@localhost.localdomain>
References: <20080528213944.16327.92950.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.189]:51223 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755927AbYE1VpE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 28 May 2008 17:45:04 -0400
Received: by mu-out-0910.google.com with SMTP id w8so2394621mue.1
        for <linux-ide@vger.kernel.org>; Wed, 28 May 2008 14:45:01 -0700 (PDT)
In-Reply-To: <20080528213944.16327.92950.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

There should be no functional changes caused by this patch.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/Kconfig      |    1 +
 drivers/ide/pci/cmd64x.c |    6 +++---
 2 files changed, 4 insertions(+), 3 deletions(-)

Index: b/drivers/ide/Kconfig
===================================================================
--- a/drivers/ide/Kconfig
+++ b/drivers/ide/Kconfig
@@ -495,6 +495,7 @@ config BLK_DEV_ATIIXP
 
 config BLK_DEV_CMD64X
 	tristate "CMD64{3|6|8|9} chipset support"
+	select IDE_TIMINGS
 	select BLK_DEV_IDEDMA_PCI
 	help
 	  Say Y here if you have an IDE controller which uses any of these
Index: b/drivers/ide/pci/cmd64x.c
===================================================================
--- a/drivers/ide/pci/cmd64x.c
+++ b/drivers/ide/pci/cmd64x.c
@@ -116,6 +116,7 @@ static void cmd64x_tune_pio(ide_drive_t 
 {
 	ide_hwif_t *hwif	= HWIF(drive);
 	struct pci_dev *dev	= to_pci_dev(hwif->dev);
+	struct ide_timing *t	= ide_timing_find_mode(XFER_PIO_0 + pio);
 	unsigned int cycle_time;
 	u8 setup_count, arttim = 0;
 
@@ -124,10 +125,9 @@ static void cmd64x_tune_pio(ide_drive_t 
 
 	cycle_time = ide_pio_cycle_time(drive, pio);
 
-	program_cycle_times(drive, cycle_time,
-			    ide_pio_timings[pio].active_time);
+	program_cycle_times(drive, cycle_time, t->active);
 
-	setup_count = quantize_timing(ide_pio_timings[pio].setup_time,
+	setup_count = quantize_timing(t->setup,
 			1000 / (ide_pci_clk ? ide_pci_clk : 33));
 
 	/*
