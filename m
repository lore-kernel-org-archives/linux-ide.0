From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 11/20] ide: kill DATA_READY define
Date: Sun, 9 Dec 2007 22:15:11 +0100
Message-ID: <200712092215.11448.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.175]:55327 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751413AbXLIVVC (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 9 Dec 2007 16:21:02 -0500
Received: by ug-out-1314.google.com with SMTP id z38so1381310ugc
        for <linux-ide@vger.kernel.org>; Sun, 09 Dec 2007 13:21:01 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-taskfile.c |    4 ++--
 include/linux/ide.h        |    1 -
 2 files changed, 2 insertions(+), 3 deletions(-)

Index: b/drivers/ide/ide-taskfile.c
===================================================================
--- a/drivers/ide/ide-taskfile.c
+++ b/drivers/ide/ide-taskfile.c
@@ -436,7 +436,7 @@ static ide_startstop_t task_in_intr(ide_
 	u8 stat = hwif->INB(IDE_STATUS_REG);
 
 	/* new way for dealing with premature shared PCI interrupts */
-	if (!OK_STAT(stat, DATA_READY, BAD_R_STAT)) {
+	if (!OK_STAT(stat, DRQ_STAT, BAD_R_STAT)) {
 		if (stat & (ERR_STAT | DRQ_STAT))
 			return task_error(drive, rq, __FUNCTION__, stat);
 		/* No data yet, so wait for another IRQ. */
@@ -493,7 +493,7 @@ static ide_startstop_t pre_task_out_intr
 {
 	ide_startstop_t startstop;
 
-	if (ide_wait_stat(&startstop, drive, DATA_READY,
+	if (ide_wait_stat(&startstop, drive, DRQ_STAT,
 			  drive->bad_wstat, WAIT_DRQ)) {
 		printk(KERN_ERR "%s: no DRQ after issuing %sWRITE%s\n",
 				drive->name,
Index: b/include/linux/ide.h
===================================================================
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -107,7 +107,6 @@ typedef unsigned char	byte;	/* used ever
 #define BAD_W_STAT		(BAD_R_STAT  | WRERR_STAT)
 #define BAD_STAT		(BAD_R_STAT  | DRQ_STAT)
 #define DRIVE_READY		(READY_STAT  | SEEK_STAT)
-#define DATA_READY		(DRQ_STAT)
 
 #define BAD_CRC			(ABRT_ERR    | ICRC_ERR)
 
