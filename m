From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 1/7] amd74xx: use ide_get_pair_dev() helper
Date: Sun, 21 Dec 2008 21:59:58 +0100
Message-ID: <20081221205958.23791.22069.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f20.google.com ([209.85.220.20]:52386 "EHLO
	mail-fx0-f20.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754163AbYLUU76 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 21 Dec 2008 15:59:58 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] amd74xx: use ide_get_pair_dev() helper

There should be no functional changes caused by this patch.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
updates for pata-2.6 tree

 drivers/ide/amd74xx.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: b/drivers/ide/amd74xx.c
===================================================================
--- a/drivers/ide/amd74xx.c
+++ b/drivers/ide/amd74xx.c
@@ -82,7 +82,7 @@ static void amd_set_drive(ide_drive_t *d
 {
 	ide_hwif_t *hwif = drive->hwif;
 	struct pci_dev *dev = to_pci_dev(hwif->dev);
-	ide_drive_t *peer = hwif->drives + (~drive->dn & 1);
+	ide_drive_t *peer = ide_get_pair_dev(drive);
 	struct ide_timing t, p;
 	int T, UT;
 	u8 udma_mask = hwif->ultra_mask;
@@ -92,7 +92,7 @@ static void amd_set_drive(ide_drive_t *d
 
 	ide_timing_compute(drive, speed, &t, T, UT);
 
-	if (peer->dev_flags & IDE_DFLAG_PRESENT) {
+	if (peer) {
 		ide_timing_compute(peer, peer->current_speed, &p, T, UT);
 		ide_timing_merge(&p, &t, &t, IDE_TIMING_8BIT);
 	}
