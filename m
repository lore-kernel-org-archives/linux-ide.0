From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 3/7] cmd64x: use ide_get_pair_dev() helper
Date: Sun, 21 Dec 2008 22:00:22 +0100
Message-ID: <20081221210022.23795.64425.sendpatchset@localhost.localdomain>
References: <20081221210007.23795.27999.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f21.google.com ([209.85.218.21]:34166 "EHLO
	mail-bw0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753762AbYLUVAW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 21 Dec 2008 16:00:22 -0500
In-Reply-To: <20081221210007.23795.27999.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] cmd64x: use ide_get_pair_dev() helper

There should be no functional changes caused by this patch.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/cmd64x.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

Index: b/drivers/ide/cmd64x.c
===================================================================
--- a/drivers/ide/cmd64x.c
+++ b/drivers/ide/cmd64x.c
@@ -138,10 +138,12 @@ static void cmd64x_tune_pio(ide_drive_t 
 	 * the slowest address setup timing ourselves.
 	 */
 	if (hwif->channel) {
-		ide_drive_t *drives = hwif->drives;
+		ide_drive_t *pair = ide_get_pair_dev(drive);
 
 		drive->drive_data = setup_count;
-		setup_count = max(drives[0].drive_data, drives[1].drive_data);
+
+		if (pair)
+			setup_count = max_t(u8, setup_count, pair->drive_data);
 	}
 
 	if (setup_count > 5)		/* shouldn't actually happen... */
