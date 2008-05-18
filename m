From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 33/40] ide-tape: factor out DSC handling from idetape_pc_intr()
Date: Sun, 18 May 2008 20:59:25 +0200
Message-ID: <20080518185925.5636.76205.sendpatchset@localhost.localdomain>
References: <20080518185428.5636.77234.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.190]:17236 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757610AbYERSl7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 18 May 2008 14:41:59 -0400
Received: by fk-out-0910.google.com with SMTP id 18so1473278fkq.5
        for <linux-ide@vger.kernel.org>; Sun, 18 May 2008 11:41:59 -0700 (PDT)
In-Reply-To: <20080518185428.5636.77234.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Borislav Petkov <petkovbb@gmail.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

Factor out DSC handling from idetape_pc_intr() to ide_tape_handle_dsc()
helper as a preparation for adding generic ide_pc_intr() helper.

There should be no functional changes caused by this patch.

Cc: Borislav Petkov <petkovbb@gmail.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-tape.c |   19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

Index: b/drivers/ide/ide-tape.c
===================================================================
--- a/drivers/ide/ide-tape.c
+++ b/drivers/ide/ide-tape.c
@@ -768,6 +768,18 @@ static void idetape_postpone_request(ide
 	ide_stall_queue(drive, tape->dsc_poll_freq);
 }
 
+static void ide_tape_handle_dsc(ide_drive_t *drive)
+{
+	idetape_tape_t *tape = drive->driver_data;
+
+	/* Media access command */
+	tape->dsc_polling_start = jiffies;
+	tape->dsc_poll_freq = IDETAPE_DSC_MA_FAST;
+	tape->dsc_timeout = jiffies + IDETAPE_DSC_MA_TIMEOUT;
+	/* Allow ide.c to handle other requests */
+	idetape_postpone_request(drive);
+}
+
 typedef void idetape_io_buf(ide_drive_t *, struct ide_atapi_pc *, unsigned int);
 
 /*
@@ -833,12 +845,7 @@ static ide_startstop_t idetape_pc_intr(i
 		pc->error = 0;
 		if ((pc->flags & PC_FLAG_WAIT_FOR_DSC) &&
 		    (stat & SEEK_STAT) == 0) {
-			/* Media access command */
-			tape->dsc_polling_start = jiffies;
-			tape->dsc_poll_freq = IDETAPE_DSC_MA_FAST;
-			tape->dsc_timeout = jiffies + IDETAPE_DSC_MA_TIMEOUT;
-			/* Allow ide.c to handle other requests */
-			idetape_postpone_request(drive);
+			ide_tape_handle_dsc(drive);
 			return ide_stopped;
 		}
 		/* Command finished - Call the callback function */
