From: Borislav Petkov <petkovbb@googlemail.com>
Subject: [PATCH 05/10] ide-atapi: accomodate transfer length to ide-cd
Date: Sun, 14 Sep 2008 13:35:53 +0200
Message-ID: <1221392158-3848-6-git-send-email-petkovbb@gmail.com>
References: <1221392158-3848-1-git-send-email-petkovbb@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.190]:22222 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753302AbYINLgH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 14 Sep 2008 07:36:07 -0400
Received: by mu-out-0910.google.com with SMTP id g7so1209412muf.1
        for <linux-ide@vger.kernel.org>; Sun, 14 Sep 2008 04:36:04 -0700 (PDT)
In-Reply-To: <1221392158-3848-1-git-send-email-petkovbb@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Borislav Petkov <petkovbb@gmail.com>

There should be no functional change resulting from this patch.

Signed-off-by: Borislav Petkov <petkovbb@gmail.com>
---
 drivers/ide/ide-atapi.c  |    4 +++-
 drivers/ide/ide-floppy.c |    2 +-
 drivers/ide/ide-tape.c   |    2 +-
 drivers/scsi/ide-scsi.c  |    3 ++-
 include/linux/ide.h      |    2 +-
 5 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/ide/ide-atapi.c b/drivers/ide/ide-atapi.c
index df17401..7045d34 100644
--- a/drivers/ide/ide-atapi.c
+++ b/drivers/ide/ide-atapi.c
@@ -546,7 +546,7 @@ static ide_startstop_t ide_transfer_pc(ide_drive_t *drive)
 }
 
 ide_startstop_t ide_issue_pc(ide_drive_t *drive, unsigned int timeout,
-			     ide_expiry_t *expiry)
+			     ide_expiry_t *expiry, int xferlen)
 {
 	struct ide_atapi_pc *pc = drive->pc;
 	ide_hwif_t *hwif = drive->hwif;
@@ -561,6 +561,8 @@ ide_startstop_t ide_issue_pc(ide_drive_t *drive, unsigned int timeout,
 	/* Request to transfer the entire buffer at once */
 	if (drive->media == ide_tape && scsi == 0)
 		bcount = pc->req_xfer;
+	else if (drive->media == ide_cdrom || drive->media == ide_optical)
+		bcount = xferlen;
 	else
 		bcount = min(pc->req_xfer, 63 * 1024);
 
diff --git a/drivers/ide/ide-floppy.c b/drivers/ide/ide-floppy.c
index cf0aa25..3a03e0c 100644
--- a/drivers/ide/ide-floppy.c
+++ b/drivers/ide/ide-floppy.c
@@ -246,7 +246,7 @@ static ide_startstop_t idefloppy_issue_pc(ide_drive_t *drive,
 
 	pc->retries++;
 
-	return ide_issue_pc(drive, WAIT_FLOPPY_CMD, NULL);
+	return ide_issue_pc(drive, WAIT_FLOPPY_CMD, NULL, 0);
 }
 
 void ide_floppy_create_read_capacity_cmd(struct ide_atapi_pc *pc)
diff --git a/drivers/ide/ide-tape.c b/drivers/ide/ide-tape.c
index 1ea9049..0ab3766 100644
--- a/drivers/ide/ide-tape.c
+++ b/drivers/ide/ide-tape.c
@@ -694,7 +694,7 @@ static ide_startstop_t idetape_issue_pc(ide_drive_t *drive,
 
 	pc->retries++;
 
-	return ide_issue_pc(drive, WAIT_TAPE_CMD, NULL);
+	return ide_issue_pc(drive, WAIT_TAPE_CMD, NULL, 0);
 }
 
 /* A mode sense command is used to "sense" tape parameters. */
diff --git a/drivers/scsi/ide-scsi.c b/drivers/scsi/ide-scsi.c
index 8723182..825b890 100644
--- a/drivers/scsi/ide-scsi.c
+++ b/drivers/scsi/ide-scsi.c
@@ -315,7 +315,8 @@ static ide_startstop_t idescsi_issue_pc(ide_drive_t *drive,
 	/* Set the current packet command */
 	drive->pc = pc;
 
-	return ide_issue_pc(drive, ide_scsi_get_timeout(pc), ide_scsi_expiry);
+	return ide_issue_pc(drive, ide_scsi_get_timeout(pc),
+			    ide_scsi_expiry, 0);
 }
 
 /*
diff --git a/include/linux/ide.h b/include/linux/ide.h
index 7c1b00a..e431e33 100644
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -1233,7 +1233,7 @@ static inline unsigned long ide_scsi_get_timeout(struct ide_atapi_pc *pc)
 
 int ide_scsi_expiry(ide_drive_t *);
 
-ide_startstop_t ide_issue_pc(ide_drive_t *, unsigned int, ide_expiry_t *);
+ide_startstop_t ide_issue_pc(ide_drive_t *, unsigned int, ide_expiry_t *, int);
 
 ide_startstop_t do_rw_taskfile(ide_drive_t *, ide_task_t *);
 
-- 
1.5.5.1

