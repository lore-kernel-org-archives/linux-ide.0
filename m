From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: [PATCH] ide-taskfile.c fixups/cleanups part #2 [4/9]
Date: Wed, 30 Jun 2004 17:25:05 +0200
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <200406301725.05181.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-S266720AbUF3PZn@vger.kernel.org>
Content-Disposition: inline
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org


[PATCH] ide: remove BUSY check from task_in_intr() (CONFIG_IDE_TASKFILE_IO=n)

We shouldn't ever get there if drive is busy and we can't start transfer
in this case.  ide-disk.c:read_intr() also doesn't check for BUSY_STAT bit.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>

 linux-2.6.7-bk11-bzolnier/drivers/ide/ide-taskfile.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff -puN drivers/ide/ide-taskfile.c~ide_task_in_intr drivers/ide/ide-taskfile.c
--- linux-2.6.7-bk11/drivers/ide/ide-taskfile.c~ide_task_in_intr	2004-06-28 21:24:49.097867728 +0200
+++ linux-2.6.7-bk11-bzolnier/drivers/ide/ide-taskfile.c	2004-06-28 21:24:49.100867272 +0200
@@ -321,10 +321,8 @@ ide_startstop_t task_in_intr (ide_drive_
 		if (stat & (ERR_STAT|DRQ_STAT)) {
 			return DRIVER(drive)->error(drive, "task_in_intr", stat);
 		}
-		if (!(stat & BUSY_STAT)) {
-			ide_set_handler(drive, &task_in_intr, WAIT_WORSTCASE, NULL);
-			return ide_started;  
-		}
+		ide_set_handler(drive, &task_in_intr, WAIT_WORSTCASE, NULL);
+		return ide_started;
 	}
 
 	task_buffer_sectors(drive, rq, 1, IDE_PIO_IN);

_
