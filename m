From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: [PATCH] IDE update for 2.6.7-rc3 [8/12]
Date: Fri, 11 Jun 2004 18:01:47 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <200406111801.47580.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:8089 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S264113AbUFKQQJ
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 11 Jun 2004 12:16:09 -0400
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Willem Riede <osst@riede.org>


[PATCH] ide: fix REQ_DRIVE_* requests error handling in ide-scsi

If REQ_DRIVE_* request fails ide_end_drive_cmd() should be called
for it not ->end_request().  This was broken by 2.6.5, fix it.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>

 linux-2.6.7-rc3-bzolnier/drivers/scsi/ide-scsi.c |    7 +++++++
 1 files changed, 7 insertions(+)

diff -puN drivers/scsi/ide-scsi.c~ide_scsi_req_drive drivers/scsi/ide-scsi.c
--- linux-2.6.7-rc3/drivers/scsi/ide-scsi.c~ide_scsi_req_drive	2004-06-10 23:12:23.716220912 +0200
+++ linux-2.6.7-rc3-bzolnier/drivers/scsi/ide-scsi.c	2004-06-10 23:12:23.726219392 +0200
@@ -318,6 +318,13 @@ ide_startstop_t idescsi_atapi_error (ide
 	if (drive == NULL || (rq = HWGROUP(drive)->rq) == NULL)
 		return ide_stopped;
 
+	/* retry only "normal" I/O: */
+	if (rq->flags & (REQ_DRIVE_CMD | REQ_DRIVE_TASK | REQ_DRIVE_TASKFILE)) {
+		rq->errors = 1;
+		ide_end_drive_cmd(drive, stat, err);
+		return ide_stopped;
+	}
+
 	if (HWIF(drive)->INB(IDE_STATUS_REG) & (BUSY_STAT|DRQ_STAT))
 		/* force an abort */
 		HWIF(drive)->OUTB(WIN_IDLEIMMEDIATE,IDE_COMMAND_REG);

_

