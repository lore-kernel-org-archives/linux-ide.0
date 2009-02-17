From: Roel Kluin <roel.kluin@gmail.com>
Subject: [PATCH] atiixp: missing parentheses?
Date: Tue, 17 Feb 2009 14:10:55 +0100
Message-ID: <499AB75F.6060709@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f167.google.com ([209.85.218.167]:62994 "EHLO
	mail-bw0-f167.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750974AbZBQNK5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 17 Feb 2009 08:10:57 -0500
Received: by bwz11 with SMTP id 11so2027620bwz.13
        for <linux-ide@vger.kernel.org>; Tue, 17 Feb 2009 05:10:55 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>

This looks odd, is below what was intended? note that timing_shift can
only be 16, 8 or 0. Maybe intended was 24, 16, 8 or 0? then we should do:

int timing_shift = ((drive->dn & 2) ? 16 : 0) + ((drive->dn & 1) ? 0 : 8);
--------------------------->8-------------8<------------------------------
Add missing parentheses

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---
diff --git a/drivers/ide/atiixp.c b/drivers/ide/atiixp.c
index b2735d2..b7813ec 100644
--- a/drivers/ide/atiixp.c
+++ b/drivers/ide/atiixp.c
@@ -52,7 +52,7 @@ static void atiixp_set_pio_mode(ide_drive_t *drive, const u8 pio)
 {
 	struct pci_dev *dev = to_pci_dev(drive->hwif->dev);
 	unsigned long flags;
-	int timing_shift = (drive->dn & 2) ? 16 : 0 + (drive->dn & 1) ? 0 : 8;
+	int timing_shift = (drive->dn & 2) ? 16 : 0 + ((drive->dn & 1) ? 0 : 8);
 	u32 pio_timing_data;
 	u16 pio_mode_data;
 
@@ -85,7 +85,7 @@ static void atiixp_set_dma_mode(ide_drive_t *drive, const u8 speed)
 {
 	struct pci_dev *dev = to_pci_dev(drive->hwif->dev);
 	unsigned long flags;
-	int timing_shift = (drive->dn & 2) ? 16 : 0 + (drive->dn & 1) ? 0 : 8;
+	int timing_shift = (drive->dn & 2) ? 16 : 0 + ((drive->dn & 1) ? 0 : 8);
 	u32 tmp32;
 	u16 tmp16;
 	u16 udma_ctl = 0;
