From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 1/15] ide-floppy: remove dead code
Date: Wed, 31 Oct 2007 00:23:49 +0100
Message-ID: <200710310023.49858.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.189]:45624 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751983AbXJ3XuS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 30 Oct 2007 19:50:18 -0400
Received: by nf-out-0910.google.com with SMTP id g13so1788114nfb
        for <linux-ide@vger.kernel.org>; Tue, 30 Oct 2007 16:50:16 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-floppy.c |   33 ---------------------------------
 1 file changed, 33 deletions(-)

Index: b/drivers/ide/ide-floppy.c
===================================================================
--- a/drivers/ide/ide-floppy.c
+++ b/drivers/ide/ide-floppy.c
@@ -369,27 +369,6 @@ typedef struct ide_floppy_obj {
 #define	IDEFLOPPY_IOCTL_FORMAT_START		0x4602
 #define IDEFLOPPY_IOCTL_FORMAT_GET_PROGRESS	0x4603
 
-#if 0
-/*
- *	Special requests for our block device strategy routine.
- */
-#define	IDEFLOPPY_FIRST_RQ	90
-
-/*
- * 	IDEFLOPPY_PC_RQ is used to queue a packet command in the request queue.
- */
-#define	IDEFLOPPY_PC_RQ		90
-
-#define IDEFLOPPY_LAST_RQ	90
-
-/*
- *	A macro which can be used to check if a given request command
- *	originated in the driver or in the buffer cache layer.
- */
-#define IDEFLOPPY_RQ_CMD(cmd) 	((cmd >= IDEFLOPPY_FIRST_RQ) && (cmd <= IDEFLOPPY_LAST_RQ))
-
-#endif
-
 /*
  *	Error codes which are returned in rq->errors to the higher part
  *	of the driver.
@@ -1045,18 +1024,6 @@ static ide_startstop_t idefloppy_issue_p
 	atapi_bcount_t bcount;
 	ide_handler_t *pkt_xfer_routine;
 
-#if 0 /* Accessing floppy->pc is not valid here, the previous pc may be gone
-         and have lived on another thread's stack; that stack may have become
-         unmapped meanwhile (CONFIG_DEBUG_PAGEALLOC). */
-#if IDEFLOPPY_DEBUG_BUGS
-	if (floppy->pc->c[0] == IDEFLOPPY_REQUEST_SENSE_CMD &&
-	    pc->c[0] == IDEFLOPPY_REQUEST_SENSE_CMD) {
-		printk(KERN_ERR "ide-floppy: possible ide-floppy.c bug - "
-			"Two request sense in serial were issued\n");
-	}
-#endif /* IDEFLOPPY_DEBUG_BUGS */
-#endif
-
 	if (floppy->failed_pc == NULL &&
 	    pc->c[0] != IDEFLOPPY_REQUEST_SENSE_CMD)
 		floppy->failed_pc = pc;
