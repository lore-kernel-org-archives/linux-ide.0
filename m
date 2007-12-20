From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 48/63] ide-cd: unify request end exit path in cdrom_pc_intr()
Date: Thu, 20 Dec 2007 02:29:08 +0100
Message-ID: <200712200229.08481.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.173]:11752 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755647AbXLTBew (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 19 Dec 2007 20:34:52 -0500
Received: by ug-out-1314.google.com with SMTP id z38so389251ugc.16
        for <linux-ide@vger.kernel.org>; Wed, 19 Dec 2007 17:34:51 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org


This is a preparation for cdrom_pc_intr() and cdrom_newpc_intr() merge.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
+10 bytes
 drivers/ide/ide-cd.c |   23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

Index: b/drivers/ide/ide-cd.c
===================================================================
--- a/drivers/ide/ide-cd.c
+++ b/drivers/ide/ide-cd.c
@@ -1066,7 +1066,7 @@ static ide_startstop_t cdrom_pc_intr (id
 {
 	struct request *rq = HWGROUP(drive)->rq;
 	xfer_func_t *xferfunc = NULL;
-	int stat, ireason, len, thislen, write;
+	int stat, ireason, len, thislen, write, update;
 	u8 lowcyl = 0, highcyl = 0;
 
 	/* Check for errors. */
@@ -1084,14 +1084,8 @@ static ide_startstop_t cdrom_pc_intr (id
 	   Complain if we still have data left to transfer. */
 	if ((stat & DRQ_STAT) == 0) {
 		ide_cd_request_sense_fixup(rq);
-
-		if (rq->data_len == 0)
-			cdrom_end_request(drive, 1);
-		else {
-			rq->cmd_flags |= REQ_FAILED;
-			cdrom_end_request(drive, 0);
-		}
-		return ide_stopped;
+		update = rq->data_len ? 0 : 1;
+		goto end_request;
 	}
 
 	/* Figure out how much data to transfer. */
@@ -1130,9 +1124,8 @@ static ide_startstop_t cdrom_pc_intr (id
 			"appears confused (ireason = 0x%02x). "
 			"Trying to recover by ending request.\n",
 			drive->name, ireason);
-		rq->cmd_flags |= REQ_FAILED;
-		cdrom_end_request(drive, 0);
-		return ide_stopped;
+		update = 0;
+		goto end_request;
 	}
 pad:
 	/*
@@ -1145,6 +1138,12 @@ pad:
 	/* Now we wait for another interrupt. */
 	ide_set_handler(drive, &cdrom_pc_intr, ATAPI_WAIT_PC, cdrom_timer_expiry);
 	return ide_started;
+
+end_request:
+	if (!update)
+		rq->cmd_flags |= REQ_FAILED;
+	cdrom_end_request(drive, update);
+	return ide_stopped;
 }
 
 static ide_startstop_t cdrom_do_pc_continuation (ide_drive_t *drive)
