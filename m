From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 16/20] ide: check BUSY and ERROR status bits before reading data in drive_cmd_intr()
Date: Sun, 9 Dec 2007 22:19:13 +0100
Message-ID: <200712092219.13597.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.175]:55327 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751504AbXLIVVG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 9 Dec 2007 16:21:06 -0500
Received: by ug-out-1314.google.com with SMTP id z38so1381310ugc
        for <linux-ide@vger.kernel.org>; Sun, 09 Dec 2007 13:21:05 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-io.c |    7 +++++++
 1 file changed, 7 insertions(+)

Index: b/drivers/ide/ide-io.c
===================================================================
--- a/drivers/ide/ide-io.c
+++ b/drivers/ide/ide-io.c
@@ -643,6 +643,13 @@ static ide_startstop_t drive_cmd_intr (i
 	if (pio_in) {
 		u8 io_32bit = drive->io_32bit;
 		stat = hwif->INB(IDE_STATUS_REG);
+		if (!OK_STAT(stat, DRQ_STAT, BAD_R_STAT)) {
+			if (stat & (ERR_STAT | DRQ_STAT))
+				return ide_error(drive, __FUNCTION__, stat);
+			ide_set_handler(drive, &drive_cmd_intr, WAIT_WORSTCASE,
+					NULL);
+			return ide_started;
+		}
 		drive->io_32bit = 0;
 		hwif->ata_input_data(drive, &args[4], args[3] * SECTOR_WORDS);
 		drive->io_32bit = io_32bit;
