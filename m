From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: [PATCH] ide-taskfile.c fixups/cleanups [1/11]
Date: Sat, 19 Jun 2004 18:07:22 +0200
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <200406191807.22987.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-S264373AbUFSQVE@vger.kernel.org>
Content-Disposition: inline
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org


[PATCH] ide: remove redundant hwgroup->handler checks from ide-taskfile.c

Remove checks for hwgroup->handler == NULL from task_[in,mulin,out]_intr()
(CONFIG_IDE_TASKFILE_IO=n versions).  These functions can be called only from
ide_intr() or ide_timer_expiry() and both set hwgroup->handler to NULL first.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>

 linux-2.6.7-bzolnier/drivers/ide/ide-taskfile.c |   19 +++++--------------
 1 files changed, 5 insertions(+), 14 deletions(-)

diff -puN drivers/ide/ide-taskfile.c~ide_handler_checks drivers/ide/ide-taskfile.c
--- linux-2.6.7/drivers/ide/ide-taskfile.c~ide_handler_checks	2004-06-19 02:40:54.620473544 +0200
+++ linux-2.6.7-bzolnier/drivers/ide/ide-taskfile.c	2004-06-19 02:40:54.625472784 +0200
@@ -317,8 +317,7 @@ ide_startstop_t task_in_intr (ide_drive_
 		}
 		if (!(stat & BUSY_STAT)) {
 			DTF("task_in_intr to Soon wait for next interrupt\n");
-			if (HWGROUP(drive)->handler == NULL)
-				ide_set_handler(drive, &task_in_intr, WAIT_WORSTCASE, NULL);
+			ide_set_handler(drive, &task_in_intr, WAIT_WORSTCASE, NULL);
 			return ide_started;  
 		}
 	}
@@ -332,12 +331,7 @@ ide_startstop_t task_in_intr (ide_drive_
 	if (--rq->current_nr_sectors <= 0)
 		if (!DRIVER(drive)->end_request(drive, 1, 0))
 			return ide_stopped;
-	/*
-	 * ERM, it is techincally legal to leave/exit here but it makes
-	 * a mess of the code ...
-	 */
-	if (HWGROUP(drive)->handler == NULL)
-		ide_set_handler(drive, &task_in_intr, WAIT_WORSTCASE, NULL);
+	ide_set_handler(drive, &task_in_intr, WAIT_WORSTCASE, NULL);
 	return ide_started;
 }
 
@@ -360,8 +354,7 @@ ide_startstop_t task_mulin_intr (ide_dri
 			return DRIVER(drive)->error(drive, "task_mulin_intr", stat);
 		}
 		/* no data yet, so wait for another interrupt */
-		if (HWGROUP(drive)->handler == NULL)
-			ide_set_handler(drive, &task_mulin_intr, WAIT_WORSTCASE, NULL);
+		ide_set_handler(drive, &task_mulin_intr, WAIT_WORSTCASE, NULL);
 		return ide_started;
 	}
 
@@ -384,8 +377,7 @@ ide_startstop_t task_mulin_intr (ide_dri
 				return ide_stopped;
 		}
 	} while (msect);
-	if (HWGROUP(drive)->handler == NULL)
-		ide_set_handler(drive, &task_mulin_intr, WAIT_WORSTCASE, NULL);
+	ide_set_handler(drive, &task_mulin_intr, WAIT_WORSTCASE, NULL);
 	return ide_started;
 }
 
@@ -445,8 +437,7 @@ ide_startstop_t task_out_intr (ide_drive
 		rq->errors = 0;
 		rq->current_nr_sectors--;
 	}
-	if (HWGROUP(drive)->handler == NULL)
-		ide_set_handler(drive, &task_out_intr, WAIT_WORSTCASE, NULL);
+	ide_set_handler(drive, &task_out_intr, WAIT_WORSTCASE, NULL);
 	return ide_started;
 }
 

_
