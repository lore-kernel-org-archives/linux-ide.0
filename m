From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 17/20] ide: fix final status check in drive_cmd_intr()
Date: Sun, 9 Dec 2007 22:19:55 +0100
Message-ID: <200712092219.55175.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.169]:55848 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751519AbXLIVVH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 9 Dec 2007 16:21:07 -0500
Received: by ug-out-1314.google.com with SMTP id z38so1381313ugc
        for <linux-ide@vger.kernel.org>; Sun, 09 Dec 2007 13:21:06 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


Don't check for READY_STAT bit being set for PIO-in protocol (makes the
final status check in drive_cmd_intr() match the one in task_in_intr()).

Also fix function name reported by ide_error() call while at it.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-io.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: b/drivers/ide/ide-io.c
===================================================================
--- a/drivers/ide/ide-io.c
+++ b/drivers/ide/ide-io.c
@@ -659,8 +659,8 @@ static ide_startstop_t drive_cmd_intr (i
 		stat = hwif->INB(IDE_STATUS_REG);
 	}
 
-	if (!OK_STAT(stat, READY_STAT, BAD_STAT))
-		return ide_error(drive, "drive_cmd", stat);
+	if (!OK_STAT(stat, (pio_in ? 0 : READY_STAT), BAD_STAT))
+		return ide_error(drive, __FUNCTION__, stat);
 		/* calls ide_end_drive_cmd */
 	ide_end_drive_cmd(drive, stat, hwif->INB(IDE_ERROR_REG));
 	return ide_stopped;
