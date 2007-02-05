From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] amd74xx: don't configure udma mode higher than BIOS did
Date: Mon, 5 Feb 2007 16:58:36 +0900
Message-ID: <20070205075836.GG1625@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.239]:36157 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752770AbXBEH6l (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 5 Feb 2007 02:58:41 -0500
Received: by wx-out-0506.google.com with SMTP id h31so1533150wxd
        for <linux-ide@vger.kernel.org>; Sun, 04 Feb 2007 23:58:41 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org

On many nvidia boards, BIOSen often set CABLE bit in EIDE Controller
Configuration Register even when 40c cable is attached but configures
transfer mode correctly (<= udma33).  As amd74xx depends on the CABLE
bit to determine the cable type and thus the highest allowed udma
mode, this often results in incorrectly configured device resulting in
CRC errors and DMA disabling.

This patch makes amd74xx not configure udma mode higher than BIOS did.
If BIOS configured the device <= udma44, udma33 is the maximum speed.
Otherwise, the mode BIOs configured is the highest.  udma44
discrepancy is due to limitation in ide_find_best_mode() interface.
This shouldn't make much difference.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
Without this change, amd74xx can't figure out the right udma mode.
I've verified with 40c and 80c cables and a few new and old disks and
ODDs.  Works pretty good.

 drivers/ide/pci/amd74xx.c |   43 ++++++++++++++++++++++++++++++++++++-------
 1 file changed, 36 insertions(+), 7 deletions(-)

Index: work/drivers/ide/pci/amd74xx.c
===================================================================
--- work.orig/drivers/ide/pci/amd74xx.c
+++ work/drivers/ide/pci/amd74xx.c
@@ -84,6 +84,7 @@ static struct amd_ide_chip *amd_config;
 static ide_pci_device_t *amd_chipset;
 static unsigned int amd_80w;
 static unsigned int amd_clock;
+static u32 amd_udma_timing;
 
 static char *amd_dma[] = { "MWDMA16", "UDMA33", "UDMA66", "UDMA100", "UDMA133" };
 static unsigned char amd_cyc2udma[] = { 6, 6, 5, 4, 0, 1, 1, 2, 2, 3, 3, 3, 3, 3, 3, 7 };
@@ -292,14 +293,37 @@ static void amd74xx_tune_drive(ide_drive
 
 static int amd74xx_ide_dma_check(ide_drive_t *drive)
 {
-	int w80 = HWIF(drive)->udma_four;
+	/* UDMA timing to limit map, we don't limit below udma33 */
+	static const int udma_limit_map[] =
+		{ AMD_UDMA_33, AMD_UDMA_33, AMD_UDMA_33, AMD_UDMA_33,
+		  AMD_UDMA_33, AMD_UDMA_66, AMD_UDMA_100, AMD_UDMA_133 };
+	int w80, map;
+	u8 speed;
+
+	w80 = HWIF(drive)->udma_four && eighty_ninty_three(drive);
+	map = XFER_PIO | XFER_EPIO | XFER_MWDMA | XFER_UDMA |
+		((amd_config->flags & AMD_BAD_SWDMA) ? 0 : XFER_SWDMA);
+
+	if (w80) {
+		int udma_mode = amd_config->flags & AMD_UDMA;
+		u32 udma_timing = amd_udma_timing;
+
+		/* don't go over BIOS configured speed */
+		udma_timing >>= 8 * (3 - drive->dn);
+
+		if ((udma_timing & 0xc0) == 0xc0)
+			udma_mode = min(udma_mode,
+					udma_limit_map[udma_timing & 0x07]);
+
+		if (udma_mode >= AMD_UDMA_66)
+			map |= XFER_UDMA_66;
+		if (udma_mode >= AMD_UDMA_100)
+			map |= XFER_UDMA_100;
+		if (udma_mode >= AMD_UDMA_133)
+			map |= XFER_UDMA_133;
+	}
 
-	u8 speed = ide_find_best_mode(drive,
-		XFER_PIO | XFER_EPIO | XFER_MWDMA | XFER_UDMA |
-		((amd_config->flags & AMD_BAD_SWDMA) ? 0 : XFER_SWDMA) |
-		(w80 && (amd_config->flags & AMD_UDMA) >= AMD_UDMA_66 ? XFER_UDMA_66 : 0) |
-		(w80 && (amd_config->flags & AMD_UDMA) >= AMD_UDMA_100 ? XFER_UDMA_100 : 0) |
-		(w80 && (amd_config->flags & AMD_UDMA) >= AMD_UDMA_133 ? XFER_UDMA_133 : 0));
+	speed = ide_find_best_mode(drive, map);
 
 	amd_set_drive(drive, speed);
 
@@ -355,6 +379,11 @@ static unsigned int __devinit init_chips
 	}
 
 /*
+ * Cache UDMA timing BIOS configured.
+ */
+	pci_read_config_dword(dev, AMD_UDMA_TIMING, &amd_udma_timing);
+
+/*
  * Take care of prefetch & postwrite.
  */
 
