From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: [PATCH] ide-taskfile.c fixups/cleanups [5/11]
Date: Sat, 19 Jun 2004 18:11:04 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <200406191811.04740.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:7076 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S264196AbUFSQP7
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 19 Jun 2004 12:15:59 -0400
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org


[PATCH] ide: last IRQ fix for task_mulout_intr() (CONFIG_IDE_TASKFILE_IO=n)

We should wait for the last IRQ after all data is sent.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>

 linux-2.6.7-bzolnier/drivers/ide/ide-taskfile.c |    7 -------
 1 files changed, 7 deletions(-)

diff -puN drivers/ide/ide-taskfile.c~ide_tf_pio_out_end_fix drivers/ide/ide-taskfile.c
--- linux-2.6.7/drivers/ide/ide-taskfile.c~ide_tf_pio_out_end_fix	2004-06-19 02:57:14.073574040 +0200
+++ linux-2.6.7-bzolnier/drivers/ide/ide-taskfile.c	2004-06-19 02:57:14.078573280 +0200
@@ -520,13 +520,6 @@ ide_startstop_t task_mulout_intr (ide_dr
 		msect -= nsect;
 		taskfile_output_data(drive, pBuf, nsect * SECTOR_WORDS);
 		rq->current_nr_sectors -= nsect;
-
-		/* FIXME: check drive status */
-		if (!rq->current_nr_sectors) {
-			if (!DRIVER(drive)->end_request(drive, 1, 0))
-				if (!rq->bio)
-					return ide_stopped;
-		}
 	} while (msect);
 	rq->errors = 0;
 	if (HWGROUP(drive)->handler == NULL)

_

