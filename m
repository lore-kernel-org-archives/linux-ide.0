From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 50/63] ide-cd: remove cdrom_do_pc_continuation()
Date: Thu, 20 Dec 2007 02:30:27 +0100
Message-ID: <200712200230.27388.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.175]:11604 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757495AbXLTBey (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 19 Dec 2007 20:34:54 -0500
Received: by ug-out-1314.google.com with SMTP id z38so389244ugc.16
        for <linux-ide@vger.kernel.org>; Wed, 19 Dec 2007 17:34:53 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org


cdrom_do_pc_continuation() is now identical to cdrom_do_newpc_cont()
so just always use the latter function.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
-49 bytes
 drivers/ide/ide-cd.c |   15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

Index: b/drivers/ide/ide-cd.c
===================================================================
--- a/drivers/ide/ide-cd.c
+++ b/drivers/ide/ide-cd.c
@@ -1061,18 +1061,7 @@ static void ide_cd_request_sense_fixup(s
 		}
 }
 
-static ide_startstop_t cdrom_newpc_intr(ide_drive_t *);
-
-static ide_startstop_t cdrom_do_pc_continuation (ide_drive_t *drive)
-{
-	struct request *rq = HWGROUP(drive)->rq;
-
-	if (!rq->timeout)
-		rq->timeout = ATAPI_WAIT_PC;
-
-	/* Send the command to the drive and return. */
-	return cdrom_transfer_packet_command(drive, rq, cdrom_newpc_intr);
-}
+static ide_startstop_t cdrom_do_newpc_cont(ide_drive_t *);
 
 static ide_startstop_t cdrom_do_packet_command (ide_drive_t *drive)
 {
@@ -1085,7 +1074,7 @@ static ide_startstop_t cdrom_do_packet_c
 	len = rq->data_len;
 
 	/* Start sending the command to the drive. */
-	return cdrom_start_packet_command(drive, len, cdrom_do_pc_continuation);
+	return cdrom_start_packet_command(drive, len, cdrom_do_newpc_cont);
 }
 
 int ide_cd_queue_pc(ide_drive_t *drive, struct request *rq)
