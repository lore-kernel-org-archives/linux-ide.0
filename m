From: Borislav Petkov <petkovbb@googlemail.com>
Subject: [PATCH] ide-cd: handle fragmented packet commands gracefully
Date: Sun, 21 Jun 2009 10:55:27 +0200
Message-ID: <1245574527-2104-1-git-send-email-petkovbb@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.157]:19551 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751375AbZFUIz3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 21 Jun 2009 04:55:29 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

There are some devices in the wild that clear the DRQ bit during the
last word of a packet command and therefore could use a "second chance"
for that last word of data to be xferred instead of simply failing the
request. Do that by attempting to suck in those last bytes in PIO mode.

In addition, the ATA_ERR bit has to be cleared for we cannot be sure the
data is valid otherwise.

See http://bugzilla.kernel.org/show_bug.cgi?id=13399 for details.

Signed-off-by: Borislav Petkov <petkovbb@gmail.com>
---
 drivers/ide/ide-cd.c |   14 ++++++++++++--
 1 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/ide/ide-cd.c b/drivers/ide/ide-cd.c
index 4a19686..8d3f7d0 100644
--- a/drivers/ide/ide-cd.c
+++ b/drivers/ide/ide-cd.c
@@ -592,9 +592,19 @@ static ide_startstop_t cdrom_newpc_intr(ide_drive_t *drive)
 			}
 		} else if (!blk_pc_request(rq)) {
 			ide_cd_request_sense_fixup(drive, cmd);
-			/* complain if we still have data left to transfer */
+
 			uptodate = cmd->nleft ? 0 : 1;
-			if (uptodate == 0)
+
+			/*
+			 * suck out the remaining bytes from the drive in an
+			 * attempt to complete the data xfer. (see BZ#13399)
+			 */
+			if (!(stat & ATA_ERR) && !uptodate && thislen) {
+				ide_pio_bytes(drive, cmd, write, thislen);
+				uptodate = cmd->nleft ? 0 : 1;
+			}
+
+			if (!uptodate)
 				rq->cmd_flags |= REQ_FAILED;
 		}
 		goto out_end;
-- 
1.6.3.1

