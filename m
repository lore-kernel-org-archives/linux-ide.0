From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 14/20] ide-cd: cleanup ide_cd_do_request()
Date: Mon, 16 Feb 2009 01:14:42 +0100
Message-ID: <20090216001442.27491.81015.sendpatchset@localhost.localdomain>
References: <20090216001309.27491.59759.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f161.google.com ([209.85.218.161]:53581 "EHLO
	mail-bw0-f161.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756012AbZBPANP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 15 Feb 2009 19:13:15 -0500
In-Reply-To: <20090216001309.27491.59759.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Borislav Petkov <petkovbb@gmail.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] ide-cd: cleanup ide_cd_do_request()

There should be no functional changes caused by this patch.

Cc: Borislav Petkov <petkovbb@gmail.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-cd.c |   15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

Index: b/drivers/ide/ide-cd.c
===================================================================
--- a/drivers/ide/ide-cd.c
+++ b/drivers/ide/ide-cd.c
@@ -1044,8 +1044,11 @@ static ide_startstop_t ide_cd_do_request
 
 	if (blk_fs_request(rq)) {
 		if (cdrom_start_rw(drive, rq) == ide_stopped ||
-		    ide_cd_prepare_rw_request(drive, rq) == ide_stopped)
+		    ide_cd_prepare_rw_request(drive, rq) == ide_stopped) {
+			if (rq->current_nr_sectors == 0)
+				uptodate = 1;
 			goto out_end;
+		}
 	} else if (blk_sense_request(rq) || blk_pc_request(rq) ||
 		   rq->cmd_type == REQ_TYPE_ATA_PC) {
 		if (!rq->timeout)
@@ -1058,6 +1061,8 @@ static ide_startstop_t ide_cd_do_request
 		goto out_end;
 	} else {
 		blk_dump_rq_flags(rq, DRV_NAME " bad flags");
+		if (rq->errors == 0)
+			rq->errors = -EIO;
 		goto out_end;
 	}
 
@@ -1070,14 +1075,6 @@ static ide_startstop_t ide_cd_do_request
 
 	return ide_issue_pc(drive, &cmd);
 out_end:
-	if (blk_fs_request(rq)) {
-		if (rq->current_nr_sectors == 0)
-			uptodate = 1;
-	} else {
-		if (uptodate <= 0 && rq->errors == 0)
-			rq->errors = -EIO;
-	}
-
 	nsectors = rq->hard_nr_sectors;
 
 	if (nsectors == 0)
