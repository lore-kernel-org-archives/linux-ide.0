From: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
Subject: [PATCH 07/10] IDE: Coding Style fixes to drivers/ide/pci/slc90e66.c
Date: Sat, 23 Feb 2008 15:05:38 +0100
Message-ID: <20080223150538.7bd86335@paolo-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.156]:33567 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758859AbYBWOFn (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 23 Feb 2008 09:05:43 -0500
Received: by fg-out-1718.google.com with SMTP id e21so582555fga.17
        for <linux-ide@vger.kernel.org>; Sat, 23 Feb 2008 06:05:43 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, linux-ide <linux-ide@vger.kernel.org>

File is now error free, only 1 warning left.
Compile tested.


Signed-off-by: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
---
 drivers/ide/pci/slc90e66.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/ide/pci/slc90e66.c b/drivers/ide/pci/slc90e66.c
index 2ce384a..eab557c 100644
--- a/drivers/ide/pci/slc90e66.c
+++ b/drivers/ide/pci/slc90e66.c
@@ -27,9 +27,9 @@ static void slc90e66_set_pio_mode(ide_drive_t *drive, const u8 pio)
 	unsigned long flags;
 	u16 master_data;
 	u8 slave_data;
- 	int control = 0;
+	int control = 0;
 				     /* ISP  RTC */
-	static const u8 timings[][2]= {
+	static const u8 timings[][2] = {
 					{ 0, 0 },
 					{ 0, 0 },
 					{ 1, 0 },
@@ -136,7 +136,7 @@ static void __devinit init_hwif_slc90e66(ide_hwif_t *hwif)
 static const struct ide_port_info slc90e66_chipset __devinitdata = {
 	.name		= "SLC90E66",
 	.init_hwif	= init_hwif_slc90e66,
-	.enablebits	= {{0x41,0x80,0x80}, {0x43,0x80,0x80}},
+	.enablebits	= { {0x41, 0x80, 0x80}, {0x43, 0x80, 0x80} },
 	.host_flags	= IDE_HFLAG_LEGACY_IRQS,
 	.pio_mask	= ATA_PIO4,
 	.swdma_mask	= ATA_SWDMA2_ONLY,
-- 
1.5.4.2.316.gf7a7

