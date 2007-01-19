From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 6/15] atiixp/jmicron/triflex: fix PIO fallback
Date: Fri, 19 Jan 2007 01:31:37 +0100
Message-ID: <20070119003137.14846.51524.sendpatchset@localhost.localdomain>
References: <20070119003058.14846.43637.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.172]:62361 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932810AbXASA1i (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 18 Jan 2007 19:27:38 -0500
Received: by ug-out-1314.google.com with SMTP id 44so322530uga
        for <linux-ide@vger.kernel.org>; Thu, 18 Jan 2007 16:27:37 -0800 (PST)
In-Reply-To: <20070119003058.14846.43637.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

[PATCH] atiixp/jmicron/triflex: fix PIO fallback

* atiixp: if DMA can't be used atiixp_config_drive_for_dma() should return 0,
  atiixp_dma_check() will tune the correct PIO mode anyway

* jmicron: if DMA can't be used config_chipset_for_dma() should return 0,
  micron_config_drive_for_dma() will tune the correct PIO mode anyway

  config_jmicron_chipset_for_pio(drive, !speed) doesn't program
  device transfer mode for speed != 0 (only wastes some CPU cycles
  on ide_get_best_pio_mode() call) so remove it

* triflex: if DMA can't be used triflex_config_drive_for_dma() should return 0,
  triflex_config_drive_xfer_rate() will tune correct PIO mode anyway

Above changes also fix (theoretical) issue when ->speedproc fails to set
device transfer mode (i.e. when ide_config_drive_speed() fails to program it)
but one of DMA transfer modes is already enabled on the device by the BIOS.
In such scenario ide_dma_enable() will incorrectly return true statement
and ->ide_dma_check will try to enable DMA on the device.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

---
 drivers/ide/pci/atiixp.c  |    7 ++-----
 drivers/ide/pci/jmicron.c |    4 +++-
 drivers/ide/pci/triflex.c |    8 +++-----
 3 files changed, 8 insertions(+), 11 deletions(-)

Index: b/drivers/ide/pci/atiixp.c
===================================================================
--- a/drivers/ide/pci/atiixp.c
+++ b/drivers/ide/pci/atiixp.c
@@ -235,11 +235,8 @@ static int atiixp_config_drive_for_dma(i
 {
 	u8 speed = ide_dma_speed(drive, atiixp_ratemask(drive));
 
-	/* If no DMA speed was available then disable DMA and use PIO. */
-	if (!speed) {
-		u8 tspeed = ide_get_best_pio_mode(drive, 255, 5, NULL);
-		speed = atiixp_dma_2_pio(XFER_PIO_0 + tspeed) + XFER_PIO_0;
-	}
+	if (!speed)
+		return 0;
 
 	(void) atiixp_speedproc(drive, speed);
 	return ide_dma_enable(drive);
Index: b/drivers/ide/pci/jmicron.c
===================================================================
--- a/drivers/ide/pci/jmicron.c
+++ b/drivers/ide/pci/jmicron.c
@@ -147,7 +147,9 @@ static int config_chipset_for_dma (ide_d
 {
 	u8 speed	= ide_dma_speed(drive, jmicron_ratemask(drive));
 
-	config_jmicron_chipset_for_pio(drive, !speed);
+	if (!speed)
+		return 0;
+
 	jmicron_tune_chipset(drive, speed);
 	return ide_dma_enable(drive);
 }
Index: b/drivers/ide/pci/triflex.c
===================================================================
--- a/drivers/ide/pci/triflex.c
+++ b/drivers/ide/pci/triflex.c
@@ -104,11 +104,9 @@ static int triflex_config_drive_for_dma(
 {
 	int speed = ide_dma_speed(drive, 0); /* No ultra speeds */
 
-	if (!speed) { 
-		u8 pspeed = ide_get_best_pio_mode(drive, 255, 4, NULL);
-		speed = XFER_PIO_0 + pspeed;
-	}
-	
+	if (!speed)
+		return 0;
+
 	(void) triflex_tune_chipset(drive, speed);
 	 return ide_dma_enable(drive);
 }
