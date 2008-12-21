From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 2/7] cmd640: use ide_get_pair_dev() helper
Date: Sun, 21 Dec 2008 22:00:15 +0100
Message-ID: <20081221210015.23795.25127.sendpatchset@localhost.localdomain>
References: <20081221210007.23795.27999.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f21.google.com ([209.85.218.21]:34166 "EHLO
	mail-bw0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752077AbYLUVAP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 21 Dec 2008 16:00:15 -0500
In-Reply-To: <20081221210007.23795.27999.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] cmd640: use ide_get_pair_dev() helper

There should be no functional changes caused by this patch.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/cmd640.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

Index: b/drivers/ide/cmd640.c
===================================================================
--- a/drivers/ide/cmd640.c
+++ b/drivers/ide/cmd640.c
@@ -467,11 +467,10 @@ static void program_drive_counts(ide_dri
 	 * so we merge the timings, using the slowest value for each timing.
 	 */
 	if (index > 1) {
-		ide_hwif_t *hwif = drive->hwif;
-		ide_drive_t *peer = &hwif->drives[!(drive->dn & 1)];
+		ide_drive_t *peer = ide_get_pair_dev(drive);
 		unsigned int mate = index ^ 1;
 
-		if (peer->dev_flags & IDE_DFLAG_PRESENT) {
+		if (peer) {
 			if (setup_count < setup_counts[mate])
 				setup_count = setup_counts[mate];
 			if (active_count < active_counts[mate])
