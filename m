From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: [PATCH] IDE update for 2.6.7-rc3 [7/12]
Date: Fri, 11 Jun 2004 17:59:54 +0200
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <200406111759.54209.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-S264191AbUFKQ0P@vger.kernel.org>
Content-Disposition: inline
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Jens Axboe <axboe@suse.de>
List-Id: linux-ide@vger.kernel.org


[PATCH] ide: fix ide-cd to not retry REQ_DRIVE_TASKFILE requests

'cat /proc/ide/hdx/identify' generates REQ_DRIVE_TASKFILE request
(for WIN_PIDENTIFY command) even for devices controlled by ide-cd.

All other drivers don't retry such requests.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>

 linux-2.6.7-rc3-bzolnier/drivers/ide/ide-cd.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN drivers/ide/ide-cd.c~ide_cdrom_taskfile drivers/ide/ide-cd.c
--- linux-2.6.7-rc3/drivers/ide/ide-cd.c~ide_cdrom_taskfile	2004-06-10 23:01:31.725338592 +0200
+++ linux-2.6.7-rc3-bzolnier/drivers/ide/ide-cd.c	2004-06-10 23:01:31.731337680 +0200
@@ -574,7 +574,7 @@ ide_startstop_t ide_cdrom_error (ide_dri
 	if (drive == NULL || (rq = HWGROUP(drive)->rq) == NULL)
 		return ide_stopped;
 	/* retry only "normal" I/O: */
-	if (rq->flags & (REQ_DRIVE_CMD | REQ_DRIVE_TASK)) {
+	if (rq->flags & (REQ_DRIVE_CMD | REQ_DRIVE_TASK | REQ_DRIVE_TASKFILE)) {
 		rq->errors = 1;
 		ide_end_drive_cmd(drive, stat, err);
 		return ide_stopped;

_
