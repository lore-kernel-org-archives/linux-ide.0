From: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
Subject: [PATCH 4/6] IDE: Coding Style fixes to drivers/ide/pci/it8213.c
Date: Sun, 24 Feb 2008 19:18:42 +0100
Message-ID: <20080224191842.61694afb@paolo-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.191]:37639 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752013AbYBXSSt (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 24 Feb 2008 13:18:49 -0500
Received: by fk-out-0910.google.com with SMTP id z23so1714211fkz.5
        for <linux-ide@vger.kernel.org>; Sun, 24 Feb 2008 10:18:45 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, linux-ide <linux-ide@vger.kernel.org>

File is now error free, only a few
WARNING: line over 80 characters
are left.

Compile tested.

Signed-off-by: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
---
 drivers/ide/pci/it8213.c |    9 ++++-----
 1 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/ide/pci/it8213.c b/drivers/ide/pci/it8213.c
index a5ba7e8..5b5b0cc 100644
--- a/drivers/ide/pci/it8213.c
+++ b/drivers/ide/pci/it8213.c
@@ -35,7 +35,7 @@ static void it8213_set_pio_mode(ide_drive_t *drive, const u8 pio)
 	static DEFINE_SPINLOCK(tune_lock);
 	int control = 0;
 
-	static const u8 timings[][2]= {
+	static const u8 timings[][2] = {
 					{ 0, 0 },
 					{ 0, 0 },
 					{ 1, 0 },
@@ -105,11 +105,10 @@ static void it8213_set_dma_mode(ide_drive_t *drive, const u8 speed)
 
 		if (!(reg48 & u_flag))
 			pci_write_config_byte(dev, 0x48, reg48 | u_flag);
-		if (speed >= XFER_UDMA_5) {
+		if (speed >= XFER_UDMA_5)
 			pci_write_config_byte(dev, 0x55, (u8) reg55|w_flag);
-		} else {
+		else
 			pci_write_config_byte(dev, 0x55, (u8) reg55 & ~w_flag);
-		}
 
 		if ((reg4a & a_speed) != u_speed)
 			pci_write_config_word(dev, 0x4a, (reg4a & ~a_speed) | u_speed);
@@ -170,7 +169,7 @@ static void __devinit init_hwif_it8213(ide_hwif_t *hwif)
 	{						\
 		.name		= name_str,		\
 		.init_hwif	= init_hwif_it8213,	\
-		.enablebits	= {{0x41,0x80,0x80}}, \
+		.enablebits	= { {0x41, 0x80, 0x80} }, \
 		.host_flags	= IDE_HFLAG_SINGLE,	\
 		.pio_mask	= ATA_PIO4,		\
 		.swdma_mask	= ATA_SWDMA2_ONLY,	\
-- 
1.5.4.2.316.gf7a7

